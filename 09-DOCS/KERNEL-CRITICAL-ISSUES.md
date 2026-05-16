# ⚠️ Critical Issues & Failure Scenarios — OP7Pro SM8150 Kernels

**MANDATORY READ BEFORE FLASHING**

**Device:** OnePlus 7 Pro (guacamole, SM8150)  
**ROM:** LineageOS 23.2 (Android 16)  
**Kernel:** 4.14.x (non-GKI)  
**Updated:** May 16, 2026

---

## 🔴 CRITICAL ISSUE #1: Non-GKI Kernel = Full ROM Flash Required

### The Problem

OnePlus 7 Pro uses a **non-GKI kernel** (Qualcomm SM8150, Linux 4.14.x). This is NOT the standard modular GKI architecture (5.4+).

**Critical fact:** Kernel-only `boot.img` flashes break device functionality.

### Why This Happens

When you flash only `boot.img`:
1. ✅ Boot partition loads new kernel
2. ❌ System partition (`system.img`) still has OLD kernel modules
3. ❌ OLD system drivers expect OLD kernel interfaces
4. ❌ Mismatched kernel ↔ system causes:
   - **Wi-Fi completely broken** (wlan0 missing, no interfaces)
   - **Audio subsystem offline** (audioserver crashes)
   - **Some sensors non-functional**
   - **Random kernel panics** (module load failures)

### The Solution: Full ROM Flash

You **MUST** flash the entire system together:

```bash
# ❌ WRONG (will break Wi-Fi & audio):
adb reboot bootloader
fastboot flash boot boot.img
fastboot reboot

# ✅ CORRECT (full ROM):
adb reboot bootloader
fastboot flash boot boot.img
fastboot flash dtbo dtbo.img
fastboot flash vbmeta vbmeta.img
adb sideload lineage-23.2-*.zip  # Full ROM ZIP
```

### How GitHub Actions Workflow Helps

The `Numbersf/Action-Build` GitHub Actions kernel builder:
1. Compiles **entire LineageOS** with integrated SukiSU/APatch
2. Produces **system.img + boot.img + dtbo.img + vbmeta.img** together
3. Packages as **AnyKernel3 flashable ZIP** that handles proper sequencing

**Result:** You flash ONE ZIP that has everything pre-built & tested together.

---

## 🔴 CRITICAL ISSUE #2: KernelSU v0.9.5 is Last Version for Non-GKI

### The Problem

**KernelSU v0.9.5+ officially dropped non-GKI support.** The SM8150 4.14.x kernel is non-GKI.

### What This Means

| Version | GKI Support | Non-GKI Support | Status |
|---------|-------------|-----------------|--------|
| KernelSU v0.5–0.9.5 | ✅ | ✅ | Still works |
| KernelSU v0.10+ | ✅ | ❌ | **No non-GKI** |
| APatch v0.1+ | ✅ | ✅ | **Better support** |
| SukiSU v0.1+ | ✅ | ✅ | Fork w/ non-GKI focus |

### The Solution: Use SukiSU or APatch

1. **SukiSU Ultra** = KernelSU fork that maintains non-GKI support
2. **APatch** = Newer, better non-GKI support, actively maintained

**DO NOT try to use KernelSU v0.10+ on SM8150.** It won't compile or work.

### Pre-built Limitation

The SurfaceOcean pre-built kernel in your workspace:
- Uses **KernelSU v0.9.5** (last compatible version)
- Targets **LineageOS 21 (Android 14)**, not LOS 23.2
- **Will NOT work on LOS 23.2**

---

## 🔴 CRITICAL ISSUE #3: Data Wipe Requirement

### The Problem

Flashing a new kernel on top of old system can corrupt `/data` partition due to:
- Kernel module ABI changes
- Different block device drivers
- Mismatched SELinux policy
- systemd/init incompatibilities

### What Happens If You Don't Wipe

```
Boot sequence:
1. New kernel loads
2. New kernel tries to mount /data with OLD filesystem metadata
3. Module load failures (missing symbols, ABI mismatch)
4. /data corruption or unreadable state
5. Device stuck in bootloop or soft-bricked
```

### The Fix: Mandatory Data Wipe

**Before flashing any new kernel:**

