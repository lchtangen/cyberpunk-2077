#!/usr/bin/env bash
set -Eeuo pipefail

trap 'echo "[ERROR] Failed at line $LINENO: $BASH_COMMAND" >&2' ERR

echo
echo "============================================================"
echo " Arch Linux Minimal Sway Desktop Installer"
echo " Fixed: no fragile SUDO variable"
echo "============================================================"
echo

if [ ! -f /etc/os-release ]; then
  echo "[ERROR] /etc/os-release not found."
  exit 1
fi

if ! grep -qi "arch" /etc/os-release; then
  echo "[ERROR] This script is for Arch Linux."
  cat /etc/os-release
  exit 1
fi

as_root() {
  if [ "$EUID" -eq 0 ]; then
    "$@"
  elif command -v sudo >/dev/null 2>&1; then
    sudo "$@"
  else
    echo "[ERROR] This command needs root, but sudo is not installed."
    echo "Run this instead:"
    echo "su -"
    echo "bash /home/YOUR_USERNAME/setup-sway-desktop.sh"
    exit 1
  fi
}

detect_target_user() {
  if [ "${SUDO_USER:-}" != "" ] && [ "${SUDO_USER:-}" != "root" ]; then
    echo "$SUDO_USER"
    return
  fi

  awk -F: '$3 >= 1000 && $3 < 60000 && $7 !~ /(nologin|false)$/ {print $1; exit}' /etc/passwd
}

TARGET_USER="$(detect_target_user || true)"

if [ "$TARGET_USER" = "" ]; then
  echo "[ERROR] Could not detect normal user."
  echo "Create a normal user first, or run this script with sudo from your normal user."
  exit 1
fi

TARGET_HOME="$(getent passwd "$TARGET_USER" | cut -d: -f6)"

if [ "$TARGET_HOME" = "" ] || [ ! -d "$TARGET_HOME" ]; then
  echo "[ERROR] Could not detect home directory for: $TARGET_USER"
  exit 1
fi

as_user() {
  if [ "$EUID" -eq 0 ]; then
    runuser -u "$TARGET_USER" -- env HOME="$TARGET_HOME" "$@"
  else
    env HOME="$TARGET_HOME" "$@"
  fi
}

echo "[INFO] Target user: $TARGET_USER"
echo "[INFO] Target home: $TARGET_HOME"
echo

if [ -f /var/lib/pacman/db.lck ]; then
  echo "[ERROR] Pacman lock exists: /var/lib/pacman/db.lck"
  echo "Check running pacman:"
  echo "ps aux | grep pacman"
  echo
  echo "If pacman is NOT running, remove lock:"
  echo "sudo rm /var/lib/pacman/db.lck"
  exit 1
fi

echo "[1/9] Checking network..."
if ping -c 1 -W 3 archlinux.org >/dev/null 2>&1; then
  echo "[OK] Internet works."
else
  echo "[WARN] Internet check failed."
  echo "Pacman install may fail if DNS/network is broken."
  echo "Try USB tethering or Ethernet before running this script."
fi

echo
echo "[2/9] Checking pacman repos..."
if ! grep -q "^\[extra\]" /etc/pacman.conf; then
  echo "[ERROR] [extra] repo is not enabled in /etc/pacman.conf"
  echo "Edit it:"
  echo "sudo nano /etc/pacman.conf"
  echo
  echo "You need:"
  echo "[core]"
  echo "Include = /etc/pacman.d/mirrorlist"
  echo
  echo "[extra]"
  echo "Include = /etc/pacman.d/mirrorlist"
  exit 1
fi

echo
echo "[3/9] Refreshing package database..."
as_root pacman -Syy

echo
echo "[4/9] Installing Sway desktop packages..."
as_root pacman -S --needed sway swaybg swayidle swaylock foot foot-terminfo waybar wofi wl-clipboard grim slurp mako polkit xorg-xwayland xdg-desktop-portal xdg-desktop-portal-wlr xdg-user-dirs mesa noto-fonts noto-fonts-emoji ttf-dejavu ttf-liberation ttf-jetbrains-mono adwaita-icon-theme hicolor-icon-theme fastfetch nano git curl wget networkmanager

echo
echo "[5/9] Enabling NetworkManager if installed..."
as_root systemctl enable --now NetworkManager 2>/dev/null || true

