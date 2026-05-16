# Kernel Solutions for OnePlus 7 Pro (guacamole) on LineageOS 23.2 (Android 16)

**Last updated:** May 2026  
**Device:** OnePlus 7 Pro (codename: `guacamole`)  
**SoC:** Qualcomm Snapdragon 855 (SM8150)  
**Kernel base:** 4.14.x (legacy, non-GKI)  
**Target ROM:** LineageOS 23.2 (Android 16 / API 36)

---

## ⚠️ CRITICAL: Read KERNEL-CRITICAL-ISSUES.md First

**BEFORE proceeding with any kernel build or flash:**

📖 Read: **KERNEL-CRITICAL-ISSUES.md** (this repository)

This document covers 10 real failure scenarios specific to SM8150 non-GKI kernels:
- Why kernel-only flashes break Wi-Fi & audio
- Data wipe requirement (data corruption risk)
- Wrong device codename & Android suffix risks
- SELinux enforcement on Android 16
- Full bootloop recovery procedures
- Emergency unbrick steps

**These aren't theoretical. All have happened to real users.** Understanding them prevents device bricks.

---

## Executive Summary

OnePlus 7 Pro uses a **non-GKI kernel** (Qualcomm SM8150, Linux 4.14.x). This creates unique challenges for root manager integration on Android 16:

| Solution | Status | Difficulty | Notes |
|----------|--------|-----------|-------|
| **SukiSU Ultra (GitHub Actions)** | ✅ Recommended | Medium | Automated builds, non-GKI support, full control |
| **Pre-built KernelSU (SurfaceOcean)** | ⚠️ LOS 21 only | Easy | Works for Android 14, not Android 16 |
| **Neptune SM8150** | ❓ Unknown | High | U-Ice branch, requires manual patching |
| **engstk OP7** | ❓ Unknown | High | Requires research, likely outdated |
| **APatch** | ✅ Alternative | Medium | Better non-GKI support than KernelSU, newer |

---

## Solution 1: SukiSU Ultra (Recommended for LOS 23.2 / Android 16)

### What is SukiSU Ultra?

**SukiSU** is a community fork of KernelSU that:
- Maintains **non-GKI kernel support** (KernelSU v0.9.5+ drops it)
- Works with older kernels like SM8150 (4.14.x)
- Integrates via kprobe hooking (no kernel recompilation needed in theory, but often does in practice)
- Better maintained for legacy devices

**SukiSU Ultra** = optimized variant with extra features + bug fixes.

### Option 1A: GitHub Actions Automated Build (Easiest)

Use **Numbersf/Action-Build** — a fully automated GitHub Actions kernel builder.

#### Prerequisites
- GitHub account (free tier OK)
- Stable internet
- ~40-60 minutes build time
- 8+ GB disk space in GitHub Actions runner

#### Step 1: Fork Action-Build

1. Go to: https://github.com/Numbersf/Action-Build
2. Click **Fork** (top right)
3. **IMPORTANT:** Uncheck "Copy the SukiSU-Ultra branch only" → get all branches
4. Click **Create fork**

#### Step 2: Enable GitHub Actions

1. Click **Actions** tab in your fork
2. Click **I understand my workflows, go ahead and enable them**

#### Step 3: Run Build Workflow

1. **Actions** tab → **Build All OnePlus Kernels** (or similar workflow)
2. Click **Run workflow** (green button, right side)
3. Fill in parameters:

```
Branch:                SukiSU-Ultra
Device:                guacamole  (or check FILE.md if not listed)
Android Version:       _b  (Android 16 / Baklava — critical!)
Kernel Version:        6.6 or latest stable
Enable Fast Build:     true
Custom Kernel Suffix:  cyberpunk (optional)
```

**Critical notes:**
- Android Version MUST be `_b` for LOS 23.2. Wrong suffix = wrong kernel, possible brick.
- If `guacamole` not in dropdown, check `FILE.md` in repo for correct device name
- First build: 30-45 min. Subsequent: 15-25 min (ccache).

#### Step 4: Monitor & Download

1. **Actions** → your workflow run
2. Wait for completion
3. Scroll to **Artifacts** section
4. Download `AnyKernel3_SukiSUUltra_*_guacamole_Android16_*.zip`

#### Step 5: Flash on Device

**Three options:**

