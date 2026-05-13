# Workspace Guide

How this workspace is organized and how to navigate it efficiently.

---

## Directory Layout

```
cyberpunk-2077/
│
├── 00-CONTROL/              — Workspace control docs (policy, status)
│
├── 01-DEVELOPMENT/          — Source repos and dev trees
│   └── repos/
│       ├── cyberpunk/                          — All cyberpunk-themed repos
│       │   ├── CP2077-OP7Pro/                  — PRIMARY: Full Edition source (local)
│       │   ├── CP2077-OP7Pro-Ultimate/         — PRIMARY: Ultimate source (local)
│       │   ├── CP2077-Universal/               — Universal multi-device build
│       │   ├── GlitchedCyberBoot/              — Magisk-Modules-Alt-Repo upstream
│       │   ├── ONEPLUS9-OOS13-BootAnimation/   — sodasoba1 OP9 source animations
│       │   └── AndroidCyberpankIcons/          — OP8T Cyberpunk icon pack + charging anim
│       ├── oneplus-7-pro/   — OP7 Pro device/kernel repos
│       ├── kali-nethunter/  — NetHunter source
│       ├── android-roms/    — ROM source trees
│       └── arch-linux/      — Arch Linux config repos
│
├── 02-PRODUCTION/           — Release-ready artifacts
│   └── magisk-modules/
│       ├── CP2077-OP7Pro-release/
│       ├── CP2077-OP7Pro-Ultimate-release/
│       ├── device-beta-fix-applied/
│       └── device-copy-*.zip
│
├── 03-BUILD/                — Build workspace and raw artifacts
│   └── artifacts/cyberpunk-build/
│       ├── CyberPunk-2077-OOS13-…/   — sodasoba1 upstream module (upstream ref)
│       ├── Magisk-Module-…-POCO/     — ENEIZEM POCO module (upstream ref)
│       └── *.zip                     — Raw extracted animation ZIPs
│
├── 04-ANDROID/              — Android-side files
│   ├── apk/                 — APKs staged for device install
│   ├── arm64/               — ARM64 archives (Kali FS, etc.)
│   ├── device/sdcard-Download/ — Device /sdcard/Download snapshot
│   └── android-tools/       — ADB / fastboot tools
│
├── 05-LINUX/                — Arch host tooling and scripts
│   └── arch-host/
│       ├── device-arch-scripts/
│       ├── grub-cyberpunk-2077.png
│       ├── install-kde-wayland-minimal.sh
│       └── setup-sway-desktop.sh
│
├── 06-UI-THEMES-ANIMATIONS/ — All visual and audio assets
│   ├── animations/          — Boot and shutdown animation ZIPs (OP7 Pro native)
│   ├── themes/
│   │   ├── CP2077-splash-assets/             — Boot splash PNGs
│   │   ├── CP2077-system-audio/              — CP2077 .ogg UI sounds
│   │   ├── Cyberpunk-Neon/                   — KDE/GTK/Sway/terminal theme (Roboron3042)
│   │   ├── K-DE-Cyberpunk-Neon/              — KDE Plasma + Konsole + Plymouth (UtkarshKunwar)
│   │   ├── cyber-hyprland-theme/             — Hyprland + eww + Rofi theme (taylor85345)
│   │   ├── cybrland/                         — Arch Hyprland full dotfiles (scherrer-txt)
│   │   ├── cybrcolors/                       — Cyberpunk color palette / design tokens
│   │   └── cyberpunk-technotronic-icon-theme/ — Blue-purple gradient icon theme
│   └── wallpapers/
│       ├── Cyberpunk-Wallpapers/             — AI-generated + curated (JPEG/PNG/WebP)
│       └── cybrpapers/                       — Hand-crafted CP2077-inspired (CC0)
│
├── 07-KERNEL-PACKAGE-MODULES/ — Kernel images and sources
│   ├── kernel/
│   │   ├── boot.img                          — Stock OP7 Pro boot image
│   │   ├── magisk_patched-30700_rLeMH.img    — Magisk-patched boot image (active)
│   │   ├── oneplus-7-pro-lineage-kernel-sm8150/ — LineageOS kernel (existing)
│   │   ├── kali-nethunter-kernel-builder/    — NetHunter kernel builder
│   │   ├── blu-spark-kernel-op7/             — blu_spark kernel source (engstk, --depth 1)
│   │   ├── neptune-kernel-sm8150/            — Neptune kernel source (0wnerDied, --depth 1)
│   │   └── kernelsu-lineageos-guacamole/     — KernelSU pre-built for OP7 Pro + LineageOS
│   ├── modules/
│   └── packages/
│
├── 08-HACKING-RESEARCH/     — Security and NetHunter work
│   ├── nethunter/
│   └── security-repos/
│
├── 09-DOCS/                 — All workspace documentation  ← you are here
├── 10-QUARANTINE-invalid-downloads/ — Corrupt/invalid files (do not install)
└── 99-MANIFESTS/            — Auto-generated inventories and checksums
```

---

## Repository Inventory

### Primary (local dev — no upstream remote)

| Repo | Path |
|---|---|
| CP2077-OP7Pro Full Edition | `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/` |
| CP2077-OP7Pro Ultimate | `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro-Ultimate/` |

### Upstream Reference Modules

| Repo | Path | GitHub |
|---|---|---|
| GlitchedCyberBoot | `01-DEVELOPMENT/repos/cyberpunk/GlitchedCyberBoot/` | Magisk-Modules-Alt-Repo |
| ONEPLUS9-OOS13-BootAnimation | `01-DEVELOPMENT/repos/cyberpunk/ONEPLUS9-OOS13-BootAnimation/` | sodasoba1 |
| CyberPunk-2077-OOS13-Modded | `03-BUILD/artifacts/cyberpunk-build/CyberPunk-2077-OOS13-…/` | sodasoba1 |
| Magisk-Module-CP2077-POCO | `03-BUILD/artifacts/cyberpunk-build/Magisk-Module-…-POCO/` | ENEIZEM |

