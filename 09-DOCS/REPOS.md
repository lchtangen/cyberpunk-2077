<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░▒▓  REPOSITORY CATALOGUE — CYBERPUNK 2077 WORKSPACE  ▓▒░             ║
║  ────────────────────────────────────────────────────────────────────── ║
║  17 repos · 9 cyberpunk · 5 kernels · 6 themes · 2 wallpaper           ║
║  Last updated: 2026-05-13                                               ║
╚══════════════════════════════════════════════════════════════════════════╝
```

</div>

Full manifest with paths and remotes: [`../99-MANIFESTS/git-repositories.txt`](../99-MANIFESTS/git-repositories.txt)

---

## 🟢 Primary — Magisk Modules *(local dev)*

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ PRIMARY MODULES ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### 📦 CP2077-OP7Pro — Full Edition · `ACTIVE`

| 🔷 Field | 📋 Value |
|:---------|:--------|
| 📍 **Path** | `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/` |
| 🔗 **Remote** | local (no upstream) |
| 🔢 **Version** | v3.0.0 |
| 🏷 **Status** | ✅ Active on device |

The **primary development repo**. Cyberpunk 2077 Full Edition Magisk module for OnePlus 7 Pro. 4 boot animation variants at 1440×3120, matching shutdown animations, CP2077 audio pack, splash assets, and config-file-driven variant selection. Multi-path mount for AOSP/LineageOS/OOS.

---

### 📦 CP2077-OP7Pro-Ultimate

| 🔷 Field | 📋 Value |
|:---------|:--------|
| 📍 **Path** | `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro-Ultimate/` |
| 🔗 **Remote** | local (no upstream) |
| 🔢 **Version** | v3.0.0 |
| 🏷 **Status** | 🟡 Built — disabled |

All-in-one variant with extended config tooling and live wallpaper slot. **Note:** The two bundled live wallpaper APKs (`cp2077-livewallpaper-original.apk`, `cp2077-livewallpaper-vivid.apk`) are HTML documents masquerading as APKs — quarantined. Currently disabled in favour of the lighter Full Edition.

---

### 📦 CP2077-Universal

| 🔷 Field | 📋 Value |
|:---------|:--------|
| 📍 **Path** | `01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal/` |
| 🔗 **Remote** | local (no upstream) |
| 🔢 **Version** | v1.0.0 |
| 🏷 **Status** | 🟢 Built — release ZIP published |

All-device universal build. Auto-detects resolution, ROM family (14 families), and root solution (Magisk/KernelSU/APatch) at install time. Scales animations to any resolution. Release: `release/CP2077-Universal-v1.0.0.zip` (278 MB) + 4 per-variant ZIPs.

---

## 🔵 Upstream Reference — Bootanimation Modules

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ UPSTREAM ANIMATION SOURCES ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### 📦 GlitchedCyberBoot

| 🔷 Field | 📋 Value |
|:---------|:--------|
| 📍 **Path** | `01-DEVELOPMENT/repos/cyberpunk/GlitchedCyberBoot/` |
| 🔗 **Remote** | `https://github.com/Magisk-Modules-Alt-Repo/GlitchedCyberBoot` |
| 👤 **Author** | Magisk-Modules-Alt-Repo |

Glitch-effect CP2077 boot animation Magisk module. Uses `my_product/media/bootanimation/` path for OOS 13 compatibility. **Reference for OOS path format and animation packaging.**

---

### 📦 ONEPLUS9-OOS13-BootAnimation

| 🔷 Field | 📋 Value |
|:---------|:--------|
| 📍 **Path** | `01-DEVELOPMENT/repos/cyberpunk/ONEPLUS9-OOS13-BootAnimation/` |
| 🔗 **Remote** | `https://github.com/sodasoba1/ONEPLUS9-OOS13-BootAnimation` |
| 👤 **Author** | sodasoba1 |

Higher-resolution CP2077 boot animations from the OnePlus 9 OOS 13 port. Contains source frames used as reference for the OP7 Pro port. Note: native OP9 resolution, not 1440×3120.

---

### 📦 CyberPunk-2077-OOS13-Modded-Boot-and-Shutdown-Animation

| 🔷 Field | 📋 Value |
|:---------|:--------|
| 📍 **Path** | `03-BUILD/artifacts/cyberpunk-build/CyberPunk-2077-OOS13-Modded-Boot-and-Shutdown-Animation/` |
| 🔗 **Remote** | `https://github.com/sodasoba1/CyberPunk-2077-OOS13-Modded-Boot-and-Shutdown-Animation` |
| 👤 **Author** | sodasoba1 |

Modified Cyberpunk 2077 boot + shutdown animation for OxygenOS 13. Glitch-effect color-matching shutdown animation. **Primary upstream source for the glitch variant** in CP2077-OP7Pro.

---

### 📦 Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO

| 🔷 Field | 📋 Value |
|:---------|:--------|
| 📍 **Path** | `03-BUILD/artifacts/cyberpunk-build/Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO/` |
| 🔗 **Remote** | `https://github.com/ENEIZEM/Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO` |
| 👤 **Author** | ENEIZEM |

