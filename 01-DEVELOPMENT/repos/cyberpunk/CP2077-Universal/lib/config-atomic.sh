#!/system/bin/sh
# lib/config-atomic.sh — Atomic config file write helper
#
# Provides safe, atomic writes to /data/cp2077.conf with:
# - Temp file buffering
# - Atomic rename
# - Retry with exponential backoff
# - Fallback to direct write with warning
# - Permission validation
#
# Usage: config_write_atomic "variant=glitch" "audio=yes"
#
# Version: v3.1.0
# Updated: 2026-05-16

set -u

CONFIG_FILE="/data/cp2077.conf"
CONFIG_DIR="/data"
TEMP_BASE="/data/cp2077.conf.tmp"
MAX_RETRIES=3
INITIAL_RETRY_DELAY=100  # milliseconds

# ─────────────────────────────────────────────────────────────────────────────
# ATOMIC WRITE HELPER
# ─────────────────────────────────────────────────────────────────────────────

# Write config atomically with retry logic
# Arguments: key=value pairs (e.g., "variant=glitch" "audio=yes")
# Returns: 0 on success, 1 on failure
config_write_atomic() {
  local temp_file
  local retry_delay
  local attempt
  
  # Validate arguments
  if [ $# -eq 0 ]; then
    echo "[ERROR] config_write_atomic: no arguments provided" >&2
    return 1
  fi
  
  # Create temp filename with PID to avoid collisions
  temp_file="${TEMP_BASE}.$$"
  retry_delay=$INITIAL_RETRY_DELAY
  attempt=0
  
  # Step 1: Write to temporary file
  if ! _write_temp_file "$temp_file" "$@"; then
    echo "[ERROR] config_write_atomic: failed to write temp file" >&2
    return 1
  fi
  
  # Step 2: Retry atomic rename with exponential backoff
  while [ $attempt -lt $MAX_RETRIES ]; do
    # Try atomic rename
    if mv "$temp_file" "$CONFIG_FILE" 2>/dev/null; then
      # Success
      chmod 0644 "$CONFIG_FILE" 2>/dev/null || true
      echo "[INFO] config_write_atomic: config updated successfully" >&2
      return 0
    fi
    
    # Retry after delay
    attempt=$((attempt + 1))
    if [ $attempt -lt $MAX_RETRIES ]; then
      echo "[WARN] config_write_atomic: rename failed, retry $attempt/$MAX_RETRIES after ${retry_delay}ms" >&2
      sleep 0.$(printf '%03d' $((retry_delay % 1000)))
      retry_delay=$((retry_delay * 2))  # Exponential backoff
    fi
  done
  
  # Step 3: Fallback to direct write (if atomic rename failed repeatedly)
  echo "[WARN] config_write_atomic: atomic rename failed, falling back to direct write" >&2
  if _write_direct "$CONFIG_FILE" "$@"; then
    return 0
  fi
  
  # Complete failure
  echo "[ERROR] config_write_atomic: all write attempts failed" >&2
  rm -f "$temp_file" 2>/dev/null || true
  return 1
}

# Write lines to temporary file
_write_temp_file() {
  local temp_file="$1"
  shift
  local arg
  
  # Clear temp file
  : > "$temp_file" || return 1
  
  # Write each argument as a line
  for arg in "$@"; do
    echo "$arg" >> "$temp_file" || return 1
  done
  
  # Verify temp file was written
  if [ ! -s "$temp_file" ]; then
    echo "[ERROR] _write_temp_file: temp file is empty" >&2
    return 1
  fi
  
  return 0
}

# Direct write fallback (not atomic, but guaranteed to write)
_write_direct() {
  local target_file="$1"
  shift
  local arg
  
  # Backup existing config if it exists
  if [ -f "$target_file" ]; then
    cp "$target_file" "${target_file}.bak" 2>/dev/null || true
  fi
  
  # Clear target file
  : > "$target_file" || return 1
  
  # Write each argument
  for arg in "$@"; do
    echo "$arg" >> "$target_file" || return 1
  done
  
  # Verify
  if [ ! -s "$target_file" ]; then
    echo "[ERROR] _write_direct: target file is empty" >&2
    return 1
  fi
  
  return 0
}

# ─────────────────────────────────────────────────────────────────────────────
# CONFIG READ HELPER
# ─────────────────────────────────────────────────────────────────────────────

# Read a config value by key
# Usage: config_read "variant"
# Returns the value, or empty string if not found
config_read() {
  local key="$1"
  
  if [ ! -f "$CONFIG_FILE" ]; then
    return 1
  fi
  
  grep "^${key}=" "$CONFIG_FILE" 2>/dev/null | cut -d'=' -f2- | head -1
}

# Safely update a single config key
# Usage: config_update "variant" "glitch"
# Returns: 0 on success, 1 on failure
config_update() {
  local key="$1"
  local value="$2"
  local temp_file
  local line
  local found=0
  
  if [ ! -f "$CONFIG_FILE" ]; then
    # Config file doesn't exist, create it
    echo "${key}=${value}" > "$CONFIG_FILE" || return 1
    chmod 0644 "$CONFIG_FILE" 2>/dev/null || true
    return 0
  fi
  
  # Read-modify-write pattern
  temp_file="${TEMP_BASE}.upd.$$"
  
  # Copy existing config, updating the key
  while IFS= read -r line; do
    if [ "$found" -eq 0 ] && echo "$line" | grep -q "^${key}="; then
      echo "${key}=${value}" >> "$temp_file"
      found=1
    else
      echo "$line" >> "$temp_file"
    fi
  done < "$CONFIG_FILE"
  
  # If key wasn't found, append it
  if [ $found -eq 0 ]; then
    echo "${key}=${value}" >> "$temp_file"
  fi
  
  # Atomic swap
  if mv "$temp_file" "$CONFIG_FILE" 2>/dev/null; then
    chmod 0644 "$CONFIG_FILE" 2>/dev/null || true
    return 0
  fi
  
  rm -f "$temp_file" 2>/dev/null || true
  return 1
}

# ─────────────────────────────────────────────────────────────────────────────
# CONFIG VALIDATION
# ─────────────────────────────────────────────────────────────────────────────

# Validate config file consistency
# Returns: 0 if valid, 1 if corrupted
config_validate() {
  if [ ! -f "$CONFIG_FILE" ]; then
    # Missing is OK (will be created)
    return 0
  fi
  
  # Check for empty file
  if [ ! -s "$CONFIG_FILE" ]; then
    echo "[WARN] config_validate: config file is empty" >&2
    return 1
  fi
  
  # Check for valid key=value format
  if grep -v "^[a-z_]*=" "$CONFIG_FILE" | grep -v "^#" | grep -v "^$"; then
    echo "[WARN] config_validate: invalid lines detected" >&2
    return 1
  fi
  
  return 0
}

# ─────────────────────────────────────────────────────────────────────────────
# EXPORTS
# ─────────────────────────────────────────────────────────────────────────────

export -f config_write_atomic
export -f config_read
export -f config_update
export -f config_validate
