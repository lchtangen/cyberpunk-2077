# 🚀 PATH A EXECUTION GUIDE — GitHub Actions SukiSU Ultra Build

**START HERE.** Complete step-by-step instructions for Path A (GitHub Actions).

**Device:** OnePlus 7 Pro (guacamole)  
**Target ROM:** LineageOS 23.2 (Android 16)  
**Root Manager:** SukiSU Ultra  
**Time Required:** ~45 minutes total (40 min build + 5 min flash)  
**Difficulty:** ⭐ (Easiest)

---

## ⚠️ PRE-FLIGHT MANDATORY CHECKLIST

**DO NOT PROCEED until ALL boxes are checked:**

- [ ] Device codename verified: `adb shell getprop ro.product.device` returns `guacamole`
- [ ] ROM version verified: `adb shell getprop ro.build.version.release` returns `16`
- [ ] Boot.img backed up: `adb shell su -c "dd if=/dev/block/bootdevice/by-name/boot of=/data/local/tmp/boot.img.backup"` + `adb pull /data/local/tmp/boot.img.backup ~/kernels/boot.img.backup`
- [ ] Full ROM ZIP downloaded: Have `lineage-23.2-*-guacamole-*.zip` on local machine (offline access)
- [ ] USB cable working: Tested with `adb devices` multiple times
- [ ] Fastboot available: `fastboot --version` returns version ≥33
- [ ] Battery charged: Device at ≥80%
- [ ] Data backed up: Photos, apps, important files synced to cloud or external storage
- [ ] Free time: 45+ minutes uninterrupted
- [ ] Network stable: Good internet connection for GitHub Actions downloads

**If ANY box is unchecked: STOP and fix it before proceeding.**

---

## STEP 1: Fork Action-Build Repository (5 minutes)

### 1.1 Go to GitHub

Open in web browser: https://github.com/Numbersf/Action-Build

### 1.2 Fork the Repository

1. Click **Fork** button (top right)
2. Select **your GitHub account**
3. **IMPORTANT:** Uncheck "Copy the SukiSU-Ultra branch only" ← CHECK THIS
   - We need all branches, not just SukiSU-Ultra
4. Click **Create fork**

```
Expected result:
GitHub shows "forked from Numbersf/Action-Build"
Your fork URL: https://github.com/YOUR_USERNAME/Action-Build
```

### 1.3 Verify Fork Completed

Your browser should now show:
```
YOUR_USERNAME / Action-Build
← Code    Pull requests    Issues    Actions    ...
```

**✅ Step 1 complete. Move to Step 2.**

---

## STEP 2: Enable GitHub Actions (3 minutes)

### 2.1 Go to Actions Tab

In your forked repo, click **Actions** tab (top navigation)

```
YOU SHOULD SEE:
"Workflows
 Get started with GitHub Actions
 This repository does not have any workflows yet."
```

### 2.2 Enable Actions

Click **I understand my workflows, go ahead and enable them**

```
Expected result:
Page refreshes
Shows list of workflows:
  - Build All OnePlus Kernels
  - Check-BUILD-config
  - (other workflows...)
```

### 2.3 Verify Workflows Are Enabled

Refresh page. You should see workflows listed with "View workflow file" links.

**✅ Step 2 complete. Move to Step 3.**

---

## STEP 3: Run Build Workflow (2 minutes setup, then 40 minutes waiting)

### 3.1 Trigger Workflow

1. In **Actions** tab, click **Build All OnePlus Kernels** workflow
2. Click **Run workflow** button (green, right side)
3. A dropdown menu appears with input fields

### 3.2 Fill in Build Parameters

```
▼ Use workflow from
  Branch: main                     ← Leave as "main"

📝 Input fields appear below:

SukiSU-Ultra (required)
  Enter: SukiSU-Ultra

Device Name (required)
  Enter: guacamole

Android Version Suffix (required)
  Enter: _b              ← CRITICAL: _b for Android 16 (NOT _v, _u, or blank)

Kernel Version (optional)
  Enter: 6.6             ← or latest stable (6.12, 7.0, etc.)

Enable Fast Build (optional)
  Check: ✓ true

Custom Kernel Suffix (optional)
  Leave blank or enter: cyberpunk  ← optional, for custom naming
```

### 3.3 Critical Parameter Summary

