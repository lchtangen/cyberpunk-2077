#!/system/bin/sh
# service.sh — CP2077 Universal v1.0.0
# Late-start: verify all mounts, repair under-size files, fix permissions

MODDIR=${0%/*}
BA="$MODDIR/system/product/media/bootanimation.zip"
SA="$MODDIR/system/product/media/shutdownanimation.zip"

[ ! -f "$BA" ] && exit 0

sleep 5

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
