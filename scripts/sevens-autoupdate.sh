#!/usr/bin/env bash
# Sevens Shell auto-update runner. Invoked by sevens-autoupdate.service.
# Streams paru output to journal; notifies on failure or success-with-updates.

set -uo pipefail

# Bail out cleanly if pacman db is already locked (concurrent paru/pacman).
# Returning success keeps systemd's retry budget for real failures (network,
# mirrors, etc.) — the timer will pick this run up next cycle.
if [[ -f /var/lib/pacman/db.lck ]]; then
    echo "pacman db locked at /var/lib/pacman/db.lck — another process is updating, skipping" >&2
    exit 0
fi

LOG=$(mktemp)
trap 'rm -f "$LOG"' EXIT

paru -Syu --noconfirm 2>&1 | tee "$LOG"
rc=${PIPESTATUS[0]}

if [[ $rc -ne 0 ]]; then
    err=$(tail -3 "$LOG" | tr '\n' ' ' | sed 's/  */ /g')
    notify-send --app-name="Auto Update" --urgency=critical --expire-time=10000 \
        --hint=string:x-dunst-stack-tag:autoupdate \
        "Update Failed" "${err:-Run paru -Syu manually for details}" 2>/dev/null || true
    exit "$rc"
fi

count=$(grep -oP 'Packages \(\K[0-9]+' "$LOG" | tail -1)
if [[ -n "${count:-}" && "$count" -gt 0 ]]; then
    notify-send --app-name="Auto Update" --expire-time=5000 \
        --hint=string:x-dunst-stack-tag:autoupdate \
        "System Updated" "Updated ${count} package(s)" 2>/dev/null || true
fi