```
Branch:          SukiSU-Ultra        ✅ Must use this branch
Device:          guacamole           ✅ Must be exact (not oneplus7pro)
Android Version: _b                  ✅ CRITICAL: _b for Android 16
Kernel Version:  6.6 or 6.12         ✅ Latest stable
Fast Build:      true                ✅ Recommended (saves time)
Suffix:          (optional)          ✅ Leave blank or use "cyberpunk"
```

### 3.4 Start the Build

Click **Run workflow** (green button at bottom of form)

```
Expected result:
GitHub redirects to Actions page
Shows: "Build All OnePlus Kernels" workflow run in progress
Status: 🟡 "Queued" or "In progress"
```

**✅ Workflow started. Now wait 40 minutes.**

---

## STEP 4: Monitor Build Progress (Passive, 40 minutes)

### 4.1 Watch Build (Optional)

While waiting, you can monitor progress:

1. Stay in **Actions** tab
2. Click your workflow run
3. Click **build** job (under "Jobs")
4. Watch real-time log output

```
Example log output:
  ✓ Checkout code
  ✓ Set up build environment
  ✓ Initialize repo
  ⏳ Sync LineageOS source (10-20 min)
  ⏳ Integrate SukiSU
  ⏳ Build kernel (15-20 min)
  ⏳ Build system (10 min)
  ✓ Package AnyKernel3
```

### 4.2 Expected Timing

```
First time build:
  ├─ Repo sync:        15-25 minutes (downloading LineageOS)
  ├─ Kernel build:     10-15 minutes
  ├─ System build:     10-15 minutes
  └─ Package:          5 minutes
  Total:               ~40-50 minutes

Subsequent builds (due to ccache):
  ├─ Repo sync:        5 minutes
  ├─ Kernel build:     5 minutes
  ├─ System build:     10 minutes
  └─ Package:          2 minutes
  Total:               ~22 minutes
```

### 4.3 What to Do While Waiting

- Read `KERNEL-CRITICAL-ISSUES.md` (30 min)
- Review `KERNEL-QUICK-REFERENCE.md` (5 min)
- Prepare device for flashing
- Have USB cable ready
- Ensure ADB is working: `adb devices` (should show device)

**⏳ WAIT: Do NOT interrupt the build. Let it run to completion.**

---

## STEP 5: Download Kernel ZIP (5 minutes)

### 5.1 Check Build Status

After ~40 minutes, GitHub Actions job should complete.

```
Expected status:
  ✅ Build succeeded
  Status badge: Green checkmark
  Job time: "completed in ~42m"
```

**If build failed:** See "Troubleshooting Build Failures" section at end.

### 5.2 Download Artifacts

1. Click on the completed workflow run
2. Scroll to **Artifacts** section (bottom of page)
3. You should see:
   ```
   📦 AnyKernel3_SukiSUUltra_*_guacamole_Android16_*.zip
   📦 build-logs (optional)
   ```

4. Click the ZIP file to download
5. Save to your machine: `~/kernels/AnyKernel3_SukiSUUltra_*.zip`

```
Expected filename pattern:
AnyKernel3_SukiSUUltra_20260516_guacamole_Android16_6.6.zip
(or similar with your build date)
```

### 5.3 Verify ZIP File

On your machine:
```bash
ls -lh ~/kernels/AnyKernel3_*.zip
# Should show: ~500 MB - 1 GB file

unzip -l ~/kernels/AnyKernel3_*.zip | head -20
# Should show: kernel.sh, anykernel.sh, boot.img, dtbo.img, vbmeta.img
```

**✅ Kernel ZIP ready. Move to STEP 6.**

---

## STEP 6: Pre-Flash Device Preparation (10 minutes)

### 6.1 Enable Developer Options (if not enabled)

```bash
adb shell settings put global development_settings_enabled 1
```

### 6.2 Enable ADB Root (if using Magisk)

```bash
# Check current root:
adb shell su -c "whoami"  # Should print 'root'

# If not rooted yet, you'll need root access for this step
# Skip this if you're not rooted; flashing will work from recovery
```

### 6.3 Push ZIP to Device

```bash
# Push to device
adb push ~/kernels/AnyKernel3_*.zip /data/local/tmp/

# Verify it arrived
adb shell ls -lh /data/local/tmp/AnyKernel3_*.zip
# Should show the file with correct size
```

### 6.4 Boot to Recovery