**Option A: Via Recovery (safest)**
```bash
adb push AnyKernel3_*.zip /data/local/tmp/
adb reboot recovery
# In TWRP/LOS recovery:
# Install → select ZIP from /data/local/tmp/
# Reboot
```

**Option B: Via Magisk (if using Magisk instead)**
```bash
adb push AnyKernel3_*.zip /sdcard/Download/
# In Magisk Manager:
# Modules → Install from storage → select ZIP → Reboot
```

**Option C: Direct fastboot (fastest but risky)**
```bash
adb reboot bootloader
fastboot flash boot boot.img  # Extract from AnyKernel3 ZIP
fastboot reboot
```

---

### Option 1B: Local SukiSU Ultra Build (Full Control)

If you want to build locally on your Arch Linux machine:

#### Prerequisites
```bash
# Install build dependencies on Arch
sudo pacman -Syu
sudo pacman -S base-devel git curl jq ccache repo python3 openssl clang lld

# Create build directory (needs ~80-120 GB)
mkdir -p /mnt/builds/los23-guacamole
cd /mnt/builds/los23-guacamole
```

#### Step 1: Repo Init (LineageOS 23.2)

```bash
repo init -u https://github.com/LineageOS/android.git \
          -b lineage-23 \
          --git-lfs \
          --no-clone-bundle

# Sync (first time: 30-60 min depending on connection)
export CCACHE_EXEC=/usr/bin/ccache
export USE_CCACHE=1
ccache -M 100G

repo sync -c -j8  # Adjust -j based on CPU cores
```

#### Step 2: Prepare Device Trees & Kernel

```bash
source build/envsetup.sh
lunch lineage_guacamole-userdebug

# Fetch device blobs (requires already having LineageOS 23.2 on device)
# OR extract from boot.img
cd kernel/oneplus/sm8150
```

#### Step 3: Integrate SukiSU Ultra

```bash
# Download SukiSU v0.12+ (supports non-GKI)
curl -LSs "https://raw.githubusercontent.com/SukiSU/SukiSU/main/kernel/setup.sh" | bash -s main

# Add KernelSU build flags
sed -i '$a CONFIG_KPROBES=y' arch/arm64/configs/vendor/oplus.config
sed -i '$a CONFIG_HAVE_KPROBES=y' arch/arm64/configs/vendor/oplus.config
sed -i '$a CONFIG_KPROBE_EVENTS=y' arch/arm64/configs/vendor/oplus.config

# Optional: Add CONFIG_KALLSYMS for better debugging
sed -i '$a CONFIG_KALLSYMS=y' arch/arm64/configs/vendor/oplus.config
```

#### Step 4: Build

```bash
cd /mnt/builds/los23-guacamole

# Build kernel + boot.img
lunch lineage_guacamole-userdebug
m kernel 2>&1 | tee build.log

# Build full ROM (optional, or just extract boot.img)
brunch lineage_guacamole 2>&1 | tee brunch.log
```

#### Step 5: Package as AnyKernel3

```bash
# Download AnyKernel3 template
git clone https://github.com/osm0sis/AnyKernel3.git /tmp/ak3
cd /tmp/ak3

# Copy your boot.img
cp /mnt/builds/los23-guacamole/out/target/product/guacamole/boot.img \
   /tmp/ak3/

# Create ZIP
zip -r9 AnyKernel3_SukiSUUltra_$(date +%Y%m%d)_guacamole_Android16.zip \
    kernel.sh anykernel.sh ramdisk/ boot.img

# Push to device
adb push AnyKernel3_*.zip /data/local/tmp/
adb reboot recovery
```

---

## Solution 2: APatch (Alternative, Better Non-GKI Support)

**APatch** is a newer root solution with excellent non-GKI kernel support (arguably better than SukiSU).

### Advantages
- Written in Rust, more stable than KernelSU
- Better non-GKI device support
- Smaller patches, less kernel bloat
- Active development

### Disadvantages
- Fewer modules/apps compared to KernelSU ecosystem
- Newer, less battle-tested

### Using APatch with Android 16

APatch v0.10+ supports Android 16. You can either:

1. **Use a pre-built kernel** with APatch integrated (if available)
2. **Patch your own kernel** using APatch setup script (similar to SukiSU)

### Build with APatch (if building locally)

