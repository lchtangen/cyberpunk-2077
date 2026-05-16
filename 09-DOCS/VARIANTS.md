<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░▒▓  ANIMATION VARIANTS — CYBERPUNK 2077 MAGISK MODULE  ▓▒░           ║
║  ────────────────────────────────────────────────────────────────────── ║
║  Boot · Shutdown · Reboot · Audio Pack · Asset Map                     ║
╚══════════════════════════════════════════════════════════════════════════╝
```

</div>

All variants are pre-scaled to **1440 × 3120** — native OnePlus 7 Pro resolution.  
Universal edition auto-scales to any device resolution at install time.

## ⚡ Quick Reference Matrix

<div align="center">

| 🎬 Variant | 🔑 Key | ⚡ FPS | 📐 Res | 💀 Shutdown | 📦 Boot ZIP |
|:----------|:------|:------|:------|:----------|:-----------|
| ⭐ CyberGlitch-2077 | `glitch` | 60 | 1440×3120 | ✅ | 66 MB |
| Cyberpunk-Flatline | `flatline` | 60 | 1440×3120 | ✅ | 57 MB |
| Re-Boot Animation | `reboot` | 60 | 1440×3120 | ✅ | 66 MB |
| Original 1080p | `og1080p` | 30 | 1080×2340 | ✅ | 92 MB |
| Original 4K | `og4k` | 30 | 2160×4800 | ✅ | 358 MB |
| Phantom Liberty | `phantom-lib` | — | — | — | v3.1.0 |
| Dogtown | `dogtown` | — | — | — | v3.1.0 |

</div>

---

## 🎬 Boot Animation Variants

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ VARIANT MATRIX ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### ⚡ 1. CyberGlitch-2077 — `glitch` *(Active · Recommended)*

<div align="center">

| 🔷 Property | 📋 Value |
|:-----------|:--------|
| 🔑 **Key** | `glitch` |
| 🎨 **Style** | Glitch-effect CP2077 logo with neon cyan/yellow palette |
| 🎞 **FPS** | **60** |
| 📐 **Resolution** | 1440 × 3120 |
| 📦 **Source** | sodasoba1 — OOS 13 modded (ported to OP7 Pro) |
| 💀 **Shutdown match** | ✅ `glitch/shutdownanimation.zip` |
| ⭐ **Recommend** | Best visual match to OP8T Cyberpunk Edition hardware theme |

</div>

---

### 💀 2. Cyberpunk-Flatline-2077 — `flatline`

<div align="center">

| 🔷 Property | 📋 Value |
|:-----------|:--------|
| 🔑 **Key** | `flatline` |
| 🎨 **Style** | Flatline ECG motif with CP2077 neon color grade |
| 🎞 **FPS** | **60** |
| 📐 **Resolution** | 1440 × 3120 |
| 📦 **Source** | sodasoba1 — OOS 13 modded |
| 💀 **Shutdown match** | ✅ `flatline/shutdownanimation.zip` |
| ⭐ **Character** | Subtle, cinematic — best for minimalist builds |

</div>

---

### 🔄 3. Re-Boot Animation — `reboot`

<div align="center">

| 🔷 Property | 📋 Value |
|:-----------|:--------|
| 🔑 **Key** | `reboot` |
| 🎨 **Style** | OnePlus logo with glitch transition overlay |
| 🎞 **FPS** | **60** |
| 📐 **Resolution** | 1440 × 3120 |
| 📦 **Source** | sodasoba1 — OOS 13 modded |
| 💀 **Shutdown match** | ✅ `reboot/shutdownanimation.zip` |
| ⭐ **Character** | Closest to stock OP boot feel with CP2077 flair |

</div>

---

### 📺 4. Original 1080p — `og1080p`

<div align="center">

| 🔷 Property | 📋 Value |
|:-----------|:--------|
| 🔑 **Key** | `og1080p` |
| 🎨 **Style** | Authentic OnePlus 8T Cyberpunk Special Edition animation |
| 🎞 **FPS** | 30 |
| 📐 **Resolution** | 1080 × 2340 (upscaled display) |
| 📦 **Source** | OP8T Cyberpunk Edition SE port |
| 💀 **Shutdown match** | ✅ `og1080p/shutdownanimation.zip` (reboot frames adapted) |
| ⭐ **Character** | Authentic source material · lower fps/res is intentional |

</div>

---

### 🔬 5. Original 4K — `og4k` *(Development Asset)*

<div align="center">

| 🔷 Property | 📋 Value |
|:-----------|:--------|
| 🔑 **Key** | `og4k` |
| 🎨 **Style** | 4K upscaled variant |
| 🎞 **FPS** | 30 |
| 📐 **Resolution** | 2160 × 4800 (LANCZOS 2× upscale from og1080p) |
| 📦 **Source** | og1080p upscaled via Pillow LANCZOS · 267 frames · 358 MB |
| 💀 **Shutdown match** | Glitch frames adapted to 2160×4800 |
| 📍 **Location** | `06-UI-THEMES-ANIMATIONS/animations/CP2077-OP7Pro-bootanimations/og4k/` |
| ⚠️ **Status** | Dev asset — not bundled in module ZIP by default |

</div>

---

## 💀 Shutdown Animation Matrix

<div align="center">

| 🎬 Variant | 💀 Shutdown File | 🔄 Reboot File |
|:-----------|:----------------|:--------------|
| `glitch` | `glitch/shutdownanimation.zip` | Same → `rbootanimation.zip` |
| `flatline` | `flatline/shutdownanimation.zip` | Same → `rbootanimation.zip` |
| `reboot` | `reboot/shutdownanimation.zip` | Same → `rbootanimation.zip` |
| `og1080p` | `og1080p/shutdownanimation.zip` | Reboot frames → 1080×2340 |
| `og4k` | Glitch frames → 2160×4800 | — |

</div>

---

## 🔊 Audio Pack — CP2077 UI Sounds

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ AUDIO CORTEX — UI SOUND REPLACEMENTS ░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

Installed to `/product/media/audio/ui/` and `/media/audio/ui/`:

<div align="center">

| 🔊 File | 🔄 Replaces | 📝 Notes |
|:--------|:-----------|:--------|
| `Lock.ogg` | Screen lock sound | — |
| `Unlock.ogg` | Screen unlock sound | — |
| `ChargingStarted.ogg` | Wired charging connect | — |
| `WirelessChargingStarted.ogg` | Wireless charging connect | Some OOS builds play both — see Troubleshooting |
| `camera_click.ogg` | Camera shutter | — |
| `camera_focus.ogg` | Camera autofocus | — |
| `Effect_Tick.ogg` | UI tick / selection | — |

</div>

---

## 🔄 Switching Variants After Install

**Option A — Reflash (recommended):**
```bash
# Push updated module and reflash via Magisk
# The installer reads /data/cp2077.conf to pre-fill your previous selection
adb push CP2077-OP7Pro-v3.1.0.zip /sdcard/Download/
# Magisk → Modules → Install → select ZIP
```

**Option B — Config edit (no reflash):**
```bash
# Edit config directly — post-fs-data.sh re-applies on next boot
adb shell su -c 'echo -e "variant=flatline\naudio=yes" > /data/cp2077.conf'
adb reboot
```

**Option C — Force restart animation service:**
```bash
adb shell su -c 'echo "variant=glitch" > /data/cp2077.conf'
adb shell su -c 'setprop ctl.restart bootanim'
```

---

## 📁 Asset Locations in This Workspace

```
06-UI-THEMES-ANIMATIONS/
├── 🎬 animations/
│   ├── CP2077-OP7Pro-bootanimations/
│   │   ├── flatline/bootanimation.zip       (1440×3120 · 60fps)
│   │   ├── glitch/bootanimation.zip         (1440×3120 · 60fps) ← ACTIVE
│   │   ├── og1080p/bootanimation.zip        (1080×2340 · 30fps)
│   │   ├── og4k/bootanimation.zip           (2160×4800 · 30fps · dev)
│   │   └── reboot/bootanimation.zip         (1440×3120 · 60fps)
│   ├── CP2077-OP7Pro-shutdownanimations/
│   │   ├── flatline/shutdownanimation.zip
│   │   ├── glitch/shutdownanimation.zip
│   │   ├── og1080p/shutdownanimation.zip
│   │   └── reboot/shutdownanimation.zip
│   └── CP2077-Universal-bootanimations/     (auto-scaled variants)
│
├── 🎨 themes/
│   ├── CP2077-splash-assets/                ← boot splash PNGs
│   ├── CP2077-system-audio/ui/              ← .ogg audio files
│   ├── Cyberpunk-Neon/                      ← KDE/GTK/Sway/terminal
│   ├── K-DE-Cyberpunk-Neon/                 ← KDE + Plymouth
│   ├── cyber-hyprland-theme/                ← Hyprland + eww + Rofi
│   ├── cybrland/                            ← Full Arch dotfiles
│   ├── cybrcolors/                          ← Color palette tokens
│   └── cyberpunk-technotronic-icon-theme/   ← SVG icon theme
│
└── 🖼 wallpapers/
    ├── Cyberpunk-Wallpapers/                ← AI-gen + curated (JPEG/PNG/WebP)
    └── cybrpapers/                          ← CC0 hand-crafted collection