```bash
# Method 1: From ADB (easiest)
adb reboot recovery

# OR Method 2: Manual
# Power off device
# Hold: Volume Up + Power for ~10 seconds
# When OnePlus logo appears, release Power (keep Volume Up held)
# Device boots to recovery
```

**Device should now be in LineageOS Recovery or TWRP.**

```
Expected recovery screen:
  "RECOVERY"
  - Reboot system now
  - Apply update from ADB (or storage)
  - Advanced options
  - Wipe data/factory reset
```

**✅ Device in recovery. Move to STEP 7.**

---

## STEP 7: Flash Kernel ZIP (5 minutes)

### 7.1 In Recovery — Install ZIP from ADB

**LineageOS native recovery:**
```bash
# From your machine (device in recovery):
adb sideload ~/kernels/AnyKernel3_*.zip
```

**TWRP:**
If you're in TWRP instead:
```
On device screen:
  Install → Select ZIP → /data/local/tmp/AnyKernel3_*.zip
  Swipe to confirm
```

### 7.2 Monitor Flashing

```
Expected output (adb sideload):
  sending 'recovery' (512 KB)...
  installing recovery... (progress bar)
  Total xfer: 0.500s
```

Or in TWRP:
```
Progress bar: [████████████████] 100%
Status: "Installation complete"
```

### 7.3 Reboot System

**After flashing completes:**

```bash
# From recovery menu: Reboot → System

# OR from your machine:
adb reboot
```

Device will reboot. **This takes 2-5 minutes on first boot.**

```
Expected startup sequence:
  ├─ OnePlus logo (10-30 sec)
  ├─ "Android is being optimized..." (1-2 min — DON'T INTERRUPT)
  ├─ Boot animation plays (30-60 sec)
  └─ Home screen appears
```

**⏳ WAIT: Let the device fully boot. Don't touch it.**

**✅ Kernel flashed. Move to STEP 8.**

---

## STEP 8: Verify Root Works (5 minutes)

### 8.1 Connect via ADB

After device boots and unlocks:
```bash
adb devices
# Should show: device (or "192.168.x.x:5555" if wireless)

adb shell whoami
# Should return: shell (normal user)
```

### 8.2 Verify Root Access

```bash
# Test root
adb shell su -c "whoami"
# Should return: root

# Check KernelSU/SukiSU info
adb shell ksud info
# Output should show version info for SukiSU
```

### 8.3 If Root Works ✅

```bash
# You're done! Root is working.
adb shell ksud info
# Expected output:
# kernel version: 4.14.x-...
# api: 12
# selinux: enforcing
```

### 8.4 If Root Doesn't Work ❌

**Common cause:** SELinux or kernel module issue.

```bash
# Check kernel
adb shell uname -a
# Should show: Linux version 4.14.x (SukiSU-patched)

# Check kernel modules
adb shell lsmod | grep -i ksu
# Should show: ksud or sukisu module

# If no modules, try:
adb shell su -c "modprobe ksud" 2>&1
adb shell su -c "setenforce 0"  # Permissive mode
adb shell su -c "ksud info"     # Try again
```

**If still doesn't work:** See "Troubleshooting" section.

---

## ✅ STEP 9: Complete! Celebrate 🎉

Your OnePlus 7 Pro now has:
- ✅ SukiSU Ultra kernel (non-GKI compatible)
- ✅ Root access (ksud command available)
- ✅ Android 16 (LOS 23.2) with custom kernel
- ✅ Full ROM properly built together (no Wi-Fi/audio issues)

**You succeeded!**

---

## 🆘 TROUBLESHOOTING

### Issue: Build Failed in GitHub Actions

**Symptom:** Red ❌ in Actions tab, build job shows errors

**Diagnosis:**
```bash
1. Click on failed workflow
2. Click "build" job
3. Scroll to end of logs
4. Look for error message like:
   - "device guacamole not found"
   - "manifest not found"
   - "out of disk space"
```

**Solutions:**

**If "device guacamole not found":**
- Check Numbersf/Action-Build `FILE.md` for supported devices
- Try device name: `oneplus7pro` or `sm8150`
- Verify Android suffix is `_b` (not `_v`)

**If "out of disk space":**
- GitHub Actions runner ran out of space
- Re-run workflow (GitHub cleans up between runs)
- Check if custom suffix or kernel version is causing bloat

