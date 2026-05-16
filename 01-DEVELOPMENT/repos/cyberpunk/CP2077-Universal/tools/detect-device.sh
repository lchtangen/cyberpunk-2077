#!/system/bin/sh
# detect-device.sh — Dump device fingerprint info for debugging
# Run: su -c /data/adb/modules/CP2077_Universal/tools/detect-device.sh

echo ""
echo "  ╔═══════════════════════════════════════════╗"
echo "  ║   CP2077 Universal — Device Fingerprint   ║"
echo "  ╚═══════════════════════════════════════════╝"
echo ""

echo "  ── Device ──────────────────────────────────"
echo "  Brand      : $(getprop ro.product.brand)"
echo "  Model      : $(getprop ro.product.model)"
echo "  Device     : $(getprop ro.product.device)"
echo "  Mfr        : $(getprop ro.product.manufacturer)"
echo "  ABI        : $(getprop ro.product.cpu.abi)"
echo ""
echo "  ── Android ─────────────────────────────────"
echo "  Release    : $(getprop ro.build.version.release)"
echo "  API        : $(getprop ro.build.version.sdk)"
echo "  Build ID   : $(getprop ro.build.id)"
echo "  Fingerprint: $(getprop ro.build.fingerprint)"
echo ""
echo "  ── Screen ──────────────────────────────────"
echo "  wm size    : $(wm size 2>/dev/null)"
echo "  wm density : $(wm density 2>/dev/null)"
echo "  lcd_width  : $(getprop ro.sf.lcd_width)"
echo "  lcd_height : $(getprop ro.sf.lcd_height)"
echo "  lcd_density: $(getprop ro.sf.lcd_density)"
echo ""
echo "  ── ROM Detection ───────────────────────────"
echo "  LineageOS  : $(getprop ro.lineage.version)"
echo "  OOS        : $(getprop ro.oxygen.version)"
echo "  MIUI       : $(getprop ro.miui.ui.version.name)"
echo "  HyperOS    : $(getprop ro.mi.os.version.name)"
echo "  One UI     : $(getprop ro.build.version.oneui)"
echo "  CalyxOS    : $(getprop ro.calyxos.version)"
echo "  GrapheneOS : $(getprop ro.grapheneos.version)"
echo "  crDroid    : $(getprop org.crdroid.version)"
echo "  Evolution X: $(getprop ro.evo.version)"
echo "  yaap       : $(getprop ro.yaap.version)"
echo "  PixelOS    : $(getprop ro.pixelos.version)"
echo "  RisingOS   : $(getprop org.rising.version)"
echo "  DerpFest   : $(getprop ro.derp.version)"
echo ""
echo "  ── Root ────────────────────────────────────"
echo "  Magisk     : $(magisk -v 2>/dev/null || echo 'n/a')"
echo "  KernelSU   : $(ksud version 2>/dev/null || echo 'n/a')"
echo ""
echo "  ── Partitions ──────────────────────────────"
for p in /product /my_product /vendor /system/product /system/media /data/local; do
  [ -d "$p" ] && echo "  EXISTS: $p" || echo "  absent: $p"
done
echo ""
echo "  ── Active bootanimation files ──────────────"
for f in \
  /product/media/bootanimation.zip \
  /system/product/media/bootanimation.zip \
  /system/media/bootanimation.zip \
  /my_product/media/bootanimation/bootanimation.zip \
  /data/local/bootanimation.zip \
  /data/misc/bootanim/bootanimation.zip; do
  if [ -f "$f" ]; then
    sz=$(du -h "$f" | cut -f1)
    echo "  $sz  $f"
  fi
done
echo ""
