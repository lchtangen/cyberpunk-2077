#!/system/bin/sh
# cp2077-config.sh — CP2077 Universal Config Tool v1.0.0
# Run as root: su -c /data/adb/modules/CP2077_Universal/cp2077-config.sh
# Reconfigures and reinstalls module based on user choices.

CONFIG_FILE="/data/cp2077_universal.conf"
MOD_DIR="/data/adb/modules/CP2077_Universal"

# Auto-detect current device info
_screen=$(cat "$MOD_DIR/resolution.txt" 2>/dev/null || wm size 2>/dev/null | grep -oE '[0-9]+x[0-9]+' | head -1)
_rom=$(cat "$MOD_DIR/rom.txt" 2>/dev/null || echo "unknown")
_model=$(getprop ro.product.model 2>/dev/null || echo "unknown")

echo ""
echo "  ╔════════════════════════════════════════════════════╗"
echo "  ║   Cyberpunk 2077 Universal — Config Tool v1.0.0   ║"
echo "  ╠════════════════════════════════════════════════════╣"
echo "  ║  Device : $_model"
echo "  ║  Screen : $_screen"
echo "  ║  ROM    : $_rom"
echo "  ╚════════════════════════════════════════════════════╝"
echo ""

echo "  Select boot animation variant:"
echo "  [1] CyberGlitch-2077    (glitch + logo, 60fps) — recommended"
echo "  [2] Cyberpunk-Flatline-2077  (flatline style, 60fps)"
echo "  [3] Re-Boot Animation   (OP logo + glitch, 60fps)"
echo "  [4] Original (8T SE port, 30fps)"
printf "  Choice [1-4]: "
read -r c
case "$c" in
  2|flatline) BOOT="flatline" ;;
  3|reboot)   BOOT="reboot" ;;
  4|og)       BOOT="og" ;;
  *)          BOOT="glitch" ;;
esac
echo "  → Boot: $BOOT"
echo ""

echo "  Select shutdown animation:"
echo "  [1] Match boot variant  (recommended)"
echo "  [2] CyberGlitch"
echo "  [3] Flatline"
echo "  [4] Re-Boot"
echo "  [5] None"
printf "  Choice [1-5]: "
read -r c
case "$c" in
  2|glitch)   SHUT="glitch" ;;
  3|flatline) SHUT="flatline" ;;
  4|reboot)   SHUT="reboot" ;;
  5|none)     SHUT="none" ;;
  *)          SHUT="$BOOT" ;;
esac
echo "  → Shutdown: $SHUT"
echo ""

printf "  Install CP2077 audio sounds? [Y/n]: "
read -r c
case "$c" in n|N) AUDIO="no" ;; *) AUDIO="yes" ;; esac
echo "  → Audio: $AUDIO"
echo ""

echo "  ═══════════════════════════"
echo "  Boot    : $BOOT"
echo "  Shutdown: $SHUT"
echo "  Audio   : $AUDIO"
echo "  ═══════════════════════════"
printf "  Save and reinstall? [Y/n]: "
read -r c
case "$c" in n|N) echo "  Cancelled."; exit 0 ;; esac

rm -f "$CONFIG_FILE"
{
  echo "boot=$BOOT"
  echo "shutdown=$SHUT"
  echo "audio=$AUDIO"
} > "$CONFIG_FILE"
chmod 644 "$CONFIG_FILE"
echo "  ✓ Config saved to $CONFIG_FILE"
echo ""

# Find the module zip to reinstall
MOD_ZIP=""
for candidate in \
  "/sdcard/Download/CP2077-Universal-v1.0.0.zip" \
  "/sdcard/Download/CP2077-Universal.zip" \
  "/storage/emulated/0/Download/CP2077-Universal-v1.0.0.zip"; do
  [ -f "$candidate" ] && MOD_ZIP="$candidate" && break
done

if [ -n "$MOD_ZIP" ]; then
  echo "  Re-installing from $MOD_ZIP ..."
  magisk --install-module "$MOD_ZIP" 2>/dev/null || \
    ksud module install "$MOD_ZIP" 2>/dev/null || \
    echo "  Could not auto-reinstall. Reflash manually via Magisk/KSU Manager."
else
  echo "  Module zip not found in /sdcard/Download."
  echo "  Copy the zip there and reflash via Magisk/KernelSU Manager."
fi
echo ""
echo "  Done! Reboot to apply changes."
