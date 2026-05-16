#!/usr/bin/env bash
# install-plymouth.sh — Install CP2077 Plymouth theme on Arch Linux
# Usage: sudo ./install-plymouth.sh

set -euo pipefail

THEME_NAME="cp2077"
THEME_DIR="/usr/share/plymouth/themes/${THEME_NAME}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

YLW='\033[38;2;252;238;12m'
GRN='\033[38;2;0;255;159m'
RED='\033[38;2;255;0;60m'
RST='\033[0m'

if [ "$(id -u)" -ne 0 ]; then
  echo -e "${RED}  ✗ Run as root: sudo $0${RST}" >&2; exit 1
fi

echo -e "${YLW}  Installing CP2077 Plymouth theme…${RST}"

# Ensure plymouth is installed
if ! command -v plymouth &>/dev/null; then
  echo -e "  Installing plymouth…"
  pacman -S --noconfirm plymouth 2>/dev/null || \
    { echo -e "${RED}  ✗ Plymouth not found. Install: sudo pacman -S plymouth${RST}"; exit 1; }
fi

# Copy theme files
mkdir -p "$THEME_DIR"
cp -f "${SCRIPT_DIR}/${THEME_NAME}.plymouth" "${THEME_DIR}/"
cp -f "${SCRIPT_DIR}/${THEME_NAME}.script"   "${THEME_DIR}/"
echo -e "  ${GRN}✓ Theme files copied to ${THEME_DIR}${RST}"

# Set as default Plymouth theme
plymouth-set-default-theme --rebuild-initrd "$THEME_NAME"
echo -e "  ${GRN}✓ Default theme set to: ${THEME_NAME}${RST}"

# Add quiet splash to GRUB if not present
GRUB_CFG="/etc/default/grub"
if [ -f "$GRUB_CFG" ]; then
  if ! grep -q "quiet splash" "$GRUB_CFG"; then
    sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="\([^"]*\)"/GRUB_CMDLINE_LINUX_DEFAULT="\1 quiet splash"/' "$GRUB_CFG"
    grub-mkconfig -o /boot/grub/grub.cfg 2>/dev/null || true
    echo -e "  ${GRN}✓ Added 'quiet splash' to GRUB_CMDLINE_LINUX_DEFAULT${RST}"
  else
    echo -e "  (GRUB already has quiet splash)"
  fi
fi

echo ""
echo -e "${YLW}  Done. Reboot to see the CP2077 Plymouth boot splash.${RST}"
echo ""
echo -e "  To preview without rebooting:  plymouthd && plymouth --show-splash"
echo -e "  To uninstall:                  plymouth-set-default-theme --rebuild-initrd details"
