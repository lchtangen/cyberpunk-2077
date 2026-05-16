<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════════╗
║  ░▒▓  CYBERPUNK 2077 — UNIVERSAL EDITION  ▓▒░                              ║
║  ────────────────────────────────────────────────────────────────────────── ║
║  ALL Android Devices · ALL ROM Families · AUTO Resolution · AUTO Root      ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

[![Version](https://img.shields.io/badge/VERSION-v1.0.0-FCEE0C?style=for-the-badge&labelColor=0a0a0a)](../../releases/CHANGELOG-universal.md)
[![Android](https://img.shields.io/badge/ANDROID-5.1%2B_(API_22)-00FF9F?style=for-the-badge&logo=android&logoColor=black&labelColor=0a0a0a)](./)
[![Root](https://img.shields.io/badge/ROOT-Magisk_%7C_KernelSU_%7C_APatch-00FFFF?style=for-the-badge&labelColor=0a0a0a)](./)
[![Devices](https://img.shields.io/badge/DEVICES-ALL_Android-FF003C?style=for-the-badge&labelColor=0a0a0a)](./)

**Works on every Android device, every ROM, every resolution.**

Auto-detects your device's screen resolution and ROM family, then installs the appropriate Cyberpunk 2077 boot/shutdown animation and audio theme.

</div>

---

## 🤖 Supported ROMs

```
╔══════════════════════════════════════════════════════════════════════════════╗
║  ░░░ ROM FAMILY AUTO-DETECTION — 15 FAMILIES SUPPORTED  ░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

<div align="center">

| 🤖 ROM Family | 📋 Variants Covered | 📍 Install Path |
|:-------------|:------------------|:--------------|
| AOSP | Stock Android · Android One · AOSP GSI | `/product/media/` |
| LineageOS | LineageOS 19–22 · crDroid · DerpFest | `/product/media/` |
| Samsung One UI | One UI 4–7 · Galaxy series | `/system/media/` |
| OxygenOS / ColorOS | OOS 12–15 · ColorOS 13–15 | `/my_product/media/` |
| MIUI / HyperOS | MIUI 13–14 · HyperOS 1–2 | `/system/media/` |
| Pixel / GrapheneOS | Pixel 4–9 · GrapheneOS · CalyxOS | `/product/media/` |
| Evolution X | v7–9 | `/product/media/` |
| yaap | Any version | `/product/media/` |
| PixelOS | Any version | `/product/media/` |
| ArrowOS | Any version | `/product/media/` |
| RisingOS | Any version | `/product/media/` |
| crDroid | Any version | `/product/media/` |

</div>

## 📐 Supported Resolutions

Auto-scales to **any resolution** by rewriting the animation descriptor on install.

Pre-scaled packages available for:

<div align="center">

| 📐 Label | 🖥 Resolution | 📱 Target Devices |
|:--------|:------------|:----------------|
| `720p` | 720×1600 | Budget / mid-range |
| `720p_19` | 720×1520 | HD+ 19:9 |
| `1080p` | 1080×2400 | Most flagship FHD+ (20:9) |
| `1080p_19` | 1080×2340 | Samsung FHD (19.5:9) |
| `1080p_px` | 1080×2408 | Pixel 4a · Pixel 5 |
| `1080p_px2` | 1080×2412 | Pixel 6a · Pixel 7a |
| `1080p_mi` | 1080×2376 | Xiaomi / Redmi |
| `1080p_fh` | 1080×1920 | Classic FHD 16:9 |
| `QHD` | 1440×3200 | Samsung S21+ |
| `QHD_op` | 1440×3120 | OnePlus 7/8 Pro |
| `QHD_s20` | 1440×3088 | Samsung S20/S20+ |
| `QHD_s22` | 1440×3216 | Samsung S22+ |

</div>

## 🎬 Boot Animation Variants

<div align="center">

| 🎬 Variant | ⚡ FPS | 💀 Shutdown | 📝 Style |
|:----------|:------|:----------|:--------|
| ⭐ **CyberGlitch-2077** | 60 | ✅ | Glitch logo + CP2077 neon cyan/yellow |
| **Cyberpunk-Flatline-2077** | 60 | ✅ | Flatline ECG / nomad style |
| **Re-Boot Animation** | 60 | ✅ | OEM logo + glitch effect overlay |
| **Original (8T SE Port)** | 30 | ❌ | Authentic OnePlus 8T Cyberpunk Edition |

</div>

## 🚀 Installation

```
╔══════════════════════════════════════════════════════════════════════════════╗
║  ░░░ FLASH GUIDE — 4 METHODS  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

### Method 1: Universal (auto-detects everything) ⭐ Recommended

```bash
# Flash via Magisk Manager, KernelSU Manager, or APatch
adb push CP2077-Universal-v1.0.0.zip /sdcard/Download/
# Then: Root Manager → Modules → Install from storage → Select ZIP → Reboot
```

### Method 2: Pre-scaled (if auto-scale fails)

```bash
# Find your resolution first:
adb shell wm size

# Then flash the matching ZIP:
adb push CP2077-Universal-v1.0.0-QHD_op-1440x3120.zip /sdcard/Download/
# Install via root manager
```

### Method 3: ROM-specific

```bash
# Samsung One UI:
adb push CP2077-Universal-v1.0.0-Samsung.zip /sdcard/Download/

# MIUI / HyperOS:
adb push CP2077-Universal-v1.0.0-MIUI-HyperOS.zip /sdcard/Download/

# OOS / ColorOS:
adb push CP2077-Universal-v1.0.0-OOS-ColorOS.zip /sdcard/Download/
```

### Method 4: Choose Variant

Default variant is **CyberGlitch-2077**. To change:

```bash
# Write config BEFORE flashing, or reflash after editing
su -c 'echo "boot=flatline" > /data/cp2077_universal.conf'
# Then reflash the zip

# Or use the interactive config tool
su -c /data/adb/modules/CP2077_Universal/cp2077-config.sh
```

## 🔧 Building from Source

```bash
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal
python3 build-universal.py
```

Requires: Python 3.10+, ffmpeg (optional — for audio generation)

### Build Output Tree

```
release/
├── CP2077-Universal-v1.0.0.zip                    ← universal (flash this first)
├── CP2077-Universal-v1.0.0-Samsung.zip            ← Samsung One UI optimized
├── CP2077-Universal-v1.0.0-MIUI-HyperOS.zip      ← MIUI / HyperOS optimized
├── CP2077-Universal-v1.0.0-OOS-ColorOS.zip        ← OxygenOS / ColorOS optimized
├── CP2077-Universal-v1.0.0-1080p-1080x2400.zip   ← pre-scaled FHD+
├── CP2077-Universal-v1.0.0-QHD_op-1440x3120.zip  ← pre-scaled OP7Pro/8Pro
│   ... (12 total resolution-specific packages)
└── per-variant/
    ├── CP2077-Universal-CyberGlitch-2077-v1.0.0.zip
    ├── CP2077-Universal-Cyberpunk-Flatline-2077-v1.0.0.zip
    ├── CP2077-Universal-Re-Boot-Animation-v1.0.0.zip
    └── CP2077-Universal-Original-1080p-v1.0.0.zip
```

## 🐛 Troubleshooting

<div align="center">

| ❌ Problem | 🔧 Fix |
|:---------|:------|
| Boot animation unchanged | Check `/data/misc/bootanim/bootanimation.zip` exists and is > 5 MB |
| Samsung: animation reverts | Flash Samsung-specific ZIP — One UI re-mounts system on updates |
| MIUI/HyperOS: not showing | MIUI sometimes reads from `/system/media/` — Samsung ZIP may work |
| Resolution looks wrong | Run `detect-device.sh` and flash the matching pre-scaled ZIP |
| KernelSU not finding module | `ksud module install /sdcard/Download/CP2077-Universal-v1.0.0.zip` |

</div>

```bash
# Debug device fingerprint
su -c /data/adb/modules/CP2077_Universal/tools/detect-device.sh

# Manually scale to your resolution
python3 tools/scale-animation.py bootanimation/glitch/bootanimation.zip \
        my-1234x5678.zip 1234 5678
```

## 📁 Module File Structure

```
CP2077-Universal/
├── 📄 module.prop               ← Module manifest (ID, version, updateJson)
├── 📜 customize.sh              ← Universal installer (auto-detect engine)
├── 📜 post-fs-data.sh           ← Multi-ROM bind-mount engine
├── 📜 service.sh                ← Late-start repair + permission fix
├── 📜 uninstall.sh              ← Complete cleanup
├── 📜 cp2077-config.sh          ← Interactive reconfiguration tool
├── 🔧 build-universal.py        ← Build system (20+ output packages)
├── 🗂 META-INF/                 ← Magisk/recovery installer
├── 🎬 bootanimation/            ← Animation source ZIPs
│   ├── glitch/
│   ├── flatline/
│   ├── reboot/
│   └── og/
├── 💀 shutdownanimation/
│   ├── glitch/
│   ├── flatline/
│   └── reboot/
├── 🔊 audio/ui/                 ← CP2077-themed system sounds (7 OGG files)
├── 🔧 tools/
│   ├── detect-device.sh         ← Device fingerprint debugger
│   └── scale-animation.py       ← Standalone resolution scaler
└── 📦 release/                  ← Built packages (20+ ZIPs)
```

## 🏅 Credits

<div align="center">

| 🎨 Credit | 📋 Contribution |
|:---------|:--------------|
| **天伞桜 & PanL** | Original OP8T CP2077 boot animation |
| **sodasoba1** | OOS 13+ CyberGlitch · Flatline · Re-Boot variants |
| **ENEIZEM** | POCO CP2077 splash module |
| **OnePlus** | OnePlus 8T Cyberpunk 2077 Limited Edition assets |

</div>

---

<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════════╗
║  ⚡  UNIVERSAL — EVERY DEVICE. EVERY ROM. ONE PACKAGE.  ⚡                  ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

[![Changelog](https://img.shields.io/badge/Changelog-CHANGELOG--universal.md-FF6B35?style=flat-square&labelColor=0a0a0a)](../../releases/CHANGELOG-universal.md)
[![Install Guide](https://img.shields.io/badge/Install-INSTALLATION--GUIDE.md-00FF9F?style=flat-square&labelColor=0a0a0a)](../../09-DOCS/INSTALLATION-GUIDE.md)
[![Variants](https://img.shields.io/badge/Variants-VARIANTS.md-00FFFF?style=flat-square&labelColor=0a0a0a)](../../09-DOCS/VARIANTS.md)

*Cyberpunk 2077 is a trademark of CD Projekt S.A. This is a fan project not affiliated with CD Projekt or OnePlus.*

</div>
