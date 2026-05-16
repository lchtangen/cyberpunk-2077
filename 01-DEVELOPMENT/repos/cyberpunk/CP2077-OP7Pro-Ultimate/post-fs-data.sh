#!/system/bin/sh
# post-fs-data.sh — CP2077 Ultimate All-In-One v3.0.0
# Multi-path mount engine: covers AOSP, LineageOS, OOS, yaap

MODDIR=${0%/*}
BA_FILE="$MODDIR/system/product/media/bootanimation.zip"
SA_FILE="$MODDIR/system/product/media/shutdownanimation.zip"
AD="$MODDIR/system/product/media/audio/ui"

[ ! -f "$BA_FILE" ] && exit 0

# 1. /data/local (universal fallback path, highest priority on most ROMs)
mkdir -p /data/local
cp -af "$BA_FILE" /data/local/bootanimation.zip 2>/dev/null
chmod 644 /data/local/bootanimation.zip 2>/dev/null
chown system:graphics /data/local/bootanimation.zip 2>/dev/null

# 2. /data/misc/bootanim (LineageOS bootanimation customization)
mkdir -p /data/misc/bootanim
cp -af "$BA_FILE" /data/misc/bootanim/bootanimation.zip 2>/dev/null
chmod 644 /data/misc/bootanim/bootanimation.zip 2>/dev/null
chown system:graphics /data/misc/bootanim/bootanimation.zip 2>/dev/null

# 3. Bind-mount to all known system paths
for target in \
  /product/media/bootanimation.zip \
  /product/media/bootanimation-dark.zip \
  /system/product/media/bootanimation.zip \
  /system/product/media/bootanimation-dark.zip \
  /system/media/bootanimation.zip \
  /my_product/media/bootanimation/bootanimation.zip; do
  if [ -f "$target" ]; then
    umount "$target" 2>/dev/null
    mount --bind "$BA_FILE" "$target" 2>/dev/null
  fi
done

# 4. Shutdown / reverse-boot animation
if [ -f "$SA_FILE" ]; then
  cp -af "$SA_FILE" /data/local/shutdownanimation.zip 2>/dev/null
  cp -af "$SA_FILE" /data/misc/bootanim/shutdownanimation.zip 2>/dev/null
  for target in \
    /product/media/shutdownanimation.zip \
    /product/media/rbootanimation.zip \
    /system/product/media/shutdownanimation.zip \
    /system/product/media/rbootanimation.zip \
    /my_product/media/bootanimation/rbootanimation.zip; do
    [ -f "$target" ] && mount --bind "$SA_FILE" "$target" 2>/dev/null
  done
fi

# 5. Audio overlay
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

# 6. Signal bootanim restart after mounts settle
setprop ctl.restart bootanim 2>/dev/null
