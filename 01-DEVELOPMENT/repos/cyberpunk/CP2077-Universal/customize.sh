#!/system/bin/sh
# ╔══════════════════════════════════════════════════════════════╗
# ║  CYBERPUNK 2077 — UNIVERSAL EDITION  v1.0.0                 ║
# ║  Supports: ALL Android devices, ALL major ROMs               ║
# ║  Magisk 20.4+ | KernelSU | APatch                           ║
# ╚══════════════════════════════════════════════════════════════╝

[ -z "$MODPATH" ] && MODPATH="${0%/*}"
CONFIG_FILE="/data/cp2077_universal.conf"

# ================================================================
# SECTION 1: DEVICE FINGERPRINT
# ================================================================

detect_device() {
  DEVICE_BRAND=$(getprop ro.product.brand       2>/dev/null | tr '[:upper:]' '[:lower:]')
  DEVICE_MODEL=$(getprop ro.product.model        2>/dev/null)
  DEVICE_MANU=$(getprop  ro.product.manufacturer 2>/dev/null | tr '[:upper:]' '[:lower:]')
  DEVICE_API=$(getprop   ro.build.version.sdk    2>/dev/null)
  DEVICE_REL=$(getprop   ro.build.version.release 2>/dev/null)
  DEVICE_ABI=$(getprop   ro.product.cpu.abi      2>/dev/null)

  # Screen resolution — wm size returns "Physical size: WxH"
  WM_OUT=$(wm size 2>/dev/null | grep -i "physical" | grep -oE '[0-9]+x[0-9]+' | head -1)
  [ -z "$WM_OUT" ] && WM_OUT=$(wm size 2>/dev/null | grep -oE '[0-9]+x[0-9]+' | head -1)
  [ -z "$WM_OUT" ] && {
    _W=$(getprop ro.sf.lcd_width  2>/dev/null)
    _H=$(getprop ro.sf.lcd_height 2>/dev/null)
    [ -n "$_W" ] && [ -n "$_H" ] && WM_OUT="${_W}x${_H}"
  }

  SCREEN_W=0; SCREEN_H=0
  if [ -n "$WM_OUT" ]; then
    SCREEN_W="${WM_OUT%x*}"; SCREEN_H="${WM_OUT#*x}"
    # Ensure portrait orientation (W < H)
    [ "$SCREEN_W" -gt "$SCREEN_H" ] 2>/dev/null && {
      _tmp="$SCREEN_W"; SCREEN_W="$SCREEN_H"; SCREEN_H="$_tmp"
    }
  fi

  # Density
  SCREEN_DPI=$(wm density 2>/dev/null | grep -oE '[0-9]+' | head -1)
  [ -z "$SCREEN_DPI" ] && SCREEN_DPI=$(getprop ro.sf.lcd_density 2>/dev/null)
}

# ================================================================
# SECTION 2: ROM DETECTION
# ================================================================

