<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░▒▓  INSTALLATION GUIDE — CYBERPUNK 2077 MAGISK MODULE  ▓▒░           ║
║  ────────────────────────────────────────────────────────────────────── ║
║  CP2077_OP7Pro_Full v3.0.0  ·  OnePlus 7 Pro (guacamole)               ║
║  Android 14–16+ (API 34–36)  ·  Magisk 20.4+ / KernelSU / APatch      ║
╚══════════════════════════════════════════════════════════════════════════╝
```

[![Module](https://img.shields.io/badge/Module-CP2077__OP7Pro__Full_v3.0.0-00ff9f?style=for-the-badge&labelColor=0a0a0a)](../00-CONTROL/PRODUCTION-STATUS.md)
[![Magisk](https://img.shields.io/badge/Magisk-20.4+-00ff9f?style=for-the-badge&labelColor=0a0a0a)](.)
[![KernelSU](https://img.shields.io/badge/KernelSU-Supported-fcee0c?style=for-the-badge&labelColor=0a0a0a)](.)
[![APatch](https://img.shields.io/badge/APatch-Supported-fcee0c?style=for-the-badge&labelColor=0a0a0a)](.)

</div>

---

## ✅ Requirements

<div align="center">

| ⚡ Requirement | 📋 Minimum | ✅ Tested |
|:--------------|:----------|:---------|
| 📱 **Device** | OnePlus 7 Pro (guacamole / GM1911) | GM1911 |
| 🤖 **Android** | 14 (API 34) | API 36 (Android 16) |
| 🔑 **Magisk** | v20.4 (20400) | v30.7 |
| 🔑 **KernelSU** | Any stable | v0.9.5+ |
| 🔑 **APatch** | Any stable | Latest |
| 🖥 **ROM** | AOSP · LineageOS · yaap · OOS 14+ | All tested |
| 💾 **Storage** | ~50 MB free on `/data` | — |

</div>

> 🌐 For **any device**: use the Universal edition — `CP2077-Universal-v1.0.0.zip`

---

## 🚀 Quick Install — Magisk

```bash
# Step 1: Push module ZIP to device
adb push \
  02-PRODUCTION/magisk-modules/CP2077-OP7Pro-release/CP2077-OP7Pro-v3.0.0.zip \
  /sdcard/Download/

