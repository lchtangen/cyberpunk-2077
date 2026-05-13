# Repository Catalogue

All git repos cloned in this workspace as of 2026-05-13.  
Full manifest with paths and remotes: [`../99-MANIFESTS/git-repositories.txt`](../99-MANIFESTS/git-repositories.txt)

---

## Primary — Magisk Modules (local dev)

### CP2077-OP7Pro — Full Edition
- **Path:** `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/`
- **Remote:** local (no upstream)
- **Version:** v3.0.0
- **Description:** Main development repo. Cyberpunk 2077 Full Edition Magisk module for OnePlus 7 Pro. Includes 4 boot animation variants at 1440×3120, matching shutdown animations, CP2077 audio pack, splash assets, and config-file-driven variant selection. Multi-path mount for AOSP/LineageOS/OOS.

### CP2077-OP7Pro-Ultimate
- **Path:** `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro-Ultimate/`
- **Remote:** local (no upstream)
- **Version:** v3.0.0
- **Description:** All-in-one variant of the Full Edition including live wallpaper APKs and extended config tooling.

---

## Upstream Reference — Bootanimation Modules

### GlitchedCyberBoot
- **Path:** `01-DEVELOPMENT/repos/cyberpunk/GlitchedCyberBoot/`
- **Remote:** `https://github.com/Magisk-Modules-Alt-Repo/GlitchedCyberBoot`
- **Author:** Magisk-Modules-Alt-Repo
- **Description:** Glitch-effect Cyberpunk 2077 boot animation Magisk module. Uses `my_product/media/bootanimation/` path for OOS 13 compatibility. Reference for OOS path format and animation packaging.

### ONEPLUS9-OOS13-BootAnimation
- **Path:** `01-DEVELOPMENT/repos/cyberpunk/ONEPLUS9-OOS13-BootAnimation/`
- **Remote:** `https://github.com/sodasoba1/ONEPLUS9-OOS13-BootAnimation`
- **Author:** sodasoba1
- **Description:** Higher-resolution CP2077 boot animations from the OnePlus 9 OOS 13 port. Contains source frames used as reference for the OP7 Pro port. Note: native OP9 resolution, not 1440×3120.

### CyberPunk-2077-OOS13-Modded-Boot-and-Shutdown-Animation
- **Path:** `03-BUILD/artifacts/cyberpunk-build/CyberPunk-2077-OOS13-Modded-Boot-and-Shutdown-Animation/`
- **Remote:** `https://github.com/sodasoba1/CyberPunk-2077-OOS13-Modded-Boot-and-Shutdown-Animation`
- **Author:** sodasoba1
- **Description:** Modified Cyberpunk 2077 boot + shutdown animation for OxygenOS 13. Glitch-effect color-matching shutdown animation. Primary upstream source for the glitch variant in CP2077-OP7Pro.

### Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO
- **Path:** `03-BUILD/artifacts/cyberpunk-build/Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO/`
- **Remote:** `https://github.com/ENEIZEM/Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO`
- **Author:** ENEIZEM
- **Description:** Cyberpunk 2077 Magisk module adapted for POCO devices. Includes optional splash screen. Reference for splash screen implementation and generic-device compatibility.

---

## Android UI / Icon Packs

### AndroidCyberpankIcons
- **Path:** `01-DEVELOPMENT/repos/cyberpunk/AndroidCyberpankIcons/`
- **Remote:** `https://github.com/privatgt/AndroidCyberpankIcons`
- **Author:** privatgt
- **Description:** Android icon pack and charging animation directly inspired by the OnePlus 8T Cyberpunk 2077 Limited Edition. Includes xxxhdpi icons, charging animations, and launcher integration. Build with Gradle.

---

## Linux Themes

### Cyberpunk-Neon
- **Path:** `06-UI-THEMES-ANIMATIONS/themes/Cyberpunk-Neon/`
- **Remote:** `https://github.com/Roboron3042/Cyberpunk-Neon`
- **Author:** Roboron3042
- **Covers:** KDE Plasma colors, GTK theme, icon theme, Sway, Waybar, Rofi, Mako, terminal themes (Alacritty, Kitty, Konsole, Tilix, Termux, iTerm2), Vim, Telegram, Fedilab, Firefox, Discord CSS, Zim
- **Description:** Comprehensive cyberpunk/outrun color scheme for the full Linux desktop stack. Most complete cross-platform theme in the workspace.

### K-DE-Cyberpunk-Neon
- **Path:** `06-UI-THEMES-ANIMATIONS/themes/K-DE-Cyberpunk-Neon/`
- **Remote:** `https://github.com/UtkarshKunwar/K-DE-Cyberpunk-Neon`
- **Author:** UtkarshKunwar
- **Covers:** KDE Plasma, Konsole, Neovim, Glava, Plymouth boot theme, Slack, Chrome
- **Description:** KDE-specific fork of Cyberpunk Neon. Notable for the Plymouth boot theme — directly applicable to the Arch host's boot splash.

