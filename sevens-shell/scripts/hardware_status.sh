#!/bin/bash
exec < /dev/null
export PATH="/usr/bin:/usr/local/bin:/bin:$PATH"

while true; do
    echo '{"debug": "Starting Loop"}'
    
    mic_active=false
    if wpctl status | awk '/Audio/{a=1;v=0} /Video/{v=1;a=0} a && /</ && /\[active\]/ {print "found"; exit}' | grep -q "found"; then
        mic_active=true
    fi
    echo '{"debug": "Mic Done"}'

    # Webcams
    camera_active=false
    if fuser -s /dev/video* 2>/dev/null; then
        camera_active=true
    fi
    echo '{"debug": "Cam Done"}'

    # Screen share
    screen_active=false
    # REMOVED pw-dump temporarily to check if it's the culprit
    echo "{\"mic\": $mic_active, \"camera\": $camera_active, \"screen\": $screen_active}"
    
    sleep 2
done