# Step 2: Open Magisk → Modules → Install from storage
# Step 3: Select the ZIP file
# Step 4: Follow the interactive installer prompts
# Step 5: Reboot when prompted
```

---

## 📋 Interactive Installer Prompts

The `customize.sh` installer runs inside Magisk recovery. It reads `/data/cp2077.conf` on re-installs to pre-fill your previous selections.

### 🎬 Variant Selection

```
╔══════════════════════════════════════════════════════════╗
║  Select Boot Animation Variant                           ║
║  ──────────────────────────────────────────────────────  ║
║  [1] CyberGlitch-2077    — glitch logo, 60fps  ★ rec.  ║
║  [2] Cyberpunk-Flatline  — flatline ECG, 60fps          ║
║  [3] Re-Boot Animation   — OP logo + glitch, 60fps      ║
║  [4] Original 1080p      — 8T SE port, 30fps            ║
╚══════════════════════════════════════════════════════════╝
```

### 🔊 Audio Pack Prompt

```
╔══════════════════════════════════════════════════════════╗
║  Install CP2077 UI Sound Pack?                           ║
║  ──────────────────────────────────────────────────────  ║
║  [Y] Install CP2077 UI sounds (lock, unlock, charging,  ║
║       camera shutter, UI tick) — 7 OGG files            ║
║  [N] Keep stock device audio                            ║
╚══════════════════════════════════════════════════════════╝
```

---

## 📁 Installed File Locations

After flashing, the module bind-mounts files at:

<div align="center">

| 📄 File | 📍 Path | 📝 Notes |
|:--------|:-------|:--------|
| 🎬 Boot animation | `/product/media/bootanimation.zip` | All ROMs |
| 🎬 Boot anim (dark) | `/product/media/bootanimation-dark.zip` | All ROMs |
| 💀 Shutdown animation | `/product/media/shutdownanimation.zip` | All ROMs |
| 🔄 Reboot animation | `/product/media/rbootanimation.zip` | All ROMs |
| 🔊 UI sounds | `/product/media/audio/ui/*.ogg` | 7 files |
| 📱 OOS compat copy | `/my_product/media/` | Auto-detected |
| ⚙️ Config | `/data/cp2077.conf` | Persists across reflashes |

</div>

---

## ⚙️ Config File Reference

Config is saved to `/data/cp2077.conf` after each install:

```bash
# /data/cp2077.conf
variant=glitch   # glitch | flatline | reboot | og1080p
audio=yes        # yes | no
oos=auto         # auto | yes | no (force OOS path)
```

**Modify without reflashing:**
```bash
adb shell su -c 'echo -e "variant=flatline\naudio=yes\noos=auto" > /data/cp2077.conf'
adb shell su -c 'setprop ctl.restart bootanim'   # restart immediately
```

**Reset to interactive installer:**
```bash
adb shell su -c 'rm /data/cp2077.conf'
# Reflash the module ZIP to trigger interactive prompts again
```

---

## 🔄 Switch Variant (no reflash)

```bash
# Edit config on device
adb shell su -c 'echo -e "variant=flatline\naudio=yes" > /data/cp2077.conf'

# Restart boot animation service to apply immediately
adb shell su -c 'setprop ctl.restart bootanim'

# Or reboot the device for a full cycle
adb reboot
```

---

## 🌐 Universal Edition Install (any device)

```bash
# Push universal ZIP
adb push \
  02-PRODUCTION/magisk-modules/CP2077-Universal-release/CP2077-Universal-v1.0.0.zip \
  /sdcard/Download/

# Install via Magisk → Modules → Install from storage
# The installer auto-detects: ROM family, resolution, root solution
```

---

## 🛠 ADB Sideload (no Magisk UI / TWRP)

```bash
# Push the ZIP and install via TWRP or Magisk CLI
adb push CP2077-OP7Pro-v3.0.0.zip /sdcard/Download/
# Then use TWRP: Install → select ZIP → Swipe to install

# Or Magisk CLI (if available):
adb shell su -c 'magisk --install-module /sdcard/Download/CP2077-OP7Pro-v3.0.0.zip'
```

---

## 🔍 Verify Installation

```bash
# Check all animation files are mounted
adb shell su -c 'ls -lh /product/media/bootanimation.zip'
adb shell su -c 'ls -lh /product/media/shutdownanimation.zip'
adb shell su -c 'ls -lh /product/media/rbootanimation.zip'

# Check audio pack
adb shell su -c 'ls -lh /product/media/audio/ui/'

# Check module is active in Magisk
adb shell su -c 'magisk --list'

# Read active config
adb shell su -c 'cat /data/cp2077.conf'
```

---

## 🗑 Uninstall

```bash
# Via Magisk Manager: Modules → CP2077 Full Edition → Remove → Reboot

# The uninstall.sh script automatically cleans:
#   /data/cp2077.conf
#   All bind-mounted animation / audio files
```

---

## 🚫 Do Not Install — Quarantine List

The following files in `10-QUARANTINE-invalid-downloads/` are **corrupt**:

<div align="center">

| 🚫 File | ❌ Reason |
|:--------|:---------|
| `cp2077-livewallpaper-original.apk` | HTML document, not APK |
| `cp2077-livewallpaper-vivid.apk` | HTML document, not APK |
| `cp2077-bootanimation-stock-oos.zip` | Zero bytes — empty |
| `cp2077-bootanimation-mega.zip` | HTML document, not ZIP |

</div>

---

## 🔗 Related Docs

| 📄 | 🔗 |
|:---|:---|
| 🎬 Animation variant details | [VARIANTS.md](VARIANTS.md) |
| 🔧 Rebuild or customize | [BUILD-GUIDE.md](BUILD-GUIDE.md) |
| 🐛 Fix common issues | [TROUBLESHOOTING.md](TROUBLESHOOTING.md) |
| 📱 Device specs & ROM compat | [DEVICE-SPECS.md](DEVICE-SPECS.md) |
| 📋 Current device state | [../00-CONTROL/PRODUCTION-STATUS.md](../00-CONTROL/PRODUCTION-STATUS.md) |