```

---

## 📦 bootanimation.zip Format Reference

```bash
# Standard Android boot animation format:
bootanimation.zip
├── desc.txt        ← "1440 3120 60" (width height fps)
├── part0/          ← intro section (plays once)
│   ├── frame001.png
│   ├── frame002.png
│   └── ...
└── part1/          ← loop section (loops until boot complete)
    ├── frame001.png
    └── ...
```

**Verify a ZIP:**
```bash
python3 -c "
import zipfile
z = zipfile.ZipFile('bootanimation.zip')
print(z.read('desc.txt').decode())
frames = [n for n in z.namelist() if n.endswith('.png')]
print(f'Frames: {len(frames)}')
"
```

---

## 🔗 Upstream Source Repos

<div align="center">

| 📦 Repo | 📍 Location | 🎨 Contribution |
|:--------|:-----------|:---------------|
| `sodasoba1/CyberPunk-2077-OOS13-Modded-Boot-and-Shutdown-Animation` | `03-BUILD/artifacts/cyberpunk-build/` | Source frames for glitch + flatline |
| `Magisk-Modules-Alt-Repo/GlitchedCyberBoot` | `01-DEVELOPMENT/repos/cyberpunk/GlitchedCyberBoot/` | Alternative glitch variant · OOS path format |
| `sodasoba1/ONEPLUS9-OOS13-BootAnimation` | `01-DEVELOPMENT/repos/cyberpunk/ONEPLUS9-OOS13-BootAnimation/` | Higher-res source frames (OP9 native) |
| `ENEIZEM/Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO` | `03-BUILD/artifacts/cyberpunk-build/` | POCO module · splash screen reference |

</div>

---

## 📐 Asset Dimensions Reference

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ FRAME COUNT · RESOLUTION · FPS · ZIP SIZE ░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

<div align="center">

### Boot Animations

| 🎬 Variant | 📐 Resolution | ⚡ FPS | 🖼 Frames | 📦 ZIP Size |
|:----------|:-------------|:------|:---------|:-----------|
| `glitch` | 1440×3120 | **60** | 227 | 66.0 MB |
| `flatline` | 1440×3120 | **60** | 227 | 57.0 MB |
| `reboot` | 1440×3120 | **60** | 227 | 65.9 MB |
| `og1080p` | 1080×2400 | 30 | 267 | 91.6 MB |
| `og4k` | 2160×4800 | 30 | 267 | 358.0 MB |

### Shutdown / Reverse-Boot Animations

| 🎬 Variant | 📐 Resolution | ⚡ FPS | 🖼 Frames | 📦 ZIP Size |
|:----------|:-------------|:------|:---------|:-----------|
| `glitch` | 1440×3120 | 60 | 58 | 0.6 MB |
| `flatline` | 1440×3120 | 60 | 64 | 0.9 MB |
| `reboot` | 1440×3120 | 60 | 58 | 0.5 MB |
| `og1080p` | 1440×3120 | 60 | 58 | 0.5 MB |
| `og4k` | 2160×4800 | 30 | 58 | 0.6 MB |

</div>

> Frame counts include all parts (intro + loop). ZIP size is uncompressed (`ZIP_STORED`) on-device.
> og4k boot animation was upscaled from og1080p via Pillow LANCZOS 2× (2160×4800, 358 MB).

---

## 🔗 Related Docs

| 📄 | 🔗 |
|:---|:---|
| ⚡ Installation instructions | [INSTALLATION-GUIDE.md](INSTALLATION-GUIDE.md) |
| 🔧 Build from source | [BUILD-GUIDE.md](BUILD-GUIDE.md) |
| 🐛 Troubleshoot issues | [TROUBLESHOOTING.md](TROUBLESHOOTING.md) |
| 📋 Current device state | [../00-CONTROL/PRODUCTION-STATUS.md](../00-CONTROL/PRODUCTION-STATUS.md) |
