#!/usr/bin/env bash
set -Eeuo pipefail

trap 'echo "[ERROR] Failed at line $LINENO: $BASH_COMMAND" >&2' ERR

echo
echo "============================================================"
echo " Arch Linux KDE Plasma Wayland Minimal Installer"
echo "============================================================"
echo

if [ ! -f /etc/os-release ]; then
  echo "[ERROR] /etc/os-release not found. This does not look like Arch Linux."
  exit 1
fi

if ! grep -qi "arch" /etc/os-release; then
  echo "[ERROR] This script is intended for Arch Linux only."
  cat /etc/os-release
  exit 1
fi

if command -v sudo >/dev/null 2>&1; then
  if [ "$EUID" -eq 0 ]; then
    SUDO=""
  else
    SUDO="sudo"
  fi
else
  if [ "$EUID" -ne 0 ]; then
    echo "[ERROR] sudo is not installed and you are not root."
    echo "Run: su -"
    echo "Then run the script again."
    exit 1
  fi
  SUDO=""
fi

if [ -f /var/lib/pacman/db.lck ]; then
  echo "[ERROR] Pacman lock exists:"
  echo "/var/lib/pacman/db.lck"
  echo "If no pacman process is running, remove it with:"
  echo "sudo rm /var/lib/pacman/db.lck"
  exit 1
fi

TARGET_USER="${SUDO_USER:-$USER}"

if [ "$TARGET_USER" = "root" ]; then
  TARGET_HOME="/root"
else
  TARGET_HOME="$(getent passwd "$TARGET_USER" | cut -d: -f6)"
fi

if [ -z "$TARGET_HOME" ] || [ ! -d "$TARGET_HOME" ]; then
  echo "[WARN] Could not detect normal user home. User configs will be skipped."
  TARGET_HOME=""
fi

echo "[INFO] Target user: $TARGET_USER"
echo "[INFO] Target home: ${TARGET_HOME:-none}"
echo

echo "[1/8] Updating pacman keyring..."
$SUDO pacman -Sy --needed archlinux-keyring

echo
echo "[2/8] Updating full system..."
$SUDO pacman -Syu --needed

echo
echo "[3/8] Installing minimal KDE Plasma Wayland desktop..."
PKGS=(
  plasma-meta
  sddm
  sddm-kcm
  konsole
  dolphin
  kate
  ark
  spectacle
  gwenview
  okular
  kio-extras
  kio-admin
  ffmpegthumbs
  kdegraphics-thumbnailers
  firefox
  networkmanager
  plasma-nm
  pipewire
  wireplumber
  pipewire-pulse
  pipewire-alsa
  pipewire-jack
  alsa-utils
  sof-firmware
  plasma-pa
  bluez
  bluez-utils
  bluedevil
  power-profiles-daemon
  xdg-desktop-portal
  xdg-desktop-portal-kde
  xdg-user-dirs
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  ttf-dejavu
  ttf-liberation
  ttf-jetbrains-mono
  mesa
  vulkan-intel
  intel-media-driver
  libva-utils
  breeze-gtk
  papirus-icon-theme
  ufw
  plasma-firewall
  nano
  git
  curl
  wget
  fastfetch
)

$SUDO pacman -S --needed "${PKGS[@]}"

echo
echo "[4/8] Writing SDDM config..."
$SUDO mkdir -p /etc/sddm.conf.d
$SUDO tee /etc/sddm.conf.d/kde-minimal.conf >/dev/null <<'SDDMEOF'
[Theme]
Current=breeze

[Users]
RememberLastUser=true
RememberLastSession=true

[General]
HaltCommand=/usr/bin/systemctl poweroff
RebootCommand=/usr/bin/systemctl reboot
SDDMEOF

echo
echo "[5/8] Writing Wayland-friendly environment config..."
$SUDO tee /etc/environment >/dev/null <<'ENVEOF'
MOZ_ENABLE_WAYLAND=1
ELECTRON_OZONE_PLATFORM_HINT=auto
ENVEOF

echo
echo "[6/8] Enabling system services..."
$SUDO systemctl enable NetworkManager
$SUDO systemctl enable bluetooth
$SUDO systemctl enable power-profiles-daemon
$SUDO systemctl enable sddm
$SUDO systemctl set-default graphical.target

echo
echo "[7/8] Enabling firewall..."
$SUDO systemctl enable --now ufw || true
$SUDO ufw default deny incoming || true
$SUDO ufw default allow outgoing || true
$SUDO ufw --force enable || true

echo
echo "[8/8] Applying minimal user config..."
if [ -n "$TARGET_HOME" ]; then
  $SUDO mkdir -p "$TARGET_HOME/Desktop" "$TARGET_HOME/Documents" "$TARGET_HOME/Downloads" "$TARGET_HOME/Pictures" "$TARGET_HOME/Music" "$TARGET_HOME/Videos" "$TARGET_HOME/Projects"
  $SUDO mkdir -p "$TARGET_HOME/.config"

  $SUDO tee "$TARGET_HOME/.config/baloofilerc" >/dev/null <<'BALOOEOF'
[Basic Settings]
Indexing-Enabled=false
BALOOEOF

  $SUDO tee "$TARGET_HOME/.config/kdeglobals" >/dev/null <<'KDEEOF'
[General]
ColorScheme=BreezeDark
Name=Breeze Dark
fixed=JetBrains Mono,10,-1,5,50,0,0,0,0,0
font=Noto Sans,10,-1,5,50,0,0,0,0,0
menuFont=Noto Sans,10,-1,5,50,0,0,0,0,0
smallestReadableFont=Noto Sans,8,-1,5,50,0,0,0,0,0
toolBarFont=Noto Sans,10,-1,5,50,0,0,0,0,0

[KDE]
LookAndFeelPackage=org.kde.breezedark.desktop

[Icons]
Theme=Papirus-Dark
KDEEOF

  $SUDO chown -R "$TARGET_USER:$TARGET_USER" "$TARGET_HOME/.config" "$TARGET_HOME/Desktop" "$TARGET_HOME/Documents" "$TARGET_HOME/Downloads" "$TARGET_HOME/Pictures" "$TARGET_HOME/Music" "$TARGET_HOME/Videos" "$TARGET_HOME/Projects"
fi

echo
echo "============================================================"
echo " DONE."
echo " Reboot with:"
echo " sudo reboot"
echo
echo " At login screen choose:"
echo " Plasma (Wayland)"
echo
echo " After login, open Konsole and verify:"
echo " echo \$XDG_SESSION_TYPE"
echo " Expected output: wayland"
echo "============================================================"
