#!/usr/bin/env bash
set -Eeuo pipefail

trap 'echo "[ERROR] Failed at line $LINENO: $BASH_COMMAND" >&2' ERR

echo
echo "============================================================"
echo " Arch Minimal Copy/Paste Desktop Installer"
echo " Sway + Foot + wl-clipboard"
echo "============================================================"
echo

if [ ! -f /etc/os-release ]; then
  echo "[ERROR] /etc/os-release not found. This does not look like Arch Linux."
  exit 1
fi

if ! grep -qi "arch" /etc/os-release; then
  echo "[ERROR] This script is made for Arch Linux."
  cat /etc/os-release
  exit 1
fi

if command -v sudo >/dev/null 2>&1; then
  if [ "$EUID" -eq 0 ]; then
    SUDO=""
    TARGET_USER="${SUDO_USER:-root}"
  else
    SUDO="sudo"
    TARGET_USER="$USER"
  fi
else
  if [ "$EUID" -ne 0 ]; then
    echo "[ERROR] sudo is not installed and you are not root."
    echo "Run as root or install sudo."
    exit 1
  fi
  SUDO=""
  TARGET_USER="${SUDO_USER:-root}"
fi

if [ "$TARGET_USER" = "root" ]; then
  TARGET_HOME="/root"
else
  TARGET_HOME="$(getent passwd "$TARGET_USER" | cut -d: -f6)"
fi

if [ -z "$TARGET_HOME" ] || [ ! -d "$TARGET_HOME" ]; then
  echo "[ERROR] Could not detect target home folder."
  exit 1
fi

echo "[INFO] Target user: $TARGET_USER"
echo "[INFO] Target home: $TARGET_HOME"
echo

if [ -f /var/lib/pacman/db.lck ]; then
  echo "[ERROR] Pacman lock exists: /var/lib/pacman/db.lck"
  echo "Check running pacman first:"
  echo "ps aux | grep pacman"
  echo
  echo "If nothing is running, remove lock:"
  echo "sudo rm /var/lib/pacman/db.lck"
  exit 1
fi

echo "[1/6] Refreshing package database..."
$SUDO pacman -Syy

echo
echo "[2/6] Installing minimal Wayland desktop packages..."
$SUDO pacman -S --needed sway foot foot-terminfo wl-clipboard xorg-xwayland polkit mesa noto-fonts noto-fonts-emoji ttf-dejavu ttf-liberation ttf-jetbrains-mono xdg-user-dirs

echo
echo "[3/6] Creating user directories..."
$SUDO -u "$TARGET_USER" xdg-user-dirs-update 2>/dev/null || true
$SUDO mkdir -p "$TARGET_HOME/Desktop" "$TARGET_HOME/Documents" "$TARGET_HOME/Downloads" "$TARGET_HOME/Pictures" "$TARGET_HOME/Music" "$TARGET_HOME/Videos" "$TARGET_HOME/Projects" "$TARGET_HOME/bin"
$SUDO chown -R "$TARGET_USER:$TARGET_USER" "$TARGET_HOME/Desktop" "$TARGET_HOME/Documents" "$TARGET_HOME/Downloads" "$TARGET_HOME/Pictures" "$TARGET_HOME/Music" "$TARGET_HOME/Videos" "$TARGET_HOME/Projects" "$TARGET_HOME/bin"

echo
echo "[4/6] Writing Sway config..."
$SUDO -u "$TARGET_USER" mkdir -p "$TARGET_HOME/.config/sway"
$SUDO -u "$TARGET_USER" tee "$TARGET_HOME/.config/sway/config" >/dev/null <<'SWAYEOF'
set $mod Mod4
set $term foot

font pango:JetBrains Mono 10

bindsym $mod+Return exec $term
bindsym $mod+q kill
bindsym $mod+Shift+r reload
bindsym $mod+Shift+e exit
bindsym $mod+d exec foot

input * {
    xkb_layout no
}

output * bg #111111 solid_color

exec foot
SWAYEOF

echo
echo "[5/6] Writing Foot terminal config..."
$SUDO -u "$TARGET_USER" mkdir -p "$TARGET_HOME/.config/foot"
$SUDO -u "$TARGET_USER" tee "$TARGET_HOME/.config/foot/foot.ini" >/dev/null <<'FOOTEOF'
font=JetBrains Mono:size=11

[scrollback]
lines=10000

[cursor]
style=beam

[mouse]
hide-when-typing=yes
FOOTEOF

echo
echo "[6/6] Creating start command..."
$SUDO -u "$TARGET_USER" tee "$TARGET_HOME/bin/startcopydesk" >/dev/null <<'STARTEOF'
#!/usr/bin/env bash
export XDG_SESSION_TYPE=wayland
exec sway
STARTEOF

$SUDO chmod +x "$TARGET_HOME/bin/startcopydesk"
$SUDO chown "$TARGET_USER:$TARGET_USER" "$TARGET_HOME/bin/startcopydesk"

if ! grep -q 'export PATH="$HOME/bin:$PATH"' "$TARGET_HOME/.bashrc" 2>/dev/null; then
  echo 'export PATH="$HOME/bin:$PATH"' | $SUDO tee -a "$TARGET_HOME/.bashrc" >/dev/null
fi

echo
echo "============================================================"
echo " DONE."
echo
echo " Start minimal desktop from TTY with:"
echo " startcopydesk"
echo
echo " Or:"
echo " sway"
echo
echo " Inside Foot terminal:"
echo " Copy:  Ctrl + Shift + C"
echo " Paste: Ctrl + Shift + V"
echo
echo " Test clipboard:"
echo " echo hello | wl-copy"
echo " wl-paste"
echo
echo " Open new terminal:"
echo " Super + Enter"
echo
echo " Exit desktop:"
echo " Super + Shift + E"
echo "============================================================"
