#!/usr/bin/env bash
set -Eeuo pipefail

trap 'echo "[ERROR] Failed at line $LINENO: $BASH_COMMAND" >&2' ERR

run_root() {
  if [ "$EUID" -eq 0 ]; then
    "$@"
  elif command -v sudo >/dev/null 2>&1; then
    sudo "$@"
  else
    echo "[ERROR] Need root or sudo."
    echo "Run this script with:"
    echo "su -"
    echo "bash /home/YOURUSER/setup-sway-fixed.sh"
    exit 1
  fi
}

detect_user() {
  if [ "${SUDO_USER:-}" != "" ] && [ "${SUDO_USER:-}" != "root" ]; then
    echo "$SUDO_USER"
  else
    awk -F: '$3 >= 1000 && $3 < 60000 && $7 !~ /(nologin|false)$/ {print $1; exit}' /etc/passwd
  fi
}

echo "============================================================"
echo " Arch Linux Sway Desktop Installer - Fixed"
echo "============================================================"

if [ ! -f /etc/os-release ]; then
  echo "[ERROR] /etc/os-release not found."
  exit 1
fi

if ! grep -qi "arch" /etc/os-release; then
  echo "[ERROR] This script is for Arch Linux only."
  cat /etc/os-release
  exit 1
fi

TARGET_USER="$(detect_user)"

if [ -z "$TARGET_USER" ]; then
  echo "[ERROR] Could not detect normal user."
  echo "Create user first or run script with sudo from your user."
  exit 1
fi

TARGET_HOME="$(getent passwd "$TARGET_USER" | cut -d: -f6)"

if [ -z "$TARGET_HOME" ] || [ ! -d "$TARGET_HOME" ]; then
  echo "[ERROR] Could not detect home for user: $TARGET_USER"
  exit 1
fi

run_user() {
  if [ "$EUID" -eq 0 ]; then
    runuser -u "$TARGET_USER" -- "$@"
  else
    "$@"
  fi
}

echo "[INFO] Target user: $TARGET_USER"
echo "[INFO] Target home: $TARGET_HOME"

if [ -f /var/lib/pacman/db.lck ]; then
  echo "[ERROR] Pacman lock exists."
  echo "If pacman is not running, fix with:"
  echo "sudo rm /var/lib/pacman/db.lck"
  exit 1
fi

echo "[1/7] Checking internet..."
if ! ping -c 1 -W 3 archlinux.org >/dev/null 2>&1; then
  echo "[WARN] No internet detected."
  echo "Package install may fail."
  echo "Check USB tethering, WiFi, or Ethernet first."
fi

echo "[2/7] Refreshing pacman database..."
run_root pacman -Syy

echo "[3/7] Installing Sway desktop packages..."
run_root pacman -S --needed sway swaybg swayidle swaylock foot foot-terminfo waybar wofi wl-clipboard grim slurp mako polkit xorg-xwayland xdg-desktop-portal xdg-desktop-portal-wlr xdg-user-dirs mesa noto-fonts noto-fonts-emoji ttf-dejavu ttf-liberation ttf-jetbrains-mono adwaita-icon-theme hicolor-icon-theme nano git curl wget

echo "[4/7] Creating user folders..."
run_user mkdir -p "$TARGET_HOME/Desktop" "$TARGET_HOME/Documents" "$TARGET_HOME/Downloads" "$TARGET_HOME/Pictures" "$TARGET_HOME/Music" "$TARGET_HOME/Videos" "$TARGET_HOME/Projects" "$TARGET_HOME/bin"
run_user xdg-user-dirs-update 2>/dev/null || true

echo "[5/7] Writing Sway config..."
run_user mkdir -p "$TARGET_HOME/.config/sway"
cat > /tmp/sway-config-fixed <<'SWAYEOF'
set $mod Mod4
set $term foot
set $menu wofi --show drun

font pango:JetBrains Mono 10

output * bg #111111 solid_color

input * {
    xkb_layout no
    tap enabled
    natural_scroll enabled
}

bindsym $mod+Return exec $term
bindsym $mod+d exec $menu
bindsym $mod+Shift+q kill
bindsym $mod+Shift+r reload
bindsym $mod+Shift+e exit
bindsym $mod+f fullscreen toggle
bindsym $mod+space floating toggle

bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

bindsym $mod+1 workspace number 1
bindsym $mod+2 workspace number 2
bindsym $mod+3 workspace number 3
bindsym $mod+4 workspace number 4
bindsym $mod+5 workspace number 5

bindsym Print exec grim -g "$(slurp)" "$HOME/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png"
bindsym $mod+Print exec grim "$HOME/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png"

bar {
    swaybar_command waybar
}

exec mako
exec foot
SWAYEOF
run_root cp /tmp/sway-config-fixed "$TARGET_HOME/.config/sway/config"

echo "[6/7] Writing Foot config..."
run_user mkdir -p "$TARGET_HOME/.config/foot"
cat > /tmp/foot-config-fixed <<'FOOTEOF'
font=JetBrains Mono:size=11
pad=8x8

[scrollback]
lines=10000

[cursor]
style=beam

[mouse]
hide-when-typing=yes

[key-bindings]
clipboard-copy=Control+Shift+c
clipboard-paste=Control+Shift+v
search-start=Control+Shift+f
FOOTEOF
run_root cp /tmp/foot-config-fixed "$TARGET_HOME/.config/foot/foot.ini"

echo "[7/7] Creating startsway command..."
cat > /tmp/startsway-fixed <<'STARTEOF'
#!/usr/bin/env bash
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export QT_QPA_PLATFORM=wayland
export MOZ_ENABLE_WAYLAND=1
exec sway
STARTEOF

run_root cp /tmp/startsway-fixed "$TARGET_HOME/bin/startsway"
run_root chmod +x "$TARGET_HOME/bin/startsway"
run_root chown -R "$TARGET_USER:$TARGET_USER" "$TARGET_HOME/.config" "$TARGET_HOME/bin" "$TARGET_HOME/Desktop" "$TARGET_HOME/Documents" "$TARGET_HOME/Downloads" "$TARGET_HOME/Pictures" "$TARGET_HOME/Music" "$TARGET_HOME/Videos" "$TARGET_HOME/Projects"

if ! grep -q 'export PATH="$HOME/bin:$PATH"' "$TARGET_HOME/.bashrc" 2>/dev/null; then
  echo 'export PATH="$HOME/bin:$PATH"' >> "$TARGET_HOME/.bashrc"
  run_root chown "$TARGET_USER:$TARGET_USER" "$TARGET_HOME/.bashrc"
fi

echo
echo "============================================================"
echo " DONE."
echo
echo " Log in as normal user and start Sway with:"
echo " startsway"
echo
echo "Controls:"
echo " Super + Enter       Terminal"
echo " Super + D           App launcher"
echo " Super + Shift + Q   Close window"
echo " Super + Shift + E   Exit Sway"
echo " Ctrl + Shift + C    Copy in terminal"
echo " Ctrl + Shift + V    Paste in terminal"
echo "============================================================"
