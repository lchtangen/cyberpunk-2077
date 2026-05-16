#!/system/bin/sh
# service.sh — CP2077 Ultimate All-In-One v3.0.0
# Late-start service: verify mounts, repair if needed, fix permissions

MODDIR=${0%/*}
BA_FILE="$MODDIR/system/product/media/bootanimation.zip"
SA_FILE="$MODDIR/system/product/media/shutdownanimation.zip"

sleep 5

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

_remount_if_small /product/media/bootanimation.zip           "$BA_FILE"
_remount_if_small /product/media/bootanimation-dark.zip      "$BA_FILE"
_remount_if_small /system/product/media/bootanimation.zip    "$BA_FILE"
_remount_if_small /system/product/media/bootanimation-dark.zip "$BA_FILE"

if [ -f "$SA_FILE" ]; then
  _remount_if_small /product/media/shutdownanimation.zip          "$SA_FILE"
  _remount_if_small /product/media/rbootanimation.zip             "$SA_FILE"
  _remount_if_small /system/product/media/shutdownanimation.zip   "$SA_FILE"
  _remount_if_small /system/product/media/rbootanimation.zip      "$SA_FILE"
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
  /system/product/media/rbootanimation.zip 2>/dev/null
