#!/system/bin/sh
# customize.sh — Cyberpunk 2077 Ultimate All-In-One v3.0.0
# OnePlus 7 Pro (guacamole) • Android 14–16+
# Config-file driven; all components individually selectable

[ -z "$MODPATH" ] && MODPATH="${0%/*}"
CONFIG_FILE="/data/cp2077_ultimate.conf"

# ==================== COMPONENT INSTALLERS ====================

install_bootanimation() {
  local variant="$1" dstdir="$MODPATH/system/product/media"
  local src="$MODPATH/bootanimation/$variant/bootanimation.zip"
  [ ! -f "$src" ] && { ui_print "  ✗ Boot anim '$variant' not found"; return 1; }
  mkdir -p "$dstdir"
  cp -af "$src" "$dstdir/bootanimation.zip"
  cp -af "$src" "$dstdir/bootanimation-dark.zip"
  chmod 644 "$dstdir/bootanimation.zip" "$dstdir/bootanimation-dark.zip"
  ui_print "  ✓ Boot animation  : $variant ($(du -h "$src" 2>/dev/null | cut -f1))"
}

install_shutdownanimation() {
  local variant="$1" dstdir="$MODPATH/system/product/media"
  local src="$MODPATH/shutdownanimation/$variant/shutdownanimation.zip"
  [ ! -f "$src" ] && return 1
  cp -af "$src" "$dstdir/shutdownanimation.zip"
  cp -af "$src" "$dstdir/rbootanimation.zip"
  chmod 644 "$dstdir/shutdownanimation.zip" "$dstdir/rbootanimation.zip"
  ui_print "  ✓ Shutdown anim   : $variant"
}

install_audio() {
  local src="$MODPATH/audio/ui"
  local dst1="$MODPATH/system/product/media/audio/ui"
  local dst2="$MODPATH/system/media/audio/ui"
  [ ! -d "$src" ] && return 1
  mkdir -p "$dst1" "$dst2"
  cp -af "$src/"*.ogg "$dst1/" 2>/dev/null
  cp -af "$src/"*.ogg "$dst2/" 2>/dev/null
  ui_print "  ✓ Audio           : 7 CP2077 sound effects"
}

install_livewallpaper() {
  local variant="$1" apk
  case "$variant" in
    original) apk="$MODPATH/livewallpaper/cp2077-livewallpaper-original.apk" ;;
    vivid)    apk="$MODPATH/livewallpaper/cp2077-livewallpaper-vivid.apk" ;;
    *)        return 1 ;;
  esac
  [ ! -f "$apk" ] && { ui_print "  ! Live wallpaper APK not present (use KWLP or Backdrops)"; return 1; }
  local dst="$MODPATH/system/product/app/CyberpunkWallpaper"
  mkdir -p "$dst"
  cp -af "$apk" "$dst/CyberpunkWallpaper.apk"
  chmod 644 "$dst/CyberpunkWallpaper.apk"
  ui_print "  ✓ Live wallpaper  : $variant"
}

install_oos_paths() {
  local src_dst="$MODPATH/system/product/media"
  if getprop ro.build.version.ota_partition 2>/dev/null | grep -q "my_product"; then
    local dst_oos="$MODPATH/my_product/media"
    mkdir -p "$dst_oos"
    [ -f "$src_dst/bootanimation.zip" ] && cp -af "$src_dst/bootanimation.zip" "$dst_oos/" 2>/dev/null
    [ -f "$src_dst/shutdownanimation.zip" ] && cp -af "$src_dst/shutdownanimation.zip" "$dst_oos/" 2>/dev/null
    ui_print "  ✓ OOS/my_product paths populated"
  fi
}

update_conf() {
  local key="$1" value="$2"
  [ -f "$CONFIG_FILE" ] && sed -i "/^$key=/d" "$CONFIG_FILE"
  echo "$key=$value" >> "$CONFIG_FILE"
}

save_selection() {
  rm -f "$CONFIG_FILE"
  {
    echo "# Cyberpunk 2077 Ultimate — last install config"
    echo "boot=$BOOT_VARIANT"
    echo "shutdown=$SHUT_VARIANT"
    echo "audio=$AUDIO_CHOICE"
    echo "wallpaper=$WALLPAPER_CHOICE"
    echo "splash=$SPLASH_CHOICE"
    echo "installed=$(date)"
  } > "$CONFIG_FILE"
  chmod 644 "$CONFIG_FILE"
}

