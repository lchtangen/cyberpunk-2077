<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░▒▓  DEVICE SPECIFICATIONS & COMPATIBILITY  ▓▒░                       ║
║  ────────────────────────────────────────────────────────────────────── ║
║  OnePlus 7 Pro (guacamole)  ·  SM8150  ·  Android 14–16+               ║
╚══════════════════════════════════════════════════════════════════════════╝
```

[![Device](https://img.shields.io/badge/Device-OnePlus_7_Pro-ff003c?style=for-the-badge&labelColor=0a0a0a)](.)
[![SoC](https://img.shields.io/badge/SoC-Snapdragon_855_SM8150-fcee0c?style=for-the-badge&labelColor=0a0a0a)](.)
[![Android](https://img.shields.io/badge/Tested-Android_14|15|16-00ff9f?style=for-the-badge&labelColor=0a0a0a)](.)

</div>

---

## 📱 Primary Target — OnePlus 7 Pro

<div align="center">

| 🔷 Field | ⚡ Value |
|:---------|:--------|
| 📱 **Model** | OnePlus 7 Pro |
| 🔑 **Codename** | `guacamole` |
| 🔢 **Model Numbers** | `GM1910` · `GM1911` · `GM1913` · `GM1917` |
| ⚙️ **SoC** | Qualcomm Snapdragon 855 (SM8150) |
| 🖥 **Display** | 6.67" Fluid AMOLED · **1440 × 3120** · 90 Hz |
| 🧠 **RAM** | 6 / 8 / 12 GB LPDDR4X |
| 💾 **Storage** | 128 / 256 GB UFS 3.0 |
| 🤖 **Android (tested)** | 14 (API 34) · 15 (API 35) · **16 (API 36) — ACTIVE** |
| 🔑 **Magisk (tested)** | v30.7 |
| 🖥 **Active ROM** | Stock OOS 14+ / LineageOS / yaap / AOSP |
| 🔌 **ADB** | `adb devices` → confirm `guacamole` |

</div>

---

## ⚙️ Kernel & Boot Images

<div align="center">

| 📦 Artifact | 📍 Location |
|:-----------|:-----------|
| Stock `boot.img` | `07-KERNEL-PACKAGE-MODULES/kernel/boot.img` |
| Magisk-patched `boot.img` | `07-KERNEL-PACKAGE-MODULES/kernel/magisk_patched-30700_rLeMH.img` |
| Kali NetHunter kernel builder | `07-KERNEL-PACKAGE-MODULES/kernel/kali-nethunter-kernel-builder/` |
| LineageOS SM8150 kernel | `07-KERNEL-PACKAGE-MODULES/kernel/oneplus-7-pro-lineage-kernel-sm8150/` |
| blu-spark kernel | `07-KERNEL-PACKAGE-MODULES/kernel/blu-spark-kernel-op7/` |
| Neptune kernel | `07-KERNEL-PACKAGE-MODULES/kernel/neptune-kernel-sm8150/` |
| KernelSU LineageOS build | `07-KERNEL-PACKAGE-MODULES/kernel/kernelsu-lineageos-guacamole/` |

</div>

**Flash patched boot image:**
```bash
fastboot flash boot magisk_patched-30700_rLeMH.img
fastboot reboot
```

---

## 🗺 ROM Compatibility Matrix

<div align="center">

| 🤖 ROM | 🎬 Boot Anim Path | 🔊 Audio Path | 🔧 OOS Hook |
|:-------|:-----------------|:-------------|:-----------|
| AOSP / LineageOS | `/product/media/` | `/product/media/audio/ui/` | No |
| yaap / crDroid / DerpFest | `/product/media/` | `/product/media/audio/ui/` | No |
| **OOS 14+** | `/my_product/media/` | `/my_product/media/audio/ui/` | **Auto** |
| OOS 13 (legacy) | `/my_product/media/bootanimation/` | — | Manual |
| GrapheneOS / CalyxOS | `/product/media/` | `/product/media/audio/ui/` | No |
| Evolution X | `/product/media/` | `/product/media/audio/ui/` | No |
| Samsung One UI | `/system/media/` | `/system/media/audio/ui/` | Experimental |
| MIUI / HyperOS | `/system/media/` | `/system/media/audio/ui/` | Experimental |

</div>

> The installer auto-detects ROM type via `ro.build.version.ota_partition` and `ro.build.version.release_type`.

---

## 🤖 Android API Reference

<div align="center">

| 🤖 Android | 📊 API | 🏷 Status |
|:----------|:------|:---------|
| Android 8.0 | API 26 | Minimum declared in `module.prop` |
| Android 12 | API 31 | Legacy v1.0 baseline |
| Android 14 | API 34 | ✅ Supported |
| Android 15 | API 35 | ✅ Supported |
| **Android 16** | **API 36** | ✅ **Tested & Active** |

</div>

`minMagisk=20400` · `androidApi=26` (declared in `module.prop`)

---

## ⚙️ Kernel Arsenal — SM8150

<div align="center">

| ⚙️ Kernel | 📦 Path | 🔗 Upstream | 📝 Notes |
|:---------|:-------|:-----------|:--------|
| **blu-spark** | `kernel/blu-spark-kernel-op7/` | `engstk/op7` | CAF-based · perf/battery · OP7/7T/7Pro |
| **Neptune** | `kernel/neptune-kernel-sm8150/` | `0wnerDied/Neptune_kernel` | CLO `LA.UM.9.1.r1-15500` |
| **KernelSU (pre-built)** | `kernel/kernelsu-lineageos-guacamole/` | `surfaceocean/kernelsu_oneplus_7_pro_lineageos_guacamole` | v20251215 (32 releases) · LOS 21 (Android 14) · full flash required |
| **LineageOS** | `kernel/oneplus-7-pro-lineage-kernel-sm8150/` | LineageOS upstream | Official LOS SM8150 |
| **NetHunter** | `kernel/kali-nethunter-kernel-builder/` | NetHunter upstream | NetHunter-patched builder |

</div>

> ⚠️ **KernelSU + LineageOS Note:** Requires **full LineageOS 21 flash** — not just a kernel swap. The SurfaceOcean pre-built (`v20251215`) requires: factory reset + flash `boot.img` + `dtbo.img` + `vbmeta.img` + lineage ZIP. Swapping only the kernel (`boot.img`) breaks Wi-Fi and audio on guacamole.

---

## 🔌 ADB Quick Reference

```bash
# ── Device Connection ────────────────────────────────────────────────
adb devices                                   # list connected devices
adb kill-server && adb start-server           # reset ADB server