### cyber-hyprland-theme
- **Path:** `06-UI-THEMES-ANIMATIONS/themes/cyber-hyprland-theme/`
- **Remote:** `https://github.com/taylor85345/cyber-hyprland-theme`
- **Author:** taylor85345
- **Covers:** Hyprland, eww widgets, Rofi launcher, foot terminal
- **Description:** Cyberpunk-aesthetic Hyprland compositor theme with complete widget and launcher styling.

### cybrland
- **Path:** `06-UI-THEMES-ANIMATIONS/themes/cybrland/`
- **Remote:** `https://github.com/scherrer-txt/cybrland`
- **Author:** scherrer-txt
- **Covers:** Hyprland, Waybar, Rofi, swaync, Kitty, Nvim, Fish, Starship, Fastfetch, Btop, Cava, Yazi, GTK, Firefox, Obsidian, Newsboat
- **Description:** Complete cyberpunk Arch Hyprland dotfiles. Follows game-UI-inspired design philosophy (Cyberpunk 2077, Deus Ex). Requires Hyprland ≥ v0.53.1.

### cybrcolors
- **Path:** `06-UI-THEMES-ANIMATIONS/themes/cybrcolors/`
- **Remote:** `https://github.com/scherrer-txt/cybrcolors`
- **Author:** scherrer-txt
- **Description:** Cyberpunk-inspired color palette and design token system. Companion to cybrland. Contains palette assets and color definition files for use as a theme base.

### cyberpunk-technotronic-icon-theme
- **Path:** `06-UI-THEMES-ANIMATIONS/themes/cyberpunk-technotronic-icon-theme/`
- **Remote:** `https://github.com/dreifacherspass/cyberpunk-technotronic-icon-theme`
- **Author:** dreifacherspass
- **Description:** Blue-purple gradient full icon theme. SVG-based with 16px raster variants. Covers actions, apps, devices, emblems, status, mimetypes, and panel icons.

---

## Wallpapers

### cybrpapers
- **Path:** `06-UI-THEMES-ANIMATIONS/wallpapers/cybrpapers/`
- **Remote:** `https://github.com/scherrer-txt/cybrpapers`
- **Author:** scherrer-txt (Kevin Scherrer)
- **License:** CC0 1.0 Universal (Public Domain)
- **Description:** 9 hand-crafted wallpapers in the cyberpunk UI design language and color palette. Not affiliated with CD PROJEKT RED.

### Cyberpunk-Wallpapers *(local)*
- **Path:** `06-UI-THEMES-ANIMATIONS/wallpapers/Cyberpunk-Wallpapers/`
- **Remote:** local (no upstream)
- **Description:** AI-generated and curated cyberpunk wallpapers. JPEG/PNG/WebP. Includes GRUB splash (`grub-cyberpunk-2077.png`).

---

## Kernels — OnePlus 7 Pro / SM8150

### blu-spark-kernel-op7
- **Path:** `07-KERNEL-PACKAGE-MODULES/kernel/blu-spark-kernel-op7/`
- **Remote:** `https://github.com/engstk/op7`
- **Author:** engstk (XDA)
- **Clone:** `--depth 1` (~117 MB)
- **Description:** blu_spark custom kernel for OnePlus 7/7T/7 Pro. CAF-based, optimized for performance and battery. Supports AOSP, LineageOS, OOS. Well-maintained with active XDA thread.

### neptune-kernel-sm8150
- **Path:** `07-KERNEL-PACKAGE-MODULES/kernel/neptune-kernel-sm8150/`
- **Remote:** `https://github.com/0wnerDied/Neptune_kernel_sm8150_oneplus`
- **Author:** 0wnerDied
- **Clone:** `--depth 1` (~111 MB)
- **Description:** Neptune kernel for OnePlus 7/7T/Pro series. Updated to CLO tag `LA.UM.9.1.r1-15500-SMxxx0.QSSI14.0`. CAF + linux-stable base.

### kernelsu-lineageos-guacamole
- **Path:** `07-KERNEL-PACKAGE-MODULES/kernel/kernelsu-lineageos-guacamole/`
- **Remote:** `https://github.com/surfaceocean/kernelsu_oneplus_7_pro_lineageos_guacamole`
- **Author:** surfaceocean
- **Clone:** `--depth 1` (~312 KB — pre-built releases only)
- **Description:** Working KernelSU build for OP7 Pro (guacamole) on LineageOS. Non-GKI kernel; KernelSU v0.9.5 is the last supported version. Requires full LineageOS flash (not just kernel swap — Wi-Fi/sound break if only kernel is swapped).

### oneplus-7-pro-lineage-kernel-sm8150 *(existing)*
- **Path:** `07-KERNEL-PACKAGE-MODULES/kernel/oneplus-7-pro-lineage-kernel-sm8150/`
- **Remote:** LineageOS upstream
- **Description:** Official LineageOS kernel for SM8150 (OP7 Pro / OP7T / OP7T Pro).