CP2077 Magisk module adapted for POCO devices. Includes optional splash screen. Reference for splash screen implementation and generic-device compatibility.

---

## 🎨 Android UI / Icon Packs

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ ANDROID THEMES & ICONS ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### 📦 AndroidCyberpankIcons

| 🔷 Field | 📋 Value |
|:---------|:--------|
| 📍 **Path** | `01-DEVELOPMENT/repos/cyberpunk/AndroidCyberpankIcons/` |
| 🔗 **Remote** | `https://github.com/privatgt/AndroidCyberpankIcons` |
| 👤 **Author** | privatgt |

Android icon pack and charging animation directly inspired by the OnePlus 8T Cyberpunk 2077 Limited Edition. Includes xxxhdpi icons, charging animations, and launcher integration. Build with Gradle.

---

## 🖥 Linux Themes

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ LINUX THEME STACK ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### 📦 Cyberpunk-Neon

| 🔷 Field | 📋 Value |
|:---------|:--------|
| 📍 **Path** | `06-UI-THEMES-ANIMATIONS/themes/Cyberpunk-Neon/` |
| 🔗 **Remote** | `https://github.com/Roboron3042/Cyberpunk-Neon` |
| 👤 **Author** | Roboron3042 |
| 🖥 **Covers** | KDE Plasma colors · GTK theme · icon theme · Sway · Waybar · Rofi · Mako · Alacritty · Kitty · Konsole · Tilix · Termux · iTerm2 · Vim · Telegram · Fedilab · Firefox · Discord CSS · Zim |

Comprehensive cyberpunk/outrun color scheme for the **full Linux desktop stack**. Most complete cross-platform theme in the workspace.

---

### 📦 K-DE-Cyberpunk-Neon

| 🔷 Field | 📋 Value |
|:---------|:--------|
| 📍 **Path** | `06-UI-THEMES-ANIMATIONS/themes/K-DE-Cyberpunk-Neon/` |
| 🔗 **Remote** | `https://github.com/UtkarshKunwar/K-DE-Cyberpunk-Neon` |
| 👤 **Author** | UtkarshKunwar |
| 🖥 **Covers** | KDE Plasma · Konsole · Neovim · Glava · Plymouth boot theme · Slack · Chrome |

KDE-specific fork of Cyberpunk Neon. Notable for the **Plymouth boot theme** — directly applicable to the Arch host's boot splash.

---

### 📦 cyber-hyprland-theme

| 🔷 Field | 📋 Value |
|:---------|:--------|
| 📍 **Path** | `06-UI-THEMES-ANIMATIONS/themes/cyber-hyprland-theme/` |
| 🔗 **Remote** | `https://github.com/taylor85345/cyber-hyprland-theme` |
| 👤 **Author** | taylor85345 |
| 🖥 **Covers** | Hyprland · eww widgets · Rofi launcher · foot terminal |

Cyberpunk-aesthetic Hyprland compositor theme with complete widget and launcher styling.

---

### 📦 cybrland

| 🔷 Field | 📋 Value |
|:---------|:--------|
| 📍 **Path** | `06-UI-THEMES-ANIMATIONS/themes/cybrland/` |
| 🔗 **Remote** | `https://github.com/scherrer-txt/cybrland` |
| 👤 **Author** | scherrer-txt |
| 🖥 **Covers** | Hyprland ≥ v0.53.1 · Waybar · Rofi · swaync · Kitty · Nvim · Fish · Starship · Fastfetch · Btop · Cava · Yazi · GTK · Firefox · Obsidian · Newsboat |

Complete cyberpunk Arch Hyprland dotfiles. Follows game-UI-inspired design philosophy (Cyberpunk 2077, Deus Ex). **Most complete Arch dotfile suite in the workspace.**

---

### 📦 cybrcolors

| 🔷 Field | 📋 Value |
|:---------|:--------|
| 📍 **Path** | `06-UI-THEMES-ANIMATIONS/themes/cybrcolors/` |
| 🔗 **Remote** | `https://github.com/scherrer-txt/cybrcolors` |
| 👤 **Author** | scherrer-txt |

Cyberpunk-inspired **color palette and design token system**. Companion to cybrland. Contains palette assets and color definition files for use as a theme base.

---

### 📦 cyberpunk-technotronic-icon-theme

| 🔷 Field | 📋 Value |
|:---------|:--------|
| 📍 **Path** | `06-UI-THEMES-ANIMATIONS/themes/cyberpunk-technotronic-icon-theme/` |
| 🔗 **Remote** | `https://github.com/dreifacherspass/cyberpunk-technotronic-icon-theme` |
| 👤 **Author** | dreifacherspass |

Blue-purple gradient full icon theme. SVG-based with 16px raster variants. Covers actions, apps, devices, emblems, status, mimetypes, and panel icons. *(~20 broken SVG symlinks removed locally — falls back to system theme for missing entries.)*

---

## 🖼 Wallpapers

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ WALLPAPER VAULTS ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### 📦 cybrpapers

