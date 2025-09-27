#!/bin/bash

set -euo pipefail

sleep 0.3 # let waytrogen set the wallpaper

# Source common utilities if available
if [[ -f "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh" ]]; then
  source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"
else
  # Fallback logging functions if common.sh is not available
  log_info() {
    local -r timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "\\033[1;34m[$timestamp] INFO: $*\\033[0m" >&2
  }

  log_error() {
    local -r timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "\\033[1;31m[$timestamp] ERROR: $*\\033[0m" >&2
  }

  log_success() {
    local -r timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "\\033[1;32m[$timestamp] SUCCESS: $*\\033[0m" >&2
  }

  log_warn() {
    local -r timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "\\033[1;33m[$timestamp] WARN: $*\\033[0m" >&2
  }

  die() {
    log_error "$*"
    exit 1
  }

  validate_dependencies() {
    local -ra required_deps=("$@")
    local missing_deps=()

    for dep in "${required_deps[@]}"; do
      command -v "$dep" > /dev/null 2>&1 || missing_deps+=("$dep")
    done

    if [[ ${#missing_deps[@]} -gt 0 ]]; then
      die "Missing required dependencies: ${missing_deps[*]}"
    fi
  }
fi

# --- Configuration ---
readonly SCRIPT_NAME="${0##*/}"
readonly WALLPAPERS_DIR="$HOME/Pictures/Wallpapers"
readonly DEFAULT_GTK_THEME="Colloid-Dark"
readonly DEFAULT_ICON_THEME="Colloid-Dark"

# Get theme based on directory and variation
map_to_gtk_theme() {
  local theme_name="$1"
  local variation="$2"

  case "${theme_name}" in
    "catppuccin")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Light-Catppuccin"
      else
        echo "Colloid-Dark-Catppuccin"
      fi
      ;;
    "dracula")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Light-Dracula"
      else
        echo "Colloid-Dark-Dracula"
      fi
      ;;
    "everforest")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Light-Everforest"
      else
        echo "Colloid-Dark-Everforest"
      fi
      ;;
    "gruvbox")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Light-Gruvbox"
      else
        echo "Colloid-Dark-Gruvbox"
      fi
      ;;
    "material")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Light"
      else
        echo "Colloid-Grey-Dark"
      fi
      ;;
    "nord")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Light-Nord"
      else
        echo "Colloid-Dark-Nord"
      fi
      ;;
    "solarized")
      if [[ "$variation" == "light" ]]; then
        echo "Osaka-Light-Solarized"
      else
        echo "Osaka-Dark-Solarized"
      fi
      ;;
    "rose-pine")
      if [[ "$variation" == "light" ]]; then
        echo "Rosepine-Light"
      else
        echo "Rosepine-Dark"
      fi
      ;;
    "tokyo-night")
      if [[ "$variation" == "light" ]]; then
        echo "Tokyonight-Light"
      else
        echo "Tokyonight-Dark"
      fi
      ;;
    *)
      log_warn "Unknown theme: $theme_name, using default theme"
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Light"
      else
        echo "Colloid-Dark"
      fi
      ;;
  esac
}

map_to_icon_theme() {
  local theme_name="$1"
  local variation="$2"

  case "${theme_name}" in
    "catppuccin")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Catppuccin-Light"
      else
        echo "Colloid-Catppuccin-Dark"
      fi
      ;;
    "dracula")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Dracula-Light"
      else
        echo "Colloid-Dracula-Dark"
      fi
      ;;
    "everforest")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Everforest-Light"
      else
        echo "Colloid-Everforest-Dark"
      fi
      ;;
    "gruvbox")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Gruvbox-Light"
      else
        echo "Colloid-Gruvbox-Dark"
      fi
      ;;
    "material")
      # Base colloid-dark for material as requested
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Light"
      else
        echo "Colloid-Dark"
      fi
      ;;
    "nord")
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Nord-Light"
      else
        echo "Colloid-Nord-Dark"
      fi
      ;;
    "solarized")
      # everforest for osaka (solarized) as requested
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Everforest-Light"
      else
        echo "Colloid-Everforest-Dark"
      fi
      ;;
    "rose-pine" | "tokyo-night")
      # catppuccin for rose-pine and tokyo-night as requested
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Catppuccin-Light"
      else
        echo "Colloid-Catppuccin-Dark"
      fi
      ;;
    *)
      log_warn "Unknown theme: $theme_name, using default icon theme"
      if [[ "$variation" == "light" ]]; then
        echo "Colloid-Light"
      else
        echo "Colloid-Dark"
      fi
      ;;
  esac
}

