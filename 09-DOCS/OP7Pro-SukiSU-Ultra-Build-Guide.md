# Building SukiSU Ultra Kernel for OnePlus 7 Pro on LineageOS 23.2 (Android 16)

## Prerequisites
- GitHub account
- ~40-60 minutes build time
- Stable internet connection

## Step 1: Fork the Action-Build Repository

1. Go to: **https://github.com/Numbersf/Action-Build**
2. Click **Fork** (top right)
3. Select your GitHub account
4. **IMPORTANT:** Uncheck "Copy the SukiSU-Ultra branch only" to get all branches
5. Click **Create fork**

## Step 2: Enable GitHub Actions

1. After forking, go to your forked repo
2. Click **Actions** tab
3. Click **I understand my workflows, go ahead and enable them**
4. Workflows are now enabled

## Step 3: Run the Build Workflow

1. In your forked repo, click **Actions** tab
2. Click **Build All OnePlus Kernels** (or specific workflow name)
3. Click **Run workflow** (right side, green button)
4. Configure inputs:

| Parameter | Value |
|-----------|-------|
| **Branch** | `SukiSU-Ultra` |
| **Device** | `guacamole` (OnePlus 7 Pro codename) |
| **Android Version** | `_b` (Android 16 / Baklava) |
| **Kernel Version** | `6.6` or `6.12` (latest stable) |
| **Enable Fast Build** | `true` (recommended) |
| **Custom Kernel Suffix** | (optional, e.g., `cyberpunk`) |

**Note:** If `guacamole` is not in the dropdown, check the `FILE.md` file in the repo. You may need to add it manually or use an alternative device name.

## Step 4: Wait for Build

- First build: **30-45 minutes**
- Subsequent builds: **15-25 minutes** (due to ccache)
- Watch progress in **Actions → Build All OnePlus Kernels → your run**

## Step 5: Download Your Kernel

1. When build completes, go to **Actions** → your run
2. Scroll to **Artifacts** section
3. Download `AnyKernel3` zip for your device
4. Filename looks like: `AnyKernel3_SukiSUUltra_XXXXX_guacamole_Android16_*`

## Step 6: Flash on Device

### Option A: Via recovery (TWRP/LineageOS Recovery)
```bash
adb push AnyKernel3_*.zip /data/local/tmp/
adb shell
su
# Flash in recovery:
dd if=/data/local/tmp/boot.img of=/dev/block/bootdevice/by-name/boot
# OR use anykernel3 flasher if available
reboot
```

### Option B: Via Magisk Manager
1. Transfer kernel ZIP to phone
2. Open Magisk Manager
3. Tap **Modules** → **Install from storage** → select ZIP
4. Reboot

### Option C: Direct boot.img flash (fastboot)
```bash
# Boot to fastboot:
adb reboot bootloader
# Flash:
fastboot flash boot boot.img
fastboot reboot
```

## Features Included in SukiSU Ultra

| Feature | Description |
|---------|-------------|
| **SukiSU Ultra** | Root solution with magic mount |
| **SUSFS** | SUSFS v1.5.12+ for file system hooks |
| **KPM** | Kernel Patch Module support |
| **ZRAM** | RAM compression for better memory usage |
| **BBR+ECN** | TCP congestion control optimization |
| **LSM_BBG** | SELinux baseband guard |
| **VFS Hook** | Virtual file system hooking |

## Device-Specific Notes

### OnePlus 7 Pro (guacamole)
- **CPU:** Snapdragon 855 (sm8150)
- **RAM:** 6/8/12 GB
- **Kernel base:** 4.14.x (legacy GKI, not GKI2.0)
- **Android 16 support:** Requires `_b` suffix in build config

### Important Warnings

1. **Wrong kernel = brick!** Always verify device codename matches
2. **Android 16 = `_b` suffix** - Don't use `_v` or `_u` for LOS 23.2
3. **Backup first!** Keep a copy of your original boot.img
4. **LOS 23.2 required** - This build is specifically for LineageOS 23.2

## Troubleshooting

### "Device guacamole not found"
- Check `FILE.md` in repo for correct device name
- Try `oneplus7pro` or `guacamoleb` as alternatives
- May need to manually add device to build config

### Build fails at "Initialize Repo"
- GitHub network issue - try again
- Check if repo is up-to-date (sync fork)
- Delete cache and retry

### Bootloop after flash
- Boot to recovery, restore original boot.img
- Verify you flashed correct kernel for your device
- Check SELinux contexts with `dmesg | grep avc`

## Alternative: Pre-built KernelSU for LineageOS 21/22

If you want a quicker solution for Android 14/15:

- **Source:** https://github.com/surfaceocean/kernelsu_oneplus_7_pro_lineageos_guacamole
- **Latest:** v20251215
- **Compatible:** LineageOS 21/22 (Android 14-15)
- **Root:** KernelSU v0.9.5 pre-installed

## Support

- **SukiSU Ultra Channel:** https://t.me/AndroidCoreLayer
- **Action-Build Issues:** https://github.com/Numbersf/Action-Build/issues
- **OnePlus 7 Pro XDA:** https://xdaforums.com/t/oneplus-7-pro

---

*Last updated: 2026-05-14*