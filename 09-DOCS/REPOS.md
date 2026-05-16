<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════════╗
║  ░▒▓  REPOSITORY CATALOGUE — CYBERPUNK 2077 WORKSPACE  ▓▒░                 ║
║  ────────────────────────────────────────────────────────────────────────── ║
║  All cloned repos · Categories · Remotes · Last audited 2026-05-13         ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

[![Repos](https://img.shields.io/badge/REPOSITORIES-39_cloned-FCEE0C?style=for-the-badge&labelColor=0a0a0a)](./)
[![Kernels](https://img.shields.io/badge/KERNELS-7_sources-00FF9F?style=for-the-badge&labelColor=0a0a0a)](./)
[![Themes](https://img.shields.io/badge/THEMES-12_sets-00FFFF?style=for-the-badge&labelColor=0a0a0a)](./)
[![Root](https://img.shields.io/badge/ROOT_ECOSYSTEM-10_repos-FF003C?style=for-the-badge&labelColor=0a0a0a)](./)

> **Live manifest:** [`../99-MANIFESTS/git-repositories.txt`](../99-MANIFESTS/git-repositories.txt)

<div align="center">

| 📊 Metric | 🔢 Value |
|:---------|:--------|
| Total Repositories | **39** |
| Cyberpunk Animation Sources | **4** |
| Linux Themes | **8** |
| Magisk/Root Ecosystem | **10** |
| Device/Kernel Sources | **8** |
| Wallpapers | **2** |
| Last Audited | **2026-05-13** |

</div>

</div>

```
┌────────────────────────────────────────────────────────────────────────────┐
│  WORKSPACE STRUCTURE                                                    │
│  01-DEVELOPMENT/repos/     — Source repos, module dev, device configs  │
│  03-BUILD/artifacts/        — Upstream build artifacts                   │
│  06-UI-THEMES-ANIMATIONS/  — Themes, icons, wallpapers, Plymouth       │
│  07-KERNEL-PACKAGE-MODULES/ — Kernel sources, KSU builds                │
└────────────────────────────────────────────────────────────────────────────┘
```

</div>

---

## 📋 SECTION INDEX

<div align="center">

| # | 📁 Category | 🔢 Count | 📍 Location |
|:--|:---------|------:|:---------|
| [01] | Primary Modules (CP2077) | 3 | `01-DEVELOPMENT/repos/cyberpunk/` |
| [02] | Upstream Animation Sources | 4 | `01-DEVELOPMENT/` + `03-BUILD/` |
| [03] | Magisk & Root Ecosystem | 10 | `01-DEVELOPMENT/repos/magisk-ecosystem/` |
| [04] | Linux Themes | 8 | `06-UI-THEMES-ANIMATIONS/` |
| [05] | Device & Kernel Sources | 8 | `01-DEVELOPMENT/repos/oneplus-7-pro/` + `07-KERNEL-PACKAGE-MODULES/` |
| [06] | Wallpapers | 2 | `06-UI-THEMES-ANIMATIONS/wallpapers/` |
| [07] | Android UI / Icons | 1 | `01-DEVELOPMENT/repos/cyberpunk/` |
| [08] | Full Repository Table | — | End of document |

</div>

---

## [01] PRIMARY MODULES — CP2077 Development

> [!IMPORTANT]
> These are the active development repositories for the CP2077 Magisk theme suite.

### 📦 CP2077-OP7Pro — Full Edition · 🔴 ACTIVE

| Field | Value |
|:------|:------|
| Path | `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/` |
| Remote | local (no upstream) |
| Version | v3.0.0 |
| Size | **3.1 GB** |
| Branch | `master` |
| Status | ✅ Active on device |

The **primary development repo**. Cyberpunk 2077 Full Edition Magisk module for OnePlus 7 Pro. 4 boot animation variants at 1440x3120, matching shutdown animations, CP2077 audio pack, splash assets, and config-file-driven variant selection. Multi-path mount engine supporting AOSP/LineageOS/OOS/yaap.

---

### 📦 CP2077-OP7Pro-Ultimate — Superseded

| Field | Value |
|:------|:------|
| Path | `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro-Ultimate/` |
| Remote | local (no upstream) |
| Version | v3.0.0 |
| Status | 🟡 Built — disabled |

All-in-one variant with extended config tooling and live wallpaper slot. **Note:** Two bundled live wallpaper APKs (`cp2077-livewallpaper-original.apk`, `cp2077-livewallpaper-vivid.apk`) are HTML documents — quarantined in `10-QUARANTINE-invalid-downloads/`.

---

### 📦 CP2077-Universal — Universal Edition

| Field | Value |
|:------|:------|
| Path | `01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal/` |
| Remote | local (no upstream) |
| Version | v1.0.0 |
| Size | ~278 MB release ZIP |
| Status | 🟢 Published on GitHub |

All-device universal build. Auto-detects resolution, ROM family (14 families), and root solution (Magisk/KernelSU/APatch) at install time. Release: `release/CP2077-Universal-v1.0.0.zip` (278 MB) + 4 per-variant ZIPs.

---

## [02] UPSTREAM ANIMATION SOURCES

> [!NOTE]
> These repositories provide source animation frames, reference implementations, and packaging patterns used in CP2077 module development.

### 📦 ONEPLUS9-OOS13-BootAnimation · 🔵 PRIMARY UPSTREAM

| Field | Value |
|:------|:------|
| Path | `01-DEVELOPMENT/repos/cyberpunk/ONEPLUS9-OOS13-BootAnimation/` |
| Remote | `https://github.com/sodasoba1/ONEPLUS9-OOS13-BootAnimation` |
| Author | sodasoba1 |
| Size | **345 MB** |
| Branch | `main` |
| License | Unknown |

**Primary upstream source** for glitch/flatline variants. Contains boot animation source frames used as reference for the OP7 Pro port at 1440x3120. Native OP9 resolution differs — frames are adapted via Pillow LANCZOS upscaling.

---

### 📦 CyberPunk-2077-OOS13-Modded-Boot-and-Shutdown-Animation

| Field | Value |
|:------|:------|
| Path | `03-BUILD/artifacts/cyberpunk-build/CyberPunk-2077-OOS13-Modded-Boot-and-Shutdown-Animation/` |
| Remote | `https://github.com/sodasoba1/CyberPunk-2077-OOS13-Modded-Boot-and-Shutdown-Animation` |
| Author | sodasoba1 |
| Size | **132 MB** |
| Branch | `main` |

Modified CP2077 boot + shutdown animation for OxygenOS 13. Glitch-effect color-matching shutdown animation. **Reference for shutdown animation implementation.**

---

### 📦 GlitchedCyberBoot

| Field | Value |
|:------|:------|
| Path | `01-DEVELOPMENT/repos/cyberpunk/GlitchedCyberBoot/` |
| Remote | `https://github.com/Magisk-Modules-Alt-Repo/GlitchedCyberBoot` |
| Author | Magisk-Modules-Alt-Repo |
| Branch | `main` |

Glitch-effect CP2077 boot animation Magisk module. Uses `my_product/media/bootanimation/` path for OOS 13 compatibility. **Reference for OOS path format and animation packaging.**

---

### 📦 Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO

| Field | Value |
|:------|:------|
| Path | `03-BUILD/artifacts/cyberpunk-build/Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO/` |
| Remote | `https://github.com/ENEIZEM/Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO` |
| Author | ENEIZEM |
| Size | **203 MB** |
| Branch | `main` |

CP2077 Magisk module adapted for POCO devices. Includes optional splash screen. **Reference for splash screen implementation and generic-device compatibility.**

---

## [03] MAGISK & ROOT ECOSYSTEM

> [!TIP]
> These repositories provide reference implementations, module APIs, and tooling for Magisk, KernelSU, LSPosed, Zygisk, and APatch development.

| Repo | Path | Remote | Size | Branch | Purpose |
|:-----|:-----|:-------|-----:|:------|:--------|
| Magisk | `magisk-ecosystem/Magisk/` | `https://github.com/topjohnwu/Magisk` | 9.7 MB | master | Reference Magisk module structure, build system, MagiskHide |
| KernelSU | `magisk-ecosystem/KernelSU/` | `https://github.com/tiann/KernelSU` | 14 MB | main | KernelSU module spec, KSU WebUI API, module.json format |
| LSPosed | `magisk-ecosystem/LSPosed/` | `https://github.com/LSPosed/LSPosed` | 6.2 MB | master | LSPosed module resource IDs, SystemUI hooks, Xposed ZBridge |
| APatch | `magisk-ecosystem/APatch/` | `https://github.com/bmax121/APatch` | 6.0 MB | main | APatch module compat, apd path detection |
| MMRL | `magisk-ecosystem/MMRL/` | `https://github.com/MMRLApp/MMRL` | 65 MB | master | MMRL bridge — WebUI exec bridge for Magisk (window.mmrl.exec) |
| ZygiskNext | `magisk-ecosystem/ZygiskNext/` | `https://github.com/Dr-TSNG/ZygiskNext` | 236 KB | copyright | ZygiskNext module reference |
| ReZygisk | `magisk-ecosystem/ReZygisk/` | `https://github.com/PerformanC/ReZygisk` | 1.8 MB | main | ReZygisk module reference |
| zygisk-module-sample | `magisk-ecosystem/zygisk-module-sample/` | `https://github.com/topjohnwu/zygisk-module-sample` | 424 KB | master | Official zygisk module sample from topjohnwu |
| Vector | `magisk-ecosystem/Vector/` | `https://github.com/JingMatrix/Vector` | 6.2 MB | master | Vector module — Magisk/Zygisk integration |
| awesome-android-root | `magisk-ecosystem/awesome-android-root/` | `https://github.com/awesome-android-root/awesome-android-root` | 18 MB | main | Curated list of Magisk modules, root tools, Xposed framework |

### Key Integration Points

| Integration | File | Bridge API |
|:------------|:-----|:----------|
| Magisk WebUI | `webroot/index.html` | `window.mmrl.exec()` via MMRL |
| KernelSU WebUI | `webroot/index.html` | `window.__ksuExec()` via KernelSU bridge |
| Magisk Module | `module.prop` | `id=`, `version=`, `versionCode=`, `updateJson=` |
| KSU Module | `module.json` | JSON descriptor for KernelSU |
| APatch Module | `module.prop` | `apd_module_compat=true` flag |

---

## [04] LINUX THEMES

> [!NOTE]
> These repositories provide themes, color palettes, Plymouth boot themes, Hyprland configs, Waybar/eww widgets, and Rofi launcher skins for the Arch host desktop.

### 🎨 Cyberpunk-Neon — Full Desktop Stack

| Field | Value |
|:------|:------|
| Path | `06-UI-THEMES-ANIMATIONS/themes/Cyberpunk-Neon/` |
| Remote | `https://github.com/Roboron3042/Cyberpunk-Neon` |
| Author | Roboron3042 |
| Size | **24 MB** |
| Branch | `master` |
| Covers | KDE Plasma · GTK · icon theme · Sway · Waybar · Rofi · Mako · Alacritty · Kitty · Konsole · Tilix · Termux · iTerm2 · Vim · Telegram · Fedilab · Firefox · Discord CSS · Zim |

Most comprehensive cross-platform cyberpunk theme in the workspace. References the CP2077 game UI aesthetic (Night City / outrun).

---

### 🎨 K-DE-Cyberpunk-Neon — KDE Plasma Focus

| Field | Value |
|:------|:------|
| Path | `06-UI-THEMES-ANIMATIONS/themes/K-DE-Cyberpunk-Neon/` |
| Remote | `https://github.com/UtkarshKunwar/K-DE-Cyberpunk-Neon` |
| Author | UtkarshKunwar |
| Size | **26 MB** |
| Branch | `master` |
| Covers | KDE Plasma · Konsole · Neovim · Glava · **Plymouth boot theme** · Slack · Chrome |

KDE-specific fork. Notable for the **Plymouth boot theme** — directly applicable to Arch host's boot splash via `plymouth-set-default-theme`.

---

### 🎨 cyber-hyprland-theme — Hyprland Compositor

| Field | Value |
|:------|:------|
| Path | `06-UI-THEMES-ANIMATIONS/themes/cyber-hyprland-theme/` |
| Remote | `https://github.com/taylor85345/cyber-hyprland-theme` |
| Author | taylor85345 |
| Size | **126 MB** |
| Branch | `master` |
| Covers | Hyprland · eww widgets · Rofi launcher · foot terminal |

Cyberpunk-aesthetic Hyprland compositor theme. References cybrland for potential merge.

---

### 🎨 cybrland — Arch Hyprland Dotfiles

| Field | Value |
|:------|:------|
| Path | `06-UI-THEMES-ANIMATIONS/themes/cybrland/` |
| Remote | `https://github.com/scherrer-txt/cybrland` |
| Author | scherrer-txt |
| Size | **352 KB** |
| Branch | `main` |
| Covers | Hyprland >= v0.53.1 · Waybar · Rofi · swaync · Kitty · Nvim · Fish · Starship · Fastfetch · Btop · Cava · Yazi · GTK · Firefox · Obsidian · Newsboat |

Complete cyberpunk Arch Hyprland dotfiles. Game-UI-inspired design (CP2077, Deus Ex). **Most complete Arch dotfile suite in the workspace.** Potential merge candidate with `cyber-hyprland-theme`.

---

### 🎨 cybrcolors — Color Palette & Design Tokens

| Field | Value |
|:------|:------|
| Path | `06-UI-THEMES-ANIMATIONS/themes/cybrcolors/` |
| Remote | `https://github.com/scherrer-txt/cybrcolors` |
| Author | scherrer-txt |
| Size | **30 MB** |
| Branch | `main` |
| Covers | Color palette · design token system · terminal color schemes |

Cyberpunk-inspired **color palette and design token system**. Companion to cybrland. Contains palette assets exported as: `#FCEE0C` (yellow), `#00FFFF` (cyan), `#FF003C` (red), `#00FF9F` (green), `#FF6B35` (orange).

---

### 🎨 cyberpunk-technotronic-icon-theme — SVG Icon Pack

| Field | Value |
|:------|:------|
| Path | `06-UI-THEMES-ANIMATIONS/themes/cyberpunk-technotronic-icon-theme/` |
| Remote | `https://github.com/dreifacherspass/cyberpunk-technotronic-icon-theme` |
| Author | dreifacherspass |
| Size | **50 MB** |
| Branch | `main` |
| Covers | SVG icons · 16px raster · actions · apps · devices · emblems · status · mimetypes |

Blue-purple gradient full icon theme. SVG-based with 16px raster variants. **~20 broken SVG symlinks removed locally** — falls back to system theme for missing entries.

---

### 📦 Additional Theme Repos

| Repo | Path | Remote | Size | Branch | Covers |
|:-----|:-----|:-------|-----:|:------|:-------|
| catppuccin | `repos/catppuccin/` | `https://github.com/catppuccin/catppuccin` | 24 MB | main | Modular color palette (Porcelain/Mocha/Frappe/Latte) — reference for theme architecture |
| hyprdots | `repos/hyprdots/` | `https://github.com/prasanthrangan/hyprdots` | 206 MB | main | Hyprland dotfiles with preset themes, auto-tiling, shared assets |
| dotfiles | `repos/dotfiles/` | `https://github.com/gh0stzk/dotfiles` | 150 MB | master | Comprehensive rice-ready dotfiles (Hyprland, Qtile, Awesome, XMonad, Sway) |
| mechabar | `repos/mechabar/` | `https://github.com/sejjy/mechabar` | 616 KB | main | Lightweight status bar / panel for Hyprland |
| diinki-retrofuture | `repos/diinki-retrofuture/` | `https://github.com/diinki/diinki-retrofuture` | 275 MB | main | Futuristic GTK/Qt theme with cyberpunk leanings |

---

## [05] DEVICE & KERNEL SOURCES

> [!WARNING]
> Kernel sources are large (800 MB - 1.4 GB). Cloned with `--depth 1` where noted.

### 📱 Device Configurations — OnePlus 7 Pro / SM8150

| Repo | Path | Remote | Size | Branch | Purpose |
|:-----|:-----|:-------|-----:|:------|:--------|
| device_oneplus_guacamole | `oneplus-7-pro/device_oneplus_guacamole/` | `https://github.com/DerpFest-Devices/device_oneplus_guacamole` | 812 KB | 15 | Device tree for OP7 Pro (DerpFest) |
| device_oneplus_sm8150-common | `oneplus-7-pro/device_oneplus_sm8150-common/` | `https://github.com/DerpFest-Devices/device_oneplus_sm8150-common` | 2.1 MB | 15 | Common SM8150 device tree |
| evolution-x-device-guacamole | `oneplus-7-pro/evolution-x-device-guacamole/` | `https://github.com/Evolution-X-Devices/device_oneplus_guacamole` | 868 KB | bka | Evolution-X device config |
| android_kernel_oneplus_sm8150 | `oneplus-7-pro/android_kernel_oneplus_sm8150/` | `https://github.com/crdroidandroid/android_kernel_oneplus_sm8150` | 818 MB | 16.0 | CRDroid kernel source |
| kernel_oneplus_sm8150 | `oneplus-7-pro/kernel_oneplus_sm8150/` | `https://github.com/DerpFest-Devices/kernel_oneplus_sm8150` | 807 MB | 15 | DerpFest kernel source |

### ⚙️ Custom Kernels — OnePlus 7 Series

| Repo | Path | Remote | Size | Branch | Purpose |
|:-----|:-----|:-------|-----:|:------|:--------|
| blu-spark-kernel-op7 | `kernel/blu-spark-kernel-op7/` | `https://github.com/engstk/op7` | **1.3 GB** | blu_spark-11 | blu_spark custom kernel — CAF-based, optimized for performance and battery |
| neptune-kernel-sm8150 | `kernel/neptune-kernel-sm8150/` | `https://github.com/0wnerDied/Neptune_kernel_sm8150_oneplus` | **1.4 GB** | U-Ice | Neptune kernel — CLO tag `LA.UM.9.1.r1-15500-SMxxx0.QSSI14.0` |
| kernelsu-lineageos-guacamole | `kernel/kernelsu-lineageos-guacamole/` | `https://github.com/surfaceocean/kernelsu_oneplus_7_pro_lineageos_guacamole` | 312 KB | main | Working KernelSU build for OP7 Pro (guacamole) on LineageOS |

---

### 📦 Recovery Images

| Repo | Path | Remote | Size | Branch | Purpose |
|:-----|:-----|:-------|-----:|:------|:--------|
| android_device_oneplus_guacamole-pbrp | `android-roms/android_device_oneplus_guacamole-pbrp/` | `https://github.com/PitchBlackRecoveryProject/android_device_oneplus_guacamole-pbrp` | 63 MB | android-9.0 | PitchBlack Recovery Project device tree |
| android_device_oneplus_guacamole_unified_TWRP | `android-roms/android_device_oneplus_guacamole_unified_TWRP/` | `https://github.com/mauronofrio/android_device_oneplus_guacamole_unified_TWRP` | 64 MB | android-9.0 | Unified TWRP device tree |

---

## [06] WALLPAPERS

### 🖼️ cybrpapers — Public Domain Cyberpunk Wallpapers

| Field | Value |
|:------|:------|
| Path | `06-UI-THEMES-ANIMATIONS/wallpapers/cybrpapers/` |
| Remote | `https://github.com/scherrer-txt/cybrpapers` |
| Author | Kevin Scherrer (scherrer-txt) |
| Size | **1.8 GB** |
| Branch | `main` |
| License | CC0 1.0 Universal (Public Domain) |
| Contents | 9 hand-crafted wallpapers in cyberpunk UI design language and color palette |

Not affiliated with CD PROJEKT RED. All content is original.

---

### 🖼️ Cyberpunk-Wallpapers — Local Collection

| Field | Value |
|:------|:------|
| Path | `06-UI-THEMES-ANIMATIONS/wallpapers/Cyberpunk-Wallpapers/` |
| Remote | local (no upstream) |
| Contents | AI-generated and curated cyberpunk wallpapers (JPEG/PNG/WebP) |

Includes GRUB splash (`grub-cyberpunk-2077.png`).

---

## [07] ANDROID UI / ICON PACKS

### 📦 AndroidCyberpankIcons

| Field | Value |
|:------|:------|
| Path | `01-DEVELOPMENT/repos/cyberpunk/AndroidCyberpankIcons/` |
| Remote | `https://github.com/privatgt/AndroidCyberpankIcons` |
| Author | privatgt |
| Size | **105 MB** |
| Branch | `main` |
| Contents | Android icon pack + charging animation for OnePlus 8T Cyberpunk 2077 Limited Edition |
| Build | Gradle-based Android project |

---

## [08] FULL REPOSITORY TABLE

| # | Name | Path | Remote | Size | Branch | Sync Status |
|:--|:-----|:-----|:-------|-----:|:------|:------------|
| 1 | CP2077-OP7Pro | `cyberpunk/CP2077-OP7Pro/` | local | 3.1 GB | master | Local dev |
| 2 | CP2077-OP7Pro-Ultimate | `cyberpunk/CP2077-OP7Pro-Ultimate/` | local | — | master | Local dev |
| 3 | CP2077-Universal | `cyberpunk/CP2077-Universal/` | local | — | — | Local dev |
| 4 | ONEPLUS9-OOS13-BootAnimation | `cyberpunk/ONEPLUS9-OOS13-BootAnimation/` | sodasoba1 | 345 MB | main | Upstream ref |
| 5 | AndroidCyberpankIcons | `cyberpunk/AndroidCyberpankIcons/` | privatgt | 105 MB | main | Upstream ref |
| 6 | GlitchedCyberBoot | `cyberpunk/GlitchedCyberBoot/` | Magisk-Modules-Alt-Repo | — | main | Upstream ref |
| 7 | CyberPunk-2077-OOS13-Modded | `03-BUILD/.../CyberPunk-2077-OOS13-Modded/` | sodasoba1 | 132 MB | main | Upstream ref |
| 8 | Magisk-Module-Cyberpunk-POCO | `03-BUILD/.../Magisk-Module-Cyberpunk-POCO/` | ENEIZEM | 203 MB | main | Upstream ref |
| 9 | Magisk | `magisk-ecosystem/Magisk/` | topjohnwu | 9.7 MB | master | Reference |
| 10 | KernelSU | `magisk-ecosystem/KernelSU/` |iann/KernelSU | 14 MB | main | Reference |
| 11 | LSPosed | `magisk-ecosystem/LSPosed/` | LSPosed | 6.2 MB | master | Reference |
| 12 | APatch | `magisk-ecosystem/APatch/` | bmax121 | 6.0 MB | main | Reference |
| 13 | MMRL | `magisk-ecosystem/MMRL/` | MMRLApp | 65 MB | master | Reference |
| 14 | ZygiskNext | `magisk-ecosystem/ZygiskNext/` | Dr-TSNG | 236 KB | copyright | Reference |
| 15 | ReZygisk | `magisk-ecosystem/ReZygisk/` | PerformanC | 1.8 MB | main | Reference |
| 16 | zygisk-module-sample | `magisk-ecosystem/zygisk-module-sample/` | topjohnwu | 424 KB | master | Reference |
| 17 | Vector | `magisk-ecosystem/Vector/` | JingMatrix | 6.2 MB | master | Reference |
| 18 | awesome-android-root | `magisk-ecosystem/awesome-android-root/` | awesome-android-root | 18 MB | main | Reference |
| 19 | Cyberpunk-Neon | `themes/Cyberpunk-Neon/` | Roboron3042 | 24 MB | master | Theme |
| 20 | K-DE-Cyberpunk-Neon | `themes/K-DE-Cyberpunk-Neon/` | UtkarshKunwar | 26 MB | master | Theme |
| 21 | cyber-hyprland-theme | `themes/cyber-hyprland-theme/` | taylor85345 | 126 MB | master | Theme |
| 22 | cybrland | `themes/cybrland/` | scherrer-txt | 352 KB | main | Theme |
| 23 | cybrcolors | `themes/cybrcolors/` | scherrer-txt | 30 MB | main | Theme |
| 24 | cyberpunk-technotronic-icon-theme | `themes/cyberpunk-technotronic-icon-theme/` | dreifacherspass | 50 MB | main | Theme |
| 25 | catppuccin | `repos/catppuccin/` | catppuccin | 24 MB | main | Theme ref |
| 26 | hyprdots | `repos/hyprdots/` | prasanthrangan | 206 MB | main | Theme |
| 27 | dotfiles | `repos/dotfiles/` | gh0stzk | 150 MB | master | Theme |
| 28 | mechabar | `repos/mechabar/` | sejjy | 616 KB | main | Theme |
| 29 | diinki-retrofuture | `repos/diinki-retrofuture/` | diinki | 275 MB | main | Theme |
| 30 | rofi | `repos/rofi/` | adi1090x | 77 MB | master | Tool |
| 31 | plymouth-themes | `repos/plymouth-themes/` | adi1090x | 543 MB | master | Theme |
| 32 | proxzima-plymouth | `repos/proxzima-plymouth/` | PROxZIMA | 114 MB | master | Theme |
| 33 | HyprPanel | `repos/HyprPanel/` | Jas-SinghFSU | 42 MB | master | Tool |
| 34 | TokyoNight-rofi-theme | `repos/Tokyonight-rofi-theme/` | w8ste | 212 KB | main | Theme |
| 35 | dots | `repos/dots/` | 1amSimp1e | — | HEAD | Theme |
| 36 | blu-spark-kernel-op7 | `kernel/blu-spark-kernel-op7/` | engstk | 1.3 GB | blu_spark-11 | Kernel |
| 37 | neptune-kernel-sm8150 | `kernel/neptune-kernel-sm8150/` | 0wnerDied | 1.4 GB | U-Ice | Kernel |
| 38 | kernelsu-lineageos-guacamole | `kernel/kernelsu-lineageos-guacamole/` | surfaceocean | 312 KB | main | Kernel |
| 39 | cybrpapers | `wallpapers/cybrpapers/` | scherrer-txt | 1.8 GB | main | Wallpaper |

---

## DOCUMENT METADATA

| Field | Value |
|:------|:------|
| File | `09-DOCS/REPOS.md` |
| Version | v3.2.0 |
| Updated | 2026-05-13 |
| Total Repositories | **39** |
| Total Size (approx) | ~14 GB |
| Owner | @lchtangen |
| Repository | `cyberpunk-2077/workspace` |

---

<div align="center">

The road to Night City is paved with commits.

Document: 09-DOCS/REPOS.md - v3.2.0 - 2026-05-13

</div>