detect_rom() {
  _LINEAGE=$(getprop ro.lineage.version      2>/dev/null)
  _OOS=$(getprop     ro.oxygen.version       2>/dev/null)
  _OOS2=$(getprop    ro.product.system.brand 2>/dev/null | grep -i "oneplus")
  _HYPEROS=$(getprop ro.mi.os.version.name   2>/dev/null)
  _MIUI=$(getprop    ro.miui.ui.version.name 2>/dev/null)
  _ONEUI=$(getprop   ro.build.version.oneui  2>/dev/null)
  _CALYX=$(getprop   ro.calyxos.version      2>/dev/null)
  _GRAPHENE=$(getprop ro.grapheneos.version  2>/dev/null)
  _CRDROID=$(getprop org.crdroid.version     2>/dev/null)
  _EVOX=$(getprop    ro.evo.version          2>/dev/null)
  _YAAP=$(getprop    ro.yaap.version         2>/dev/null)
  _ARROW=$(getprop   ro.arrow.version        2>/dev/null)
  _PIXELOS=$(getprop ro.pixelos.version      2>/dev/null)
  _RISING=$(getprop  org.rising.version      2>/dev/null)
  _DERP=$(getprop    ro.derp.version         2>/dev/null)
  _PIXEL_BRAND=$(getprop ro.product.brand    2>/dev/null | grep -i "google")
  _COLOROS=$(getprop ro.build.version.coloros 2>/dev/null)

  ROM_FAMILY="aosp"
  ROM_VARIANT="generic"

  if   [ -n "$_HYPEROS" ];  then ROM_FAMILY="miui";     ROM_VARIANT="hyperos"
  elif [ -n "$_MIUI" ];     then ROM_FAMILY="miui";     ROM_VARIANT="miui"
  elif [ -n "$_ONEUI" ];    then ROM_FAMILY="samsung";  ROM_VARIANT="oneui"
  elif [ -n "$_OOS" ] || [ -n "$_OOS2" ] || [ -n "$_COLOROS" ]; then
                                 ROM_FAMILY="oos";      ROM_VARIANT="oos"
  elif [ -n "$_LINEAGE" ];  then ROM_FAMILY="lineage";  ROM_VARIANT="lineage"
  elif [ -n "$_GRAPHENE" ]; then ROM_FAMILY="aosp";     ROM_VARIANT="grapheneos"
  elif [ -n "$_CALYX" ];    then ROM_FAMILY="aosp";     ROM_VARIANT="calyxos"
  elif [ -n "$_CRDROID" ];  then ROM_FAMILY="lineage";  ROM_VARIANT="crdroid"
  elif [ -n "$_EVOX" ];     then ROM_FAMILY="aosp";     ROM_VARIANT="evolutionx"
  elif [ -n "$_YAAP" ];     then ROM_FAMILY="aosp";     ROM_VARIANT="yaap"
  elif [ -n "$_ARROW" ];    then ROM_FAMILY="aosp";     ROM_VARIANT="arrowos"
  elif [ -n "$_PIXELOS" ];  then ROM_FAMILY="aosp";     ROM_VARIANT="pixelos"
  elif [ -n "$_RISING" ];   then ROM_FAMILY="aosp";     ROM_VARIANT="risingos"
  elif [ -n "$_DERP" ];     then ROM_FAMILY="lineage";  ROM_VARIANT="derpfest"
  elif [ -n "$_PIXEL_BRAND" ]; then ROM_FAMILY="aosp";  ROM_VARIANT="pixel"
  fi

  # Detect root solution
  ROOT_SOLUTION="magisk"
  [ -d /data/adb/ksud ]          && ROOT_SOLUTION="kernelsu"
  command -v apd >/dev/null 2>&1 && ROOT_SOLUTION="apatch"

  # Detect partition scheme
  HAS_PRODUCT_PARTITION=0
  [ -d /product ] && HAS_PRODUCT_PARTITION=1
  HAS_MY_PRODUCT=0
  [ -d /my_product ] && HAS_MY_PRODUCT=1
  HAS_VENDOR_PARTITION=0
  [ -d /vendor ] && HAS_VENDOR_PARTITION=1
}

# ================================================================
# SECTION 3: INSTALL PATH MATRIX
# ================================================================

get_install_paths() {
  case "$ROM_FAMILY" in
    samsung)
      # Samsung One UI: system/media primary, product/media fallback
      BOOT_TARGETS="/system/media/bootanimation.zip /product/media/bootanimation.zip"
      SHUT_TARGETS="/system/media/shutdownanimation.zip /product/media/shutdownanimation.zip"
      BOOT_DARK_TARGETS=""
      RBOOT_TARGETS=""
      ;;
    oos)
      # OOS/ColorOS: my_product/media AND product/media AND system/product/media
      BOOT_TARGETS="/product/media/bootanimation.zip /system/product/media/bootanimation.zip"
      SHUT_TARGETS="/product/media/shutdownanimation.zip /system/product/media/shutdownanimation.zip"
      BOOT_DARK_TARGETS="/product/media/bootanimation-dark.zip /system/product/media/bootanimation-dark.zip"
      RBOOT_TARGETS="/product/media/rbootanimation.zip"
      OOS_TARGETS="/my_product/media/bootanimation/bootanimation.zip"
      OOS_SHUT_TARGETS="/my_product/media/bootanimation/rbootanimation.zip"
      ;;
    miui)
      # MIUI/HyperOS: product/media and system/media
      BOOT_TARGETS="/product/media/bootanimation.zip /system/product/media/bootanimation.zip /system/media/bootanimation.zip"
      SHUT_TARGETS="/product/media/shutdownanimation.zip /system/product/media/shutdownanimation.zip /system/media/shutdownanimation.zip"
      BOOT_DARK_TARGETS="/product/media/bootanimation-dark.zip"
      RBOOT_TARGETS=""
      ;;
    lineage|aosp|*)
      # AOSP / LineageOS / Pixel / custom ROMs — standard paths
      BOOT_TARGETS="/product/media/bootanimation.zip /system/product/media/bootanimation.zip /system/media/bootanimation.zip"
      SHUT_TARGETS="/product/media/shutdownanimation.zip /system/product/media/shutdownanimation.zip /system/media/shutdownanimation.zip"
      BOOT_DARK_TARGETS="/product/media/bootanimation-dark.zip /system/product/media/bootanimation-dark.zip"
      RBOOT_TARGETS="/product/media/rbootanimation.zip /system/product/media/rbootanimation.zip"
      ;;
  esac

  # Universal data paths (highest priority on all ROMs)
  DATA_BOOT="/data/local/bootanimation.zip /data/misc/bootanim/bootanimation.zip"
  DATA_SHUT="/data/local/shutdownanimation.zip /data/misc/bootanim/shutdownanimation.zip"
}

