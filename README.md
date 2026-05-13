<div align="center">

# ░▒▓ CYBERPUNK 2077 ▓▒░
### Magisk Theme Suite · OnePlus 7 Pro · Android 14–16+

[![Module](https://img.shields.io/badge/Module-CP2077__OP7Pro__Full_v3.0.0-00ff9f?style=for-the-badge&logo=android&logoColor=black)](00-CONTROL/PRODUCTION-STATUS.md)
[![Device](https://img.shields.io/badge/Device-OnePlus_7_Pro_GM1911-ff003c?style=for-the-badge)](09-DOCS/DEVICE-SPECS.md)
[![Android](https://img.shields.io/badge/Android-API_36_|_14--16+-fcee0c?style=for-the-badge&logo=android&logoColor=black)](09-DOCS/DEVICE-SPECS.md)
[![Magisk](https://img.shields.io/badge/Magisk-30.7-00ff9f?style=for-the-badge)](09-DOCS/INSTALLATION-GUIDE.md)
[![Root](https://img.shields.io/badge/Root-Magisk_|_KernelSU_|_APatch-ff6b35?style=for-the-badge)](09-DOCS/INSTALLATION-GUIDE.md)

</div>

---

```
╔══════════════════════════════════════════════════════════════════╗
║  ⠀⠀⠀⠀⠀⠀⠀⠀⠀NIGHT CITY NEVER SLEEPS⠀⠀⠀⠀⠀⠀⠀⠀⠀                 ║
║  Boot animations · Shutdown animations · UI audio               ║
║  4 variants · 1440×3120 · 60fps · Multi-ROM · Multi-root       ║
╚══════════════════════════════════════════════════════════════════╝
```

> **9.9 GB** workspace · **150,190** files · **9** cyberpunk repos · **17** tracked repos  
> Last updated: **2026-05-13**

---

## 📡 Live Device Status

| Field | Value |
|-------|-------|
| 📱 Device | OnePlus 7 Pro `GM1911` (guacamole) |
| 🖥 Display | 1440 × 3120 px |
| 🤖 Android | API 36 (Android 16) |
| 🔑 Magisk | v30.7 |
| ✅ Active Module | `CP2077_OP7Pro_Full` **v3.0.0** |
| 🎬 Active Variant | `CyberGlitch-2077` (glitch logo · 60 fps) |
| 🗂 Previous Module | `CP2077_OP7Pro_Ultimate` — disabled, not deleted |

> Full status → [`00-CONTROL/PRODUCTION-STATUS.md`](00-CONTROL/PRODUCTION-STATUS.md)

---

## 📦 Module Index

### 🟢 CP2077_OP7Pro_Full · v3.0.0 — *Active*
> **Path:** `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/`

The primary production module. Device-optimized for OnePlus 7 Pro (guacamole). Interactive installer with 4 boot animation variants at native 1440×3120, matching shutdown animations, and CP2077 UI audio pack. Multi-path mount engine covers AOSP, LineageOS, OOS 14+, and yaap.

| Feature | Detail |
|---------|--------|
| Boot animations | CyberGlitch · Flatline · Re-Boot · Original 1080p · Original 4K |
| Shutdown animations | CyberGlitch · Flatline · Re-Boot · og1080p · og4k |
| Audio pack | 7 OGG files: lock/unlock, charging, camera, UI tick |
| Installer | Interactive with config-file resume |
| Config file | `/data/cp2077.conf` |
| Min Magisk | 20400 (20.4+) |
| Min API | 26 (Android 8.0+) |

---

### 🟡 CP2077_OP7Pro_Ultimate · v3.0.0 — *Built, Disabled*
> **Path:** `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro-Ultimate/`

Superset of Full — includes all variants pre-packed in one ZIP (277 MB megapack), optional live wallpaper slot, splash screen, and fully interactive config tool. Currently disabled in favour of the lighter Full edition. Keep for testing or when the megapack workflow is preferred.

---

### 🟢 CP2077_Universal · v1.0.0 — *Built*
> **Path:** `01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal/`  
> **Release:** `release/CP2077-Universal-v1.0.0.zip` (278 MB) + 4 per-variant ZIPs

All-device universal build. Auto-detects resolution, ROM family, and root solution at install time. Supports 14 ROM families and any resolution via auto-scaling.

| Supported ROMs | |
|---|---|
| AOSP / Pixel / CalyxOS / GrapheneOS | ✅ |
| LineageOS / crDroid / DerpFest | ✅ |
| OOS / ColorOS | ✅ |
| MIUI / HyperOS | ✅ |
| Samsung One UI | ✅ |
| Evolution X / yaap / ArrowOS / PixelOS / RisingOS | ✅ |

| Supported Root Solutions | |
|---|---|
| Magisk 20.4+ | ✅ |
| KernelSU | ✅ |
| APatch | ✅ |

---

### 🗃 CP2077_OP7Pro · v1.0 — *Legacy Build-Source*
> **Path:** `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro-build-source/`

Original v1.0 module — the first iteration before the Full/Ultimate split. Static product partition mount, Android 12+ only. Kept as a reference baseline; not intended for installation.

---

## 🎬 Boot Animation Variants

| Variant | Key | FPS | Resolution | Source | Status |
|---------|-----|-----|------------|--------|--------|
| **CyberGlitch-2077** | `glitch` | 60 | 1440×3120 | sodasoba1 (ported) | ✅ Full |
| **Cyberpunk Flatline** | `flatline` | 60 | 1440×3120 | sodasoba1 (ported) | ✅ Full + shutdown |
| **Re-Boot Animation** | `reboot` | 60 | 1440×3120 | sodasoba1 (ported) | ✅ Full + shutdown |
| **Original 1080p** | `og1080p` | 30 | 1080×2340 | 8T SE port | ✅ Full + shutdown |
| **Original 4K** | `og4k` | 30 | 2160×4800 | og1080p upscaled 2× | ✅ Full + shutdown |

---

## ⚡ Quick Commands

### Install / Flash

```bash
# Via Magisk Manager — sideload:
adb push 02-PRODUCTION/magisk-modules/CP2077-OP7Pro-release/CP2077-OP7Pro-v3.0.0.zip /sdcard/Download/
# Then: Magisk → Modules → Install from storage

# Via ADB (TWRP):
adb sideload 02-PRODUCTION/magisk-modules/CP2077-OP7Pro-release/CP2077-OP7Pro-v3.0.0.zip
```

### Switch Variant (no reflash)

```bash
# Set variant in config file — takes effect on next reflash
adb shell su -c 'echo "variant=flatline" > /data/cp2077.conf'

# Available variants: glitch | flatline | reboot | og1080p
# Then reflash the module zip via Magisk Manager
```

### Force Restart Boot Animation

```bash
adb shell su -c 'setprop ctl.restart bootanim'
```

### Build from Source

```bash
# Full Edition (OnePlus 7 Pro)
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro
python3 build.py

# Universal (all devices)
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal
python3 build-universal.py

# Ultimate All-In-One
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro-Ultimate
python3 build-ultimate.py
```

### Update All Repos

```bash
for r in $(find . -name '.git' -not -path '*/.git/.git' | sed 's|/.git||'); do
  printf "\n→ %s\n" "$r"
  git -C "$r" pull --ff-only 2>&1 | grep -v '^Already'
done
```

### Verify Boot Animation Integrity

```bash
for variant in glitch flatline reboot og1080p; do
  zip="01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/bootanimation/$variant/bootanimation.zip"
  python3 -c "
import zipfile, sys
z = zipfile.ZipFile('$zip')
names = z.namelist()
desc = [n for n in names if n == 'desc.txt']
frames = [n for n in names if n.endswith('.png')]
print(f'  $variant: desc={bool(desc)} frames={len(frames)}')
"
done
```

### Check On-Device Active Animation

```bash
adb shell su -c 'ls -lh /product/media/bootanimation.zip'
adb shell su -c 'ls -lh /data/local/bootanimation.zip'
adb shell su -c 'ls -lh /data/misc/bootanim/bootanimation.zip'
```

---

## 🗂 Workspace Layout

| Dir | Purpose |
|-----|---------|
| `00-CONTROL/` | Workspace policy, production status, operating notes |
| `01-DEVELOPMENT/` | Source repositories — modules, themes, kernels |
| `02-PRODUCTION/` | Release ZIPs and Magisk module outputs (symlink-based) |
| `03-BUILD/` | Build workspace, upstream reference modules, raw assets |
| `04-ANDROID/` | Device snapshot (sdcard), APKs, ARM64 archives |
| `05-LINUX/` | Arch host scripts and Linux-side assets |
| `06-UI-THEMES-ANIMATIONS/` | Boot/shutdown animations, themes, wallpapers |
| `07-KERNEL-PACKAGE-MODULES/` | Kernel sources, patched boot images |
| `08-HACKING-RESEARCH/` | NetHunter and security research repos |
| `09-DOCS/` | Full documentation index |
| `10-QUARANTINE-invalid-downloads/` | Files confirmed bad — DO NOT install |
| `99-MANIFESTS/` | Generated inventories and checksums |

---

## 🌐 Repository Index

### 🔧 Primary Modules (local dev)

| Module | Version | Description |
|--------|---------|-------------|
| [`CP2077-OP7Pro`](01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/) | v3.0.0 | Full Edition — OP7 Pro optimized, 4 variants |
| [`CP2077-OP7Pro-Ultimate`](01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro-Ultimate/) | v3.0.0 | Ultimate All-In-One — megapack |
| [`CP2077-Universal`](01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal/) | v1.0.0-dev | Universal — auto-detects ROM, resolution, root |
| [`CP2077-OP7Pro-build-source`](01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro-build-source/) | v1.0 | Legacy — original first-gen module (reference only) |

### 📺 Upstream Reference — Boot Animations

| Repo | Author | Description |
|------|--------|-------------|
| [`GlitchedCyberBoot`](01-DEVELOPMENT/repos/cyberpunk/GlitchedCyberBoot/) | Magisk-Modules-Alt-Repo | CyberGlitch animation source |
| [`ONEPLUS9-OOS13-BootAnimation`](01-DEVELOPMENT/repos/cyberpunk/ONEPLUS9-OOS13-BootAnimation/) | sodasoba1 | Primary animation source (glitch, flatline, reboot) |
| [`CyberPunk-2077-OOS13-Modded-Boot-and-Shutdown-Animation`](03-BUILD/artifacts/cyberpunk-build/CyberPunk-2077-OOS13-Modded-Boot-and-Shutdown-Animation/) | sodasoba1 | Modded OOS13 boot + shutdown reference |
| [`Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO`](03-BUILD/artifacts/cyberpunk-build/Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO/) | ENEIZEM | POCO splash screen reference |

### 🎨 Android UI / Icons

| Repo | Author | Description |
|------|--------|-------------|
| [`AndroidCyberpankIcons`](01-DEVELOPMENT/repos/cyberpunk/AndroidCyberpankIcons/) | privatgt | CP2077-themed Android icon pack |

### 🖥 Linux Themes

| Repo | Author | Covers |
|------|--------|--------|
| [`Cyberpunk-Neon`](06-UI-THEMES-ANIMATIONS/themes/Cyberpunk-Neon/) | Roboron3042 | KDE, GTK, Sway, Waybar, Rofi, Vim, terminal |
| [`K-DE-Cyberpunk-Neon`](06-UI-THEMES-ANIMATIONS/themes/K-DE-Cyberpunk-Neon/) | UtkarshKunwar | KDE Plasma, Konsole, Plymouth, Neovim, Chrome |
| [`cyber-hyprland-theme`](06-UI-THEMES-ANIMATIONS/themes/cyber-hyprland-theme/) | taylor85345 | Hyprland, eww, Rofi, foot terminal |
| [`cybrland`](06-UI-THEMES-ANIMATIONS/themes/cybrland/) | scherrer-txt | Full Arch dotfiles — Hyprland, Waybar, kitty, nvim, fish |
| [`cybrcolors`](06-UI-THEMES-ANIMATIONS/themes/cybrcolors/) | scherrer-txt | Cyberpunk color palette / design tokens |
| [`cyberpunk-technotronic-icon-theme`](06-UI-THEMES-ANIMATIONS/themes/cyberpunk-technotronic-icon-theme/) | dreifacherspass | SVG icon theme, blue-purple gradient |

### 🖼 Wallpapers

| Repo | Author | License |
|------|--------|---------|
| [`cybrpapers`](06-UI-THEMES-ANIMATIONS/wallpapers/cybrpapers/) | scherrer-txt | CC0 |
| `Cyberpunk-Wallpapers/` | local | — |

### ⚙️ Kernels — OnePlus 7 Pro / SM8150

| Repo | Branch | Notes |
|------|--------|-------|
| [`blu-spark-kernel-op7`](07-KERNEL-PACKAGE-MODULES/kernel/blu-spark-kernel-op7/) | `blu_spark-11` | CAF 4.14, OP7/T/Pro, shallow clone |
| [`neptune-kernel-sm8150`](07-KERNEL-PACKAGE-MODULES/kernel/neptune-kernel-sm8150/) | `U-Ice` | CAF/CLO QSSI14.0, shallow clone |
| [`kernelsu-lineageos-guacamole`](07-KERNEL-PACKAGE-MODULES/kernel/kernelsu-lineageos-guacamole/) | `main` | KernelSU pre-built for OP7 Pro + LineageOS |
| `oneplus-7-pro-lineage-kernel-sm8150` *(symlink)* | — | LineageOS SM8150 kernel source |

---

## 🔧 Troubleshooting

### Boot animation not changing after flash

```bash
# 1. Confirm the module is enabled
adb shell su -c 'ls /data/adb/modules/CP2077_OP7Pro_Full/'

# 2. Check which path the system is actually reading
adb shell su -c 'stat /product/media/bootanimation.zip'

# 3. Force restart the boot animation service
adb shell su -c 'setprop ctl.restart bootanim'

# 4. If still wrong, check service.sh ran (look for size threshold repair)
adb shell su -c 'logcat -d | grep cp2077'
```

### Wrong animation after reboot (reverted to stock)

The `service.sh` size-threshold remount check runs 5 seconds after boot. If the animation is correct during boot but reverts, the bind mount is being overwritten by the ROM. Try:

```bash
# Check current size (should be >5 MB for CP2077)
adb shell su -c 'wc -c /product/media/bootanimation.zip'
```

If size < 5 MB, the ROM replaced the file. Consider filing an issue or switching to the `/data/local/bootanimation.zip` fallback path which is checked first on most ROMs.

### Module not showing in Magisk

Verify the ZIP structure contains `META-INF/com/google/android/update-binary` and `module.prop` at the root level.

### Audio not applying

```bash
adb shell su -c 'ls /product/media/audio/ui/*.ogg'
# Should show 7 CP2077 OGG files
# If empty, reinstall with audio=yes in config or answer Y at installer prompt
```

> Full troubleshooting guide → [`09-DOCS/TROUBLESHOOTING.md`](09-DOCS/TROUBLESHOOTING.md)

---

## 🚫 Quarantined — DO NOT Install

| File | Reason |
|------|--------|
| `cp2077-livewallpaper-original.apk` | HTML document masquerading as APK |
| `cp2077-livewallpaper-vivid.apk` | HTML document masquerading as APK |
| `cp2077-bootanimation-stock-oos.zip` | Zero bytes |
| `cp2077-bootanimation-mega.zip` | HTML document masquerading as ZIP |

All quarantined files are in [`10-QUARANTINE-invalid-downloads/`](10-QUARANTINE-invalid-downloads/) for audit visibility only. They are symlinked to the originals in `03-BUILD/artifacts/cyberpunk-build/` with descriptive names indicating their defect.

---

## 📚 Documentation

| Doc | Description |
|-----|-------------|
| [`09-DOCS/INDEX.md`](09-DOCS/INDEX.md) | Full docs index |
| [`09-DOCS/INSTALLATION-GUIDE.md`](09-DOCS/INSTALLATION-GUIDE.md) | Flash guide, ADB sideload, requirements |
| [`09-DOCS/VARIANTS.md`](09-DOCS/VARIANTS.md) | Animation variant details and switching |
| [`09-DOCS/BUILD-GUIDE.md`](09-DOCS/BUILD-GUIDE.md) | Build from source, adding variants |
| [`09-DOCS/DEVICE-SPECS.md`](09-DOCS/DEVICE-SPECS.md) | Hardware specs, ROM compat matrix |
| [`09-DOCS/TROUBLESHOOTING.md`](09-DOCS/TROUBLESHOOTING.md) | Common issues and fixes |
| [`09-DOCS/REPOS.md`](09-DOCS/REPOS.md) | Detailed repo catalogue with remotes |
| [`09-DOCS/WORKSPACE-GUIDE.md`](09-DOCS/WORKSPACE-GUIDE.md) | Full directory tree and layout guide |
| **[`09-DOCS/ROADMAP.md`](09-DOCS/ROADMAP.md)** | **Future roadmap, open bugs, planned features** |
| [`99-MANIFESTS/git-repositories.txt`](99-MANIFESTS/git-repositories.txt) | All repos with branches and remotes |
| [`00-CONTROL/PRODUCTION-STATUS.md`](00-CONTROL/PRODUCTION-STATUS.md) | Current device state and audit log |

---

## 🗺 Roadmap Highlights

See [`09-DOCS/ROADMAP.md`](09-DOCS/ROADMAP.md) for the full roadmap. Key upcoming items:

| Priority | Item |
|----------|------|
| 🔴 High | Source `og4k` bootanimation asset (currently empty placeholder) |
| 🔴 High | Publish v3.0.0 GitHub release — fix OTA update.json URLs |
| 🟡 Medium | Build and publish CP2077-Universal v1.0.0 release zip |
| 🟡 Medium | og1080p shutdown animation |
| 🟢 Low | GitHub Actions CI pipeline for automated builds |
| 🟢 Low | Plymouth boot theme for Arch Linux host |

---

<div align="center">

**Wake the f**k up, Samurai.**  
*We have a city to burn.*

`░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░`

</div>
