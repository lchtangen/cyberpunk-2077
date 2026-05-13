#!/system/bin/sh
# uninstall.sh — CP2077 Ultimate v3.0.0

for f in \
  /product/media/bootanimation.zip \
  /product/media/bootanimation-dark.zip \
  /product/media/shutdownanimation.zip \
  /product/media/rbootanimation.zip \
  /system/product/media/bootanimation.zip \
  /system/product/media/bootanimation-dark.zip \
  /system/product/media/shutdownanimation.zip \
  /system/product/media/rbootanimation.zip \
  /system/media/bootanimation.zip; do
  umount "$f" 2>/dev/null
done

for f in \
  /product/media/audio/ui/*.ogg \
  /system/product/media/audio/ui/*.ogg \
  /system/media/audio/ui/*.ogg; do
  mount 2>/dev/null | grep -qF "$f" && umount "$f" 2>/dev/null
done

rm -f /data/local/bootanimation.zip /data/local/shutdownanimation.zip
rm -f /data/misc/bootanim/bootanimation.zip /data/misc/bootanim/shutdownanimation.zip
rm -f /data/cp2077_ultimate.conf
