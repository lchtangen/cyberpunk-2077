#!/system/bin/sh
# uninstall.sh — CP2077 Universal v1.0.0

for f in \
  /product/media/bootanimation.zip \
  /product/media/bootanimation-dark.zip \
  /product/media/shutdownanimation.zip \
  /product/media/rbootanimation.zip \
  /system/product/media/bootanimation.zip \
  /system/product/media/bootanimation-dark.zip \
  /system/product/media/shutdownanimation.zip \
  /system/product/media/rbootanimation.zip \
  /system/media/bootanimation.zip \
  /system/media/shutdownanimation.zip \
  /my_product/media/bootanimation/bootanimation.zip \
  /my_product/media/bootanimation/rbootanimation.zip; do
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
rm -f /data/cp2077_universal.conf
