#!/system/bin/sh
# service.sh — CP2077 Ultimate All-In-One v3.0.0
# Late-start service: verify mounts, repair if needed, fix permissions
# Android 16 fix: prop-poll replaces blocking sleep (sleep 5 stalls on A15/16)

MODDIR=${0%/*}
BA_FILE="$MODDIR/system/product/media/bootanimation.zip"
SA_FILE="$MODDIR/system/product/media/shutdownanimation.zip"

# Wait for sys.boot_completed instead of a fixed sleep.
# This works correctly on Android 14, 15, and 16.
_wait_boot() {
  local i=0
  while [ "$i" -lt 60 ]; do
    [ "$(getprop sys.boot_completed 2>/dev/null)" = "1" ] && return 0
    sleep 1
    i=$((i + 1))
  done
}
_wait_boot

# Threshold: our animations are >5 MB; stock stubs are <100 KB
_remount_if_small() {
  local target="$1" src="$2"
  [ ! -f "$target" ] && return
  [ ! -f "$src" ] && return
  local sz
  sz=$(wc -c < "$target" 2>/dev/null || echo 0)
  if [ "$sz" -lt 5000000 ]; then
    umount "$target" 2>/dev/null
    mount --bind "$src" "$target" 2>/dev/null
  fi
}

_remount_if_small /product/media/bootanimation.zip                     "$BA_FILE"
_remount_if_small /product/media/bootanimation-dark.zip                "$BA_FILE"
_remount_if_small /system/product/media/bootanimation.zip              "$BA_FILE"
_remount_if_small /system/product/media/bootanimation-dark.zip         "$BA_FILE"
_remount_if_small /system/media/bootanimation.zip                      "$BA_FILE"
_remount_if_small /my_product/media/bootanimation/bootanimation.zip    "$BA_FILE"
# LineageOS 23.2 / Android 16 — cp-based fallback path (no bind-mount needed here;
# the copy lands in /data/misc/bootanim/ from post-fs-data.sh, so we only need to
# verify the file size is sane and re-copy if it was overwritten by stock.
if [ -f /data/misc/bootanim/bootanimation.zip ]; then
  _sz=$(wc -c < /data/misc/bootanim/bootanimation.zip 2>/dev/null || echo 0)
  if [ "$_sz" -lt 5000000 ]; then
    cp -af "$BA_FILE" /data/misc/bootanim/bootanimation.zip 2>/dev/null
    chmod 644 /data/misc/bootanim/bootanimation.zip 2>/dev/null
    chown system:graphics /data/misc/bootanim/bootanimation.zip 2>/dev/null
  fi
fi

if [ -f "$SA_FILE" ]; then
  _remount_if_small /product/media/shutdownanimation.zip          "$SA_FILE"
  _remount_if_small /product/media/rbootanimation.zip             "$SA_FILE"
  _remount_if_small /system/product/media/shutdownanimation.zip   "$SA_FILE"
  _remount_if_small /system/product/media/rbootanimation.zip      "$SA_FILE"
  _remount_if_small /system/media/shutdownanimation.zip           "$SA_FILE"
fi

# Fix permissions on live paths
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