map_to_wallust_theme() {
  local theme_name="$1"
  local variation="$2"

  case "${theme_name}" in
    "catppuccin")
      if [[ "$variation" == "light" ]]; then
        echo "Catppuccin-Latte"
      else
        echo "Catppuccin-Mocha"
      fi
      ;;
    "dracula")
      if [[ "$variation" == "light" ]]; then
        echo "base16-default-light"
      else
        echo "base16-dracula"
      fi
      ;;
    "everforest")
      if [[ "$variation" == "light" ]]; then
        echo "Everforest-Light-Medium"
      else
        echo "Everforest-Dark-Medium"
      fi
      ;;
    "gruvbox")
      if [[ "$variation" == "light" ]]; then
        echo "Gruvbox-Material-Light"
      else
        echo "Gruvbox-Material-Dark"
      fi
      ;;
    "material")
      if [[ "$variation" == "light" ]]; then
        echo "base16-default-light"
      else
        echo "base16-black-metal-funeral"
      fi
      ;;
    "nord")
      if [[ "$variation" == "light" ]]; then
        echo "Nord-Light"
      else
        echo "Nord"
      fi
      ;;
    "solarized")
      if [[ "$variation" == "light" ]]; then
        echo "Solarized-Light"
      else
        echo "Solarized-Dark"
      fi
      ;;
    "rose-pine")
      if [[ "$variation" == "light" ]]; then
        echo "Rosé-Pine-Dawn"
      else
        echo "Rosé-Pine"
      fi
      ;;
    "tokyo-night")
      if [[ "$variation" == "light" ]]; then
        echo "Tokyo-Night-Light"
      else
        echo "Tokyo-Night"
      fi
      ;;
    *)
      log_warn "Unknown theme: $theme_name, using random theme"
      echo "random"
      ;;
  esac
}

# --- Functions ---

detect_theme_from_wallpaper() {
  log_info "Detecting theme from current wallpaper directory"

  # Get current wallpaper from swww
  local wallpaper_path
  wallpaper_path=$(swww query 2> /dev/null | grep -oP '(?<=image: ).*' | head -n1 | tr -d '\n\r')

  if [[ -z "$wallpaper_path" ]]; then
    die "No wallpaper detected from swww query"
  fi

  if [[ ! -f "$wallpaper_path" ]]; then
    die "Wallpaper file does not exist: $wallpaper_path"
  fi

  log_debug "Found wallpaper: $wallpaper_path"

  # Extract theme from directory path (e.g., /path/to/Wallpapers/Catppuccin/Dark/file.jpg -> Catppuccin)
  local theme_dir
  theme_dir=$(dirname "$wallpaper_path")
  local parent_dir
  parent_dir=$(dirname "$theme_dir")

  # Get the theme name from the parent directory
  local theme_name
  theme_name=$(basename "$parent_dir" | tr '[:upper:]' '[:lower:]')

  # Also get the variation (e.g., Dark or Light from the immediate directory)
  local variation
  variation=$(basename "$theme_dir" | tr '[:upper:]' '[:lower:]')

  # Special case: 'osaka' should be treated as 'solarized'
  if [[ "$theme_name" == "osaka" ]]; then
    theme_name="solarized"
  fi

  log_debug "Detected theme: $theme_name, variation: $variation"

  # Store the variation for later use
  export WALLPAPER_VARIATION="$variation"

  echo "$theme_name"
}

# Function to set values in INI files
set_ini_value() {
  local -r file="$1"
  local -r section="$2"
  local -r key="$3"
  local -r value="$4"

  [[ -f "$file" ]] || touch "$file"

  if grep -q "^\\[$section\\]" "$file"; then
    if grep -q "^$key=" "$file"; then
      sed -i "/^\\[$section\\]/,/^\\[/ s/^$key=.*/$key=$value/" "$file"
    else
      sed -i "/^\\[$section\\]/a $key=$value" "$file"
    fi
  else
    printf '\\n[%s]\\n%s=%s\\n' "$section" "$key" "$value" >> "$file"
  fi
}

manage_gtk_config() {
  local -r version="$1"
  local -r theme="$2"
  local -r variation="${3:-dark}"
  local -r config_file="$HOME/.config/gtk-$version/settings.ini"

  # Create directory if it doesn't exist
  mkdir -p "$(dirname "$config_file")"

  set_ini_value "$config_file" "Settings" "gtk-theme-name" "$theme"

  # Set prefer-dark-theme based on variation
  if [[ "$variation" == "light" ]]; then
    set_ini_value "$config_file" "Settings" "gtk-application-prefer-dark-theme" "0"
  else
    set_ini_value "$config_file" "Settings" "gtk-application-prefer-dark-theme" "1"
  fi
}