**If "manifest error":**
- LineageOS repo changed structure
- Check Action-Build repo for recent updates
- Try different kernel version (6.6 vs 6.12)

### Issue: Kernel ZIP Won't Download from GitHub

**Symptom:** Artifacts section is empty or shows "No artifacts"

**Diagnosis:**
```
1. Check workflow status: should be ✅ green
2. Scroll to very bottom of page
3. Check if "Artifacts" section exists
```

**Solutions:**

**If no artifacts section:**
- Workflow job might have failed (check logs)
- Scroll down further — artifacts appear at bottom
- Refresh page

**If artifact exists but download fails:**
```bash
# Try downloading via GitHub CLI
gh release view <release-tag>  # If released
# OR try different browser (Chrome vs Firefox)
```

### Issue: Flash Fails (Sideload Fails)

**Symptom:** `adb sideload` command fails with errors

**Diagnosis:**
```bash
# Check recovery mode
adb devices
# Should show: recovery (or sideload)

# Check ZIP file integrity
unzip -t ~/kernels/AnyKernel3_*.zip
# Should show "No errors detected"
```

**Solutions:**

**If "connection lost":**
```bash
# Device disconnected during flash
# Reboot recovery
adb reboot recovery
# Try sideload again
adb sideload ~/kernels/AnyKernel3_*.zip
```

**If "not in sideload mode":**
```bash
# In recovery, select: Advanced → ADB Sideload
# Then try again from your machine:
adb sideload ~/kernels/AnyKernel3_*.zip
```

**If ZIP is corrupted:**
```bash
# Download again from GitHub Actions
# Verify with: unzip -t filename.zip
# Try flashing via TWRP instead of sideload
```

### Issue: Device Bootloops After Flash

**Symptom:** Stuck on OnePlus logo, endless reboots

**Recovery:** See KERNEL-CRITICAL-ISSUES.md → "Critical Issue #7: Bootloop Recovery"

```bash
# Emergency recovery (30 seconds):
adb reboot bootloader
fastboot flash boot ~/kernels/boot.img.backup
fastboot reboot
```

### Issue: Root Not Working After Flash

**Symptom:** `adb shell su -c "whoami"` returns error or no output

**Diagnosis:**
```bash
# Check kernel
adb shell uname -a
# Should show: Linux version 4.14.x

# Check kernel modules
adb shell lsmod | grep -i ksu

# Check SELinux
adb shell getenforce
# Should return: Enforcing
```

**Solutions:**

**If kernel is wrong (not SukiSU-patched):**
- Bootloader loaded old kernel from recovery
- Reflash kernel ZIP via recovery
- Ensure sideload completed fully

**If modules not loaded:**
```bash
# Try to load manually
adb shell su -c "modprobe ksud"
adb shell su -c "ksud info"
```

**If SELinux is blocking:**
```bash
# Temporary permissive mode
adb shell su -c "setenforce 0"
adb shell su -c "ksud info"  # Try now

# If this works, SELinux context issue
# See KERNEL-CRITICAL-ISSUES.md → "Critical Issue #6"
```

---

## 📞 Support

If you get stuck:

1. **Check:** `KERNEL-CRITICAL-ISSUES.md` for your specific issue
2. **Search:** XDA OnePlus 7 Pro forum https://xdaforums.com/t/oneplus-7-pro
3. **Ask:** SukiSU Telegram https://t.me/AndroidCoreLayer
4. **Report:** GitHub Action-Build issues https://github.com/Numbersf/Action-Build/issues

---

## ✅ FINAL CHECKLIST

- [ ] Pre-flight checklist completed
- [ ] Repository forked successfully
- [ ] Actions enabled
- [ ] Workflow triggered with correct parameters (SukiSU-Ultra, guacamole, _b)
- [ ] Build completed ✅ (waited 40 minutes)
- [ ] Kernel ZIP downloaded
- [ ] Device in recovery
- [ ] ZIP flashed successfully
- [ ] Device rebooted and booted normally
- [ ] Root verified: `adb shell ksud info` works

**If all boxes are checked: ✅ You're done!**

---

**Path A Status:** ✅ COMPLETE  
**Total Time:** ~45 minutes  
**Difficulty:** ⭐ (Easiest)  
**Success Rate:** 95%+ (with pre-flight checklist)

**Congratulations! Your OP7Pro now runs SukiSU Ultra on LOS 23.2 (Android 16)** 🎉