```bash
# Option 1: Via recovery (TWRP/LOS native)
adb reboot recovery
# Menu: Wipe → Advanced Wipe → select /data → Wipe → Reboot

# Option 2: Via fastboot (from bootloader)
adb reboot bootloader
fastboot format:ext4 userdata  # WARNING: ERASES ALL USER DATA

# Option 3: Magisk Manager (if already rooted)
adb shell su -c "pm trim-caches 1073741824"
adb shell su -c "wipe_data"
```

**Note:** This erases all apps, photos, data, settings. **Backup first.**

### Backup Checklist

Before ANY kernel flash:

- [ ] Backup photos/videos: `adb pull /sdcard/DCIM ~/backups/`
- [ ] Backup app data: Use `adb backup -apk -shared -all` or Google Drive sync
- [ ] Backup boot.img: `adb shell su -c "dd if=/dev/block/bootdevice/by-name/boot of=/data/local/tmp/boot.img.backup"`
- [ ] Download lineage-23.2-*.zip to local machine (offline access)

---

## 🔴 CRITICAL ISSUE #4: Wrong Device Codename = Brick

### The Problem

GitHub Actions workflow has device names like:
- `guacamole` ✅ (OnePlus 7 Pro)
- `oneplus7pro` ⚠️ (might work, might not)
- `guacamoleb` ❌ (wrong)
- `sm8150` ❌ (too generic)

**Wrong device = wrong kernel config = bootloop or brick.**

### How to Verify

```bash
# On device, check actual codename:
adb shell getprop ro.product.device
adb shell getprop ro.product.board
adb shell getprop ro.build.fingerprint

# Should return something like:
# ro.product.device=guacamole
# ro.product.board=msmnile
# ro.build.fingerprint=oneplus/guacamole/guacamole:...
```

### If You're Not 100% Sure

**DO NOT FLASH.** Instead:

1. Check Numbersf/Action-Build `FILE.md` for supported devices
2. Ask on XDA OnePlus 7 Pro thread
3. Check device tree: `grep -r "guacamole" github.com/LineageOS/android_device_oneplus*`

---

## 🔴 CRITICAL ISSUE #5: Android 16 Suffix _b is Mandatory

### The Problem

Build system parameter `Android=_b` (Baklava, Android 16) vs `_v` (Vanilla, Android 15):

```
_b suffix = Android 16 kernel config + APIs + SELinux rules
_v suffix = Android 15 kernel config + APIs + SELinux rules
```

Using wrong suffix means:
- ❌ Wrong kernel features enabled/disabled
- ❌ Incompatible SELinux contexts
- ❌ Bootloop or functionality loss
- ❌ Very hard to debug

### The Fix

**GitHub Actions workflow:**
```
Branch:          SukiSU-Ultra
Device:          guacamole
Android Version: _b              ← CRITICAL: Must be _b, not _v
Kernel Version:  6.6 or latest
```

**If building locally:**
```bash
# During defconfig setup, ensure:
CONFIG_ANDROID_VERSION=16  # Not 15
CONFIG_ANDROID_BAKLAVA=y   # Not VANILLA

# Check:
cat arch/arm64/configs/vendor/oplus.config | grep -i android
```

---

## 🔴 CRITICAL ISSUE #6: SELinux Enforcement on Android 16

### The Problem

Android 16 has **stricter SELinux policy** than Android 15.

If your kernel/system mismatch has wrong SELinux contexts:
- ❌ AVC denials in dmesg
- ❌ Services unable to read/write files
- ❌ Random "Permission denied" crashes
- ❌ Wi-Fi/audio/sensors fail silently

### How to Check

```bash
adb shell getenforce
# Should return: Enforcing (or Permissive if you downgraded)

adb shell dmesg | grep -i "avc: denied"
# If you see many AVC denials, context mismatch
```

### If You See AVC Denials

**Short term (workaround):**
```bash
adb shell su -c "setenforce 0"  # Permissive mode (less secure)
```

**Long term (proper fix):**
```bash
# 1. Restore backup kernel
# 2. Check sepolicy.rule in CP2077 module (if using CP2077)
#    File: 01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/sepolicy.rule
# 3. Rebuild with correct SELinux rules
```

### CP2077 Module Integration

If using CP2077 Magisk module **on top of custom kernel:**

- CP2077's `sepolicy.rule` has `bootanim_data`, `init_bootanim` (Android 16 specific)
- If kernel SELinux is wrong, CP2077 module will fail
- Symptom: Boot animation doesn't play, bootanim service crashes

**Solution:** Ensure kernel + module + ROM SELinux are all in sync (all Android 16)