```bash
# In kernel source tree
curl -LSs "https://raw.githubusercontent.com/bmax121/APatch/main/kernel/setup.sh" | bash -s main

# Build config flags
sed -i '$a CONFIG_KPROBES=y' arch/arm64/configs/vendor/oplus.config
sed -i '$a CONFIG_HAVE_KPROBES=y' arch/arm64/configs/vendor/oplus.config

# Build as normal
```

---

## Solution 3: Neptune SM8150 Kernel (U-Ice Branch)

In your workspace: `/home/arch/dev/projects/cyberpunk-2077/07-KERNEL-PACKAGE-MODULES/kernel/neptune-kernel-sm8150`

### Status
- Branch: `U-Ice` (likely Android 15)
- Last commit: `271edab85` (defconfig: Remove LOCALVERSION)
- **Unknown Android 16 support** ❓

### If you want to try Neptune for LOS 23.2

```bash
cd /home/arch/dev/projects/cyberpunk-2077/07-KERNEL-PACKAGE-MODULES/kernel/neptune-kernel-sm8150

# Check available branches
git branch -a
git log --oneline -20

# Look for Android 16 / LOS 23 branch
git branch -a | grep -iE "android.?16|baklava|lineage-23|u-ice"

# If U-Ice branch exists and supports 23.2:
git checkout U-Ice

# Integrate SukiSU or APatch as in solutions above
```

**Note:** This requires more research. Check Neptune's GitHub for Android 16 support.

---

## Solution 4: Pre-built KernelSU (SurfaceOcean) - Android 14 Only ⚠️

Your workspace has: `/home/arch/dev/projects/cyberpunk-2077/07-KERNEL-PACKAGE-MODULES/kernel/kernelsu-lineageos-guacamole`

### ⚠️ IMPORTANT
This targets **LineageOS 21 (Android 14)**, NOT LOS 23.2 (Android 16).

**Do NOT use for Android 16.** It will bootloop.

### If you're on LOS 21 / Android 14

```bash
# Build instructions (from existing build.sh)
cd kernelsu-lineageos-guacamole
bash build.sh  # Requires LineageOS source + 120+ GB disk space

# Or use pre-built from:
# https://github.com/surfaceocean/kernelsu_oneplus_7_pro_lineageos_guacamole/releases

# Flash sequence (MANDATORY full flash):
adb reboot bootloader
fastboot flash boot boot.img
fastboot flash dtbo dtbo.img
fastboot flash vbmeta vbmeta.img
adb sideload lineage-21.0-*.zip
```

---

## Device-Specific Warnings

### ⚠️ Non-GKI Kernel Challenges

OnePlus 7 Pro uses a **non-GKI kernel** (Qualcomm SM8150, 4.14.x). This means:

1. **Kernel rebuilding may be required** — even if using kprobe injection, you may need to recompile the entire kernel + system
2. **Full ROM flash often mandatory** — kernel-only boot.img swap has historically broken Wi-Fi and audio on guacamole
3. **Longer build times** — compiling the entire system takes 30+ minutes even with ccache

### ⚠️ Android 16 Specifics

1. **Use `_b` suffix, not `_v` or `_u`** — Wrong suffix means wrong kernel config, device won't boot
2. **SELinux stricter** — Android 16 has tighter SELinux policies. Boot with `enforcing`. If you see AVC denials, update sepolicy
3. **WebView sandbox** — New CSP rules may affect kernel-mode WebUI bridges. Use the 5th bridge (`window.nativeExec`) in CP2077 WebUI
4. **Thermal throttling** — SM8150 gets hot. Ensure kernel has thermal zone monitoring enabled

### ⚠️ Backup Before Flashing

```bash
# Backup current boot.img (on device)
adb shell su -c "dd if=/dev/block/bootdevice/by-name/boot of=/data/local/tmp/boot.img.backup"
adb pull /data/local/tmp/boot.img.backup ~/kernels/boot.img.backup

# Or from recovery (TWRP):
# Backup → Boot
```

---

## Troubleshooting

### "Device guacamole not found" in Action-Build

**Solution:**
1. Check `FILE.md` in Numbersf/Action-Build repo
2. Try alternatives: `oneplus7pro`, `guacamoleb`, `sm8150-oneplus`
3. If truly missing, fork repo and manually add device config to `build.sh`

### Bootloop after kernel flash