# ================================================================
# SECTION 4: ANIMATION SCALING
# ================================================================

# Scale a bootanimation.zip's desc.txt to target W×H
# Uses only shell + unzip (always available via Magisk busybox)
scale_bootanimation() {
  local src="$1" dst="$2" tw="$3" th="$4"

  # Try to get busybox unzip/zip from Magisk
  _BB=""
  for bb in /data/adb/magisk/busybox /sbin/.magisk/busybox/busybox; do
    [ -x "$bb" ] && _BB="$bb" && break
  done

  local tmp="${TMPDIR:-/dev/tmp}/cp2077_$$"
  mkdir -p "$tmp"

  # Extract desc.txt
  if [ -n "$_BB" ]; then
    "$_BB" unzip -p "$src" desc.txt > "$tmp/desc.txt" 2>/dev/null
  else
    unzip -p "$src" desc.txt > "$tmp/desc.txt" 2>/dev/null
  fi

  if [ ! -s "$tmp/desc.txt" ]; then
    cp -f "$src" "$dst" 2>/dev/null
    rm -rf "$tmp"
    return 1
  fi

  # Rewrite first line: "W H FPS" → "tw th FPS"
  local fps
  fps=$(head -1 "$tmp/desc.txt" | awk '{print $3}')
  [ -z "$fps" ] && fps=60
  {
    echo "${tw} ${th} ${fps}"
    tail -n +2 "$tmp/desc.txt"
  } > "$tmp/desc_new.txt"

  # Copy source zip to destination then update desc.txt inside it
  cp -f "$src" "$dst" 2>/dev/null
  if [ -n "$_BB" ]; then
    (cd "$tmp" && cp desc_new.txt desc.txt && "$_BB" zip -j "$dst" desc.txt 2>/dev/null)
  else
    (cd "$tmp" && cp desc_new.txt desc.txt && zip -j "$dst" desc.txt 2>/dev/null)
  fi

  rm -rf "$tmp"
  return 0
}

# Find the best source animation for the device resolution
pick_animation() {
  local variant="$1" type="$2"  # type = bootanimation|shutdownanimation
  local ext="zip"
  local base_src="$MODPATH/$type/$variant/${type}.zip"
  [ "$type" = "bootanimation" ] && base_src="$MODPATH/bootanimation/$variant/bootanimation.zip"

  [ -f "$base_src" ] && { echo "$base_src"; return 0; }
  return 1
}

# ================================================================
# SECTION 5: COMPONENT INSTALLERS
# ================================================================

install_bootanimation() {
  local variant="$1"
  local dst_dir="$MODPATH/system/product/media"
  mkdir -p "$dst_dir"

  local src
  src=$(pick_animation "$variant" "bootanimation") || {
    ui_print "  ✗ Boot animation '$variant' not found"
    return 1
  }

  local dst="$dst_dir/bootanimation.zip"

  if [ "$SCREEN_W" -gt 0 ] && [ "$SCREEN_H" -gt 0 ]; then
    ui_print "  Scaling to ${SCREEN_W}×${SCREEN_H}..."
    scale_bootanimation "$src" "$dst" "$SCREEN_W" "$SCREEN_H"
  else
    cp -af "$src" "$dst"
  fi
  chmod 644 "$dst"

  # dark variant (same animation)
  cp -af "$dst" "$dst_dir/bootanimation-dark.zip" 2>/dev/null
  chmod 644 "$dst_dir/bootanimation-dark.zip" 2>/dev/null

  # Samsung-specific: also install to system/media
  if [ "$ROM_FAMILY" = "samsung" ]; then
    mkdir -p "$MODPATH/system/media"
    cp -af "$dst" "$MODPATH/system/media/bootanimation.zip"
    chmod 644 "$MODPATH/system/media/bootanimation.zip"
  fi

  # OOS-specific: my_product/media/bootanimation/
  if [ "$ROM_FAMILY" = "oos" ] && [ "$HAS_MY_PRODUCT" = "1" ]; then
    mkdir -p "$MODPATH/my_product/media/bootanimation"
    cp -af "$dst" "$MODPATH/my_product/media/bootanimation/bootanimation.zip"
    chmod 644 "$MODPATH/my_product/media/bootanimation/bootanimation.zip"
  fi

  # MIUI: also system/media
  if [ "$ROM_FAMILY" = "miui" ]; then
    mkdir -p "$MODPATH/system/media"
    cp -af "$dst" "$MODPATH/system/media/bootanimation.zip"
    chmod 644 "$MODPATH/system/media/bootanimation.zip"
  fi

  ui_print "  ✓ Boot animation  : $variant → ${SCREEN_W}×${SCREEN_H} ($(du -h "$dst" 2>/dev/null | cut -f1))"
}