# ==================== MAIN ====================

ui_print ""
ui_print "  ╔════════════════════════════════════════════════╗"
ui_print "  ║   CYBERPUNK 2077 — ULTIMATE ALL-IN-ONE         ║"
ui_print "  ║   OnePlus 7 Pro  •  v3.0.0                     ║"
ui_print "  ║   Android 14–16+ / AOSP / LineageOS / OOS      ║"
ui_print "  ╚════════════════════════════════════════════════╝"
ui_print ""

MODEL=$(getprop ro.product.model 2>/dev/null)
API=$(getprop ro.build.version.sdk 2>/dev/null)
REL=$(getprop ro.build.version.release 2>/dev/null)
ui_print "  Device : $MODEL | Android $REL (API $API)"
ui_print ""

# Load config or use defaults
if [ -f "$CONFIG_FILE" ]; then
  ui_print "  Loading config: $CONFIG_FILE"
  . "$CONFIG_FILE" 2>/dev/null
  BOOT_VARIANT="${boot:-glitch}"
  SHUT_VARIANT="${shutdown:-glitch}"
  AUDIO_CHOICE="${audio:-yes}"
  WALLPAPER_CHOICE="${wallpaper:-no}"
  SPLASH_CHOICE="${splash:-no}"
else
  ui_print "  No config found — using defaults"
  BOOT_VARIANT="glitch"
  SHUT_VARIANT="glitch"
  AUDIO_CHOICE="yes"
  WALLPAPER_CHOICE="no"
  SPLASH_CHOICE="no"
fi

ui_print "  Boot      : $BOOT_VARIANT"
ui_print "  Shutdown  : $SHUT_VARIANT"
ui_print "  Audio     : $AUDIO_CHOICE"
ui_print "  Wallpaper : $WALLPAPER_CHOICE"
ui_print "  Splash    : $SPLASH_CHOICE"
ui_print ""

# Extract from flashable ZIP
if [ -n "$ZIPFILE" ] && [ -f "$ZIPFILE" ]; then
  ui_print "  Extracting assets..."
  for path in bootanimation shutdownanimation audio/ui livewallpaper; do
    unzip -o "$ZIPFILE" "$path/*" -d "$MODPATH" 2>/dev/null
  done
  unzip -o "$ZIPFILE" "splash/*" -d "$MODPATH" 2>/dev/null
  ui_print "  ✓ Assets extracted"
fi

ui_print ""
ui_print "  Installing components..."
install_bootanimation "$BOOT_VARIANT"

if [ "$SHUT_VARIANT" != "none" ]; then
  install_shutdownanimation "$SHUT_VARIANT"
else
  ui_print "  - Shutdown animation : skipped"
fi

[ "$AUDIO_CHOICE" = "yes" ] && install_audio || ui_print "  - Audio : skipped"

if [ "$WALLPAPER_CHOICE" != "no" ]; then
  install_livewallpaper "$WALLPAPER_CHOICE"
else
  ui_print "  - Live wallpaper : skipped"
fi

install_oos_paths

# Permissions
set_perm_recursive "$MODPATH" 0 0 0755 0644
for sh in post-fs-data.sh service.sh uninstall.sh cp2077-config.sh; do
  [ -f "$MODPATH/$sh" ] && set_perm "$MODPATH/$sh" 0 0 0755
done

# Remove source asset trees
rm -rf "$MODPATH/bootanimation" "$MODPATH/shutdownanimation" \
       "$MODPATH/audio" "$MODPATH/livewallpaper" \
       "$MODPATH/splash" 2>/dev/null

save_selection

ui_print ""
ui_print "  ╔════════════════════════════════════════════════╗"
ui_print "  ║  INSTALLATION COMPLETE                         ║"
ui_print "  ╠════════════════════════════════════════════════╣"
ui_print "  ║  Boot      : $BOOT_VARIANT"
ui_print "  ║  Shutdown  : $SHUT_VARIANT"
ui_print "  ║  Audio     : $AUDIO_CHOICE"
ui_print "  ║  Wallpaper : $WALLPAPER_CHOICE"
ui_print "  ║                                                ║"
ui_print "  ║  Edit $CONFIG_FILE to change selections"
ui_print "  ║  Run cp2077-config.sh to reconfigure           ║"
ui_print "  ║  Reboot to apply!                              ║"
ui_print "  ╚════════════════════════════════════════════════╝"
ui_print ""
