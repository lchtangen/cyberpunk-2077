#!/system/bin/sh
# lib/root-runtime.sh — unified root-manager abstraction layer.
# Detects, dispatches, and adapts for Magisk / KernelSU / APatch.
# APatch v0.10+: binary at /data/adb/ap/bin/apd; `ap info` replaces `apd info`.

# ── APatch v0.10+ binary helper ───────────────────────────────────────────────

_apatch_bin() {
  if [ -f /data/adb/ap/bin/apd ]; then
    echo /data/adb/ap/bin/apd
  else
    echo apd
  fi
}

_apatch_cmd() {
  "$(_apatch_bin)" "$@" 2>/dev/null
}

_apatch_detected() {
  [ -f /data/adb/ap/bin/apd ] && return 0
  [ -d /data/adb/ap ] && return 0
  command -v apd >/dev/null 2>&1 && return 0
  return 1
}

# ── Module directory resolution ───────────────────────────────────────────────

detect_module_dir() {
  local id="${1:-CP2077_OP7Pro_Full}"
  if [ -d "/data/adb/modules/$id" ]; then
    echo "/data/adb/modules/$id"
    return 0
  fi
  if [ -d "/data/adb/modules/$id-disabled" ]; then
    echo "/data/adb/modules/$id-disabled"
    return 0
  fi
  echo ""
  return 1
}

# ── Root manager detection ──────────────────────────────────────────────────────

detect_root_manager() {
  if [ -f "/data/adb/modules/CP2077_OP7Pro_Full/module.prop" ] && \
     command -v magisk >/dev/null 2>&1; then
    echo "magisk"
    return 0
  fi
  if [ -d "/data/adb/ksu" ] || command -v ksud >/dev/null 2>&1; then
    echo "kernelsu"
    return 0
  fi
  if _apatch_detected; then
    echo "apatch"
    return 0
  fi
  if command -v magisk >/dev/null 2>&1; then
    echo "magisk"
    return 0
  fi
  echo "unknown"
  return 1
}

is_root_manager_active() {
  local manager
  manager="$(detect_root_manager)"
  case "$manager" in
    magisk|kernelsu|apatch) return 0 ;;
    *) return 1 ;;
  esac
}

# ── WebUI bridge path detection ───────────────────────────────────────────────

detect_webui_bridge() {
  local manager="${1:-$(detect_root_manager)}"
  local MODDIR
  MODDIR="$(detect_module_dir)" || { echo ""; return 1; }

  case "$manager" in
    magisk|kernelsu|apatch)
      if [ -f "$MODDIR/webroot/cp2077.js" ]; then
        echo "$MODDIR/webroot/cp2077.js"
        return 0
      fi
      ;;
  esac

  if [ -f "/data/data/com.topjohnwu.magisk/files/bridge.js" ]; then
    echo "/data/data/com.topjohnwu.magisk/files/bridge.js"
    return 0
  fi
  if [ -f "/data/data/com.termux/files/usr/share/mmgr/bridge.js" ]; then
    echo "/data/data/com.termux/files/usr/share/mmgr/bridge.js"
    return 0
  fi
  echo ""
  return 1
}

# ── Module state detection ──────────────────────────────────────────────────────

is_module_enabled() {
  local id="${1:-CP2077_OP7Pro_Full}"
  [ ! -d "/data/adb/modules/$id-disabled" ] && \
  [ -d "/data/adb/modules/$id" ] && return 0 || return 1
}

is_module_installed() {
  local id="${1:-CP2077_OP7Pro_Full}"
  [ -d "/data/adb/modules/$id" ] || [ -d "/data/adb/modules/$id-disabled" ]
}

# ── Command dispatch ────────────────────────────────────────────────────────────

run_root_command() {
  local cmd="$1" args="${2:-}" manager
  manager="$(detect_root_manager)"

  case "$manager" in
    magisk)
      case "$cmd" in
        install)
          magisk --install-module "$args" 2>/dev/null && return 0
          return 1
          ;;
        enable)
          magisk --enable-module "${2:-CP2077_OP7Pro_Full}" 2>/dev/null && return 0
          return 1
          ;;
        disable)
          magisk --disable-module "${2:-CP2077_OP7Pro_Full}" 2>/dev/null && return 0
          return 1
          ;;
        uninstall)
          magisk --remove-module "${2:-CP2077_OP7Pro_Full}" 2>/dev/null && return 0
          return 1
          ;;
        status)
          magisk -c 2>/dev/null | grep -q . && return 0 || return 1
          ;;
        webui_bridge)
          detect_webui_bridge "magisk"
          return 0
          ;;
      esac
      ;;
    kernelsu)
      case "$cmd" in
        install)
          ksud module install "$args" 2>/dev/null && return 0
          return 1
          ;;
        enable)
          ksud module enable "${2:-CP2077_OP7Pro_Full}" 2>/dev/null && return 0
          return 1
          ;;
        disable)
          ksud module disable "${2:-CP2077_OP7Pro_Full}" 2>/dev/null && return 0
          return 1
          ;;
        uninstall)
          ksud module uninstall "${2:-CP2077_OP7Pro_Full}" 2>/dev/null && return 0
          return 1
          ;;
        status)
          ksud 2>/dev/null | grep -q . && return 0 || return 1
          ;;
        webui_bridge)
          detect_webui_bridge "kernelsu"
          return 0
          ;;
      esac
      ;;
    apatch)
      case "$cmd" in
        install)
          _apatch_cmd module install "$args" && return 0
          return 1
          ;;
        enable)
          _apatch_cmd module enable "${2:-CP2077_OP7Pro_Full}" && return 0
          return 1
          ;;
        disable)
          _apatch_cmd module disable "${2:-CP2077_OP7Pro_Full}" && return 0
          return 1
          ;;
        uninstall)
          _apatch_cmd module uninstall "${2:-CP2077_OP7Pro_Full}" && return 0
          return 1
          ;;
        status)
          _apatch_cmd info | grep -q . && return 0 || return 1
          ;;
        webui_bridge)
          detect_webui_bridge "apatch"
          return 0
          ;;
      esac
      ;;
  esac

  echo "root-runtime: unsupported command '$cmd' for manager '$manager'" >&2
  return 1
}

# ── Convenience helpers ─────────────────────────────────────────────────────────

cp2077_root_status() {
  local manager MODDIR enabled
  manager="$(detect_root_manager)"
  MODDIR="$(detect_module_dir)" || MODDIR="not found"
  if is_module_installed; then
    if is_module_enabled; then
      enabled="enabled"
    else
      enabled="disabled"
    fi
  else
    enabled="not installed"
  fi
  echo "root_manager=$manager module_dir=$MODDIR module_state=$enabled"
}

# ── Standalone invocation ────────────────────────────────────────────────────────
if [ "${0##*/}" = "root-runtime.sh" ]; then
  case "${1:-status}" in
    detect)   detect_root_manager ;;
    moddir)   detect_module_dir "${2:-}" ;;
    enabled)  is_module_enabled "${2:-}" && echo "yes" || echo "no" ;;
    installed) is_module_installed "${2:-}" && echo "yes" || echo "no" ;;
    webui)   detect_webui_bridge ;;
    status)  cp2077_root_status ;;
    run)     run_root_command "${2:-}" "${3:-}" ;;
    *)       echo "Usage: root-runtime.sh {detect|moddir|enabled|installed|webui|status|run cmd [arg]}" ;;
  esac
fi