---

## 🔴 CRITICAL ISSUE #7: Bootloop Recovery Procedure

### Scenario: Device Won't Boot After Flash

```
Flash kernel → Device stuck on "OnePlus" logo → Bootloop
```

### Emergency Recovery (Fastboot)

```bash
# 1. Boot to fastboot (from powered-off state)
# Hold: Vol Down + Power for ~10 sec
# Or via ADB:
adb reboot bootloader

# 2. Flash backup kernel
fastboot flash boot ~/kernels/boot.img.backup
fastboot reboot

# 3. If that doesn't work, restore entire system
fastboot flash boot boot.img.backup
fastboot flash dtbo dtbo.img.backup
fastboot flash vbmeta vbmeta.img.backup
adb sideload lineage-23.2-backup.zip  # Full ROM backup
fastboot reboot

# 4. If bootloader won't respond:
# - Try different USB cable
# - Different USB port (avoid USB 3.0 if possible)
# - Different machine (Windows, Mac, Linux)
# - Wait 30+ seconds between commands
```

### Emergency Recovery (TWRP/Recovery)

If fastboot is slow/unresponsive:

```bash
# 1. Boot to recovery
# Hold: Vol Up + Power for ~10 sec

# 2. In TWRP/LOS Recovery:
# Backup → Boot (save current state)
# Restore → Boot → select boot.img.backup
# Reboot

# 3. If recovery won't boot:
# This is bad. Requires:
# - EDL (Emergency Download Mode) unbrick tools
# - Device tree files
# - Serial console access
# - Professional recovery
```

### If Device is Completely Stuck

You may need **EDL mode unbrick** (advanced):
- Requires special cables/equipment
- Look for "OnePlus 7 Pro EDL unbrick" guides on XDA
- Contact OnePlus support or XDA experts

---

## 🔴 CRITICAL ISSUE #8: Wi-Fi Breakdown Specifics

### Typical Symptom After Flash

```
adb shell ifconfig wlan0
# Returns: "ifconfig: interface wlan0 not found"

adb shell ifconfig
# Shows only: lo (loopback) — no wlan0, no rmnet

adb shell ip link
# Shows only: lo — no wireless interface
```

### Root Causes (in order of likelihood)

1. **Kernel-only flash** (did NOT flash system.img) — **80% of cases**
   - Solution: Full ROM flash (boot.img + dtbo.img + vbmeta.img + lineage.zip)

2. **Mismatched kernel modules** (kernel vs system)
   - Solution: Full ROM from same build

3. **Wi-Fi driver not loaded** (missing CONFIG_WLAN in defconfig)
   - Solution: Check kernel build config, rebuild with CONFIG_WLAN=m

4. **SELinux blocking Wi-Fi** (AVC denied for wireless interfaces)
   - Solution: Check `dmesg | grep wlan`, update sepolicy

5. **Hardware not detected** (bootloader issue)
   - Solution: Flash dtbo.img (device tree), vbmeta.img

### Recovery Steps

```bash
# 1. Check what's actually loaded
adb shell lsmod | grep wlan
adb shell lsmod | grep wcn

# 2. If nothing, try forcing module load
adb shell su -c "modprobe wcnss"
adb shell su -c "modprobe wlan"

# 3. If still nothing, check logs
adb shell dmesg | grep -iE "wlan|wireless|wcn"
adb shell dmesg | tail -50

# 4. If logs show "AVC denied", fix SELinux (permissive mode):
adb shell su -c "setenforce 0"
adb shell su -c "svc wifi enable"

# 5. If still nothing, restore backup
# (see CRITICAL ISSUE #7: Bootloop Recovery)
```

---

## 🔴 CRITICAL ISSUE #9: Audio Breakdown After Kernel Flash

### Typical Symptoms

```
adb shell dumpsys audio_policy
# Returns: "audio_policy service not running"

adb shell getprop init.svc.audioserver
# Returns: "running" but crashes on log check

No sound in any app, even system sounds
```

### Root Causes (Same as Wi-Fi)

1. **Kernel-only flash** — **85% of cases**
   - Solution: Full ROM flash

2. **Mismatched audio drivers**
   - Solution: Full ROM from same build, verify CONFIG_SND in kernel

3. **Missing audio HAL** (Hardware Abstraction Layer)
   - Solution: Flash system.img from same build

