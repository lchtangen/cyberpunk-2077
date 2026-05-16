#!/usr/bin/env bash
# cp2077-adb-control.sh — Arch host ADB toolkit for CP2077 module
# Usage: ./cp2077-adb-control.sh [command] [args]
# Requires: adb in PATH, device connected with USB debugging + root

set -euo pipefail

# ── Color palette ─────────────────────────────────────────────────
YLW='\033[38;2;252;238;12m'   # #FCEE0C
CYN='\033[38;2;0;255;255m'    # #00FFFF
RED='\033[38;2;255;0;60m'     # #FF003C
GRN='\033[38;2;0;255;159m'    # #00FF9F
DIM='\033[2m'
RST='\033[0m'
BOLD='\033[1m'

# ── Defaults ──────────────────────────────────────────────────────
MODULE_ID="CP2077_OP7Pro_Full"
CONFIG_REMOTE="/data/cp2077.conf"
MODULE_DIR_REMOTE="/data/adb/modules/${MODULE_ID}"
WORKSPACE_ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
RELEASE_ZIP="${WORKSPACE_ROOT}/01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/release/CP2077-OP7Pro-v3.1.0.zip"

# ── Helpers ───────────────────────────────────────────────────────
_header() {
  echo -e "${YLW}${BOLD}"
  echo "  ╔══════════════════════════════════════════════════════╗"
  echo "  ║  ░▒▓ CP2077 ADB CONTROL  ▓▒░                        ║"
  echo "  ║  Arch Host → OnePlus 7 Pro (guacamole)              ║"
  echo "  ╚══════════════════════════════════════════════════════╝${RST}"
  echo ""
}

_check_adb() {
  if ! command -v adb &>/dev/null; then
    echo -e "${RED}  ✗ adb not found. Install: sudo pacman -S android-tools${RST}" >&2
    exit 1
  fi
  if ! adb get-state &>/dev/null; then
    echo -e "${RED}  ✗ No device connected or ADB unauthorised.${RST}" >&2
    echo -e "${DIM}    Enable USB Debugging and authorise this computer.${RST}" >&2
    exit 1
  fi
}

_su() {
  adb shell su -c "$*" 2>/dev/null
}

_print_device_info() {
  local model api rel magisk
  model=$(adb shell getprop ro.product.model 2>/dev/null | tr -d '\r')
  api=$(adb shell getprop ro.build.version.sdk 2>/dev/null | tr -d '\r')
  rel=$(adb shell getprop ro.build.version.release 2>/dev/null | tr -d '\r')
  magisk=$(adb shell su -c 'magisk -v 2>/dev/null || echo "?"' 2>/dev/null | tr -d '\r')
  echo -e "  ${DIM}Device  :${RST} ${CYN}${model}${RST}"
  echo -e "  ${DIM}Android :${RST} ${CYN}${rel} (API ${api})${RST}"
  echo -e "  ${DIM}Magisk  :${RST} ${CYN}${magisk}${RST}"
  echo ""
}

# ── Commands ──────────────────────────────────────────────────────

cmd_status() {
  echo -e "${YLW}── STATUS ─────────────────────────────────────────────${RST}"
  _print_device_info

  echo -e "  ${DIM}Config (${CONFIG_REMOTE}):${RST}"
  _su "cat ${CONFIG_REMOTE} 2>/dev/null || echo '  (not found)'" | sed 's/^/    /'
  echo ""

  echo -e "  ${DIM}Active animation sizes:${RST}"
  for p in /product/media/bootanimation.zip \
            /product/media/bootanimation-dark.zip \
            /product/media/shutdownanimation.zip \
            /product/media/rbootanimation.zip \
            /data/local/bootanimation.zip; do
    local sz
    sz=$(_su "wc -c < '$p' 2>/dev/null || echo 0" | tr -d '\r')
    local mb=$(( sz / 1024 / 1024 ))
    local col="${RED}"
    [ "$mb" -ge 5 ] && col="${GRN}"
    echo -e "    ${col}${mb} MB${RST}  ${DIM}${p}${RST}"
  done
  echo ""

  echo -e "  ${DIM}Module directory:${RST}"
  _su "ls -la '${MODULE_DIR_REMOTE}/' 2>/dev/null || echo '  (not found)'" | sed 's/^/    /'
  echo ""
}