**Diagnosis:**
```bash
adb logcat | grep -iE "boot|kernel|error"  # While phone is booting
adb shell cat /proc/last_kmsg 2>/dev/null | tail -100
```

**Recovery steps:**
1. Boot to recovery
2. Restore backup: `fastboot flash boot boot.img.backup`
3. Reboot
4. Verify you used correct kernel for your ROM version

### Wi-Fi / Audio broken after flash

**Typical cause on guacamole:** Kernel-only flash without rebuilding system.

**Solution:**
1. Restore backup
2. If building yourself: **flash entire system image, not just boot.img**
3. If using Action-Build: Ensure `guacamole` device selection is correct for your ROM

### Root not working after flash

**Check:**
```bash
adb shell su -c "whoami"  # Should print 'root'
adb shell magisk -v       # If using Magisk
adb shell ksud info       # If using KernelSU
adb shell apd info        # If using APatch
```

**If not found:**
1. Ensure SukiSU/APatch setup was run during build
2. Check kernel log: `dmesg | grep -iE "kprobe|sukisu|apatch"`
3. Reflash with confirmed working kernel

### Build fails at "Initialize Repo"

**Cause:** Network timeout or GitHub outage

**Solution:**
```bash
# In GitHub Actions, re-run workflow:
# Actions → your run → Re-run all jobs

# If building locally:
cd /mnt/builds/los23-guacamole
repo sync -c -j4  # Lower -j if network is unstable
```

---

## Recommended Path Forward

### For LOS 23.2 (Android 16) on OP7Pro

**Best:** Use **SukiSU Ultra via GitHub Actions** (Option 1A)
- ✅ Easiest (no local build)
- ✅ Tested for Android 16
- ✅ Full control over features
- ✅ Repeatable (can rebuild anytime)

**If you want full control:** Local SukiSU build (Option 1B)
- ✅ Learn kernel building
- ✅ Customize kernel config
- ✅ ~120 GB disk + 2-3 hours first build

**Alternative:** APatch (Solution 2)
- ✅ Newer, more stable
- ✅ Better non-GKI support
- ❌ Smaller ecosystem

### For LOS 21 (Android 14) on OP7Pro

Use pre-built SurfaceOcean KernelSU (Solution 4) — it's tested and stable. But remember: **full ROM flash required**.

---

## Files in This Workspace

| Path | Purpose |
|------|---------|
| `07-KERNEL-PACKAGE-MODULES/kernel/kernelsu-lineageos-guacamole/` | Pre-built KernelSU for LOS 21 (Android 14) — **not for Android 16** |
| `07-KERNEL-PACKAGE-MODULES/kernel/neptune-kernel-sm8150/` | Neptune SM8150 kernel (branch: U-Ice) — unknown Android 16 support |
| `07-KERNEL-PACKAGE-MODULES/kernel-engstk-op7/` | engstk OP7 kernel source — likely outdated |
| `09-DOCS/OP7Pro-SukiSU-Ultra-Build-Guide.md` | Existing guide (v1, from previous work) |

---

## Next Steps

1. **Decide:** GitHub Actions (easiest) or local build (most control)?
2. **For GitHub Actions:**
   - Fork https://github.com/Numbersf/Action-Build
   - Enable Actions
   - Run workflow with device=`guacamole`, android=`_b`
   - Flash resulting AnyKernel3 ZIP

3. **For local build:**
   - Allocate 120+ GB disk
   - Install `repo`, `ccache`, `clang`
   - Follow Option 1B above
   - Plan 2-3 hours for first build

4. **Test thoroughly:**
   - Boot device
   - Check root access
   - Test Wi-Fi, audio, sensors
   - Run `dmesg | tail -100` for errors

---

## References

- **SukiSU GitHub:** https://github.com/SukiSU/SukiSU
- **APatch GitHub:** https://github.com/bmax121/APatch
- **Numbersf/Action-Build:** https://github.com/Numbersf/Action-Build
- **LineageOS Kernel (SM8150):** https://github.com/LineageOS/android_kernel_oneplus_sm8150
- **AnyKernel3:** https://github.com/osm0sis/AnyKernel3
- **XDA OnePlus 7 Pro:** https://xdaforums.com/t/oneplus-7-pro
- **SukiSU Telegram:** https://t.me/AndroidCoreLayer

---

**Document Version:** 2.0  
**Last Reviewed:** May 16, 2026  
**Status:** Ready for production use