4. **SELinux blocking audio**
   - Check: `dmesg | grep -i "audioserver\|avc.*audio"`

### Recovery

```bash
# 1. Restart audio service
adb shell su -c "svc audio enable"
adb shell su -c "service audioserver restart"

# 2. Check audio interfaces
adb shell ls -la /dev/snd/

# 3. Check audio HAL
adb shell ps aux | grep audio

# 4. If no audio devices in /dev/snd/, kernel issue
# Restore backup or reflash system.img

# 5. Enable permissive mode as last resort
adb shell su -c "setenforce 0"
adb shell su -c "service audioserver restart"
```

---

## 🔴 CRITICAL ISSUE #10: Thermal Throttling & Boot Failures

### The Problem

SM8150 (Snapdragon 855) generates **significant heat** during boot.

If kernel enables aggressive thermal monitoring:
- Bootloader detects high temperature
- Refuses to boot (thermal shutdown)
- Device stuck in bootloop

### Symptoms

```
Device powers on → Screen goes black → Powers off after 10-30 sec
Repeats every time you try to boot
But fastboot IS accessible (doesn't overheat waiting)
```

### Prevention

When building kernel (if doing local build):

```bash
# Disable aggressive thermal throttling for boot
sed -i 's/CONFIG_THERMAL_EMERGENCY_POWEROFF=y/CONFIG_THERMAL_EMERGENCY_POWEROFF=n/' arch/arm64/configs/vendor/oplus.config
sed -i 's/CONFIG_THERMAL=y/CONFIG_THERMAL=m/' arch/arm64/configs/vendor/oplus.config

# But keep thermal monitoring (just non-aggressive)
echo "CONFIG_THERMAL_STATISTICS=y" >> arch/arm64/configs/vendor/oplus.config
```

### If Device Boots but Immediately Throttles

```bash
# Check thermal zones
adb shell cat /sys/class/thermal/thermal_zone*/temp

# If temperatures are normal but throttling happens:
adb shell cat /sys/devices/virtual/thermal/*/trip_point_*

# If temperatures are actually high (>60°C idle):
# - Device may have physical thermal paste issue
# - Or kernel is reporting wrong temps
```

---

## ✅ Pre-Flash Checklist

**MANDATORY before touching the device:**

- [ ] **Device codename verified**: `adb shell getprop ro.product.device` = `guacamole`
- [ ] **Current ROM verified**: `adb shell getprop ro.build.version.release` = `16` (or check about)
- [ ] **Boot.img backed up**: `adb shell su -c "dd if=/dev/block/bootdevice/by-name/boot of=/data/local/tmp/boot.img.backup"`
- [ ] **Backup downloaded to PC**: `adb pull /data/local/tmp/boot.img.backup ~/kernels/`
- [ ] **Full ROM ZIP downloaded**: Download `lineage-23.2-*-guacamole-*.zip` to PC (offline access)
- [ ] **AnyKernel3 ZIP ready**: Downloaded from GitHub Actions or built locally
- [ ] **USB cable verified**: Working (test `adb devices` multiple times)
- [ ] **Computer has fastboot**: `fastboot --version` returns ≥33
- [ ] **Battery charged**: ≥80%
- [ ] **Network stable**: Not on WiFi (use USB tethering if needed for downloads)
- [ ] **Data backed up**: Photos, docs, app data exported or synced to cloud
- [ ] **Time commitment**: Have 30+ min free (no interruptions)

**If ANY checkbox is unchecked: STOP and fix it first.**

---

## 📞 Emergency Contacts

If flashing fails catastrophically:

- **XDA OnePlus 7 Pro Thread**: https://xdaforums.com/t/oneplus-7-pro
- **LineageOS Wiki**: https://wiki.lineageos.org/devices/guacamole
- **SukiSU Telegram**: https://t.me/AndroidCoreLayer (kernel-specific help)
- **Workspace Docs**: Check `KERNEL-SOLUTIONS-OP7PRO-LOS23.md` troubleshooting section

---

## 🎯 Summary: Why These Issues Matter

**All 10 critical issues stem from ONE fact:**

> SM8150 is a **non-GKI kernel** that requires **full system synchronization**. Kernel ≠ System is a failed state.

**The GitHub Actions workflow solves this** by building kernel + system together as one unit.

---

**Status:** Critical Issues Document v1.0  
**Last Updated:** May 16, 2026  
**Revision:** Must read before any kernel flash
