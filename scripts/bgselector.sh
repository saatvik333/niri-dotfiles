#!/usr/bin/env bash

WALL_DIR="$HOME/Pictures/Wallpapers"
CACHE_DIR="$HOME/.cache/thumbnails/bgselector"
CACHE_INDEX="$CACHE_DIR/.index"

mkdir -p "$CACHE_DIR"

# Build current wallpaper index
current_index=$(mktemp)
find "$WALL_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' -o -iname '*.gif' -o -iname '*.bmp' -o -iname '*.tiff' -o -iname '*.avif' \) -printf '%p\n' > "$current_index"

# Clean orphaned cache files
if [ -f "$CACHE_INDEX" ]; then
    while read -r cached_path; do
        if [ ! -f "$cached_path" ]; then
            rel_path="${cached_path#$WALL_DIR/}"
            cache_name="${rel_path//\//_}"
            cache_name="${cache_name%.*}.jpg"
            rm -f "$CACHE_DIR/$cache_name"
        fi
    done < "$CACHE_INDEX"
fi

# Generate thumbnails with validation
progress_file=$(mktemp)
touch "$progress_file"
job_count=0

while read -r img; do
    rel_path="${img#$WALL_DIR/}"
    cache_name="${rel_path//\//_}"
    cache_name="${cache_name%.*}.jpg"
    cache_file="$CACHE_DIR/$cache_name"
    
    [ -f "$cache_file" ] && continue
    
    (
        if [[ "$img" =~ \.(gif|GIF)$ ]]; then
            magick "$img[0]" -strip -thumbnail 330x540^ -gravity center -extent 330x540 -quality 80 +repage "$cache_file" 2>/dev/null
        else
            magick "$img" -strip -thumbnail 330x540^ -gravity center -extent 330x540 -quality 80 +repage "$cache_file" 2>/dev/null
        fi
        [ -f "$cache_file" ] && echo "1" >> "$progress_file"
    ) &
    
    ((job_count++))
    if [ $((job_count % 4)) -eq 0 ]; then
        wait -n
    fi
done < "$current_index"

wait

total_generated=$(wc -l < "$progress_file" 2>/dev/null || echo 0)
[ $total_generated -gt 0 ] && echo "Generated $total_generated thumbnails" || echo "Cache up to date"
rm -f "$progress_file"

# Update cache index
mv "$current_index" "$CACHE_INDEX"

# Build rofi list
rofi_input=$(mktemp)
while read -r img; do
    rel_path="${img#$WALL_DIR/}"
    cache_name="${rel_path//\//_}"
    cache_name="${cache_name%.*}.jpg"
    cache_file="$CACHE_DIR/$cache_name"
    
    [ -f "$cache_file" ] && printf '%s\000icon\037%s\n' "$rel_path" "$cache_file"
done < "$CACHE_INDEX" > "$rofi_input"

# Show rofi and get selection
selected=$(rofi -dmenu -show-icons -config "$HOME/.config/rofi/bgselector/style.rasi" < "$rofi_input")
rm "$rofi_input"

# Apply wallpaper
if [ -n "$selected" ]; then
    selected_path="$WALL_DIR/$selected"
    if [ -f "$selected_path" ]; then
        awww img "$selected_path" -t fade --transition-duration 1 --transition-fps 60 &
        sleep 0.2
        "$HOME/.config/scripts/theme-sync.sh" &
        wait
    fi
fi