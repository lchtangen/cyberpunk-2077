#!/system/bin/sh
# cp2077-config.sh — Interactive config tool for CP2077 Ultimate v3.0.0
# Usage: su -c /data/adb/modules/CP2077_OP7Pro_Ultimate/cp2077-config.sh
# Writes /data/cp2077_ultimate.conf then optionally reinstalls the module.

CONFIG_FILE="/data/cp2077_ultimate.conf"
MODULE_ZIP="/sdcard/Download/CP2077-OP7Pro-v3.0.0-ultimate-all-in-one.zip"

echo ""
echo "  ╔════════════════════════════════════════════════╗"
echo "  ║   Cyberpunk 2077 Ultimate — Config Tool v3.0  ║"
echo "  ╚════════════════════════════════════════════════╝"
echo ""

echo "  Select boot animation:"
echo "  [1] CyberGlitch-2077    (recommended)"
echo "  [2] Cyberpunk-Flatline-2077"
echo "  [3] Re-Boot Animation"
echo "  [4] Original 1080p (8T SE port)"
printf "  Choice [1-4]: "
read -r boot_choice
case "$boot_choice" in
  2|flatline) BOOT="flatline" ;;
  3|reboot)   BOOT="reboot" ;;
  4|og1080p)  BOOT="og1080p" ;;
  *)          BOOT="glitch" ;;
esac
echo "  → $BOOT"
echo ""

echo "  Select shutdown animation:"
echo "  [1] Match boot variant   (recommended)"
echo "  [2] Cyberpunk-Flatline"
echo "  [3] Re-Boot Animation"
echo "  [4] Skip (no shutdown animation)"
printf "  Choice [1-4]: "
read -r shut_choice
case "$shut_choice" in
  2|flatline) SHUT="flatline" ;;
  3|reboot)   SHUT="reboot" ;;
  4|none)     SHUT="none" ;;
  *)          SHUT="$BOOT" ;;
esac
echo "  → $SHUT"
echo ""

printf "  Install CP2077 audio sounds? [Y/n]: "
read -r audio_yn
case "$audio_yn" in n|N) AUDIO="no" ;; *) AUDIO="yes" ;; esac
echo "  → Audio: $AUDIO"
echo ""

echo "  Install live wallpaper?"
echo "  [1] Skip (default)"
echo "  [2] Original"
echo "  [3] Vivid"
printf "  Choice [1-3]: "
read -r wall_choice
case "$wall_choice" in
  2|original) WALL="original" ;;
  3|vivid)    WALL="vivid" ;;
  *)          WALL="no" ;;
esac
echo "  → Wallpaper: $WALL"
echo ""

printf "  Include splash boot image? [y/N]: "
read -r splash_yn
case "$splash_yn" in y|Y) SPLASH="yes" ;; *) SPLASH="no" ;; esac
echo "  → Splash: $SPLASH"
echo ""

echo "  ================================"
echo "  Boot      : $BOOT"
echo "  Shutdown  : $SHUT"
echo "  Audio     : $AUDIO"
echo "  Wallpaper : $WALL"
echo "  Splash    : $SPLASH"
echo "  ================================"
echo ""
printf "  Save config and reinstall? [Y/n]: "
read -r confirm
case "$confirm" in n|N) echo "  Cancelled."; exit 1 ;; esac

rm -f "$CONFIG_FILE"
{
  echo "boot=$BOOT"
  echo "shutdown=$SHUT"
  echo "audio=$AUDIO"
  echo "wallpaper=$WALL"
  echo "splash=$SPLASH"
} > "$CONFIG_FILE"
chmod 644 "$CONFIG_FILE"
echo "  ✓ Config saved to $CONFIG_FILE"
echo ""

if [ -f "$MODULE_ZIP" ]; then
  echo "  Re-installing module..."
  magisk --install-module "$MODULE_ZIP"
  echo "  Done! Reboot to apply changes."
else
  echo "  Module zip not found at $MODULE_ZIP"
  echo "  Re-flash the module manually to apply config."
fi
