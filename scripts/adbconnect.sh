#!/bin/bash
set -euo pipefail

DEVICE_IP="192.168.29.69"
PORT=$(
  adb connect "${DEVICE_IP}:5555" 2>&1 | grep -oP '(?<=:)\d+(?=: connected)' || nmap -p 30000-65535 "$DEVICE_IP" | grep open |
    awk '{print $1}' | cut -d'/' -f1 | head -1
)

if [[ -z "${PORT:-}" ]]; then
  echo "Failed to determine adb port for ${DEVICE_IP}" >&2
  exit 1
fi

adb connect "${DEVICE_IP}:${PORT}"
