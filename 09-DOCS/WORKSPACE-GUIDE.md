<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░▒▓  WORKSPACE GUIDE — CYBERPUNK 2077 WORKSPACE  ▓▒░                  ║
║  ────────────────────────────────────────────────────────────────────── ║
║  Directory Map · Repo Inventory · Common Task Commands                  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

[![Size](https://img.shields.io/badge/SIZE-17_GB_workspace-FF6B35?style=for-the-badge&labelColor=0a0a0a)](./)
[![Repos](https://img.shields.io/badge/REPOS-53_cloned-FCEE0C?style=for-the-badge&labelColor=0a0a0a)](./)
[![Policy](https://img.shields.io/badge/POLICY-WORKSPACE--POLICY.md-00FFFF?style=for-the-badge&labelColor=0a0a0a)](../00-CONTROL/WORKSPACE-POLICY.md)

</div>

---

## 🗺 Full Directory Layout

```
cyberpunk-2077/
│
├── 📋 00-CONTROL/                      ← Workspace policy, production status, audit log
│   ├── PRODUCTION-STATUS.md            ← Current device state & module inventory
│   └── WORKSPACE-POLICY.md             ← Workspace operating rules
│
├── 💻 01-DEVELOPMENT/                  ← All source repos and dev trees
│   └── repos/
│       ├── cyberpunk/                  ← PRIMARY: CP2077 module source trees
│       │   ├── CP2077-OP7Pro/          ← Full Edition source (local dev, no upstream)
│       │   ├── CP2077-OP7Pro-Ultimate/ ← Ultimate source (local dev, no upstream)
│       │   ├── CP2077-Universal/       ← Universal multi-device build (local)
│       │   ├── GlitchedCyberBoot/      ← Magisk-Modules-Alt-Repo upstream ref
│       │   ├── ONEPLUS9-OOS13-BootAnimation/ ← sodasoba1 OP9 source animations
│       │   ├── AndroidCyberpankIcons/  ← OP8T Cyberpunk icon pack + charging anim
│       │   └── CP2077-OP7Pro-build-source/  ← v1.0 legacy baseline (ref only)
│       ├── oneplus-7-pro/              ← OP7 Pro device/kernel repos
│       ├── kali-nethunter/             ← NetHunter source
│       ├── android-roms/               ← ROM source manifests (LOS, crDroid, Evo-X, Infinity-X)
│       └── arch-linux/                 ← Arch Linux config repos
│
├── 📦 02-PRODUCTION/                   ← Release-ready artifacts (symlink-based)
│   └── magisk-modules/
│       ├── CP2077-OP7Pro-release/      ← ACTIVE v3.0.0 (Full Edition)
│       ├── CP2077-OP7Pro-Ultimate-release/ ← Disabled v3.0.0 (Ultimate)
│       ├── CP2077-Universal-release/   ← v1.0.0 Universal
│       └── device-beta-fix-applied/    ← Beta fix artifact
│
├── 🔨 03-BUILD/                        ← Build workspace, upstream refs, raw assets
│   └── artifacts/cyberpunk-build/
│       ├── CyberPunk-2077-OOS13-Modded-Boot-and-Shutdown-Animation/
│       ├── Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO/
│       └── *.zip                       ← Raw extracted animation ZIPs
│
├── 🤖 04-ANDROID/                      ← Android-side files
│   ├── android-tools/                  ← ADB / fastboot binaries
│   ├── apk/                            ← APKs staged for device install
│   ├── arm64/                          ← ARM64 archives (Kali FS, etc.)
│   └── device/sdcard-Download/         ← Device /sdcard/Download snapshot
│
├── 🐧 05-LINUX/                        ← Arch host tooling and scripts
│   └── arch-host/
│       ├── device-arch-scripts/
│       ├── install-kde-wayland-minimal.sh
│       ├── setup-sway-desktop.sh
│       └── setup-sway-fixed.sh
│
├── 🎨 06-UI-THEMES-ANIMATIONS/         ← All visual and audio assets
│   ├── animations/                     ← Boot and shutdown animation ZIPs (native res)
│   │   ├── CP2077-OP7Pro-bootanimations/
│   │   ├── CP2077-OP7Pro-shutdownanimations/
│   │   └── CP2077-Universal-bootanimations/
│   ├── linux-boot-themes/              ← Plymouth and GRUB themes
│   │   └── cp2077-linux-boot/
│   ├── themes/
│   │   ├── CP2077-splash-assets/       ← Boot splash PNGs
│   │   ├── CP2077-system-audio/        ← CP2077 .ogg UI sounds
│   │   ├── Cyberpunk-Neon/             ← KDE/GTK/Sway/terminal (Roboron3042)
│   │   ├── K-DE-Cyberpunk-Neon/        ← KDE Plasma + Plymouth (UtkarshKunwar)
│   │   ├── cyber-hyprland-theme/       ← Hyprland + eww + Rofi (taylor85345)
│   │   ├── cybrland/                   ← Full Arch dotfiles (scherrer-txt)
│   │   ├── cybrcolors/                 ← Cyberpunk color palette / design tokens
│   │   └── cyberpunk-technotronic-icon-theme/ ← SVG icon theme
│   └── wallpapers/
│       ├── Cyberpunk-Wallpapers/       ← AI-generated + curated (JPEG/PNG/WebP)
│       └── cybrpapers/                 ← CC0 hand-crafted wallpapers
│
├── ⚙️  07-KERNEL-PACKAGE-MODULES/      ← Kernel images and sources
│   ├── kernel/
│   │   ├── boot.img                    ← Stock OP7 Pro boot image
│   │   ├── magisk_patched-30700_rLeMH.img ← Magisk-patched (active)
│   │   ├── oneplus-7-pro-lineage-kernel-sm8150/
│   │   ├── kali-nethunter-kernel-builder/
│   │   ├── blu-spark-kernel-op7/
│   │   ├── neptune-kernel-sm8150/
│   │   └── kernelsu-lineageos-guacamole/
│   ├── modules/
│   └── packages/
│
├── 🔐 08-HACKING-RESEARCH/             ← Security and NetHunter work
│   ├── nethunter/
│   │   └── hightech-kali-nethunter-suite/
│   └── security-repos/
│
├── 📚 09-DOCS/                         ← All workspace documentation ← YOU ARE HERE
│
├── 🚫 10-QUARANTINE-invalid-downloads/ ← Corrupt/invalid files — DO NOT INSTALL
│   ├── cp2077-livewallpaper-original.html-not-apk
│   └── cp2077-livewallpaper-vivid.html-not-apk
│
├── 📊 99-MANIFESTS/                    ← Auto-generated inventories and checksums
│   ├── artifact-inventory.tsv
│   ├── artifact-sha256.txt
│   ├── directory-map.txt
│   ├── generate-manifests.sh
│   ├── git-repositories-status.txt
│   ├── git-repositories.txt
│   ├── production-artifact-sha256.txt
│   ├── symlinks.txt
│   └── workspace-size.txt
│
└── 📦 releases/                        ← GitHub release metadata
    ├── CHANGELOG-full.md
    ├── CHANGELOG-universal.md
    ├── update-full.json
    └── update-universal.json
```

---

## 📦 Repository Inventory

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ REPO MAP ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### 🟢 Primary (local dev — no upstream)

<div align="center">

| 📦 Repo | 📍 Path |
|:--------|:-------|
| CP2077-OP7Pro Full Edition | `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/` |
| CP2077-OP7Pro Ultimate | `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro-Ultimate/` |
| CP2077-Universal | `01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal/` |

</div>

### 🔵 Upstream Reference Modules

<div align="center">

| 📦 Repo | 📍 Path | 🔗 GitHub |
|:--------|:-------|:---------|
| GlitchedCyberBoot | `01-DEVELOPMENT/repos/cyberpunk/GlitchedCyberBoot/` | Magisk-Modules-Alt-Repo |
| ONEPLUS9-OOS13-BootAnimation | `01-DEVELOPMENT/repos/cyberpunk/ONEPLUS9-OOS13-BootAnimation/` | sodasoba1 |
| CyberPunk-2077-OOS13-Modded | `03-BUILD/artifacts/cyberpunk-build/CyberPunk-2077-OOS13-…/` | sodasoba1 |
| Magisk-Module-CP2077-POCO | `03-BUILD/artifacts/cyberpunk-build/Magisk-Module-…-POCO/` | ENEIZEM |

</div>

### 🎨 Android UI / Icon Packs

<div align="center">

| 📦 Repo | 📍 Path | 🔗 GitHub |
|:--------|:-------|:---------|
| AndroidCyberpankIcons | `01-DEVELOPMENT/repos/cyberpunk/AndroidCyberpankIcons/` | privatgt |

</div>

### 🖥 Linux Themes

<div align="center">

| 📦 Repo | 📍 Path | 🎨 Covers |
|:--------|:-------|:---------|
| Cyberpunk-Neon | `06-UI-THEMES-ANIMATIONS/themes/Cyberpunk-Neon/` | KDE, GTK, Sway, Telegram, Vim, terminal |
| K-DE-Cyberpunk-Neon | `06-UI-THEMES-ANIMATIONS/themes/K-DE-Cyberpunk-Neon/` | KDE Plasma, Konsole, Plymouth, Neovim |
| cyber-hyprland-theme | `06-UI-THEMES-ANIMATIONS/themes/cyber-hyprland-theme/` | Hyprland, eww widgets, Rofi, foot |
| cybrland | `06-UI-THEMES-ANIMATIONS/themes/cybrland/` | Full Arch dotfiles (Hyprland, Waybar, Kitty, Nvim…) |
| cybrcolors | `06-UI-THEMES-ANIMATIONS/themes/cybrcolors/` | Color palette / design tokens |
| cyberpunk-technotronic-icon-theme | `06-UI-THEMES-ANIMATIONS/themes/cyberpunk-technotronic-icon-theme/` | SVG icon theme |

</div>

### 🖼 Wallpapers

<div align="center">

| 📦 Repo | 📍 Path | 📝 Notes |
|:--------|:-------|:--------|
| cybrpapers | `06-UI-THEMES-ANIMATIONS/wallpapers/cybrpapers/` | CC0, hand-crafted |
| Cyberpunk-Wallpapers | `06-UI-THEMES-ANIMATIONS/wallpapers/Cyberpunk-Wallpapers/` | AI-gen + curated (local) |

</div>

### ⚙️ Kernels (OnePlus 7 Pro / SM8150)

<div align="center">

| ⚙️ Repo | 📍 Path | 📝 Notes |
|:-------|:-------|:--------|
| blu-spark-kernel-op7 | `07-KERNEL-PACKAGE-MODULES/kernel/blu-spark-kernel-op7/` | engstk — OP7/T/Pro, `--depth 1` |
| neptune-kernel-sm8150 | `07-KERNEL-PACKAGE-MODULES/kernel/neptune-kernel-sm8150/` | 0wnerDied — CAF/CLO, `--depth 1` |
| kernelsu-lineageos-guacamole | `07-KERNEL-PACKAGE-MODULES/kernel/kernelsu-lineageos-guacamole/` | surfaceocean — pre-built only |
| oneplus-7-pro-lineage-kernel-sm8150 | `07-KERNEL-PACKAGE-MODULES/kernel/oneplus-7-pro-lineage-kernel-sm8150/` | LineageOS upstream |
| kali-nethunter-kernel-builder | `07-KERNEL-PACKAGE-MODULES/kernel/kali-nethunter-kernel-builder/` | NetHunter builder |

</div>

---

## ⚡ Common Tasks

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ NEURAL COMMAND REFERENCE ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### 📲 Push latest module to device

```bash
cd 02-PRODUCTION/magisk-modules/CP2077-OP7Pro-release/
adb push CP2077-OP7Pro-v3.0.0.zip /sdcard/Download/
# Then: Magisk → Modules → Install from storage
```

### 🔧 Rebuild the module from source

```bash
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/
python3 build.py                        # all variants
python3 build.py --variant glitch       # single variant
```

### 🔄 Update all cloned repos

```bash
for r in $(find . -name '.git' -not -path '*/.git/.git' | sed 's|/.git||'); do
  printf "\n⚡ %s\n" "$r"
  git -C "$r" pull --ff-only 2>&1 | grep -v '^Already'
done
```

### 🔍 Check what's installed on device

```bash
adb shell su -c "ls -lh /product/media/*.zip"
adb shell su -c "ls -lh /product/media/audio/ui/"
adb shell su -c "cat /data/cp2077.conf"
adb shell su -c "magisk --list"
```

### 🩺 Verify boot animation ZIP integrity

```bash
for v in glitch flatline reboot og1080p; do
  python3 -c "
import zipfile
z=zipfile.ZipFile('01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/bootanimation/$v/bootanimation.zip')
n=z.namelist()
print(f'[$v] desc={any(\"desc.txt\" in x for x in n)} frames={len([x for x in n if x.endswith(\".png\")])}')"
done
```

### 📊 Regenerate all manifests

```bash
cd /home/arch/cyberpunk-2077

sha256sum 02-PRODUCTION/magisk-modules/**/*.zip \
  > 99-MANIFESTS/production-artifact-sha256.txt

find . -type f -not -path '*/.git/*' | sort \
  | awk '{print NR"\t"$0}' > 99-MANIFESTS/artifact-inventory.tsv

find . -type d -not -path '*/.git/*' | sort > 99-MANIFESTS/directory-map.txt

du -sh . > 99-MANIFESTS/workspace-size.txt

find . -name '.git' -not -path '*/.git/.git' | sed 's|/.git||' \
  | xargs -I{} git -C {} remote -v 2>/dev/null > 99-MANIFESTS/git-repositories.txt
```

### 🔐 Verify production artifact checksums

```bash
sha256sum -c 99-MANIFESTS/production-artifact-sha256.txt
```

### 🔁 Restart boot animation on device

```bash
adb shell su -c "setprop ctl.restart bootanim"
```

### 💾 Switch variant without reflash

```bash
adb shell su -c 'echo -e "variant=flatline\naudio=yes" > /data/cp2077.conf'
adb shell su -c "setprop ctl.restart bootanim"
```

---

## 📜 Workspace Rules (Summary)

Full policy: [`../00-CONTROL/WORKSPACE-POLICY.md`](../00-CONTROL/WORKSPACE-POLICY.md)

| 📋 Rule | 📝 Detail |
|:--------|:---------|
| 1️⃣ Edit source only | Through `01-DEVELOPMENT/repos/` — never edit production symlinks directly |
| 2️⃣ Place outputs in production | `02-PRODUCTION/` for release ZIPs only |
| 3️⃣ Never install from quarantine | Files in `10-QUARANTINE/` are corrupt — do not flash |
| 4️⃣ Regenerate manifests after builds | Update `99-MANIFESTS/` after every build or new clone |
| 5️⃣ Update production status | Update `00-CONTROL/PRODUCTION-STATUS.md` after every device flash |

---

## 🔗 Documentation Index

| 📄 Document | 🔗 Link | 📝 Purpose |
|:------------|:--------|:----------|
| ⚡ Installation Guide | [INSTALLATION-GUIDE.md](INSTALLATION-GUIDE.md) | Flash the module |
| 🎬 Variants | [VARIANTS.md](VARIANTS.md) | Animation variant details and sources |
| 🔧 Build Guide | [BUILD-GUIDE.md](BUILD-GUIDE.md) | Build and package |
| 📱 Device Specs | [DEVICE-SPECS.md](DEVICE-SPECS.md) | Hardware specs and compatibility |
| 🐛 Troubleshooting | [TROUBLESHOOTING.md](TROUBLESHOOTING.md) | Fix common issues |
| 📚 Repos | [REPOS.md](REPOS.md) | Full repository catalogue |
| 🗺 Roadmap | [ROADMAP.md](ROADMAP.md) | Bugs, features, completed items |
| 🏠 README | [../README.md](../README.md) | Project overview |
| 📋 Production Status | [../00-CONTROL/PRODUCTION-STATUS.md](../00-CONTROL/PRODUCTION-STATUS.md) | Current device state |
| 📜 Workspace Policy | [../00-CONTROL/WORKSPACE-POLICY.md](../00-CONTROL/WORKSPACE-POLICY.md) | Rules |
| 🔗 Git Repositories | [../99-MANIFESTS/git-repositories.txt](../99-MANIFESTS/git-repositories.txt) | All cloned repos with remotes |
