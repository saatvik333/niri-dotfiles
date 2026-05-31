#!/usr/bin/env bash
# QuickSnip dual-pass OCR.
# Args: <full_png> <crop_x> <crop_y> <crop_w> <crop_h> <upscale_pct> <psm> <lang> <out_a> <out_b>
#   crop_w=0  → no crop (whole image)
#   upscale_pct=100 → no upscale
# Writes winning Tesseract TSV to stdout.

set -uo pipefail

if [ "$#" -lt 10 ]; then
    echo "usage: $0 full_png x y w h upscale psm lang outA outB" >&2
    exit 64
fi

FULL=$1; CX=$2; CY=$3; CW=$4; CH=$5; UP=$6; PSM=$7; LANG=$8; OUTA=$9; OUTB=${10}

tmpA="/dev/shm/qs-a-$$-$(date +%s%N).pnm"
tmpB="/dev/shm/qs-b-$$-$(date +%s%N).pnm"
trap 'rm -f "$tmpA" "$tmpB" "$OUTA.tsv" "$OUTB.tsv"' EXIT

CROP_ARGS=()
if [ "$CW" != "0" ]; then
    CROP_ARGS=(-crop "${CW}x${CH}+${CX}+${CY}" +repage)
fi
SCALE_ARGS=()
if [ "$UP" != "100" ]; then
    SCALE_ARGS=(-resize "${UP}%")
fi

magick "$FULL" "${CROP_ARGS[@]}" -colorspace Gray "${SCALE_ARGS[@]}" -depth 8 \
    \( +clone -negate -write "$tmpB" \) "$tmpA" || exit 1

tesseract "$tmpA" "$OUTA" -l "$LANG" --psm "$PSM" --oem 1 -c preserve_interword_spaces=1 tsv 2>/dev/null &
PID1=$!
tesseract "$tmpB" "$OUTB" -l "$LANG" --psm "$PSM" --oem 1 -c preserve_interword_spaces=1 tsv 2>/dev/null &
PID2=$!
wait "$PID1" "$PID2"

read -r -d '' SCORE_AWK <<'AWK_EOF'
NR > 1 && $1 == "5" && $12 != "" {
    conf = $11 + 0; w = $9 + 0; h = $10 + 0; y = $8 + 0; word = $12; len = length(word)
    if (h < 6 || w < 2 || conf < 15) next
    word_score = len * conf
    ratio = w / h
    if (ratio > 0.2 && ratio < 15) word_score *= 1.2
    tmp = word; gsub(/[a-zA-Z0-9]/, "", tmp); noise_chars = length(tmp)
    if (len > 1 && noise_chars / len > 0.7) word_score *= 0.3
    total += word_score
    bucket = int(y / (h > 0 ? h : 10)); lines[bucket]++
}
END {
    line_bonus = 0
    for (b in lines) {
        if (lines[b] >= 2) line_bonus += lines[b] * 100
        if (lines[b] >= 5) line_bonus += lines[b] * 200
    }
    printf "%d", total + line_bonus
}
AWK_EOF

SCORE_A=$(awk -F'\t' "$SCORE_AWK" "$OUTA.tsv" 2>/dev/null)
SCORE_B=$(awk -F'\t' "$SCORE_AWK" "$OUTB.tsv" 2>/dev/null)

if [ "${SCORE_A:-0}" -ge "${SCORE_B:-0}" ]; then
    cat "$OUTA.tsv"
else
    cat "$OUTB.tsv"
fi