install_shutdownanimation() {
  local variant="$1"
  local dst_dir="$MODPATH/system/product/media"
  local src="$MODPATH/shutdownanimation/$variant/shutdownanimation.zip"

  [ ! -f "$src" ] && return 1

  local dst="$dst_dir/shutdownanimation.zip"

  if [ "$SCREEN_W" -gt 0 ] && [ "$SCREEN_H" -gt 0 ]; then
    scale_bootanimation "$src" "$dst" "$SCREEN_W" "$SCREEN_H"
  else
    cp -af "$src" "$dst"
  fi
  chmod 644 "$dst"

  # rbootanimation (reverse boot animation — used by OOS and some LineageOS builds)
  cp -af "$dst" "$dst_dir/rbootanimation.zip" 2>/dev/null
  chmod 644 "$dst_dir/rbootanimation.zip" 2>/dev/null

  if [ "$ROM_FAMILY" = "samsung" ]; then
    mkdir -p "$MODPATH/system/media"
    cp -af "$dst" "$MODPATH/system/media/shutdownanimation.zip"
    chmod 644 "$MODPATH/system/media/shutdownanimation.zip"
  fi

  if [ "$ROM_FAMILY" = "oos" ] && [ "$HAS_MY_PRODUCT" = "1" ]; then
    cp -af "$dst" "$MODPATH/my_product/media/bootanimation/rbootanimation.zip" 2>/dev/null
    chmod 644 "$MODPATH/my_product/media/bootanimation/rbootanimation.zip" 2>/dev/null
  fi

  ui_print "  ✓ Shutdown anim   : $variant"
}

install_audio() {
  local src="$MODPATH/audio/ui"
  [ ! -d "$src" ] && return 1

  # Install to both product/media and system/media for max compatibility
  for dst in \
    "$MODPATH/system/product/media/audio/ui" \
    "$MODPATH/system/media/audio/ui"; do
    mkdir -p "$dst"
    cp -af "$src/"*.ogg "$dst/" 2>/dev/null
    chmod 644 "$dst/"*.ogg 2>/dev/null
  done

  ui_print "  ✓ Audio           : CP2077 UI sounds (7 files)"
}

# ================================================================
# SECTION 6: CONFIG PERSISTENCE
# ================================================================

save_config() {
  rm -f "$CONFIG_FILE"
  {
    echo "# CP2077 Universal — install config"
    echo "boot=$BOOT_VARIANT"
    echo "shutdown=$SHUT_VARIANT"
    echo "audio=$AUDIO_CHOICE"
    echo "rom_family=$ROM_FAMILY"
    echo "rom_variant=$ROM_VARIANT"
    echo "screen=${SCREEN_W}x${SCREEN_H}"
    echo "device=$DEVICE_MODEL"
    echo "installed=$(date 2>/dev/null || echo 'unknown')"
  } > "$CONFIG_FILE"
  chmod 644 "$CONFIG_FILE"
}

# ================================================================
# SECTION 7: MAIN
# ================================================================

ui_print ""
ui_print "  ╔══════════════════════════════════════════════════╗"
ui_print "  ║   CYBERPUNK 2077 — UNIVERSAL EDITION  v1.0.0     ║"
ui_print "  ║   ALL Android Devices  •  ALL Major ROMs         ║"
ui_print "  ╚══════════════════════════════════════════════════╝"
ui_print ""

detect_device
detect_rom

ui_print "  Device  : $DEVICE_MODEL  ($DEVICE_BRAND)"
ui_print "  Android : $DEVICE_REL  (API $DEVICE_API)"
ui_print "  ABI     : $DEVICE_ABI"
ui_print "  Screen  : ${SCREEN_W}×${SCREEN_H}  ($SCREEN_DPI dpi)"
ui_print "  ROM     : $ROM_VARIANT  ($ROM_FAMILY family)"
ui_print "  Root    : $ROOT_SOLUTION"
ui_print ""

