#!/usr/bin/env bash
# QuickSnip direct-mode OCR (single-pass, copies to clipboard, notifies).
# Args: <full_png> <x> <y> <w> <h> <upscale_pct> <psm> <lang> <single_line:0|1> <raw:0|1>

set -uo pipefail

if [ "$#" -lt 10 ]; then
    echo "usage: $0 full_png x y w h upscale psm lang single raw" >&2
    exit 64
fi

FULL=$1; CX=$2; CY=$3; CW=$4; CH=$5; UP=$6; PSM=$7; LANG=$8; SINGLE=$9; RAW=${10}

tmp="/dev/shm/qs-direct-$$-$(date +%s%N)"
trap 'rm -f "$tmp.pnm"' EXIT

SCALE_ARGS=()
if [ "$UP" != "100" ]; then
    SCALE_ARGS=(-resize "${UP}%")
fi

magick "$FULL" \
    -crop "${CW}x${CH}+${CX}+${CY}" +repage \
    "${SCALE_ARGS[@]}" \
    -colorspace Gray \
    -depth 8 "$tmp.pnm" || exit 1

# Auto-invert if region is mostly dark (light text on dark bg → invert for OCR).
if [ "$(magick "$tmp.pnm" -format "%[fx:mean<0.5?1:0]" info:)" = "0" ]; then
    magick "$tmp.pnm" -negate "$tmp.pnm"
fi

TEXT=$(tesseract "$tmp.pnm" - -l "$LANG" --psm "$PSM" --oem 1 2>/dev/null)

# Fallback: if too little text, try the opposite polarity.
if [ "$(printf '%s' "$TEXT" | tr -d '[:space:]' | wc -c)" -lt 3 ]; then
    magick "$tmp.pnm" -negate "$tmp.pnm"
    TEXT2=$(tesseract "$tmp.pnm" - -l "$LANG" --psm "$PSM" --oem 1 2>/dev/null)
    if [ "$(printf '%s' "$TEXT2" | tr -d '[:space:]' | wc -c)" -gt "$(printf '%s' "$TEXT" | tr -d '[:space:]' | wc -c)" ]; then
        TEXT=$TEXT2
    fi
fi

if [ "$RAW" = "1" ]; then
    OUT=$(printf '%s' "$TEXT" | sed 's/[[:space:]]*$//')
else
    OUT=$(printf '%s' "$TEXT" | awk 'BEGIN{RS=""; ORS="\n\n"} {$1=$1; print}' | sed 's/[[:space:]]*$//')
fi
if [ "$SINGLE" = "1" ]; then
    OUT=$(printf '%s' "$OUT" | tr '\n' ' ' | sed 's/  */ /g; s/[[:space:]]*$//')
fi

printf '%s' "$OUT" | wl-copy

CLEAN=$(printf '%s' "$OUT" | tr '\n' ' ' | sed 's/  */ /g')
BODY=$(printf '%s' "$CLEAN" | head -c 100)
[ "${#CLEAN}" -gt 100 ] && BODY="${BODY}..."
notify-send "Copied" "$BODY" -t 3000 2>/dev/null || true
