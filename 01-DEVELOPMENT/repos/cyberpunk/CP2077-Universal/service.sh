#!/system/bin/sh
# service.sh — CP2077 Universal v1.0.0
# Late-start: verify all mounts, repair under-size files, fix permissions
# Android 16 fix: prop-poll replaces blocking sleep (sleep stalls on A15/16)

MODDIR=${0%/*}
BA="$MODDIR/system/product/media/bootanimation.zip"
SA="$MODDIR/system/product/media/shutdownanimation.zip"

[ ! -f "$BA" ] && exit 0

# Wait for sys.boot_completed instead of a fixed sleep.
# Works correctly on Android 14, 15, and 16.
_wait_boot() {
  local i=0
  while [ "$i" -lt 60 ]; do
    [ "$(getprop sys.boot_completed 2>/dev/null)" = "1" ] && return 0
    sleep 1
    i=$((i + 1))
  done
}
_wait_boot

# Our animations are >5 MB; stock stubs are tiny
_fix() {
  local src="$1" tgt="$2"
  [ ! -f "$tgt" ] && return
  [ ! -f "$src" ] && return
  local sz
  sz=$(wc -c < "$tgt" 2>/dev/null || echo 0)
  if [ "$sz" -lt 5000000 ]; then
    umount "$tgt" 2>/dev/null
    mount --bind "$src" "$tgt" 2>/dev/null
  fi
}

for t in \
  /product/media/bootanimation.zip \
  /product/media/bootanimation-dark.zip \
  /system/product/media/bootanimation.zip \
  /system/product/media/bootanimation-dark.zip \
  /system/media/bootanimation.zip \
  /my_product/media/bootanimation/bootanimation.zip; do
  _fix "$BA" "$t"
done

# LineageOS 23.2 / Android 16 — copy-based fallback (not a bind-mount path)
if [ -f /data/misc/bootanim/bootanimation.zip ]; then
  _sz=$(wc -c < /data/misc/bootanim/bootanimation.zip 2>/dev/null || echo 0)
  if [ "$_sz" -lt 5000000 ]; then
    cp -af "$BA" /data/misc/bootanim/bootanimation.zip 2>/dev/null
    chmod 644 /data/misc/bootanim/bootanimation.zip 2>/dev/null
    chown system:graphics /data/misc/bootanim/bootanimation.zip 2>/dev/null
  fi
fi

if [ -f "$SA" ]; then
  for t in \
    /product/media/shutdownanimation.zip \
    /product/media/rbootanimation.zip \
    /system/product/media/shutdownanimation.zip \
    /system/product/media/rbootanimation.zip \
    /system/media/shutdownanimation.zip \
    /my_product/media/bootanimation/rbootanimation.zip; do
    _fix "$SA" "$t"
  done
fi

# Blanket permission fix on all live animation paths
chmod 644 \
  /product/media/bootanimation.zip \
  /product/media/bootanimation-dark.zip \
  /product/media/shutdownanimation.zip \
  /product/media/rbootanimation.zip \
  /system/product/media/bootanimation.zip \
  /system/product/media/bootanimation-dark.zip \
  /system/product/media/shutdownanimation.zip \
  /system/product/media/rbootanimation.zip \
  /system/media/bootanimation.zip \
  /system/media/shutdownanimation.zip 2>/dev/null