| 🔷 Field | 📋 Value |
|:---------|:--------|
| 📍 **Path** | `06-UI-THEMES-ANIMATIONS/wallpapers/cybrpapers/` |
| 🔗 **Remote** | `https://github.com/scherrer-txt/cybrpapers` |
| 👤 **Author** | scherrer-txt (Kevin Scherrer) |
| 📜 **License** | CC0 1.0 Universal (Public Domain) |

9 hand-crafted wallpapers in the cyberpunk UI design language and color palette. Not affiliated with CD PROJEKT RED.

---

### 📦 Cyberpunk-Wallpapers *(local)*

| 🔷 Field | 📋 Value |
|:---------|:--------|
| 📍 **Path** | `06-UI-THEMES-ANIMATIONS/wallpapers/Cyberpunk-Wallpapers/` |
| 🔗 **Remote** | local (no upstream) |

AI-generated and curated cyberpunk wallpapers (JPEG/PNG/WebP). Includes GRUB splash (`grub-cyberpunk-2077.png`).

---

## ⚙️ Kernels — OnePlus 7 Pro / SM8150

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ KERNEL ARSENAL ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### ⚙️ blu-spark-kernel-op7

| 🔷 Field | 📋 Value |
|:---------|:--------|
| 📍 **Path** | `07-KERNEL-PACKAGE-MODULES/kernel/blu-spark-kernel-op7/` |
| 🔗 **Remote** | `https://github.com/engstk/op7` |
| 👤 **Author** | engstk (XDA) |
| 📦 **Clone** | `--depth 1` (~117 MB) |

blu_spark custom kernel for OnePlus 7/7T/7 Pro. CAF-based, optimized for performance and battery. Supports AOSP, LineageOS, OOS. Well-maintained XDA thread.

---

### ⚙️ neptune-kernel-sm8150

| 🔷 Field | 📋 Value |
|:---------|:--------|
| 📍 **Path** | `07-KERNEL-PACKAGE-MODULES/kernel/neptune-kernel-sm8150/` |
| 🔗 **Remote** | `https://github.com/0wnerDied/Neptune_kernel_sm8150_oneplus` |
| 👤 **Author** | 0wnerDied |
| 📦 **Clone** | `--depth 1` (~111 MB) |

Neptune kernel for OnePlus 7/7T/Pro series. Updated to CLO tag `LA.UM.9.1.r1-15500-SMxxx0.QSSI14.0`. CAF + linux-stable base.

---

### ⚙️ kernelsu-lineageos-guacamole

| 🔷 Field | 📋 Value |
|:---------|:--------|
| 📍 **Path** | `07-KERNEL-PACKAGE-MODULES/kernel/kernelsu-lineageos-guacamole/` |
| 🔗 **Remote** | `https://github.com/surfaceocean/kernelsu_oneplus_7_pro_lineageos_guacamole` |
| 👤 **Author** | surfaceocean |
| 📦 **Clone** | `--depth 1` (~312 KB — pre-built releases only) |

Working KernelSU build for OP7 Pro (guacamole) on LineageOS. Non-GKI kernel; KernelSU v0.9.5 is the last supported version.

> ⚠️ Requires **full LineageOS flash** — kernel-only swap breaks Wi-Fi and audio.

---

### ⚙️ oneplus-7-pro-lineage-kernel-sm8150

| 🔷 Field | 📋 Value |
|:---------|:--------|
| 📍 **Path** | `07-KERNEL-PACKAGE-MODULES/kernel/oneplus-7-pro-lineage-kernel-sm8150/` |
| 🔗 **Remote** | LineageOS upstream |

Official LineageOS kernel for SM8150 (OP7 Pro / OP7T / OP7T Pro).

---

### ⚙️ kali-nethunter-kernel-builder

| 🔷 Field | 📋 Value |
|:---------|:--------|
| 📍 **Path** | `07-KERNEL-PACKAGE-MODULES/kernel/kali-nethunter-kernel-builder/` |
| 🔗 **Remote** | NetHunter upstream |

Kali NetHunter kernel builder with patches for wireless injection, HID support, and NetHunter-specific drivers.

---

## 📊 Repository Summary

<div align="center">

| 🏷 Category | 📦 Count | 📍 Location |
|:-----------|:--------|:-----------|
| 🟢 Local dev modules | 3 | `01-DEVELOPMENT/repos/cyberpunk/` |
| 🔵 Upstream ref modules | 4 | `01-DEVELOPMENT/repos/cyberpunk/` + `03-BUILD/` |
| 🎨 Android UI/icons | 1 | `01-DEVELOPMENT/repos/cyberpunk/` |
| 🖥 Linux themes | 6 | `06-UI-THEMES-ANIMATIONS/themes/` |
| 🖼 Wallpapers | 2 | `06-UI-THEMES-ANIMATIONS/wallpapers/` |
| ⚙️ Kernels | 5 | `07-KERNEL-PACKAGE-MODULES/kernel/` |
| 🌐 **Total** | **17** | — |

</div>