update_xsettingsd() {
  local -r theme="$1"
  local -r icon_theme="$2"
  local -r config_file="$HOME/.config/xsettingsd/xsettingsd.conf"

  # Create directory if it doesn't exist
  mkdir -p "$(dirname "$config_file")"

  # Check if file exists, create it with proper format if it doesn't
  if [[ ! -f "$config_file" ]]; then
    printf 'Net/ThemeName "%s"
Net/IconThemeName "%s"
' "$theme" "$icon_theme" > "$config_file"
  else
    sed -i "s/Net\/ThemeName \".*\"/Net\/ThemeName \"$theme\"/; s/Net\/IconThemeName \".*\"/Net\/IconThemeName \"$icon_theme\"/" "$config_file" 2> /dev/null ||
      log_warn "Failed to update xsettingsd config for theme name"
  fi
}

update_gtk_settings() {
  local -r gtk_theme="$1"

  # Set the GTK theme using gsettings
  gsettings set org.gnome.desktop.interface gtk-theme "$gtk_theme" 2> /dev/null || {
    log_warn "Failed to set GTK theme via gsettings, may not be available"
  }

  # Set color scheme based on variation
  if [[ "$WALLPAPER_VARIATION" == "light" ]]; then
    gsettings set org.gnome.desktop.interface color-scheme "prefer-light" 2> /dev/null || {
      log_warn "Failed to set light color scheme via gsettings"
    }
  else
    gsettings set org.gnome.desktop.interface color-scheme "prefer-dark" 2> /dev/null || {
      log_warn "Failed to set dark color scheme via gsettings"
    }
  fi
}

manage_symlinks() {
  local -r theme="$1"
  local target_dir=""

  # Find theme directory
  local -ra theme_paths=(
    "$HOME/.themes/$theme"
    "$HOME/.local/share/themes/$theme"
    "/usr/share/themes/$theme"
  )

  for path in "${theme_paths[@]}"; do
    if [[ -d "$path" ]]; then
      target_dir="$path"
      break
    fi
  done

  [[ -n "$target_dir" ]] || {
    log_warn "Theme assets not found: $theme, skipping symlinks"
    return 1
  }

  # Create symlinks for GTK 4.0
  local -r gtk4_dir="$HOME/.config/gtk-4.0"
  mkdir -p "$gtk4_dir"

  declare -A links=(
    ["$gtk4_dir/gtk.css"]="gtk-4.0/gtk.css"
    ["$gtk4_dir/gtk-dark.css"]="gtk-4.0/gtk-dark.css"
    ["$gtk4_dir/assets"]="gtk-4.0/assets"
  )

  # Create symlinks
  for link in "${!links[@]}"; do
    local target="$target_dir/${links[$link]}"
    [[ -e "$target" ]] || continue

    mkdir -p "$(dirname "$link")"
    ln -sf "$target" "$link" && log_info "Created symlink: ${link##*/}"
  done
}

set_gtk_theme() {
  local -r gtk_theme="$1"

  log_info "Setting GTK theme to: $gtk_theme"

  # Check if theme directory exists
  local theme_found=0
  local -ra theme_paths=(
    "$HOME/.themes/$gtk_theme"
    "$HOME/.local/share/themes/$gtk_theme"
    "/usr/share/themes/$gtk_theme"
  )

  for path in "${theme_paths[@]}"; do
    if [[ -d "$path" ]]; then
      theme_found=1
      break
    fi
  done

  if [[ $theme_found -eq 0 ]]; then
    log_warn "GTK theme not found: $gtk_theme, skipping theme change"
    return
  fi

  # Apply theme through multiple methods to ensure coverage
  update_gtk_settings "$gtk_theme"
  manage_gtk_config "3.0" "$gtk_theme" "$wallpaper_variation"
  manage_gtk_config "4.0" "$gtk_theme" "$wallpaper_variation"
  manage_symlinks "$gtk_theme"
  update_xsettingsd "$gtk_theme" "$icon_theme"

  log_success "GTK theme set to: $gtk_theme with comprehensive configuration"
}