# Load config or defaults
if [ -f "$CONFIG_FILE" ]; then
  ui_print "  Loading config: $CONFIG_FILE"
  . "$CONFIG_FILE" 2>/dev/null
fi
BOOT_VARIANT="${boot:-glitch}"
SHUT_VARIANT="${shutdown:-glitch}"
AUDIO_CHOICE="${audio:-yes}"

ui_print "  Boot variant : $BOOT_VARIANT"
ui_print "  Shutdown     : $SHUT_VARIANT"
ui_print "  Audio        : $AUDIO_CHOICE"
ui_print ""

get_install_paths

# Extract assets from flashable ZIP
if [ -n "$ZIPFILE" ] && [ -f "$ZIPFILE" ]; then
  ui_print "  Extracting assets..."
  unzip -o "$ZIPFILE" "bootanimation/$BOOT_VARIANT/*" -d "$MODPATH" 2>/dev/null
  unzip -o "$ZIPFILE" "shutdownanimation/$SHUT_VARIANT/*" -d "$MODPATH" 2>/dev/null
  unzip -o "$ZIPFILE" "audio/ui/*" -d "$MODPATH" 2>/dev/null
  ui_print "  ✓ Extracted"
  ui_print ""
fi

ui_print "  ─── Installing components ───"
install_bootanimation "$BOOT_VARIANT"

case "$SHUT_VARIANT" in
  none) ui_print "  - Shutdown animation : skipped" ;;
  *)    install_shutdownanimation "$SHUT_VARIANT" ;;
esac

[ "$AUDIO_CHOICE" = "yes" ] && install_audio || ui_print "  - Audio : skipped"

# Populate /data fallback paths (work on ALL ROMs regardless of partition layout)
ui_print ""
ui_print "  ─── Writing /data fallback paths ───"
BA_INSTALLED="$MODPATH/system/product/media/bootanimation.zip"
SA_INSTALLED="$MODPATH/system/product/media/shutdownanimation.zip"
if [ -f "$BA_INSTALLED" ]; then
  mkdir -p /data/local /data/misc/bootanim
  cp -af "$BA_INSTALLED" /data/local/bootanimation.zip 2>/dev/null
  cp -af "$BA_INSTALLED" /data/misc/bootanim/bootanimation.zip 2>/dev/null
  chmod 644 /data/local/bootanimation.zip /data/misc/bootanim/bootanimation.zip 2>/dev/null
  chown system:graphics /data/local/bootanimation.zip /data/misc/bootanim/bootanimation.zip 2>/dev/null
  ui_print "  ✓ /data/local + /data/misc/bootanim"
fi
if [ -f "$SA_INSTALLED" ]; then
  cp -af "$SA_INSTALLED" /data/local/shutdownanimation.zip 2>/dev/null
  cp -af "$SA_INSTALLED" /data/misc/bootanim/shutdownanimation.zip 2>/dev/null
  chmod 644 /data/local/shutdownanimation.zip /data/misc/bootanim/shutdownanimation.zip 2>/dev/null
fi

# Permissions
set_perm_recursive "$MODPATH" 0 0 0755 0644
for sh in post-fs-data.sh service.sh uninstall.sh cp2077-config.sh; do
  [ -f "$MODPATH/$sh" ] && set_perm "$MODPATH/$sh" 0 0 0755
done

# Cleanup source assets
rm -rf "$MODPATH/bootanimation" "$MODPATH/shutdownanimation" "$MODPATH/audio" 2>/dev/null

save_config
echo "$BOOT_VARIANT" > "$MODPATH/variant.txt"
echo "$ROM_VARIANT"   > "$MODPATH/rom.txt"
echo "${SCREEN_W}x${SCREEN_H}" > "$MODPATH/resolution.txt"

ui_print ""
ui_print "  ╔══════════════════════════════════════════════════╗"
ui_print "  ║  INSTALLATION COMPLETE                           ║"
ui_print "  ╠══════════════════════════════════════════════════╣"
ui_print "  ║  Device  : $DEVICE_MODEL"
ui_print "  ║  ROM     : $ROM_VARIANT"
ui_print "  ║  Screen  : ${SCREEN_W}×${SCREEN_H}"
ui_print "  ║  Variant : $BOOT_VARIANT"
ui_print "  ║                                                  ║"
ui_print "  ║  Edit $CONFIG_FILE to reconfigure"
ui_print "  ║  Reboot to apply!                                ║"
ui_print "  ╚══════════════════════════════════════════════════╝"
ui_print ""
