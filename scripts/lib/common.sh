#!/bin/bash

# --- Logging Functions ---
log_info() {
    local -r timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "\033[1;34m[$timestamp] INFO: $*\033[0m" >&2
}

log_error() {
    local -r timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "\033[1;31m[$timestamp] ERROR: $*\033[0m" >&2
}

log_success() {
    local -r timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "\033[1;32m[$timestamp] SUCCESS: $*\033[0m" >&2
}

log_warn() {
    local -r timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "\033[1;33m[$timestamp] WARN: $*\033[0m" >&2
}

log_debug() {
    if [[ ${DEBUG:-0} -eq 1 ]]; then
        local -r timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        echo -e "\033[1;90m[$timestamp] DEBUG: $*\033[0m" >&2
    fi
}

# --- Error Handling ---
die() {
    log_error "$*"
    exit 1
}

# --- File System Utilities ---
ensure_directory() {
    local -r dir="$1"
    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir" || die "Failed to create directory: $dir"
        log_debug "Created directory: $dir"
    fi
}

validate_file() {
    local -r file="$1"
    local -r description="${2:-File}"
    
    [[ -f "$file" ]] || die "$description not found: $file"
}

validate_executable() {
    local -r file="$1"
    local -r description="${2:-Script}"
    
    validate_file "$file" "$description"
    [[ -x "$file" ]] || die "$description not executable: $file"
}

# --- Process Management ---
acquire_lock() {
    local -r lock_file="$1"
    local -r script_name="${2:-$(basename "$0")}"
    
    if [[ -f "$lock_file" ]]; then
        local pid
        pid=$(cat "$lock_file" 2>/dev/null || echo "")
        if [[ -n "$pid" ]] && kill -0 "$pid" 2>/dev/null; then
            die "Another instance of $script_name is already running (PID: $pid)"
        else
            log_info "Removing stale lock file: $lock_file"
            rm -f "$lock_file"
        fi
    fi
    
    echo $$ >"$lock_file"
    trap "rm -f '$lock_file'" EXIT INT TERM
}

# --- Dependency Validation ---
validate_dependencies() {
    local -ra required_deps=("$@")
    local missing_deps=()
    
    for dep in "${required_deps[@]}"; do
        command -v "$dep" >/dev/null 2>&1 || missing_deps+=("$dep")
    done
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        die "Missing required dependencies: ${missing_deps[*]}"
    fi
    
    log_debug "All dependencies validated: ${required_deps[*]}"
}

# --- Notification Helper ---
send_notification() {
    local -r app_name="$1"
    local -r title="$2"
    local -r message="$3"
    local -r urgency="${4:-normal}"
    local -r icon="${5:-}"
    
    local notify_args=(
        --app-name="$app_name"
        --urgency="$urgency"
    )
    
    [[ -n "$icon" ]] && notify_args+=(--icon="$icon")
    
    notify-send "${notify_args[@]}" "$title" "$message"
}