set_icon_theme() {
  local -r icon_theme="$1"

  log_info "Setting icon theme to: $icon_theme"

  # Check if icon theme directory exists
  local theme_found=0
  local -ra icon_theme_paths=(
    "$HOME/.icons/$icon_theme"
    "$HOME/.local/share/icons/$icon_theme"
    "/usr/share/icons/$icon_theme"
  )

  for path in "${icon_theme_paths[@]}"; do
    if [[ -d "$path" ]]; then
      theme_found=1
      break
    fi
  done

  if [[ $theme_found -eq 0 ]]; then
    log_warn "Icon theme not found: $icon_theme, skipping icon theme change"
    return
  fi

  # Set the icon theme
  gsettings set org.gnome.desktop.interface icon-theme "$icon_theme" || {
    log_warn "Failed to set icon theme, gsettings may not be available"
  }

  log_success "Icon theme set to: $icon_theme"
}

run_wallust_theme() {
  local -r wallust_theme="$1"
  local -r wallpaper_path="$2"

  log_info "Running wallust with theme: $wallust_theme for wallpaper: $wallpaper_path"

  if [[ "$wallust_theme" == "random" ]]; then
    # Just run wallust on the wallpaper without a specific theme if unknown
    log_info "Running wallust in auto mode for: $wallpaper_path"
    if ! wallust run "$wallpaper_path" --dynamic-threshold 2> /dev/null; then
      log_warn "Wallust theme generation failed, continuing..."
    else
      log_success "Wallust theme generation completed"
    fi
  else
    # Try to apply the specific theme if available
    log_info "Applying specific wallust theme: $wallust_theme"
    if ! wallust theme "$wallust_theme" 2> /dev/null; then
      log_warn "Specific wallust theme failed, falling back to auto-generation for: $wallpaper_path"
      # Fallback to running wallust on the wallpaper directly
      if ! wallust run "$wallpaper_path" --dynamic-threshold 2> /dev/null; then
        log_warn "Wallust generation failed completely, continuing..."
      else
        log_success "Wallust fallback theme generation completed"
      fi
    else
      log_success "Wallust specific theme applied: $wallust_theme"
    fi
  fi
}

main() {
  log_info "Starting dynamic theme synchronization"

  # Validate dependencies
  validate_dependencies "swww" "wallust" "gsettings"

  # Detect theme from current wallpaper
  local detected_theme
  detected_theme=$(detect_theme_from_wallpaper)

  # First, detect theme and variation separately
  local wallpaper_path
  wallpaper_path=$(swww query 2> /dev/null | grep -oP '(?<=image: ).*' | head -n1 | tr -d '\n\r')

  if [[ -z "$wallpaper_path" ]]; then
    die "No wallpaper detected from swww query"
  fi

  if [[ ! -f "$wallpaper_path" ]]; then
    die "Wallpaper file does not exist: $wallpaper_path"
  fi

  # Extract theme and variation from directory path
  local theme_dir
  theme_dir=$(dirname "$wallpaper_path")
  local parent_dir
  parent_dir=$(dirname "$theme_dir")

  local detected_theme
  detected_theme=$(basename "$parent_dir" | tr '[:upper:]' '[:lower:]')

  local wallpaper_variation
  wallpaper_variation=$(basename "$theme_dir" | tr '[:upper:]' '[:lower:]')

  # Special case: 'osaka' should be treated as 'solarized'
  if [[ "$detected_theme" == "osaka" ]]; then
    detected_theme="solarized"
  fi

  log_info "Detected theme: $detected_theme, variation: $wallpaper_variation"

  # Store the variation for functions that need access to it
  export WALLPAPER_VARIATION="$wallpaper_variation"

  # Map to appropriate themes using both theme and variation
  local gtk_theme
  gtk_theme=$(map_to_gtk_theme "$detected_theme" "$wallpaper_variation")

  local icon_theme
  icon_theme=$(map_to_icon_theme "$detected_theme" "$wallpaper_variation")

  local wallust_theme
  wallust_theme=$(map_to_wallust_theme "$detected_theme" "$wallpaper_variation")

  # Apply themes
  set_gtk_theme "$gtk_theme"
  set_icon_theme "$icon_theme"
  run_wallust_theme "$wallust_theme" "$wallpaper_path"

  log_success "Dynamic theme synchronization completed successfully"

  # Send notification if notify-send is available
  if command -v notify-send > /dev/null 2>&1; then
    notify-send "Theme Sync" "Theme updated to: $detected_theme" \
      --icon=preferences-desktop-theme --urgency=low
  fi
}

# --- Script Entry Point ---
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
