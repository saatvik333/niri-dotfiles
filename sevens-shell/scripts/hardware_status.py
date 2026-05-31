#!/usr/bin/env python3
import subprocess
import json
import time
import sys
import glob

def run_cmd(cmd):
    try:
        return subprocess.check_output(cmd, shell=True, text=True, stderr=subprocess.DEVNULL)
    except subprocess.CalledProcessError:
        return ""

def is_mic_active():
    output = run_cmd("wpctl status")
    
    # Check if default source is muted first
    in_audio = False
    in_sources = False
    for line in output.split('\n'):
        if line.startswith('Audio'): in_audio = True
        elif line.startswith('Video'): in_audio = False
        if not in_audio: continue
        
        if '├─ Sources:' in line or '└─ Sources:' in line:
            in_sources = True
            continue
        
        if in_sources:
            if '├─ ' in line or '└─ ' in line:
                in_sources = False
                continue
            if '*' in line: # Default source
                if 'MUTED' in line:
                    return False
    
    # If not muted, check for active streams
    in_audio = False
    for line in output.split('\n'):
        if 'Audio' in line: in_audio = True
        elif 'Video' in line: in_audio = False
        
        if in_audio and '<' in line and '[active]' in line:
            return True
            
    return False

def is_camera_active():
    video_devs = glob.glob("/dev/video*")
    if not video_devs:
        return False
    # fuser returns non-zero if no process is using the files
    try:
        subprocess.check_call(["fuser", "-s"] + video_devs, stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
        return True
    except subprocess.CalledProcessError:
        return False

def is_screen_shared():
    # Attempt to use pw-dump to find active screen shares
    try:
        dump = run_cmd("pw-dump")
        if not dump: return False
        data = json.loads(dump)
        for node in data:
            if 'info' in node and 'props' in node['info']:
                props = node['info']['props']
                media_class = props.get('media.class', '')
                media_role = props.get('media.role', '')
                state = node['info'].get('state', '')
                
                # Exclude physical Video/Source (Webcams) which we check via fuser
                if (media_class == "Stream/Input/Video" or media_class == "Stream/Output/Video" or media_role == "Screen") and (state == "running" or state == "active"):
                    return True
    except Exception:
        pass
    return False

def main():
    while True:
        state = {
            "mic": is_mic_active(),
            "camera": is_camera_active(),
            "screen": is_screen_shared()
        }
        
        print(json.dumps(state))
        sys.stdout.flush()
        
        time.sleep(2)

if __name__ == "__main__":
    main()