cmd_switch() {
  local variant="${1:-}"
  local valid_variants="glitch flatline reboot og1080p og4k glitch-v2"

  if [ -z "$variant" ]; then
    echo -e "${YLW}── SELECT VARIANT ─────────────────────────────────────${RST}"
    echo ""
    echo -e "  ${CYN}[1] CyberGlitch-2077${RST}        glitch logo · 60fps · 1440×3120 ← recommended"
    echo -e "  ${CYN}[2] Cyberpunk-Flatline${RST}       flatline ECG · 60fps · 1440×3120"
    echo -e "  ${CYN}[3] Re-Boot Animation${RST}        OP logo+glitch · 60fps · 1440×3120"
    echo -e "  ${CYN}[4] Original 1080p${RST}           8T SE port · 30fps · 1080×2340"
    echo -e "  ${CYN}[5] Original 4K${RST}              LANCZOS upscaled \u00b7 30fps \u00b7 2160\u00d74800"
    echo ""
    echo -e "  ${CYN}[6] CyberGlitch-v2-2077${RST}      enhanced glitch · 60fps · 1440×3120"
    echo ""
    printf "  Choice [1-6]: "
    read -r c
    case "$c" in
      1|glitch)   variant="glitch" ;;
      2|flatline) variant="flatline" ;;
      3|reboot)   variant="reboot" ;;
      4|og1080p)  variant="og1080p" ;;
      5|og4k)      variant="og4k" ;;
      6|glitch-v2) variant="glitch-v2" ;;
      *) echo -e "${RED}  Invalid choice.${RST}"; exit 1 ;;
    esac
  fi

  if ! echo "$valid_variants" | grep -qw "$variant"; then
    echo -e "${RED}  \u2717 Unknown variant: $variant${RST}" >&2
    echo -e "${DIM}    Valid: glitch | flatline | reboot | og1080p | og4k | glitch-v2${RST}" >&2
    exit 1
  fi

  echo -e "${YLW}── SWITCHING VARIANT → ${variant} ────────────────────────${RST}"
  # Read existing config values so we only update variant, preserving audio/silent/etc.
  local _cur_audio _cur_silent
  _cur_audio=$(_su "grep '^audio=' '${CONFIG_REMOTE}' 2>/dev/null | cut -d= -f2" | tr -d '\r')
  _cur_silent=$(_su "grep '^silent=' '${CONFIG_REMOTE}' 2>/dev/null | cut -d= -f2" | tr -d '\r')
  _cur_audio="${_cur_audio:-yes}"
  _cur_silent="${_cur_silent:-no}"
  _su "printf 'variant=${variant}\naudio=%s\nsilent=%s\n' '${_cur_audio}' '${_cur_silent}' > '${CONFIG_REMOTE}' && chmod 644 '${CONFIG_REMOTE}'"
  echo -e "  ${GRN}✓ Config written${RST}"

  printf "  Push and reflash module now? [Y/n]: "
  read -r yn
  case "$yn" in n|N) echo "  Skipped. Reflash manually to apply."; return ;; esac

  cmd_flash
}

cmd_flash() {
  echo -e "${YLW}── FLASH MODULE ───────────────────────────────────────${RST}"
  if [ ! -f "$RELEASE_ZIP" ]; then
    echo -e "${RED}  ✗ Release ZIP not found: ${RELEASE_ZIP}${RST}" >&2
    echo -e "${DIM}    Run: cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro && python3 build.py${RST}" >&2
    exit 1
  fi
  local remote="/sdcard/Download/$(basename "$RELEASE_ZIP")"
  echo -e "  Pushing ${DIM}$(basename "$RELEASE_ZIP")${RST} → ${CYN}${remote}${RST}"
  adb push "$RELEASE_ZIP" "$remote"
  echo -e "  ${GRN}✓ Pushed${RST}"
  echo ""
  echo -e "  ${DIM}Installing via Magisk/KernelSU…${RST}"
  _su "magisk --install-module '${remote}' 2>/dev/null || ksud module install '${remote}' 2>/dev/null || apd module install '${remote}' 2>/dev/null" || true
  echo -e "  ${GRN}✓ Module queued — reboot to apply!${RST}"
}

