#!/system/bin/sh
# lib/mount-runtime.sh — Shared bind-mount and copy runtime for boot lifecycle
#
# Provides unified mount/copy/verify logic used by post-fs-data.sh and service.sh
# Features:
# - Bind mount with retry and fallback
# - Copy with metadata preservation
# - 5 MB threshold checks for stock stub detection
# - Shared logging
# - Remount verification
#
# Version: v3.1.0
# Updated: 2026-05-16

set -u

# Configuration (can be overridden)
CP2077_LOG_FILE="${CP2077_LOG_FILE:-/data/local/tmp/cp2077-service.log}"
CP2077_MOUNT_MIN_BYTES="${CP2077_MOUNT_MIN_BYTES:-5000000}"  # 5 MB threshold
MOUNT_RETRY_COUNT="${MOUNT_RETRY_COUNT:-3}"
MOUNT_RETRY_DELAY="${MOUNT_RETRY_DELAY:-1}"  # seconds

# ─────────────────────────────────────────────────────────────────────────────
# LOGGING
# ─────────────────────────────────────────────────────────────────────────────

mount_log() {
  local msg="$*"
  local timestamp
  timestamp=$(date '+%Y-%m-%d %H:%M:%S' 2>/dev/null || echo "unknown")
  
  mkdir -p "${CP2077_LOG_FILE%/*}" 2>/dev/null || true
  {
    echo "[$timestamp] [mount] $msg"
  } >> "$CP2077_LOG_FILE" 2>/dev/null || true
  
  # Also log to dmesg if available
  command -v log >/dev/null 2>&1 && log -t cp2077-mount "$msg" 2>/dev/null || true
}

# ─────────────────────────────────────────────────────────────────────────────
# SIZE VERIFICATION
# ─────────────────────────────────────────────────────────────────────────────

# Get file size in bytes
get_file_size() {
  local file="$1"
  if [ -f "$file" ]; then
    wc -c < "$file" 2>/dev/null || echo 0
  else
    echo 0
  fi
}

# Check if file is below minimum threshold (stock stub detection)
is_file_small() {
  local target="$1"
  local min="${2:-$CP2077_MOUNT_MIN_BYTES}"
  local size
  
  if [ ! -f "$target" ]; then
    return 1
  fi
  
  size=$(get_file_size "$target")
  [ "$size" -lt "$min" ]
}

# ─────────────────────────────────────────────────────────────────────────────
# COPY OPERATIONS
# ─────────────────────────────────────────────────────────────────────────────

# Copy file with metadata preservation
# Usage: copy_file <source> <dest> [owner:group]
copy_file() {
  local src="$1"
  local dst="$2"
  local owner="${3:-system:graphics}"
  local dst_dir
  
  if [ ! -f "$src" ]; then
    mount_log "copy skip: source not found: $src"
    return 1
  fi
  
  dst_dir="${dst%/*}"
  mkdir -p "$dst_dir" 2>/dev/null || true
  
  # Copy preserving modification time and permissions
  if cp -af "$src" "$dst" 2>/dev/null; then
    chmod 644 "$dst" 2>/dev/null || true
    chown "$owner" "$dst" 2>/dev/null || true
    mount_log "copy ok: $src -> $dst"
    return 0
  fi
  
  mount_log "copy failed: $src -> $dst"
  return 1
}

# ─────────────────────────────────────────────────────────────────────────────
# MOUNT OPERATIONS (CORE)
# ─────────────────────────────────────────────────────────────────────────────

# Single bind mount attempt
_do_bind_mount() {
  local src="$1"
  local target="$2"
  
  if [ ! -f "$src" ]; then
    mount_log "mount skip: source not found: $src"
    return 1
  fi
  
  if [ ! -e "$target" ]; then
    mount_log "mount skip: target not found: $target"
    return 1
  fi
  
  # Unmount if already mounted (idempotent)
  umount "$target" 2>/dev/null || true
  
  # Attempt bind mount
  if mount --bind "$src" "$target" 2>/dev/null; then
    mount_log "mount ok: $src -> $target"
    return 0
  fi
  
  mount_log "mount failed: $src -> $target"
  return 1
}