echo
echo "[6/9] Creating user folders..."
as_user mkdir -p "$TARGET_HOME/Desktop" "$TARGET_HOME/Documents" "$TARGET_HOME/Downloads" "$TARGET_HOME/Pictures" "$TARGET_HOME/Music" "$TARGET_HOME/Videos" "$TARGET_HOME/Projects" "$TARGET_HOME/bin"
as_user xdg-user-dirs-update 2>/dev/null || true

echo
echo "[7/9] Writing Sway config..."
as_user mkdir -p "$TARGET_HOME/.config/sway"

cat > /tmp/sway-config <<'SWAYEOF'
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
bindsym $mod+Shift+space focus mode_toggle

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

bindsym $mod+Shift+1 move container to workspace number 1
bindsym $mod+Shift+2 move container to workspace number 2
bindsym $mod+Shift+3 move container to workspace number 3
bindsym $mod+Shift+4 move container to workspace number 4
bindsym $mod+Shift+5 move container to workspace number 5

bindsym Print exec grim -g "$(slurp)" "$HOME/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png"
bindsym $mod+Print exec grim "$HOME/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png"

bar {
    swaybar_command waybar
}

exec mako
exec foot
SWAYEOF

as_root cp /tmp/sway-config "$TARGET_HOME/.config/sway/config"

echo
echo "[8/9] Writing Foot and Waybar configs..."
as_user mkdir -p "$TARGET_HOME/.config/foot" "$TARGET_HOME/.config/waybar"

cat > /tmp/foot.ini <<'FOOTEOF'
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

as_root cp /tmp/foot.ini "$TARGET_HOME/.config/foot/foot.ini"

cat > /tmp/waybar-config <<'WAYBAREOF'
{
  "layer": "top",
  "position": "top",
  "height": 30,
  "modules-left": ["sway/workspaces", "sway/mode"],
  "modules-center": ["clock"],
  "modules-right": ["network", "battery", "tray"],
  "clock": {
    "format": "{:%a %d %b  %H:%M}"
  },
  "network": {
    "format-wifi": "WiFi {essid}",
    "format-ethernet": "ETH",
    "format-disconnected": "Offline"
  },
  "battery": {
    "format": "BAT {capacity}%"
  }
}
WAYBAREOF

as_root cp /tmp/waybar-config "$TARGET_HOME/.config/waybar/config"

cat > /tmp/waybar-style.css <<'STYLEEOF'
* {
  font-family: "JetBrains Mono", "Noto Sans";
  font-size: 12px;
}

window#waybar {
  background: #111111;
  color: #eeeeee;
}

#workspaces button {
  color: #dddddd;
  background: transparent;
  padding: 0 8px;
  border: none;
}

#workspaces button.focused {
  background: #333333;
  color: #ffffff;
}

#clock, #network, #battery, #tray {
  padding: 0 10px;
}
STYLEEOF

as_root cp /tmp/waybar-style.css "$TARGET_HOME/.config/waybar/style.css"

echo
echo "[9/9] Creating start command..."
cat > /tmp/startsway <<'STARTEOF'
#!/usr/bin/env bash
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export QT_QPA_PLATFORM=wayland
export MOZ_ENABLE_WAYLAND=1
exec sway
STARTEOF

as_root cp /tmp/startsway "$TARGET_HOME/bin/startsway"
as_root chmod +x "$TARGET_HOME/bin/startsway"

if ! grep -q 'export PATH="$HOME/bin:$PATH"' "$TARGET_HOME/.bashrc" 2>/dev/null; then
  echo 'export PATH="$HOME/bin:$PATH"' >> "$TARGET_HOME/.bashrc"
fi

as_root chown -R "$TARGET_USER:$TARGET_USER" "$TARGET_HOME/.config" "$TARGET_HOME/bin" "$TARGET_HOME/Desktop" "$TARGET_HOME/Documents" "$TARGET_HOME/Downloads" "$TARGET_HOME/Pictures" "$TARGET_HOME/Music" "$TARGET_HOME/Videos" "$TARGET_HOME/Projects" "$TARGET_HOME/.bashrc"

echo
echo "============================================================"
echo " DONE."
echo
echo "Start Sway from TTY:"
echo "$TARGET_HOME/bin/startsway"
echo
echo "Or after logging out/in:"
echo "startsway"
echo
echo "Controls:"
echo "Super + Enter       Open terminal"
echo "Super + D           App launcher"
echo "Super + Shift + Q   Close window"
echo "Super + Shift + E   Exit Sway"
echo "Ctrl + Shift + C    Copy in terminal"
echo "Ctrl + Shift + V    Paste in terminal"
echo "============================================================"