### Android UI / Icon Packs

| Repo | Path | GitHub |
|---|---|---|
| AndroidCyberpankIcons | `01-DEVELOPMENT/repos/cyberpunk/AndroidCyberpankIcons/` | privatgt |

### Linux Themes

| Repo | Path | Covers |
|---|---|---|
| Cyberpunk-Neon | `06-UI-THEMES-ANIMATIONS/themes/Cyberpunk-Neon/` | KDE, GTK, Sway, Telegram, Vim, terminal |
| K-DE-Cyberpunk-Neon | `06-UI-THEMES-ANIMATIONS/themes/K-DE-Cyberpunk-Neon/` | KDE Plasma, Konsole, Plymouth, Neovim |
| cyber-hyprland-theme | `06-UI-THEMES-ANIMATIONS/themes/cyber-hyprland-theme/` | Hyprland, eww widgets, Rofi, foot |
| cybrland | `06-UI-THEMES-ANIMATIONS/themes/cybrland/` | Full Arch dotfiles (Hyprland, Waybar, kitty, nvim…) |
| cybrcolors | `06-UI-THEMES-ANIMATIONS/themes/cybrcolors/` | Color palette / design tokens |
| cyberpunk-technotronic-icon-theme | `06-UI-THEMES-ANIMATIONS/themes/cyberpunk-technotronic-icon-theme/` | Icon theme (SVG, 16px…) |

### Wallpapers

| Repo | Path | Notes |
|---|---|---|
| cybrpapers | `06-UI-THEMES-ANIMATIONS/wallpapers/cybrpapers/` | CC0, hand-crafted |
| Cyberpunk-Wallpapers | `06-UI-THEMES-ANIMATIONS/wallpapers/Cyberpunk-Wallpapers/` | AI-gen + curated (local) |

### Kernels (OnePlus 7 Pro / SM8150)

| Repo | Path | Notes |
|---|---|---|
| blu-spark-kernel-op7 | `07-KERNEL-PACKAGE-MODULES/kernel/blu-spark-kernel-op7/` | engstk — OP7/T/Pro, --depth 1 |
| neptune-kernel-sm8150 | `07-KERNEL-PACKAGE-MODULES/kernel/neptune-kernel-sm8150/` | 0wnerDied — CAF/CLO, --depth 1 |
| kernelsu-lineageos-guacamole | `07-KERNEL-PACKAGE-MODULES/kernel/kernelsu-lineageos-guacamole/` | surfaceocean — pre-built |
| oneplus-7-pro-lineage-kernel-sm8150 | `07-KERNEL-PACKAGE-MODULES/kernel/oneplus-7-pro-lineage-kernel-sm8150/` | LineageOS — existing |

---

## Common Tasks

### Push latest module to device
```bash
cd 02-PRODUCTION/magisk-modules/CP2077-OP7Pro-release/
adb push CP2077-OP7Pro-v3.0.0.zip /sdcard/Download/
```

### Rebuild the module from source
```bash
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/
python build.py
```

### Update all cloned repos
```bash
for r in $(find . -name '.git' -not -path '*/.git/.git' | sed 's|/.git||'); do
  git -C "$r" pull --ff-only 2>&1 | grep -v '^Already'
done
```

### Check what's installed on device
```bash
adb shell su -c "ls -lh /product/media/*.zip"
adb shell su -c "cat /data/cp2077.conf"
```

### Regenerate all manifests
```bash
find . -type d -not -path '*/.git/*' -not -name '.git' | sort > 99-MANIFESTS/directory-map.txt
find . -type f -not -path '*/.git/*' | wc -l
du -sh . > 99-MANIFESTS/workspace-size.txt
```

### Verify production artifact checksums
```bash
sha256sum -c 99-MANIFESTS/production-artifact-sha256.txt
```

---

## Workspace Rules (Summary)

Full policy: [../00-CONTROL/WORKSPACE-POLICY.md](../00-CONTROL/WORKSPACE-POLICY.md)

1. Edit source only through `01-DEVELOPMENT/repos/`.
2. Place release outputs in `02-PRODUCTION/`.
3. Never install files from `10-QUARANTINE-invalid-downloads/`.
4. Regenerate `99-MANIFESTS/` after every build or new clone.
5. Update `00-CONTROL/PRODUCTION-STATUS.md` after every device flash.

---

## Documentation Index

| Document | Purpose |
|---|---|
| [INSTALLATION-GUIDE.md](INSTALLATION-GUIDE.md) | How to flash the module |
| [VARIANTS.md](VARIANTS.md) | Animation variant details and upstream sources |
| [BUILD-GUIDE.md](BUILD-GUIDE.md) | How to build and package |
| [DEVICE-SPECS.md](DEVICE-SPECS.md) | Hardware specs and compatibility |
| [TROUBLESHOOTING.md](TROUBLESHOOTING.md) | Fix common issues |
| [REPOS.md](REPOS.md) | Full repository catalogue with descriptions |
| [WORKSPACE-GUIDE.md](WORKSPACE-GUIDE.md) | This file |
| [../README.md](../README.md) | Project overview |
| [../00-CONTROL/PRODUCTION-STATUS.md](../00-CONTROL/PRODUCTION-STATUS.md) | Current device state |
| [../00-CONTROL/WORKSPACE-POLICY.md](../00-CONTROL/WORKSPACE-POLICY.md) | Rules |
| [../99-MANIFESTS/git-repositories.txt](../99-MANIFESTS/git-repositories.txt) | All cloned repos with remotes |
