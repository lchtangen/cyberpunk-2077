<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░▒▓  BUILD GUIDE — CYBERPUNK 2077 MAGISK MODULE  ▓▒░                  ║
║  ────────────────────────────────────────────────────────────────────── ║
║  Rebuild · Modify · Repackage from Source                               ║
╚══════════════════════════════════════════════════════════════════════════╝
```

[![Python](https://img.shields.io/badge/Python-3.8+-00ff9f?style=for-the-badge&logo=python&logoColor=black&labelColor=0a0a0a)](.)
[![Platform](https://img.shields.io/badge/Platform-Arch_Linux-1793d1?style=for-the-badge&logo=archlinux&logoColor=white&labelColor=0a0a0a)](.)
[![Build](https://img.shields.io/badge/Build-python_build.py-fcee0c?style=for-the-badge&labelColor=0a0a0a)](.)

</div>

---

## 📁 Source Tree

```
01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/
│
├── 🔊 audio/ui/                  — CP2077 .ogg sound files (7 files)
├── 🎬 bootanimation/             — Variant boot animation ZIPs
│   ├── flatline/bootanimation.zip
│   ├── glitch/bootanimation.zip
│   ├── og1080p/bootanimation.zip
│   └── reboot/bootanimation.zip
├── 💀 shutdownanimation/         — Variant shutdown animation ZIPs
│   ├── flatline/shutdownanimation.zip
│   ├── glitch/shutdownanimation.zip
│   ├── og1080p/shutdownanimation.zip
│   └── reboot/shutdownanimation.zip
├── 🖼 splash/                    — Boot splash and about-phone PNGs
├── ⚙️  META-INF/                  — Magisk installer scripts (update-binary etc.)
├── 📜 customize.sh               — Interactive variant installer
├── 📜 post-fs-data.sh            — Config-driven boot hook
├── 📜 service.sh                 — Late-start service hook
├── 📜 uninstall.sh               — Cleanup script
├── 📄 module.prop                — Module metadata
├── 🔧 build.py                   — Primary build script
└── 📦 release/                   — Output ZIPs land here
```

---

## 🛠 Prerequisites

```bash
# Arch Linux host
sudo pacman -S python zip unzip android-tools

# Verify tools
python3 --version   # 3.8+
zip --version
adb version
```

---

## 🚀 Build the Module ZIP

### Full Edition (OnePlus 7 Pro)

```bash
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro

# Build all variants (default)
python3 build.py

# Single variant — smaller ZIP
python3 build.py --variant glitch

# Skip audio pack
python3 build.py --no-audio

# All variants + audio (megapack)
python3 build.py --all
```

Output: `release/CP2077-OP7Pro-v<version>.zip`

The build script:
1. ✅ Validates all animation and audio assets exist
2. 📁 Assembles the Magisk module directory structure
3. 📦 Packages into a flashable ZIP with `zip -r`
4. 🔐 Prints SHA-256 of the output

---

### Universal Edition (all devices)

```bash
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal

# Build universal ZIP (auto-scaling pipeline)
python3 build-universal.py

# Build per-variant ZIPs separately
python3 build-universal.py --split-variants
```

Output: `release/CP2077-Universal-v<version>.zip` + 4 per-variant ZIPs

---

### Ultimate All-In-One Megapack

```bash
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro-Ultimate

python3 build-ultimate.py
```

Output: `release/CP2077-OP7Pro-Ultimate-v<version>.zip` (~277 MB)

---

## 🎬 Adding a New Animation Variant

### Step 1 — Place assets

```
bootanimation/<name>/bootanimation.zip
shutdownanimation/<name>/shutdownanimation.zip   # optional but recommended
```

### Step 2 — Verify the ZIP format

```bash
python3 -c "
import zipfile
z = zipfile.ZipFile('bootanimation/<name>/bootanimation.zip')
print('desc.txt:', z.read('desc.txt').decode())
frames = [n for n in z.namelist() if n.endswith('.png')]
print(f'Frames: {len(frames)}')
"
# desc.txt must be: "1440 3120 60" (width height fps)
```

### Step 3 — Register in customize.sh

Add the variant to:
- The selection menu `echo`
- The `install_bootanimation` function call
- The `install_shutdownanimation` function call (if shutdown is included)

```bash
# Example addition in customize.sh selection menu:
echo "[5] My New Variant   — description, Xfps"

