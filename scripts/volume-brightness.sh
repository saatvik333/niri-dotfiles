#!/bin/bash

set -euo pipefail

# Source common utilities
source "$(dirname "${BASH_SOURCE[0]}")/./lib/common.sh"

# --- Configuration ---
readonly VOLUME_STEP=5
readonly BRIGHTNESS_STEP=5
readonly MAX_VOLUME=100
readonly NOTIFICATION_TIMEOUT=1000

# System Icons (using standard icon names)
readonly VOLUME_MUTE_ICON="audio-volume-muted"
readonly VOLUME_LOW_ICON="audio-volume-low"
readonly VOLUME_MED_ICON="audio-volume-medium"
readonly VOLUME_HIGH_ICON="audio-volume-high"
readonly MIC_MUTE_ICON="microphone-sensitivity-muted-symbolic"
readonly MIC_UNMUTE_ICON="audio-input-microphone-symbolic"
readonly BRIGHTNESS_LOW_ICON="display-brightness-symbolic"
readonly BRIGHTNESS_MED_ICON="display-brightness-symbolic" 
readonly BRIGHTNESS_HIGH_ICON="display-brightness-symbolic"

# --- Volume Functions ---
get_volume() {
    pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1
}

get_mute_status() {
    pactl get-sink-mute @DEFAULT_SINK@ | grep -Po '(?<=Mute: )(yes|no)'
}

get_volume_icon() {
    local -r volume=$1
    local -r mute_status=$2

    if [[ "$mute_status" == "yes" || "$volume" -eq 0 ]]; then
        echo "$VOLUME_MUTE_ICON"
    elif (( volume < 33 )); then
        echo "$VOLUME_LOW_ICON"
    elif (( volume < 66 )); then
        echo "$VOLUME_MED_ICON"
    else
        echo "$VOLUME_HIGH_ICON"
    fi
}

show_volume_notification() {
    local -r volume=$(get_volume)
    local -r mute_status=$(get_mute_status)
    local -r volume_icon=$(get_volume_icon "$volume" "$mute_status")

    local body_text progress_value
    if [[ "$mute_status" == "yes" || "$volume" -eq 0 ]]; then
        body_text="Muted"
        progress_value=0
    else
        body_text="$volume%"
        progress_value=$volume
    fi

    notify-send \
        --app-name="Volume" \
        --expire-time="$NOTIFICATION_TIMEOUT" \
        --transient \
        --hint="string:x-canonical-private-synchronous:volume" \
        --hint="string:x-dunst-stack-tag:volume_notif" \
        --hint="int:value:$progress_value" \
        --hint="string:hlcolor:#ffffff" \
        --hint="string:category:volume" \
        --icon="$volume_icon" \
        "$body_text"
}

# --- Microphone Functions ---
get_mic_mute_status() {
    pactl get-source-mute @DEFAULT_SOURCE@ | grep -Po '(?<=Mute: )(yes|no)'
}

get_mic_icon() {
    local -r mute_status=$1
    if [[ "$mute_status" == "yes" ]]; then
        echo "$MIC_MUTE_ICON"
    else
        echo "$MIC_UNMUTE_ICON"
    fi
}

show_mic_notification() {
    local -r mute_status=$(get_mic_mute_status)
    local -r mic_icon=$(get_mic_icon "$mute_status")
    local status_text

    if [[ "$mute_status" == "yes" ]]; then
        status_text="Muted"
    else
        status_text="Unmuted"
    fi

    notify-send \
        --app-name="Microphone" \
        --expire-time="$NOTIFICATION_TIMEOUT" \
        --transient \
        --hint="string:x-canonical-private-synchronous:microphone" \
        --hint="string:x-dunst-stack-tag:mic_mute_notif" \
        --icon="$mic_icon" \
        "$status_text"
}

# --- Brightness Functions ---
get_brightness() {
    local current max
    current=$(brightnessctl g)
    max=$(brightnessctl m)
    echo $((current * 100 / max))
}

get_brightness_icon() {
    local -r brightness=$1
    if (( brightness < 33 )); then
        echo "$BRIGHTNESS_LOW_ICON"
    elif (( brightness < 66 )); then
        echo "$BRIGHTNESS_MED_ICON"
    else
        echo "$BRIGHTNESS_HIGH_ICON"
    fi
}

show_brightness_notification() {
    local -r brightness=$(get_brightness)
    local -r brightness_icon=$(get_brightness_icon "$brightness")

    notify-send \
        --app-name="Brightness" \
        --expire-time="$NOTIFICATION_TIMEOUT" \
        --transient \
        --hint="string:x-canonical-private-synchronous:brightness" \
        --hint="string:x-dunst-stack-tag:brightness_notif" \
        --hint="string:hlcolor:#ffffff" \
        --hint="string:category:brightness" \
        --hint="int:value:$brightness" \
        --icon="$brightness_icon" \
        "$brightness%"
}

# --- Music Functions ---
show_music_notification() {
    local title artist album
    title=$(playerctl -f "{{title}}" metadata 2>/dev/null || echo "")
    artist=$(playerctl -f "{{artist}}" metadata 2>/dev/null || echo "")
    album=$(playerctl -f "{{album}}" metadata 2>/dev/null || echo "")

    [[ -z "$title" && -z "$artist" ]] && return

    local summary="$title"
    local body="$artist"
    [[ -n "$album" ]] && body="$body - $album"

    notify-send \
        --app-name="Music Player" \
        --expire-time="$NOTIFICATION_TIMEOUT" \
        --transient \
        --hint="string:x-dunst-stack-tag:music_notif" \
        "$summary" "$body"
}

# --- Control Functions ---
volume_up() {
    pactl set-sink-mute @DEFAULT_SINK@ 0
    local current_volume
    current_volume=$(get_volume)

    if (( current_volume + VOLUME_STEP > MAX_VOLUME )); then
        pactl set-sink-volume @DEFAULT_SINK@ "${MAX_VOLUME}%"
    else
        pactl set-sink-volume @DEFAULT_SINK@ "+${VOLUME_STEP}%"
    fi
    show_volume_notification
}

volume_down() {
    pactl set-sink-volume @DEFAULT_SINK@ "-${VOLUME_STEP}%"
    show_volume_notification
}

volume_mute() {
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    show_volume_notification
}

mic_mute() {
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
    show_mic_notification
}

brightness_up() {
    brightnessctl set "${BRIGHTNESS_STEP}%+"
    show_brightness_notification
}

brightness_down() {
    brightnessctl set "${BRIGHTNESS_STEP}%-"
    show_brightness_notification
}

next_track() {
    playerctl next
    sleep 0.2
    show_music_notification
}

prev_track() {
    playerctl previous
    sleep 0.2
    show_music_notification
}

play_pause() {
    playerctl play-pause
    sleep 0.1
    show_music_notification
}

main() {
    local -r action="${1:-}"

    case "$action" in
        volume_up) volume_up ;;
        volume_down) volume_down ;;
        volume_mute) volume_mute ;;
        mic_mute) mic_mute ;;
        brightness_up) brightness_up ;;
        brightness_down) brightness_down ;;
        next_track) next_track ;;
        prev_track) prev_track ;;
        play_pause) play_pause ;;
        *)
            echo "Usage: $0 {volume_up|volume_down|volume_mute|mic_mute|brightness_up|brightness_down|next_track|prev_track|play_pause}"
            exit 1
            ;;
    esac
}

# --- Script Entry Point ---
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi