#!/usr/bin/env bash
# install-cp2077-desktop.sh — Master installer for all CP2077 Linux desktop configs
# Sources from: 06-UI-THEMES-ANIMATIONS/ + 05-LINUX/arch-host/
# Merges best features from: cp2077-linux-hud, cyber-hyprland-theme,
#   Cyberpunk-Neon, K-DE-Cyberpunk-Neon, cybrcolors, cybrland, cybrpapers
#
# Usage: bash install-cp2077-desktop.sh [--dry-run] [--component <name>]
#        Components: all waybar eww hyprlock swaylock rofi mako plymouth
#                    terminal vim discord kde-theme wallpaper hyprland

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WORKSPACE="$(cd "$SCRIPT_DIR/../.." && pwd)"
HUD_DIR="$WORKSPACE/06-UI-THEMES-ANIMATIONS/themes/cp2077-linux-hud"
BOOT_DIR="$WORKSPACE/06-UI-THEMES-ANIMATIONS/linux-boot-themes/cp2077-linux-boot"
KDE_DIR="$WORKSPACE/06-UI-THEMES-ANIMATIONS/themes/K-DE-Cyberpunk-Neon"
HYPR_DIR="$WORKSPACE/06-UI-THEMES-ANIMATIONS/themes/cyber-hyprland-theme"
SCRIPT_THEMES="$SCRIPT_DIR"

CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

DRY=0
COMPONENT="all"
for arg in "$@"; do
  case "$arg" in
    --dry-run)          DRY=1 ;;
    --component)        shift; COMPONENT="${1:-all}" ;;
    --component=*)      COMPONENT="${arg#--component=}" ;;
  esac
done

YLW='\033[38;2;252;238;12m'
CYN='\033[38;2;0;255;255m'
GRN='\033[38;2;0;255;159m'
RED='\033[38;2;255;0;60m'
DIM='\033[2m'
RST='\033[0m'

_hdr() { echo -e "${YLW}  ── $1 ──────────────────────────${RST}"; }
_ok()  { echo -e "  ${GRN}✓${RST}  $1"; }
_skip(){ echo -e "  ${DIM}·  $1 (skipped — already exists)${RST}"; }
_dry() { echo -e "  ${CYN}[DRY]${RST}  $1"; }
_err() { echo -e "  ${RED}✗${RST}  $1" >&2; }

_install() {
  local src="$1" dst="$2" desc="$3"
  if [ ! -e "$src" ]; then _err "source not found: $src"; return 1; fi
  if [ "$DRY" = "1" ]; then _dry "$desc  →  $dst"; return 0; fi
  mkdir -p "$(dirname "$dst")"
  cp -af "$src" "$dst"
  _ok "$desc"
}

_link() {
  local src="$1" dst="$2" desc="$3"
  if [ ! -e "$src" ]; then _err "source not found: $src"; return 1; fi
  if [ "$DRY" = "1" ]; then _dry "symlink $desc  →  $dst"; return 0; fi
  mkdir -p "$(dirname "$dst")"
  ln -sfn "$src" "$dst"
  _ok "symlink $desc"
}

echo -e "${YLW}"
echo "  ╔══════════════════════════════════════════════════════╗"
echo "  ║  ░▒▓  CP2077 DESKTOP INSTALLER  ▓▒░                 ║"
echo "  ║  Night City Linux — Arch + Wayland                  ║"
echo "  ╚══════════════════════════════════════════════════════╝"
echo -e "${RST}"
[ "$DRY" = "1" ] && echo -e "  ${CYN}DRY RUN — no files will be written${RST}\n"
echo -e "  ${DIM}Component: $COMPONENT${RST}"
echo ""

# ── Waybar ────────────────────────────────────────────────────────
install_waybar() {
  _hdr "Waybar"
  _install "$HUD_DIR/waybar/config.jsonc"            "$CONFIG_HOME/waybar/config.jsonc"            "config.jsonc"
  _install "$HUD_DIR/waybar/style.css"               "$CONFIG_HOME/waybar/style.css"               "style.css"
  _install "$HUD_DIR/waybar/scripts/cp2077-net.sh"   "$CONFIG_HOME/waybar/scripts/cp2077-net.sh"   "cp2077-net.sh"
  [ "$DRY" = "0" ] && chmod +x "$CONFIG_HOME/waybar/scripts/cp2077-net.sh" 2>/dev/null || true
}

# ── eww HUD ───────────────────────────────────────────────────────
install_eww() {
  _hdr "eww HUD overlay"
  _install "$HUD_DIR/eww/eww.yuck"   "$CONFIG_HOME/eww/eww.yuck"   "eww.yuck"
  _install "$HUD_DIR/eww/eww.scss"   "$CONFIG_HOME/eww/eww.scss"   "eww.scss"
  # Net script for eww polling
  mkdir -p "$CONFIG_HOME/eww/scripts" 2>/dev/null || true
  _install "$HUD_DIR/waybar/scripts/cp2077-net.sh" \
           "$CONFIG_HOME/eww/scripts/net.sh"  "net.sh (eww polling)"
  [ "$DRY" = "0" ] && chmod +x "$CONFIG_HOME/eww/scripts/net.sh" 2>/dev/null || true
}

# ── hyprlock ──────────────────────────────────────────────────────
install_hyprlock() {
  _hdr "hyprlock lock screen"
  _install "$HUD_DIR/hyprlock/hyprlock.conf" "$CONFIG_HOME/hypr/hyprlock.conf" "hyprlock.conf"
}

# ── swaylock ──────────────────────────────────────────────────────
install_swaylock() {
  _hdr "swaylock (fallback)"
  _install "$HUD_DIR/swaylock/swaylock.conf" "$CONFIG_HOME/swaylock/config" "swaylock config"
}

# ── Rofi launcher ─────────────────────────────────────────────────
install_rofi() {
  _hdr "Rofi launcher"
  _install "$SCRIPT_THEMES/rofi/launcher.rasi" "$CONFIG_HOME/rofi/themes/cp2077.rasi" "cp2077.rasi"
  # Write minimal rofi config pointing at our theme
  if [ ! -f "$CONFIG_HOME/rofi/config.rasi" ] || grep -q "cp2077" "$CONFIG_HOME/rofi/config.rasi" 2>/dev/null; then
    if [ "$DRY" = "1" ]; then
      _dry "rofi/config.rasi → set theme to cp2077"
    else
      mkdir -p "$CONFIG_HOME/rofi"
      cat > "$CONFIG_HOME/rofi/config.rasi" <<'RASI'
configuration {
  modi:           "drun,run,window";
  show-icons:     true;
  icon-theme:     "Papirus-Dark";
  drun-display-format: "{name}";
}
@theme "cp2077"
RASI
      _ok "rofi/config.rasi"
    fi
  fi
}

# ── Mako notifications ────────────────────────────────────────────
install_mako() {
  _hdr "Mako notifications"
  _install "$SCRIPT_THEMES/mako/config" "$CONFIG_HOME/mako/config" "mako config"
}

# ── Plymouth boot theme ───────────────────────────────────────────
install_plymouth() {
  _hdr "Plymouth boot theme"
  if [ "$EUID" -ne 0 ] && [ "$DRY" = "0" ]; then
    echo -e "  ${YLW}⚠ Plymouth install requires root — run with sudo or use --dry-run${RST}"
    return 0
  fi
  if [ "$DRY" = "1" ]; then
    _dry "would run: bash $BOOT_DIR/install-plymouth.sh"
    return 0
  fi
  bash "$BOOT_DIR/install-plymouth.sh"
}

# ── Terminal color schemes ────────────────────────────────────────
install_terminal() {
  _hdr "Terminal color schemes"
  _install "$SCRIPT_THEMES/terminal-themes/kitty.conf"    "$CONFIG_HOME/kitty/cp2077.conf"                     "kitty theme"
  _install "$SCRIPT_THEMES/terminal-themes/alacritty.toml" "$CONFIG_HOME/alacritty/themes/cp2077.toml"         "alacritty theme"
  _install "$SCRIPT_THEMES/terminal-themes/wezterm.lua"   "$CONFIG_HOME/wezterm/colors/cp2077.lua"              "wezterm theme"

  # Also install Cyberpunk-Neon variants for comparison
  CN_TERM="$WORKSPACE/06-UI-THEMES-ANIMATIONS/themes/Cyberpunk-Neon/terminal"
  [ -f "$CN_TERM/kitty/cyberpunk-neon.conf" ] && \
    _install "$CN_TERM/kitty/cyberpunk-neon.conf"   "$CONFIG_HOME/kitty/cyberpunk-neon.conf"                   "kitty cyberpunk-neon"
  [ -f "$CN_TERM/alacritty/alacritty.toml" ] && \
    _install "$CN_TERM/alacritty/alacritty.toml"    "$CONFIG_HOME/alacritty/themes/cyberpunk-neon.toml"        "alacritty cyberpunk-neon"

  echo -e "  ${DIM}Activate kitty:    include ~/.config/kitty/cp2077.conf${RST}"
  echo -e "  ${DIM}Activate alacritty: import = [\"~/.config/alacritty/themes/cp2077.toml\"]${RST}"
}

# ── KDE Plasma theme ──────────────────────────────────────────────
install_kde_theme() {
  _hdr "KDE Plasma / GTK theme"
  [ -f "$KDE_DIR/CyberpunkNeon.colors" ] && \
    _install "$KDE_DIR/CyberpunkNeon.colors" "$DATA_HOME/color-schemes/CyberpunkNeon.colors" "KDE color scheme"
  [ -f "$KDE_DIR/Cyberpunk-Neon-GTK.tar.gz" ] && {
    if [ "$DRY" = "1" ]; then
      _dry "extract GTK theme → $DATA_HOME/themes/"
    else
      mkdir -p "$DATA_HOME/themes"
      tar -xzf "$KDE_DIR/Cyberpunk-Neon-GTK.tar.gz" -C "$DATA_HOME/themes/" 2>/dev/null || true
      _ok "GTK theme extracted to $DATA_HOME/themes/"
    fi
  }
  [ -f "$KDE_DIR/cyberpunk.kateschema" ] && \
    _install "$KDE_DIR/cyberpunk.kateschema" "$DATA_HOME/org.kde.syntax-highlighting/themes/cyberpunk.kateschema" "Kate syntax theme"
  echo -e "  ${DIM}Apply: System Settings → Colors → CyberpunkNeon${RST}"
}

# ── Vim / Neovim colorscheme ─────────────────────────────────────
install_vim() {
  _hdr "Vim / Neovim colorscheme"
  _install "$SCRIPT_THEMES/terminal-themes/cp2077.vim" \
           "$HOME/.vim/colors/cp2077.vim"              "cp2077.vim (Vim)"
  _install "$SCRIPT_THEMES/terminal-themes/cp2077.vim" \
           "$CONFIG_HOME/nvim/colors/cp2077.vim"       "cp2077.vim (Neovim)"
  # Also install Cyberpunk-Neon variant for reference
  [ -f "$WORKSPACE/06-UI-THEMES-ANIMATIONS/themes/Cyberpunk-Neon/terminal-apps/vim/cyberpunk-neon.vim" ] && \
    _install "$WORKSPACE/06-UI-THEMES-ANIMATIONS/themes/Cyberpunk-Neon/terminal-apps/vim/cyberpunk-neon.vim" \
             "$HOME/.vim/colors/cyberpunk-neon.vim"    "cyberpunk-neon.vim (Vim)"
  echo -e "  ${DIM}Activate: :colorscheme cp2077${RST}"
}

# ── Discord CSS theme ─────────────────────────────────────────────
install_discord() {
  _hdr "Discord theme (BetterDiscord / Vencord)"
  local disc_src="$WORKSPACE/06-UI-THEMES-ANIMATIONS/themes/Cyberpunk-Neon/CSS/discord"
  local bd_dir="$CONFIG_HOME/BetterDiscord/themes"
  local vd_dir="$CONFIG_HOME/Vencord/themes"
  [ -f "$disc_src/discord-cyberpunk-neon.theme.css" ] && {
    _install "$disc_src/discord-cyberpunk-neon.theme.css" \
             "$bd_dir/discord-cyberpunk-neon.theme.css" "BetterDiscord theme"
    _install "$disc_src/discord-cyberpunk-neon.theme.css" \
             "$vd_dir/discord-cyberpunk-neon.theme.css" "Vencord theme"
  }
  [ -f "$disc_src/discord-cyberpunk-neon-transparent.theme.css" ] && {
    _install "$disc_src/discord-cyberpunk-neon-transparent.theme.css" \
             "$bd_dir/discord-cyberpunk-neon-transparent.theme.css" "BetterDiscord transparent variant"
    _install "$disc_src/discord-cyberpunk-neon-transparent.theme.css" \
             "$vd_dir/discord-cyberpunk-neon-transparent.theme.css" "Vencord transparent variant"
  }
  echo -e "  ${DIM}Enable in BetterDiscord/Vencord → Themes${RST}"
}

# ── Wallpaper daemon ──────────────────────────────────────────────
install_wallpaper() {
  _hdr "Wallpaper daemon"
  _install "$SCRIPT_THEMES/cp2077-wallpaper-daemon.sh" \
           "$HOME/.local/bin/cp2077-wallpaper-daemon" "cp2077-wallpaper-daemon"
  [ "$DRY" = "0" ] && chmod +x "$HOME/.local/bin/cp2077-wallpaper-daemon" || true
  echo -e "  ${DIM}Start: cp2077-wallpaper-daemon [interval_seconds]${RST}"
  echo -e "  ${DIM}Config: \$XDG_CONFIG_HOME/cp2077/wallpaper.conf${RST}"
}

# ── Hyprland unified config ───────────────────────────────────────
install_hyprland() {
  _hdr "Hyprland CP2077 config"
  local src="$SCRIPT_THEMES/cp2077-hyprland.conf"
  if [ -f "$src" ]; then
    _install "$src" "$CONFIG_HOME/hypr/themes/cp2077.conf" "cp2077.conf (source in hyprland.conf)"
    echo -e "  ${DIM}Add to hyprland.conf: source = ~/.config/hypr/themes/cp2077.conf${RST}"
  else
    _err "cp2077-hyprland.conf not found — run after it is created"
  fi
}

# ── Dispatch ─────────────────────────────────────────────────────
run_component() {
  case "$1" in
    waybar)    install_waybar ;;
    eww)       install_eww ;;
    hyprlock)  install_hyprlock ;;
    swaylock)  install_swaylock ;;
    rofi)      install_rofi ;;
    mako)      install_mako ;;
    plymouth)  install_plymouth ;;
    terminal)  install_terminal ;;
    vim)       install_vim ;;
    discord)   install_discord ;;
    kde-theme) install_kde_theme ;;
    wallpaper) install_wallpaper ;;
    hyprland)  install_hyprland ;;
    all)
      install_waybar; install_eww; install_hyprlock; install_swaylock
      install_rofi; install_mako; install_terminal; install_vim
      install_wallpaper; install_hyprland
      echo ""
      echo -e "  ${DIM}Skipped (requires root): plymouth${RST}"
      echo -e "  ${DIM}Skipped (optional):      kde-theme discord${RST}"
      echo -e "  ${DIM}Run separately:          sudo bash install-cp2077-desktop.sh --component plymouth${RST}"
      ;;
    *) _err "Unknown component: $1. Use: all waybar eww hyprlock swaylock rofi mako plymouth terminal vim discord kde-theme wallpaper hyprland" ;;
  esac
}

run_component "$COMPONENT"

echo ""
echo -e "${YLW}  ╔══════════════════════════════════════════════════════╗"
echo   "  ║  INSTALLATION COMPLETE                               ║"
echo   "  ║  Restart Waybar: killall waybar && waybar &          ║"
echo   "  ║  Open eww HUD:  eww open cp2077-hud                  ║"
echo -e "  ╚══════════════════════════════════════════════════════╝${RST}"
echo ""