# And in the case statement:
5) install_bootanimation "myvariant" ;;
```

### Step 4 — Rebuild

```bash
python3 build.py
```

---

## 📄 bootanimation.zip Format

```bash
bootanimation.zip
├── desc.txt          ← "1440 3120 60\np 0 0 part0\np 1 0 part1"
├── part0/            ← intro section (p 0 = play once)
│   ├── frame001.png
│   └── frame002.png
└── part1/            ← loop section (p 1 = loop forever)
    ├── frame001.png
    └── frame002.png
```

**desc.txt format:**
```
<width> <height> <fps>
p <loop_count> <pause_ms> <dir_name>
```

- `loop_count = 0` → play once
- `loop_count = 1` → loop infinitely

---

## 📄 Updating module.prop

```properties
id=CP2077_OP7Pro_Full
name=Cyberpunk 2077 Full Edition — OnePlus 7 Pro
version=v3.0.0
versionCode=300000
author=lchtangen
description=CP2077 boot/shutdown animations + UI audio for OnePlus 7 Pro
minMagisk=20400
androidApi=26
updateJson=https://raw.githubusercontent.com/lchtangen/cyberpunk-2077/main/releases/update-full.json
```

**Version code formula:** `MAJOR * 100000 + MINOR * 1000 + PATCH`

---

## 🔐 Regenerate Manifests After Build

```bash
cd /home/arch/cyberpunk-2077

# SHA-256 of all production ZIPs
sha256sum 02-PRODUCTION/magisk-modules/**/*.zip \
  > 99-MANIFESTS/production-artifact-sha256.txt

# Full file inventory
find . -type f -not -path '*/.git/*' | sort \
  | awk '{print NR"\t"$0}' > 99-MANIFESTS/artifact-inventory.tsv

# Directory tree
find . -type d -not -path '*/.git/*' | sort > 99-MANIFESTS/directory-map.txt

# Workspace size
du -sh . > 99-MANIFESTS/workspace-size.txt
```

---

## ⚙️ Installer Script Reference

### customize.sh — Interactive installer

Runs during Magisk module flash. Reads `/data/cp2077.conf` on re-installs.

```bash
# Key functions:
install_bootanimation <variant>      # copies bootanimation.zip to module dir
install_shutdownanimation <variant>  # copies shutdown + rboot animations
install_audio                        # copies all .ogg files
save_config <variant> <audio>        # writes /data/cp2077.conf
```

### post-fs-data.sh — Boot hook

Runs at `post-fs-data` stage on every boot. Reads config and applies the selected variant.

```bash
# Reads /data/cp2077.conf
# Remounts /product or /my_product as needed
# Bind-mounts animation ZIPs and audio files
```

### service.sh — Late-start hook

Runs after boot completes. Used for size-threshold remount repair (if bind-mount fails due to `/product` size limit).

---

## 🔨 Build Troubleshooting

| ❌ Error | 🔧 Fix |
|:--------|:-------|
| `FileNotFoundError: bootanimation.zip` | Check variant path — must be `bootanimation/<variant>/bootanimation.zip` |
| `Bad zip file` | Re-extract or re-download the source animation |
| `desc.txt format error` | First line must be `width height fps` (space-separated integers) |
| `Module won't flash` | Check `module.prop` format — no trailing spaces, Unix line endings |
| `customize.sh: syntax error` | Update Magisk — old busybox sh can't handle arrays |

---

## 🔗 Related Docs

| 📄 | 🔗 |
|:---|:---|
| ⚡ Flash the built module | [INSTALLATION-GUIDE.md](INSTALLATION-GUIDE.md) |
| 🎬 Variant specifications | [VARIANTS.md](VARIANTS.md) |
| 🐛 Troubleshoot install issues | [TROUBLESHOOTING.md](TROUBLESHOOTING.md) |
| 📱 ROM compatibility matrix | [DEVICE-SPECS.md](DEVICE-SPECS.md) |
