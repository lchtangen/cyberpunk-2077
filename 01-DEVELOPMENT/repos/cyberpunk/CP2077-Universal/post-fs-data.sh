#!/system/bin/sh
# post-fs-data.sh — CP2077 Universal v1.0.0
# Runs early in boot; covers ALL known bootanimation paths for ALL ROM families

MODDIR=${0%/*}
BA="$MODDIR/system/product/media/bootanimation.zip"
SA="$MODDIR/system/product/media/shutdownanimation.zip"

[ ! -f "$BA" ] && exit 0

# Detect ROM family from saved config
ROM_FAMILY="aosp"
[ -f "$MODDIR/rom.txt" ] && {
  _r=$(cat "$MODDIR/rom.txt" 2>/dev/null)
  case "$_r" in samsung|oos|miui) ROM_FAMILY="$_r" ;; esac
}

# ── Helper: bind-mount to target if target file exists ──────────
_mount() {
  local src="$1" tgt="$2"
  [ -f "$tgt" ] || return
  umount "$tgt" 2>/dev/null
  mount --bind "$src" "$tgt" 2>/dev/null
}

# ── AOSP / LineageOS / Pixel / CalyxOS / GrapheneOS ─────────────
_mount "$BA" /product/media/bootanimation.zip
_mount "$BA" /product/media/bootanimation-dark.zip
_mount "$BA" /system/product/media/bootanimation.zip
_mount "$BA" /system/product/media/bootanimation-dark.zip
_mount "$BA" /system/media/bootanimation.zip

# ── Samsung One UI ───────────────────────────────────────────────
[ "$ROM_FAMILY" = "samsung" ] && {
  _mount "$BA" /system/media/bootanimation.zip
}

# ── OOS / ColorOS (my_product) ──────────────────────────────────
[ "$ROM_FAMILY" = "oos" ] && {
  _mount "$BA" /my_product/media/bootanimation/bootanimation.zip
}

# ── MIUI / HyperOS ──────────────────────────────────────────────
[ "$ROM_FAMILY" = "miui" ] && {
  _mount "$BA" /system/media/bootanimation.zip
  _mount "$BA" /product/media/bootanimation.zip
}

# ── Shutdown / rboot animation ──────────────────────────────────
if [ -f "$SA" ]; then
  _mount "$SA" /product/media/shutdownanimation.zip
  _mount "$SA" /product/media/rbootanimation.zip
  _mount "$SA" /system/product/media/shutdownanimation.zip
  _mount "$SA" /system/product/media/rbootanimation.zip
  _mount "$SA" /system/media/shutdownanimation.zip
  [ "$ROM_FAMILY" = "samsung" ] && _mount "$SA" /system/media/shutdownanimation.zip
  [ "$ROM_FAMILY" = "oos" ] && _mount "$SA" /my_product/media/bootanimation/rbootanimation.zip
fi

# ── Audio ────────────────────────────────────────────────────────
AD="$MODDIR/system/product/media/audio/ui"
if [ -d "$AD" ]; then
  for f in "$AD"/*.ogg; do
    [ -f "$f" ] || continue
    fn=$(basename "$f")
    for t in \
      "/product/media/audio/ui/$fn" \
      "/system/product/media/audio/ui/$fn" \
      "/system/media/audio/ui/$fn"; do
      [ -f "$t" ] && mount --bind "$f" "$t" 2>/dev/null
    done
  done
fi

# ── Signal bootanim restart ──────────────────────────────────────
setprop ctl.restart bootanim 2>/dev/null
