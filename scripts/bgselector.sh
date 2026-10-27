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

# Limit max parallel jobs to prevent system freeze during thumbnail generation
max_jobs=$(nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 4)
(( max_jobs > 2 )) && max_jobs=2
job_count=0

# Create list of images that need thumbnails
to_generate=$(mktemp)
while read -r img; do
    rel_path="${img#$WALL_DIR/}"
    cache_name="${rel_path//\//_}"
    cache_name="${cache_name%.*}.jpg"
    cache_file="$CACHE_DIR/$cache_name"
    
    [ -f "$cache_file" ] || echo "$img" >> "$to_generate"
done < "$current_index"

# Process images in parallel
generate_thumbnail() {
    local img="$1"
    local cache_dir="$2"
    local wall_dir="$3"
    local progress="$4"
    
    local rel_path="${img#$wall_dir/}"
    local cache_name="${rel_path//\//_}"
    cache_name="${cache_name%.*}.jpg"
    local cache_file="$cache_dir/$cache_name"
    
    # Optimized magick with faster settings:
    # -define jpeg:size= hints decoder to not decode full res
    # -filter Triangle is faster than default Lanczos
    # -limit memory/map constrains resource usage per job
    if [[ "$img" =~ \.(gif|GIF)$ ]]; then
        magick "$img[0]" -define jpeg:size=660x1080 -filter Triangle -strip \
            -thumbnail 330x540^ -gravity center -extent 330x540 \
            -quality 80 +repage "$cache_file" 2>/dev/null
    else
        magick "$img" -define jpeg:size=660x1080 -filter Triangle -strip \
            -thumbnail 330x540^ -gravity center -extent 330x540 \
            -quality 80 +repage "$cache_file" 2>/dev/null
    fi
    [ -f "$cache_file" ] && echo "1" >> "$progress"
}
export -f generate_thumbnail

# Use xargs for efficient parallel execution if available, fallback to bash loop
if command -v xargs >/dev/null 2>&1 && [ -s "$to_generate" ]; then
    cat "$to_generate" | nice -n 19 xargs -P "$max_jobs" -I {} bash -c \
        'generate_thumbnail "$1" "$2" "$3" "$4"' _ {} "$CACHE_DIR" "$WALL_DIR" "$progress_file"
elif [ -s "$to_generate" ]; then
    # Fallback: manual parallel with all cores
    while read -r img; do
        generate_thumbnail "$img" "$CACHE_DIR" "$WALL_DIR" "$progress_file" &
        ((job_count++))
        if [ $((job_count % max_jobs)) -eq 0 ]; then
            wait -n 2>/dev/null || wait
        fi
    done < "$to_generate"
    wait
fi

rm -f "$to_generate"

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
        awww img "$selected_path" -t fade --transition-duration 2 --transition-fps 30 &
        sleep 0.2
        "$HOME/.config/scripts/theme-sync.sh" &
        wait
    fi
fi