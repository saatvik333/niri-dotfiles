#!/bin/bash

set -euo pipefail

readonly VOLUME_STEP=0.05
readonly BRIGHTNESS_STEP=5
readonly MAX_VOLUME=1.0
readonly NOTIFICATION_TIMEOUT=1000
readonly SHOW_TEXT=false

parse_volume() {
  local vol=${1#* } muted=${1##* }
  vol=${vol%% *}
  echo "$((${vol%%.*} * 100 + ${vol#*.}))" "$muted"
}

notify() {
  local body=""
  [[ "$SHOW_TEXT" == true ]] && body="$4"
  notify-send --app-name="$1" --expire-time="$NOTIFICATION_TIMEOUT" --transient \
    --hint="string:x-canonical-private-synchronous:$2" \
    --hint="string:x-dunst-stack-tag:$2" \
    --hint="int:value:$3" "$body" &
}

volume_up() {
  wpctl set-mute @DEFAULT_SINK@ 0
  local output
  output=$(wpctl get-volume @DEFAULT_SINK@)
  read -r vol _ <<< "$(parse_volume "$output")"
  wpctl set-volume @DEFAULT_SINK@ "$(awk -v v="$vol" -v s="$VOLUME_STEP" -v m="$MAX_VOLUME" 'BEGIN {r=v/100+s; print (r>m)?m:r}')"
  output=$(wpctl get-volume @DEFAULT_SINK@)
  read -r vol _ <<< "$(parse_volume "$output")"
  notify "Volume" "volume" "$vol" "${vol}%"
}

volume_down() {
  wpctl set-volume @DEFAULT_SINK@ "${VOLUME_STEP}-"
  local output
  output=$(wpctl get-volume @DEFAULT_SINK@)
  read -r vol _ <<< "$(parse_volume "$output")"
  notify "Volume" "volume" "$vol" "${vol}%"
}

volume_mute() {
  wpctl set-mute @DEFAULT_SINK@ toggle
  local output
  output=$(wpctl get-volume @DEFAULT_SINK@)
  read -r vol muted <<< "$(parse_volume "$output")"
  if [[ "$muted" == "[MUTED]" ]]; then
    notify "Volume Mute" "volume" 0 "Muted"
  else
    notify "Volume" "volume" "$vol" "${vol}%"
  fi
}

mic_mute() {
  wpctl set-mute @DEFAULT_SOURCE@ toggle
  if [[ "$(wpctl get-volume @DEFAULT_SOURCE@)" == *"[MUTED]"* ]]; then
    notify "Microphone" "microphone" 0 "Muted"
  else
    notify "Microphone" "microphone" 100 "Unmuted"
  fi
}

brightness_up() {
  local max
  max=$(brightnessctl max)
  brightnessctl -q set "${BRIGHTNESS_STEP}%+"
  notify "Brightness" "brightness" "$(($(brightnessctl get) * 100 / max))" ""
}

brightness_down() {
  local max
  max=$(brightnessctl max)
  brightnessctl -q set "${BRIGHTNESS_STEP}%-"
  notify "Brightness" "brightness" "$(($(brightnessctl get) * 100 / max))" ""
}

music_notify() {
  local meta
  meta=$(playerctl metadata --format '{{title}}|{{artist}}' 2> /dev/null) || return
  exec notify-send --app-name="Music Player" --expire-time="$NOTIFICATION_TIMEOUT" \
    --transient --hint="string:x-dunst-stack-tag:music_notif" "${meta%%|*}" "${meta#*|}"
}

next_track() { playerctl next && sleep 0.5 && music_notify; }
prev_track() { playerctl previous && sleep 0.5 && music_notify; }
play_pause() { playerctl play-pause && sleep 0.5 && music_notify; }

case "${1:-}" in
  volume_up | volume_down | volume_mute | mic_mute | brightness_up | brightness_down | next_track | prev_track | play_pause) "$1" ;;
  *)
    echo "Usage: $0 {volume_up|volume_down|volume_mute|mic_mute|brightness_up|brightness_down|next_track|prev_track|play_pause}" >&2
    exit 1
    ;;
esac
