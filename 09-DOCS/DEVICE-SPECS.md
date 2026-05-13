# Device Specifications & Compatibility

---

## Primary Target — OnePlus 7 Pro

| Field | Value |
|---|---|
| Model | OnePlus 7 Pro |
| Codename | `guacamole` |
| Model numbers | `GM1910` · `GM1911` · `GM1913` · `GM1917` |
| SoC | Qualcomm Snapdragon 855 (SM8150) |
| Display | 6.67" Fluid AMOLED · **1440×3120** · 90 Hz |
| RAM | 6 / 8 / 12 GB LPDDR4X |
| Storage | 128 / 256 GB UFS 3.0 |
| Android (tested) | 14 (API 34) · 15 (API 35) · **16 (API 36)** |
| Magisk (tested) | 30.7 |
| Active ROM | Stock / OOS 14+ / LineageOS / yaap / AOSP |
| ADB serial | `adb devices` → confirm `guacamole` |

---

## Kernel & Boot Images

| Artifact | Location |
|---|---|
| Stock `boot.img` | `07-KERNEL-PACKAGE-MODULES/kernel/boot.img` |
| Magisk-patched `boot.img` | `07-KERNEL-PACKAGE-MODULES/kernel/magisk_patched-30700_rLeMH.img` |
| Kali NetHunter kernel builder | `07-KERNEL-PACKAGE-MODULES/kernel/kali-nethunter-kernel-builder/` |
| LineageOS SM8150 kernel | `07-KERNEL-PACKAGE-MODULES/kernel/oneplus-7-pro-lineage-kernel-sm8150/` |

Flash patched boot:
```bash
fastboot flash boot magisk_patched-30700_rLeMH.img
fastboot reboot
```

---

## ROM Compatibility Matrix

| ROM | Boot Anim Path | Audio Path | OOS Hook |
|---|---|---|---|
| AOSP / LineageOS | `/product/media/` | `/product/media/audio/ui/` | No |
| yaap | `/product/media/` | `/product/media/audio/ui/` | No |
| OOS 14+ | `/my_product/media/` | `/my_product/media/audio/ui/` | Auto |
| OOS 13 (legacy) | `/my_product/media/bootanimation/` | — | Manual |

The installer auto-detects the ROM type via `ro.build.version.ota_partition`.

---

## Android API Reference

| Android | API | Status |
|---|---|---|
| Android 14 | API 34 | Supported |
| Android 15 | API 35 | Supported |
| Android 16 | API 36 | **Tested & Active** |

`minMagisk=20400` · `androidApi=26` (minimum declared in `module.prop`)

---

## ADB Quick Reference

```bash
# Check device connection
adb devices

# Device info
adb shell getprop ro.product.model
adb shell getprop ro.product.device
adb shell getprop ro.build.version.release
adb shell getprop ro.build.version.sdk

# Push module to device
adb push CP2077-OP7Pro-v3.0.0.zip /sdcard/Download/

# Open root shell
adb shell su

# Verify active animations
adb shell su -c "ls -lh /product/media/*.zip"
```

---

## Fastboot Reference

```bash
# Flash patched boot image
fastboot flash boot magisk_patched-30700_rLeMH.img
fastboot reboot

# Flash stock boot (recovery)
fastboot flash boot boot.img
fastboot reboot
```

---

## Related Hardware Repos

| Repo | Location | Purpose |
|---|---|---|
| OP7 Pro LineageOS kernel | `01-DEVELOPMENT/repos/oneplus-7-pro/` | Kernel source |
| Kali NetHunter kernel | `07-KERNEL-PACKAGE-MODULES/kernel/kali-nethunter-kernel-builder/` | NetHunter kernel |
| Android tools | `04-ANDROID/android-tools/` | ADB / fastboot binaries |