# Bind mount with retry logic
# Usage: mount_with_retry <source> <target> [retry_count] [retry_delay]
mount_with_retry() {
  local src="$1"
  local target="$2"
  local retry_count="${3:-$MOUNT_RETRY_COUNT}"
  local retry_delay="${4:-$MOUNT_RETRY_DELAY}"
  local attempt=0
  
  while [ "$attempt" -lt "$retry_count" ]; do
    if _do_bind_mount "$src" "$target"; then
      return 0
    fi
    
    attempt=$((attempt + 1))
    if [ "$attempt" -lt "$retry_count" ]; then
      mount_log "mount retry: attempt $attempt/$retry_count after ${retry_delay}s"
      sleep "$retry_delay"
    fi
  done
  
  mount_log "mount exhausted: $src -> $target ($retry_count attempts)"
  return 1
}

# ─────────────────────────────────────────────────────────────────────────────
# VERIFICATION AND REMOUNT
# ─────────────────────────────────────────────────────────────────────────────

# Verify mount target exists and is above minimum size
# Usage: verify_mount <target> [min_bytes]
verify_mount() {
  local target="$1"
  local min="${2:-$CP2077_MOUNT_MIN_BYTES}"
  local size
  
  if [ ! -f "$target" ]; then
    mount_log "verify skip: target not found: $target"
    return 1
  fi
  
  size=$(get_file_size "$target")
  
  if [ "$size" -ge "$min" ]; then
    mount_log "verify ok: $target (size=$size)"
    return 0
  fi
  
  mount_log "verify small: $target (size=$size, threshold=$min)"
  return 1
}

# Remount if file is too small (stock stub detection and repair)
# Usage: remount_if_small <target> <source> [min_bytes]
remount_if_small() {
  local target="$1"
  local src="$2"
  local min="${3:-$CP2077_MOUNT_MIN_BYTES}"
  local size
  
  if [ ! -f "$target" ]; then
    mount_log "remount skip: target not found: $target"
    return 0
  fi
  
  if [ ! -f "$src" ]; then
    mount_log "remount skip: source not found: $src"
    return 0
  fi
  
  size=$(get_file_size "$target")
  
  if [ "$size" -lt "$min" ]; then
    mount_log "remount detected: small file: $target (size=$size < $min)"
    umount "$target" 2>/dev/null || true
    mount_with_retry "$src" "$target" 2 1
    verify_mount "$target" "$min"
    return $?
  fi
  
  mount_log "remount skip: file is large enough: $target (size=$size)"
  return 0
}

# ─────────────────────────────────────────────────────────────────────────────
# COMPOSITE OPERATIONS
# ─────────────────────────────────────────────────────────────────────────────

# Mount with automatic copy fallback
# Usage: mount_with_copy <source> <target> [owner]
mount_with_copy() {
  local src="$1"
  local target="$2"
  local owner="${3:-system:graphics}"
  
  # Try mount first (preferred)
  if mount_with_retry "$src" "$target" 2 1; then
    return 0
  fi
  
  # Fallback: copy file
  mount_log "fallback: copying instead of mounting"
  copy_file "$src" "$target" "$owner"
  return $?
}

# ─────────────────────────────────────────────────────────────────────────────
# DEBUGGING UTILITIES
# ─────────────────────────────────────────────────────────────────────────────

# Print mount status of all target paths
mount_status() {
  local targets=(
    "/product/media/bootanimation.zip"
    "/product/media/bootanimation-dark.zip"
    "/system/media/bootanimation.zip"
    "/data/local/bootanimation.zip"
    "/data/misc/bootanim/bootanimation.zip"
  )
  
  mount_log "=== MOUNT STATUS REPORT ==="
  for target in "${targets[@]}"; do
    if [ -f "$target" ]; then
      local size
      local mount_info
      size=$(get_file_size "$target")
      mount_info=$(mount | grep "$target" || echo "not mounted")
      mount_log "  $target: size=$size mounted=$mount_info"
    fi
  done
  mount_log "=== END REPORT ==="
}

# ─────────────────────────────────────────────────────────────────────────────
# EXPORTS
# ─────────────────────────────────────────────────────────────────────────────

export -f mount_log
export -f get_file_size
export -f is_file_small
export -f copy_file
export -f mount_with_retry
export -f verify_mount
export -f remount_if_small
export -f mount_with_copy
export -f mount_status
