# Cyberpunk 2077 — Universal Edition

![Version](https://img.shields.io/badge/version-v1.0.0-yellow)
![Android](https://img.shields.io/badge/Android-5.1%2B-00FF00)
![Root](https://img.shields.io/badge/root-Magisk%20%7C%20KernelSU%20%7C%20APatch-blue)
![Devices](https://img.shields.io/badge/devices-ALL_Android-cyan)

**Works on every Android device, every ROM, every resolution.**

Auto-detects your device's screen resolution and ROM family, then installs the appropriate Cyberpunk 2077 boot/shutdown animation and audio theme.

---

## Supported ROMs

| ROM Family | Variants |
|---|---|
| AOSP | Stock Android, Android One, AOSP GSI |
| LineageOS | LineageOS 19–22, crDroid, DerpFest |
| Samsung One UI | One UI 4–7, Galaxy |
| OxygenOS / ColorOS | OOS 12–15, ColorOS 13–15 |
| MIUI / HyperOS | MIUI 13–14, HyperOS 1–2 |
| Pixel / GrapheneOS | Pixel 4–9, GrapheneOS, CalyxOS |
| Evolution X | 7–9 |
| yaap | Any version |
| PixelOS | Any version |
| ArrowOS | Any version |
| RisingOS | Any version |
| crDroid | Any version |

## Supported Resolutions

Auto-scales to **any resolution** by rewriting the animation descriptor on install.

Pre-scaled packages available for:

| Label | Resolution | Devices |
|---|---|---|
| 720p | 720×1600 | Budget / mid-range |
| 720p_19 | 720×1520 | HD+ 19:9 |
| 1080p | 1080×2400 | Most flagship FHD+ (20:9) |
| 1080p_19 | 1080×2340 | Samsung FHD (19.5:9) |
| 1080p_px | 1080×2408 | Pixel 4a, Pixel 5 |
| 1080p_px2 | 1080×2412 | Pixel 6a, Pixel 7a |
| 1080p_mi | 1080×2376 | Xiaomi / Redmi |
| 1080p_fh | 1080×1920 | Classic FHD 16:9 |
| QHD | 1440×3200 | Samsung S21+ |
| QHD_op | 1440×3120 | OnePlus 7/8 Pro |
| QHD_s20 | 1440×3088 | Samsung S20/S20+ |
| QHD_s22 | 1440×3216 | Samsung S22+ |

## Boot Animation Variants

| Variant | FPS | Style | Shutdown |
|---|---|---|---|
| **CyberGlitch-2077** ⭐ | 60 | Glitch logo + CP2077 color scheme | ✅ |
| **Cyberpunk-Flatline-2077** | 60 | Flatline / nomad style | ✅ |
| **Re-Boot Animation** | 60 | OEM logo + glitch effect | ✅ |
| **Original (8T SE Port)** | 30 | Stock OP8T Cyberpunk Edition | ❌ |

## Installation

### 1. Universal (auto-detects everything)
Flash `CP2077-Universal-v1.0.0.zip` via Magisk Manager, KernelSU Manager, or APatch.

### 2. Pre-scaled (if universal auto-scale fails)
Pick the zip matching your resolution from the release folder and flash it.

### 3. ROM-specific
- Samsung: flash `CP2077-Universal-v1.0.0-Samsung.zip`
- MIUI/HyperOS: flash `CP2077-Universal-v1.0.0-MIUI-HyperOS.zip`
- OOS/ColorOS: flash `CP2077-Universal-v1.0.0-OOS-ColorOS.zip`

### 4. Choose variant
Default variant is **CyberGlitch-2077**. To change:

```bash
# Write config BEFORE flashing, or reflash after editing
su -c 'echo "boot=flatline" > /data/cp2077_universal.conf'
# Then reflash the zip

# Or use the interactive config tool
su -c /data/adb/modules/CP2077_Universal/cp2077-config.sh
```

## Building from Source

```bash
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal
python3 build-universal.py
```

Requires: Python 3.10+, ffmpeg (optional, for audio generation)

### What the build generates

```
release/
├── CP2077-Universal-v1.0.0.zip              ← universal (flash this first)
├── CP2077-Universal-v1.0.0-Samsung.zip
├── CP2077-Universal-v1.0.0-MIUI-HyperOS.zip
├── CP2077-Universal-v1.0.0-OOS-ColorOS.zip
├── CP2077-Universal-v1.0.0-1080p-1080x2400.zip
├── CP2077-Universal-v1.0.0-QHD_op-1440x3120.zip
│   ... (12 resolution-specific packages)
└── per-variant/
    ├── CP2077-Universal-CyberGlitch-2077-v1.0.0.zip
    ├── CP2077-Universal-Cyberpunk-Flatline-2077-v1.0.0.zip
    ├── CP2077-Universal-Re-Boot-Animation-v1.0.0.zip
    └── CP2077-Universal-Original-1080p-v1.0.0.zip
```

## Troubleshooting

| Problem | Fix |
|---|---|
| Boot animation unchanged | Check `/data/misc/bootanim/bootanimation.zip` exists and is >5MB |
| Samsung: animation reverts | Flash Samsung-specific zip; One UI re-mounts system on updates |
| MIUI/HyperOS: not showing | MIUI sometimes reads from `/system/media/` — Samsung zip works |
| Resolution looks wrong | Run `detect-device.sh` and flash the matching pre-scaled zip |
| KernelSU not finding module | Use `ksud module install /sdcard/Download/CP2077-Universal-v1.0.0.zip` |

```bash
# Debug device fingerprint
su -c /data/adb/modules/CP2077_Universal/tools/detect-device.sh

# Manually scale to your resolution
python3 tools/scale-animation.py bootanimation/glitch/bootanimation.zip \
        my-1234x5678.zip 1234 5678
```

## File Structure

```
CP2077-Universal/
├── module.prop               Module manifest
├── customize.sh              Universal installer (auto-detect engine)
├── post-fs-data.sh           Multi-ROM bind-mount engine
├── service.sh                Late-start repair + permission fix
├── uninstall.sh              Complete cleanup
├── cp2077-config.sh          Interactive reconfiguration tool
├── build-universal.py        Build system (20+ output packages)
├── META-INF/                 Magisk/recovery installer
├── bootanimation/            Animation source ZIPs
│   ├── glitch/
│   ├── flatline/
│   ├── reboot/
│   └── og/
├── shutdownanimation/
│   ├── glitch/
│   ├── flatline/
│   └── reboot/
├── audio/ui/                 CP2077-themed system sounds
├── tools/
│   ├── detect-device.sh      Device fingerprint debugger
│   └── scale-animation.py    Standalone resolution scaler
└── release/                  Built packages
```

## Credits

- **天伞桜 & PanL** — Original OP8T CP2077 boot animation
- **sodasoba1** — OOS 13+ CyberGlitch, Flatline, Re-Boot variants
- **ENEIZEM** — POCO CP2077 + splash module
- **OnePlus** — OnePlus 8T Cyberpunk 2077 Limited Edition assets

*Cyberpunk 2077 is a trademark of CD Projekt S.A. This is a fan project not affiliated with CD Projekt or OnePlus.*