# ── Device Info ──────────────────────────────────────────────────────
adb shell getprop ro.product.model            # "OnePlus 7 Pro"
adb shell getprop ro.product.device           # "guacamole"
adb shell getprop ro.build.version.release    # "16"
adb shell getprop ro.build.version.sdk        # "36"
adb shell getprop ro.build.version.release_type  # for ROM detection

# ── File Transfer ────────────────────────────────────────────────────
adb push CP2077-OP7Pro-v3.0.0.zip /sdcard/Download/
adb pull /product/media/bootanimation.zip /tmp/active-bootanimation.zip

# ── Root Shell ───────────────────────────────────────────────────────
adb shell su
adb shell su -c "ls -lh /product/media/"

# ── Animation Verification ───────────────────────────────────────────
adb shell su -c "ls -lh /product/media/*.zip"
adb shell su -c "ls -lh /my_product/media/*.zip"        # OOS
adb shell su -c "ls -lh /data/misc/bootanim/*.zip"      # LineageOS
adb shell su -c "ls -lh /data/local/bootanimation.zip"  # fallback

# ── Module Status ────────────────────────────────────────────────────
adb shell su -c "magisk --list"
adb shell su -c "cat /data/cp2077.conf"

# ── Restart Animation Service ────────────────────────────────────────
adb shell su -c "setprop ctl.restart bootanim"
```

---

## ⚡ Fastboot Reference

```bash
# ── Flash boot image ─────────────────────────────────────────────────
fastboot flash boot magisk_patched-30700_rLeMH.img
fastboot reboot

# ── Flash stock boot (recovery / undo root) ──────────────────────────
fastboot flash boot boot.img
fastboot reboot

# ── Enter fastboot mode ──────────────────────────────────────────────
adb reboot bootloader
# Or: hold Volume Down + Power during boot

# ── Check fastboot devices ───────────────────────────────────────────
fastboot devices
```

---

## 🔗 Related Hardware Repos

<div align="center">

| 📦 Repo | 📍 Location | 🎯 Purpose |
|:--------|:-----------|:----------|
| OP7 Pro LineageOS kernel | `07-KERNEL-PACKAGE-MODULES/kernel/oneplus-7-pro-lineage-kernel-sm8150/` | Kernel source |
| Kali NetHunter kernel | `07-KERNEL-PACKAGE-MODULES/kernel/kali-nethunter-kernel-builder/` | NetHunter kernel |
| Android tools | `04-ANDROID/android-tools/` | ADB / fastboot binaries |

</div>

---

## 🔗 Related Docs

| 📄 | 🔗 |
|:---|:---|
| ⚡ Installation guide | [INSTALLATION-GUIDE.md](INSTALLATION-GUIDE.md) |
| 🎬 Animation variants | [VARIANTS.md](VARIANTS.md) |
| 🐛 Troubleshooting | [TROUBLESHOOTING.md](TROUBLESHOOTING.md) |
| 🔧 Build guide | [BUILD-GUIDE.md](BUILD-GUIDE.md) |
