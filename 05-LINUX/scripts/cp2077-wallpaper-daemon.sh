#!/usr/bin/env bash
# cp2077-wallpaper-daemon.sh — Rotate CP2077 wallpapers via swww or swaybg
# Usage: ./cp2077-wallpaper-daemon.sh [interval_seconds]
# Reads interval from CP2077_WALL_INTERVAL env var (default: 1800 = 30 min)
# Requires: swww (preferred) or swaybg

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WORKSPACE_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
WALL_DIR="$WORKSPACE_ROOT/06-UI-THEMES-ANIMATIONS/wallpapers/Cyberpunk-Wallpapers"
CYBRPAPERS_DIR="$WORKSPACE_ROOT/06-UI-THEMES-ANIMATIONS/wallpapers/cybrpapers"
CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/cp2077/wallpaper.conf"
INTERVAL="${CP2077_WALL_INTERVAL:-${1:-1800}}"

YLW='\033[38;2;252;238;12m'
CYN='\033[38;2;0;255;255m'
DIM='\033[2m'
RST='\033[0m'

# ── Load config ───────────────────────────────────────────────────
if [ -f "$CONFIG_FILE" ]; then
  # shellcheck source=/dev/null
  . "$CONFIG_FILE"
fi

# Config keys: WALL_DIR, INTERVAL, TRANSITION (swww transition name)
TRANSITION="${CP2077_WALL_TRANSITION:-wipe}"

echo -e "${YLW}  ░▒▓ CP2077 WALLPAPER DAEMON ▓▒░${RST}"
echo -e "  ${DIM}Interval : ${INTERVAL}s${RST}"
echo -e "  ${DIM}Transition: ${TRANSITION}${RST}"
echo ""

# ── Collect wallpapers ────────────────────────────────────────────
mapfile -t WALLS < <(
  find "$WALL_DIR" "$CYBRPAPERS_DIR" \
    -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) \
    2>/dev/null | sort
)

if [ "${#WALLS[@]}" -eq 0 ]; then
  echo -e "  ${YLW}✗ No wallpapers found in:${RST}"
  echo -e "    $WALL_DIR"
  echo -e "    $CYBRPAPERS_DIR"
  exit 1
fi
echo -e "  ${CYN}Found ${#WALLS[@]} wallpapers${RST}"
echo ""

# ── Detect backend ────────────────────────────────────────────────
if command -v swww &>/dev/null; then
  BACKEND="swww"
  # Start swww daemon if not running
  if ! swww query &>/dev/null 2>&1; then
    echo -e "  ${DIM}Starting swww daemon...${RST}"
    swww init &
    sleep 1
  fi
elif command -v swaybg &>/dev/null; then
  BACKEND="swaybg"
  SWAYBG_PID=""
else
  echo -e "  ${YLW}✗ Neither swww nor swaybg found. Install one:${RST}"
  echo "    pacman -S swww   (recommended — smooth transitions)"
  echo "    pacman -S swaybg (fallback)"
  exit 1
fi
echo -e "  ${CYN}Backend: $BACKEND${RST}"
echo ""

# ── Shuffle and rotate ────────────────────────────────────────────
idx=0
while true; do
  # Reshuffle on each full cycle
  if [ "$idx" -ge "${#WALLS[@]}" ]; then
    idx=0
    mapfile -t WALLS < <(printf '%s\n' "${WALLS[@]}" | shuf)
  fi
  wall="${WALLS[$idx]}"
  name="$(basename "$wall")"
  echo -e "  ${YLW}▶${RST} ${DIM}${name}${RST}"

  case "$BACKEND" in
    swww)
      swww img "$wall" \
        --transition-type "$TRANSITION" \
        --transition-duration 2 \
        --transition-fps 60 2>/dev/null || true
      ;;
    swaybg)
      [ -n "${SWAYBG_PID:-}" ] && kill "$SWAYBG_PID" 2>/dev/null || true
      swaybg -i "$wall" -m fill &
      SWAYBG_PID=$!
      ;;
  esac

  idx=$(( idx + 1 ))
  sleep "$INTERVAL"
done