cmd_restart_anim() {
  echo -e "${YLW}── RESTART BOOT ANIMATION ─────────────────────────────${RST}"
  _su 'setprop ctl.restart bootanim'
  echo -e "  ${GRN}✓ bootanim service restarted${RST}"
}

cmd_pull_logs() {
  echo -e "${YLW}── PULL LOGS ──────────────────────────────────────────${RST}"
  local out="cp2077-debug-$(date +%Y%m%d-%H%M%S).log"
  adb shell su -c 'logcat -d 2>/dev/null | grep -i "cp2077\|bootanim\|magisk" | tail -200' > "$out"
  echo -e "  ${GRN}✓ Saved → ${out}${RST}"
  echo ""
  tail -20 "$out"
}

cmd_verify() {
  echo -e "${YLW}── VERIFY ANIMATIONS ──────────────────────────────────${RST}"
  for zip in "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/bootanimation"/*/bootanimation.zip; do
    variant=$(basename "$(dirname "$zip")")
    python3 - "$zip" "$variant" <<'EOF'
import zipfile, sys
path, name = sys.argv[1], sys.argv[2]
try:
    z = zipfile.ZipFile(path)
    names = z.namelist()
    has_desc   = 'desc.txt' in names
    frames     = [n for n in names if n.endswith('.png')]
    desc_line  = z.read('desc.txt').decode(errors='replace').splitlines()[0] if has_desc else ''
    sz_mb      = sum(z.getinfo(n).file_size for n in names) / 1024 / 1024
    ok = '✓' if has_desc and len(frames) > 0 else '✗'
    print(f'  {ok}  {name:<12}  {len(frames):>4} frames  {sz_mb:5.1f} MB  desc: {desc_line[:30]}')
except Exception as e:
    print(f'  ✗  {name:<12}  ERROR: {e}')
EOF
  done
}

cmd_disable() {
  echo -e "${YLW}── DISABLE MODULE ─────────────────────────────────────${RST}"
  _su "touch '${MODULE_DIR_REMOTE}/disable'"
  local check
  check=$(_su "[ -f '${MODULE_DIR_REMOTE}/disable' ] && echo yes || echo no" | tr -d '\r')
  if [ "$check" = "yes" ]; then
    echo -e "  ${GRN}✓ Module disabled (disable flag set)${RST}"
    echo -e "  ${DIM}Reboot to take effect — Magisk will skip this module on next boot.${RST}"
  else
    echo -e "  ${RED}✗ Could not set disable flag — check root access.${RST}" >&2
    exit 1
  fi
}

cmd_enable() {
  echo -e "${YLW}── ENABLE MODULE ──────────────────────────────────────${RST}"
  _su "rm -f '${MODULE_DIR_REMOTE}/disable'"
  local check
  check=$(_su "[ -f '${MODULE_DIR_REMOTE}/disable' ] && echo yes || echo no" | tr -d '\r')
  if [ "$check" = "no" ]; then
    echo -e "  ${GRN}✓ Module enabled (disable flag removed)${RST}"
    echo -e "  ${DIM}Reboot to take effect.${RST}"
  else
    echo -e "  ${RED}✗ disable flag still present — check permissions.${RST}" >&2
    exit 1
  fi
}

cmd_health() {
  echo -e "${YLW}── HEALTH CHECK ───────────────────────────────────────${RST}"
  _print_device_info

  # Module status flag
  local disabled mod_exists
  mod_exists=$(_su "[ -d '${MODULE_DIR_REMOTE}' ] && echo yes || echo no" | tr -d '\r')
  disabled=$(_su "[ -f '${MODULE_DIR_REMOTE}/disable' ] && echo yes || echo no" | tr -d '\r')

  echo -e "  ${DIM}Module installed :${RST} $([ "$mod_exists" = "yes" ] && echo "${GRN}yes${RST}" || echo "${RED}no${RST}")"
  echo -e "  ${DIM}Module disabled  :${RST} $([ "$disabled" = "yes" ] && echo "${RED}yes (skipped on boot)${RST}" || echo "${GRN}no${RST}")"
  echo ""

  # Mount map — 7 canonical paths + my_product
  local paths=(
    "/product/media/bootanimation.zip"
    "/product/media/bootanimation-dark.zip"
    "/product/media/shutdownanimation.zip"
    "/product/media/rbootanimation.zip"
    "/my_product/media/bootanimation/bootanimation.zip"
    "/data/local/bootanimation.zip"
    "/data/misc/bootanim/bootanimation.zip"
  )

  printf "  ${DIM}%-50s  %8s  %s${RST}\n" "PATH" "SIZE" "STATUS"
  printf "  %s\n" "$(printf '─%.0s' {1..70})"
  for p in "${paths[@]}"; do
    local sz mb col status
    sz=$(_su "wc -c < '$p' 2>/dev/null || echo 0" | tr -d '\r')
    mb=$(( sz / 1024 / 1024 ))
    if [ "$sz" -eq 0 ]; then
      col="${DIM}"; status="absent"
    elif [ "$mb" -ge 5 ]; then
      col="${GRN}"; status="OK"
    else
      col="${YLW}"; status="small (${mb}MB<5MB)"
    fi
    printf "  ${col}%-50s  %6s MB  %s${RST}\n" "$p" "$mb" "$status"
  done
  echo ""

  # Active bind-mounts touching bootanim
  echo -e "  ${DIM}Active bind-mounts:${RST}"
  _su "mount 2>/dev/null | grep -E 'bootanim|product/media' || echo '  (none)'" | sed 's/^/    /'
  echo ""

  # Trace flag
  local trace
  trace=$(_su "[ -f '${MODULE_DIR_REMOTE}/trace.flag' ] && echo yes || echo no" | tr -d '\r')
  echo -e "  ${DIM}Trace mode :${RST} $([ "$trace" = "yes" ] && echo "${YLW}ACTIVE (writes to /data/local/tmp/cp2077-trace.log)${RST}" || echo "${DIM}off${RST}")"
  echo ""
}

cmd_trace() {
  local action="${1:-status}"
  case "$action" in
    on)
      _su "touch '${MODULE_DIR_REMOTE}/trace.flag'"
      echo -e "  ${YLW}✓ Trace mode ON — post-fs-data will log next boot without mounting.${RST}"
      ;;
    off)
      _su "rm -f '${MODULE_DIR_REMOTE}/trace.flag'"
      echo -e "  ${GRN}✓ Trace mode OFF${RST}"
      ;;
    read)
      echo -e "${YLW}── TRACE LOG ──────────────────────────────────────────${RST}"
      _su 'cat /data/local/tmp/cp2077-trace.log 2>/dev/null || echo "(no trace log found)"'
      ;;
    *)
      local flag
      flag=$(_su "[ -f '${MODULE_DIR_REMOTE}/trace.flag' ] && echo ON || echo OFF" | tr -d '\r')
      echo -e "  Trace mode: ${YLW}${flag}${RST}"
      ;;
  esac
}

cmd_logwatch() {
  echo -e "${YLW}── LIVE LOG STREAM ────────────────────────────────────${RST}"
  echo -e "  ${DIM}Streaming logcat — filter: cp2077 | bootanim | magisk${RST}"
  echo -e "  ${DIM}Press Ctrl+C to stop.${RST}"
  echo ""
  adb shell su -c 'logcat -v time 2>/dev/null | grep --line-buffered -iE "cp2077|bootanim|magisk"'
}

cmd_build() {
  echo -e "${YLW}── BUILD ALL MODULES ──────────────────────────────────${RST}"
  echo ""
  for module in CP2077-OP7Pro CP2077-Universal CP2077-OP7Pro-Ultimate; do
    dir="${WORKSPACE_ROOT}/01-DEVELOPMENT/repos/cyberpunk/${module}"
    [ -d "$dir" ] || continue
    script=""
    [ -f "${dir}/build.py" ]          && script="build.py"
    [ -f "${dir}/build-universal.py" ] && script="build-universal.py"
    [ -f "${dir}/build-ultimate.py" ]  && script="build-ultimate.py"
    [ -z "$script" ] && continue
    echo -e "  ${CYN}Building ${module}…${RST}"
    (cd "$dir" && python3 "$script") && echo -e "  ${GRN}✓ ${module}${RST}" || echo -e "  ${RED}✗ ${module} FAILED${RST}"
    echo ""
  done
}

cmd_thermal() {
  echo -e "${YLW}── THERMAL STATUS ─────────────────────────────────────${RST}"
  _print_device_info

  echo -e "  ${DIM}CPU thermal zones:${RST}"
  for zone in $(seq 0 9); do
    local temp type
    temp=$(_su "cat /sys/class/thermal/thermal_zone${zone}/temp 2>/dev/null" | tr -d '\r')
    type=$(_su "cat /sys/class/thermal/thermal_zone${zone}/type 2>/dev/null" | tr -d '\r')
    [ -z "$temp" ] || [ "$temp" = "0" ] && continue
    local deg=$(( temp / 1000 ))
    local col="${GRN}"
    [ "$deg" -ge 65 ] && col="${YLW}"
    [ "$deg" -ge 80 ] && col="${RED}"
    printf "    ${col}%3d°C${RST}  ${DIM}zone%-2d  %s${RST}\n" "$deg" "$zone" "${type:-unknown}"
  done
  echo ""

  echo -e "  ${DIM}CP2077 thermal log (last 5):${RST}"
  _su "tail -5 /data/local/tmp/cp2077-thermal.log 2>/dev/null || echo '  (no log yet)'" | sed 's/^/    /'
  echo ""
}

cmd_telemetry() {
  local last="${1:-15}"
  echo -e "${YLW}── BOOT TELEMETRY ─────────────────────────────────────${RST}"
  _print_device_info

  local data
  data=$(_su "cat /data/local/tmp/cp2077-telemetry.jsonl 2>/dev/null | tail -${last}" | tr -d '\r')

  if [[ -z "$data" ]]; then
    echo -e "  ${DIM}No telemetry yet. Boot the device with the module active.${RST}"
    return
  fi

  printf "  %-3s  %-18s  %-10s  %-8s  %-14s  %-7s\n" \
    "#" "TIMESTAMP" "VARIANT" "API" "THERMAL" "ms"
  echo -e "  ${DIM}$(printf '─%.0s' {1..70})${RST}"

  local -a timings=()
  while IFS= read -r line; do
    [[ -z "$line" ]] && continue
    local ts;      ts="$(echo "$line" | grep -o '"ts":"[^"]*"' | cut -d'"' -f4)"
    local boot;    boot="$(echo "$line" | grep -o '"boot":[0-9]*' | cut -d: -f2)"
    local variant; variant="$(echo "$line" | grep -o '"variant":"[^"]*"' | cut -d'"' -f4)"
    local api;     api="$(echo "$line" | grep -o '"api":"[^"]*"' | cut -d'"' -f4)"
    local thermal; thermal="$(echo "$line" | grep -o '"thermal":"[^"]*"' | cut -d'"' -f4)"
    local timing;  timing="$(echo "$line" | grep -o '"timing_ms":[0-9]*' | cut -d: -f2)"
    timings+=("${timing:-0}")
    local deg="${thermal##*:}"
    local tstate="${thermal%%:*}"
    local col="${GRN}"
    case "$tstate" in critical) col="${RED}" ;; throttle|warn) col="${YLW}" ;; esac
    printf "  %-3s  %-18s  %-10s  %-8s  ${col}%-7s %3s°C${RST}  %-7s\n" \
      "${boot:-?}" "${ts:5:15}" "${variant:-?}" "${api:-?}" "${tstate:-?}" "${deg:-?}" "${timing:-?}"
  done <<< "$data"

  echo -e "  ${DIM}$(printf '─%.0s' {1..70})${RST}"

  if [[ ${#timings[@]} -gt 1 ]]; then
    local sum=0
    for t in "${timings[@]}"; do sum=$((sum + t)); done
    local avg=$((sum / ${#timings[@]}))
    local mn; mn="$(printf '%s\n' "${timings[@]}" | sort -n | head -1)"
    local mx; mx="$(printf '%s\n' "${timings[@]}" | sort -n | tail -1)"
    echo -e "\n  ${DIM}avg ${avg}ms  ·  min ${mn}ms  ·  max ${mx}ms  ·  ${#timings[@]} records${RST}"
  fi
  echo ""
}

cmd_integrity() {
  echo -e "${YLW}── INTEGRITY CHECK ────────────────────────────────────${RST}"
  _print_device_info

  echo -e "  ${DIM}Checking SHA-256 baseline…${RST}"
  local baseline
  baseline=$(_su "cat /data/cp2077-baseline.sha256 2>/dev/null" | tr -d '\r')
  if [[ -z "$baseline" ]]; then
    echo -e "  ${YLW}  ! No baseline file (/data/cp2077-baseline.sha256)${RST}"
    echo -e "  ${DIM}    Run: adb shell su -c \"sh ${MODULE_DIR_REMOTE}/lib/integrity.sh baseline\"${RST}"
    return
  fi

  echo -e "  ${DIM}Baseline entries:${RST}"
  echo "$baseline" | grep '^[0-9a-f]' | while IFS= read -r entry; do
    local hash="${entry%% *}"
    local path="${entry##* }"
    local cur
    cur=$(_su "sha256sum '${path}' 2>/dev/null | awk '{print \$1}'" | tr -d '\r')
    if [[ "$cur" == "$hash" ]]; then
      echo -e "    ${GRN}✓${RST}  ${path}"
    elif [[ -z "$cur" ]]; then
      echo -e "    ${DIM}–${RST}  ${path} (absent)"
    else
      echo -e "    ${RED}✗${RST}  ${path}"
      echo -e "       ${DIM}expected: ${hash}${RST}"
      echo -e "       ${RED}actual  : ${cur}${RST}"
    fi
  done

  echo ""
  echo -e "  ${DIM}Integrity log (last 5):${RST}"
  _su "tail -5 /data/local/tmp/cp2077-integrity.log 2>/dev/null || echo '  (no log)'" | sed 's/^/    /'
  echo ""
}

cmd_los232() {
  echo -e "${YLW}── LOS 23.2 / ANDROID 16 VALIDATOR ───────────────────${RST}"
  _print_device_info

  local script="${MODULE_DIR_REMOTE}/scripts/cp2077-los232-validator.sh"
  if _su "[ -f '${script}' ]" 2>/dev/null; then
    echo -e "  ${DIM}Running on-device validator…${RST}"
    echo ""
    adb shell su -c "sh '${script}'"
  else
    echo -e "  ${YLW}  ! Validator script not found at ${script}${RST}"
    echo -e "  ${DIM}    Run a fresh flash to install it, or copy manually.${RST}"
    echo ""
    echo -e "  ${DIM}Quick checks via ADB:${RST}"
    echo -e "  LOS version  : $(adb shell getprop ro.lineage.version 2>/dev/null | tr -d '\r' || echo '—')"
    echo -e "  Android API  : $(adb shell getprop ro.build.version.sdk 2>/dev/null | tr -d '\r')"
    echo -e "  SELinux      : $(adb shell getenforce 2>/dev/null | tr -d '\r')"
    echo -e "  Anim scale   : $(adb shell getprop wm.window.animation.scale 2>/dev/null | tr -d '\r')"
    local dmSz; dmSz=$(adb shell su -c "wc -c < /data/misc/bootanim/bootanimation.zip 2>/dev/null || echo 0" | tr -d '\r')
    local dmMb=$(( ${dmSz:-0} / 1024 / 1024 ))
    echo -e "  /data/misc   : ${dmMb} MB"
  fi
  echo ""
}

cmd_watch() {
  local interval="${1:-5}"
  echo -e "${YLW}── LIVE WATCH (every ${interval}s) ─────────────────────────${RST}"
  echo -e "  ${DIM}Press Ctrl+C to stop.${RST}"
  while true; do
    clear
    echo -e "${YLW}${BOLD}  CP2077 LIVE MONITOR — $(date '+%H:%M:%S')${RST}"
    echo ""
    # Device telemetry quick view
    local temp; temp=$(_su "for z in 0 1 2 3; do t=\$(cat /sys/class/thermal/thermal_zone\${z}/temp 2>/dev/null); [ -n \"\$t\" ] && [ \"\$t\" -gt 0 ] && echo \$t && break; done" | tr -d '\r')
    local deg=$(( ${temp:-0} / 1000 ))
    local ba_sz; ba_sz=$(_su "wc -c < /product/media/bootanimation.zip 2>/dev/null || echo 0" | tr -d '\r')
    local ba_mb=$(( ${ba_sz:-0} / 1024 / 1024 ))
    local variant; variant=$(_su "grep -m1 '^variant=' /data/cp2077.conf 2>/dev/null | cut -d= -f2" | tr -d '\r')
    local boot_done; boot_done=$(adb shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')

    echo -e "  ${DIM}Variant :${RST} ${CYN}${variant:-?}${RST}"
    echo -e "  ${DIM}Boot anim:${RST} ${ba_mb} MB  (/product/media/bootanimation.zip)"
    local tcol="${GRN}"; [ "$deg" -ge 65 ] && tcol="${YLW}"; [ "$deg" -ge 80 ] && tcol="${RED}"
    echo -e "  ${DIM}CPU temp :${RST} ${tcol}${deg}°C${RST}"
    echo -e "  ${DIM}Boot done:${RST} ${boot_done:-?}"

    local last_tel; last_tel=$(_su "tail -1 /data/local/tmp/cp2077-telemetry.jsonl 2>/dev/null" | tr -d '\r')
    [[ -n "$last_tel" ]] && echo -e "  ${DIM}Last boot:${RST} $(echo "$last_tel" | grep -o '"ts":"[^"]*"' | cut -d'"' -f4) — $(echo "$last_tel" | grep -o '"timing_ms":[0-9]*' | cut -d: -f2)ms"

    echo ""
    echo -e "  ${DIM}Refreshing every ${interval}s…${RST}"
    sleep "$interval"
  done
}

cmd_help() {
  echo -e "${YLW}── COMMANDS ───────────────────────────────────────────${RST}"
  echo ""
  echo -e "  ${CYN}status${RST}              Show device + module status"
  echo -e "  ${CYN}health${RST}              Full mount map + module health check"
  echo -e "  ${CYN}switch [variant]${RST}    Switch boot animation variant"
  echo -e "  ${CYN}flash${RST}               Push and install the release ZIP"
  echo -e "  ${CYN}disable${RST}             Set disable flag (Magisk skips on next boot)"
  echo -e "  ${CYN}enable${RST}              Remove disable flag (re-activates module)"
  echo -e "  ${CYN}trace <on|off|read>${RST} Toggle trace mode / read trace log"
  echo -e "  ${CYN}restart-anim${RST}        Restart the boot animation service"
  echo -e "  ${CYN}logwatch${RST}            Stream live filtered logcat (Ctrl+C to stop)"
  echo -e "  ${CYN}logs${RST}                Pull filtered logcat snapshot to file"
  echo -e "  ${CYN}verify${RST}              Verify animation ZIPs on host"
  echo -e "  ${CYN}build${RST}               Build all module ZIPs from source"
  echo -e "  ${CYN}thermal${RST}             CPU thermal zone readings + thermal log"
  echo -e "  ${CYN}telemetry [N]${RST}       Show last N boot telemetry records (default 15)"
  echo -e "  ${CYN}integrity${RST}           SHA-256 verify active ZIPs against baseline"
  echo -e "  ${CYN}los232${RST}              Run LOS 23.2 / Android 16 compatibility validator"
  echo -e "  ${CYN}watch [secs]${RST}        Live monitor: variant, temp, mount, last boot"
  echo ""
  echo -e "  Variants: ${DIM}glitch | flatline | reboot | og1080p | og4k | glitch-v2${RST}"
  echo ""
}

# ── Entry point ───────────────────────────────────────────────────
_header
_check_adb

CMD="${1:-help}"
shift || true

case "$CMD" in
  status)       cmd_status ;;
  health)       cmd_health ;;
  switch)       cmd_switch "$@" ;;
  flash)        cmd_flash ;;
  disable)      cmd_disable ;;
  enable)       cmd_enable ;;
  trace)        cmd_trace "$@" ;;
  restart-anim) cmd_restart_anim ;;
  logwatch)     cmd_logwatch ;;
  logs)         cmd_pull_logs ;;
  verify)       cmd_verify ;;
  build)        cmd_build ;;
  thermal)      cmd_thermal ;;
  telemetry)    cmd_telemetry "$@" ;;
  integrity)    cmd_integrity ;;
  los232)       cmd_los232 ;;
  watch)        cmd_watch "${1:-5}" ;;
  help|--help|-h) cmd_help ;;
  *)
    echo -e "${RED}  Unknown command: $CMD${RST}"
    echo ""
    cmd_help
    exit 1
    ;;
esac
