#!/usr/bin/env bash

WALL_DIR="$HOME/Pictures/Wallpapers"
CACHE_DIR="$HOME/.cache/thumbnails/bgselector"

mkdir -p "$CACHE_DIR"

# Create thumbnails for images that don't have them
find "$WALL_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' -o -iname '*.gif' -o -iname '*.bmp' -o -iname '*.tiff' -o -iname '*.avif' \) -print0 | while IFS= read -r -d '' img; do
    rel_path="${img#$WALL_DIR/}"
    cache_name="${rel_path//\//_}"
    cache_file="$CACHE_DIR/$cache_name"
    
    [ ! -f "$cache_file" ] && magick "$img" -strip -resize 330x540^ -gravity center -extent 330x540 "$cache_file"
done

# Show rofi menu with thumbnails
selected=$(find "$WALL_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' -o -iname '*.gif' -o -iname '*.bmp' -o -iname '*.tiff' -o -iname '*.avif' \) -print0 | while IFS= read -r -d '' img; do
    rel_path="${img#$WALL_DIR/}"
    cache_name="${rel_path//\//_}"  
    cache_file="$CACHE_DIR/$cache_name"
    
    [ -f "$cache_file" ] && printf '%s\000icon\037%s\n' "$rel_path" "$cache_file"
done | rofi -dmenu -show-icons -config "$HOME/.config/rofi/bgselector/style.rasi")

# Apply wallpaper
if [ -n "$selected" ]; then
    swww img "$WALL_DIR/$selected" -t fade --transition-duration 1 --transition-fps 60
    sleep 0.2
    "$HOME/.config/scripts/theme-sync.sh"
fi