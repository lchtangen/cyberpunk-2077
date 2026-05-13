<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░▒▓  TROUBLESHOOTING — CYBERPUNK 2077 MAGISK MODULE  ▓▒░              ║
║  ────────────────────────────────────────────────────────────────────── ║
║  Diagnostics · Common Fixes · Log Collection · Known Limitations       ║
╚══════════════════════════════════════════════════════════════════════════╝
```

</div>

---

## 🎬 Boot Animation Issues

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ ANIMATION DIAGNOSTICS ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### ❌ Animation does not play — shows stock animation

**Cause:** Wrong mount path for the ROM type.

**Diagnosis:**
```bash
adb shell su -c "ls /product/media/bootanimation.zip"    # AOSP / LOS / yaap
adb shell su -c "ls /my_product/media/bootanimation.zip" # OOS 14+
adb shell su -c "magisk --list"                          # check module active
```

**Fix:**
```bash
# Force OOS path in config
adb shell su -c 'echo -e "variant=glitch\naudio=yes\noos=yes" > /data/cp2077.conf'
adb reboot

# If neither path exists — re-flash the module
# Magisk → Modules → Install from storage → select ZIP
```

---

### ❌ Animation plays once then freezes on logo

**Cause:** Corrupted `bootanimation.zip` or mismatched resolution in `desc.txt`.

**Diagnosis:**
```bash
adb pull /product/media/bootanimation.zip /tmp/active.zip
python3 -c "
import zipfile
z = zipfile.ZipFile('/tmp/active.zip')
print(z.read('desc.txt').decode())   # must be '1440 3120 60'
frames = [n for n in z.namelist() if n.endswith('.png')]
print(f'Frames: {len(frames)}')
"
```

**Fix:** Re-flash from a known-good source in `06-UI-THEMES-ANIMATIONS/animations/`.

---

### ❌ Shutdown animation missing

**Cause:** Selected variant has no shutdown file, or wrong variant key.

**Diagnosis:**
```bash
adb shell su -c "ls -lh /product/media/shutdownanimation.zip"
adb shell su -c "cat /data/cp2077.conf"
```

**Fix:**
```bash
# Switch to a variant with shutdown animation
adb shell su -c 'echo "variant=glitch" > /data/cp2077.conf'
# Then reflash the module ZIP via Magisk
```

> ✅ **glitch**, **flatline**, and **reboot** all include shutdown animations.

---

### ❌ Animation is blurry / wrong resolution

**Cause:** Wrong variant — og1080p displays at 1080p on a 1440p screen.

**Fix:** Switch to `glitch`, `flatline`, or `reboot` variant (native 1440×3120 · 60fps).

---

## 🔊 Audio Issues

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ AUDIO DIAGNOSTICS ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### ❌ CP2077 sounds not playing

**Cause:** Audio files not mounted to both `/product/media/audio/ui/` and `/media/audio/ui/`.

**Diagnosis:**
```bash
adb shell su -c "ls -lh /product/media/audio/ui/"
adb shell su -c "ls -lh /media/audio/ui/"
adb shell su -c "cat /data/cp2077.conf"  # check audio=yes
```

**Fix:**
```bash
# Enable audio in config and reflash
adb shell su -c 'echo -e "variant=glitch\naudio=yes" > /data/cp2077.conf'
# Reflash via Magisk → Modules → Install
```

---

### ❌ Charging sound plays twice

**Cause:** Both `ChargingStarted.ogg` and `WirelessChargingStarted.ogg` are mounted; some OOS builds play both on wired connect.

**Fix (OOS only):**
```bash
adb shell su -c "rm /product/media/audio/ui/WirelessChargingStarted.ogg"
```

---

## 📦 Module Install Issues

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ MODULE INSTALL DIAGNOSTICS ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### ❌ "Installation failed" in Magisk

**Checklist:**
```bash
# 1. Check Magisk version (must be ≥ 20.4)
adb shell su -c "magisk -v"

# 2. Check Android API (must be ≥ 26)
adb shell getprop ro.build.version.sdk

# 3. Check device model
adb shell getprop ro.product.model   # must be "OnePlus 7 Pro"
adb shell getprop ro.product.device  # must be "guacamole"

# 4. Check available storage
adb shell df /data                   # needs ~50 MB free

# 5. Check ZIP integrity
python3 -m zipfile -t CP2077-OP7Pro-v3.0.0.zip
```

---

### ❌ `customize.sh: syntax error`

**Cause:** Magisk is running an old busybox shell.

**Fix:** Update Magisk to the latest stable release via the Magisk app.

---

### ❌ Module installs but files not mounted

**Cause:** `/product` partition size limit — Magisk can't overlay if `product` is full.

**Diagnosis:**
```bash
adb shell su -c "df /product"
adb shell su -c "magisk --list"
```

**Fix:** The `service.sh` script handles this via late-start remount. If still failing, check `logcat` for `magisk` errors.

---

## 🔌 ADB / Connection Issues

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ ADB DIAGNOSTICS ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### ❌ `adb push` fails — permission denied

```bash
adb shell su -c "chmod 777 /sdcard/Download"
adb push CP2077-OP7Pro-v3.0.0.zip /sdcard/Download/
```

### ❌ Device not detected

```bash
adb kill-server && adb start-server
adb devices

# If still empty:
# 1. Enable Developer Options: Settings → About → tap Build Number 7×
# 2. Enable USB Debugging: Settings → Developer Options → USB Debugging
# 3. Accept RSA fingerprint prompt on device
# 4. Try different USB cable or port
```

### ❌ `adb: unauthorized`

```bash
# Revoke and re-authorize ADB on device
adb shell settings put global adb_enabled 0
adb shell settings put global adb_enabled 1
# Then accept the fingerprint dialog on device
```

---

## ⚙️ Config File Reference

```
Location: /data/cp2077.conf

variant=glitch        # glitch | flatline | reboot | og1080p
audio=yes             # yes | no
oos=auto              # auto | yes | no
```

**Reset to defaults (interactive installer):**
```bash
adb shell su -c 'rm /data/cp2077.conf'
# Reflash the ZIP — installer will prompt for selections
```

---

## 🔍 Full Diagnostic Suite

```bash
# ── System Info ──────────────────────────────────────────────────────
adb shell getprop ro.product.device
adb shell getprop ro.build.version.sdk
adb shell getprop ro.build.version.release

# ── Module State ─────────────────────────────────────────────────────
adb shell su -c "magisk --list"
adb shell su -c "magisk -v && magisk -V"
adb shell su -c "cat /data/cp2077.conf"

# ── File Mount Checks ────────────────────────────────────────────────
adb shell su -c "ls -lh /product/media/bootanimation.zip"
adb shell su -c "ls -lh /product/media/shutdownanimation.zip"
adb shell su -c "ls -lh /product/media/rbootanimation.zip"
adb shell su -c "ls -lh /product/media/audio/ui/"
adb shell su -c "ls -lh /my_product/media/bootanimation.zip"
adb shell su -c "ls -lh /data/misc/bootanim/bootanimation.zip"

# ── Storage ──────────────────────────────────────────────────────────
adb shell df /product
adb shell df /data
```

---

## 📋 Log Collection

```bash
# Full debug log with CP2077 + Magisk + bootanim entries
adb logcat -d | grep -iE "cp2077|magisk|bootanim|customize" > cp2077-debug.log

# Module install log (during flash — run in parallel)
adb logcat -c && adb logcat | grep -i "magisk" > magisk-install.log &
# (then flash the module in Magisk UI, then kill the background job)

# Module list
adb shell su -c "magisk --list" >> cp2077-debug.log

# Active config
adb shell su -c "cat /data/cp2077.conf" >> cp2077-debug.log
```

> Attach `cp2077-debug.log` when reporting issues.

---

## ⚠️ Known Limitations

<div align="center">

| ⚠️ Limitation | 🏷 Status |
|:-------------|:---------|
| Live wallpaper APK | ❌ Not available — quarantined APKs are HTML docs |
| Icon pack overlay | 🔵 Not yet bundled in module |
| Fingerprint animation | 🟡 OOS-based ROMs only |
| Bootloader splash | 🔧 Requires manual `fastboot flash` |
| Samsung One UI support | 🧪 Experimental — not fully tested |
| MIUI / HyperOS support | 🧪 Experimental — path matrix unverified |
| KernelSU + kernel-only swap | ❌ Breaks Wi-Fi/audio on guacamole (full LOS flash required) |

</div>

---

## 🔗 Related Docs

| 📄 | 🔗 |
|:---|:---|
| ⚡ Installation guide | [INSTALLATION-GUIDE.md](INSTALLATION-GUIDE.md) |
| 🎬 Animation variants | [VARIANTS.md](VARIANTS.md) |
| 📱 Device specs & ROM compat | [DEVICE-SPECS.md](DEVICE-SPECS.md) |
| 🔧 Build from source | [BUILD-GUIDE.md](BUILD-GUIDE.md) |
| 📋 Current device state | [../00-CONTROL/PRODUCTION-STATUS.md](../00-CONTROL/PRODUCTION-STATUS.md) |
