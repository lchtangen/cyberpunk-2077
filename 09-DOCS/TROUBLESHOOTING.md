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

### HP-02: Boot Timing Trace — measure post-fs-data.sh and service.sh budgets

**Purpose:** Verify `post-fs-data.sh` completes in < 800 ms and `service.sh` first-pass in < 200 ms on your device.

**One-shot timing measurement (boot to boot_complete):**
```bash
# Clear logcat buffer
adb logcat -c

# Boot the device — logcat will capture timestamps
adb reboot

# Wait for boot completed
adb wait-for-device

# Pull relevant logcat lines
adb logcat -d -b events,main,system \
  | grep -E 'boot_completed|init.svc.bootanim|cp2077|post-fs-data|service.sh' \
  > /tmp/cp2077-boot-timing.log

# View the timing window
cat /tmp/cp2077-boot-timing.log
```

**Measure post-fs-data.sh wall-clock time:**
```bash
# Instrument the device for timing (needs root)
adb shell su -c '
  # Add timestamp to trace log at start of post-fs-data
  echo "$(date +%s%3N) post-fs-data START" >> /data/local/tmp/cp2077-trace.log
'

adb reboot
adb wait-for-device

# Check trace log
adb shell su -c "cat /data/local/tmp/cp2077-trace.log"
```

**Quick timing verification without trace flags:**
```bash
# Get boot timestamps from logcat events
adb logcat -d -b events \
  | grep -E 'boot_received|boot_completed|sys.boot_complete|init.svc.bootanim' \
  | head -20

# Get prop timings
adb shell "getprop sys.boot_completed"    # should return 1
adb shell "getprop init.svc.bootanim"       # should return "stopped"
adb shell "getprop dev.bootcomplete"          # LOS fallback prop
```

**Interpretation guide:**
| Event | Target | Problem if over |
|-------|--------|----------------|
| `post-fs-data.sh` completes | < 800 ms | Boot animation delayed |
| `service.sh` first-pass after `boot_completed=1` | < 200 ms | Animation starts late |
| `service.sh` second-pass after `bootanim=stopped` | < 100 ms | Late remounts may fail |
| Total `boot_completed` to home screen | < 15 s from power-on | User-perceivable regression |

**If timing is bad:**
```bash
# Enable trace mode to see which mount is slow
adb shell su -c "touch /data/adb/modules/CP2077_OP7Pro_Full/trace.flag"
adb reboot

# After boot: pull trace log
adb shell su -c "cat /data/local/tmp/cp2077-trace.log"
```

---

### HP-04: Audio Path Verification — verify /product/media/audio/ui/ on LOS 23.2

**Purpose:** Confirm audio overlay paths exist and have write access on LineageOS 23.2.

**Check audio paths (all variants):**
```bash
# Primary: /product/media/audio/ui/  (AOSP / LOS)
adb shell su -c 'ls -la /product/media/audio/ui/'

# Fallback: /system/media/audio/ui/   (some ROMs)
adb shell su -c 'ls -la /system/media/audio/ui/'

# OOS: /my_product/media/audio/ui/
adb shell su -c 'ls -la /my_product/media/audio/ui/ 2>/dev/null || echo "path absent"'

# Check which paths the module is mounting to
adb shell su -c 'ls -la /product/media/audio/ui/*.ogg 2>/dev/null | wc -l'
adb shell 'mount | grep "audio/ui"'
```

**Audio file presence check:**
```bash
# If audio=yes but no sounds play, check if OGG files are present
adb shell su -c '
for p in /product/media/audio/ui /system/media/audio/ui /my_product/media/audio/ui; do
  if [ -d "$p" ]; then
    count=$(ls -1 "$p"/*.ogg 2>/dev/null | wc -l)
    echo "$p: $count OGG files"
  else
    echo "$p: absent"
  fi
done
'

# Expected: 7 OGG files (Lock, Unlock, ChargingStarted, etc.)
```

**If audio path is absent on your ROM:**
```bash
# Manually create the audio directory
adb shell su -c 'mkdir -p /product/media/audio/ui'

# Or force audio=no in config if path truly doesn't exist
adb shell su -c "sed -i 's/^audio=yes/audio=no/' /data/cp2077.conf"
adb shell su -c 'setprop ctl.restart bootanim'
```

---

### HP-07: 5 MB Remount Threshold — verify LOS 23.2 stock stub sizes

**Purpose:** Confirm the 5 MB threshold correctly identifies stock stubs vs CP2077 animations on your LOS 23.2 build.

**Measure current mounted animation sizes:**
```bash
adb shell su -c '
for path in \
  /product/media/bootanimation.zip \
  /product/media/bootanimation-dark.zip \
  /system/product/media/bootanimation.zip \
  /system/media/bootanimation.zip \
  /data/local/bootanimation.zip \
  /data/misc/bootanim/bootanimation.zip; do
  if [ -f "$path" ]; then
    sz=$(wc -c < "$path")
    szmb=$(printf "%.1f" "$(echo "$sz/1024/1024" | bc -l 2>/dev/null || echo 0)")
    if [ "$sz" -lt 5000000 ]; then
      echo "STOCK STUB:  $path  ${szmb} MB"
    else
      echo "CP2077 OK:   $path  ${szmb} MB"
    fi
  else
    echo "ABSENT:      $path"
  fi
done
'
```

**Expected result on LOS 23.2 + CP2077:**
- Every present path should show ≥ 5 MB (CP2077) OR absent (not mounted yet)
- Stock stubs should be < 100 KB — easily caught by the 5 MB threshold
- If a CP2077 path shows < 5 MB → the wrong ZIP is mounted (check `service.sh`)

**Force re-verification (remount all paths):**
```bash
# Restart service.sh to trigger a remount pass
adb shell su -c 'setprop ctl.restart cp2077-service 2>/dev/null || setprop ctl.restart service 2>/dev/null'

# Or reboot to trigger full post-fs-data.sh + service.sh cycle
adb reboot
```

**If threshold fires incorrectly (very rare):**
```bash
# Check the actual bytes on the path
adb shell su -c 'wc -c < /product/media/bootanimation.zip'

# Override threshold temporarily (not recommended — indicates other problem)
adb shell su -c 'echo 1000000 > /proc/sys/vm/drop_caches'  # NOT the right fix
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
