# Kernel Quick Reference — OnePlus 7 Pro (guacamole) / LOS 23.2

## ⚠️ MANDATORY FIRST: Read Critical Issues

**BEFORE FLASHING ANY KERNEL:** Read `KERNEL-CRITICAL-ISSUES.md`

This covers 10 real failure scenarios that can brick your device:
1. Non-GKI kernel = full ROM flash required (not just boot.img)
2. KernelSU v0.9.5+ drops non-GKI support
3. Data wipe requirement
4. Wrong device codename = bootloop
5. Android 16 suffix `_b` is mandatory
6. SELinux enforcement issues
7. Bootloop recovery procedures
8. Wi-Fi breakdown (80% from kernel-only flash)
9. Audio breakdown (85% from kernel-only flash)
10. Thermal throttling & boot failures

**Read it. Don't skip.**

---

## 🚀 TL;DR: Fastest Path to SukiSU Ultra + Android 16

### 5-Minute Setup (GitHub Actions)

```bash
# 1. Fork https://github.com/Numbersf/Action-Build
# 2. Go to Actions → Run workflow
# 3. Set: Branch=SukiSU-Ultra, Device=guacamole, Android=_b
# 4. Wait 30-45 min
# 5. Download AnyKernel3_*_guacamole_Android16_*.zip
# 6. Flash:

adb push AnyKernel3_*.zip /data/local/tmp/
adb reboot recovery
# In recovery: Install → /data/local/tmp/AnyKernel3_*.zip → Reboot
```

---

## ⚠️ CRITICAL CHECKLIST

- [ ] Device is **guacamole** (OnePlus 7 Pro) — not guacamoleb or oneplus7pro
- [ ] ROM is **LineageOS 23.2** (Android 16) — not LOS 21 or 22
- [ ] Kernel Android suffix is **`_b`** — NOT `_v`, `_u`, or blank
- [ ] You have a **backup of original boot.img**
- [ ] Device is **plugged in & ADB enabled**
- [ ] You have **30+ minutes** (or 120 GB if building locally)

---

## Three Paths

### Path A: GitHub Actions (⭐ RECOMMENDED — Easiest)

```
1. Fork Numbersf/Action-Build
2. Enable Actions
3. Run Build All OnePlus Kernels workflow
4. Settings: guacamole, _b (Android 16), SukiSU-Ultra branch
5. Wait ~40 min → Download AnyKernel3 ZIP
6. adb push + reboot recovery + install
```

**Time:** 40 min build + 5 min flash = 45 min total  
**Disk:** ~2 GB (just the final ZIP)  
**Difficulty:** ⭐ (easiest)

### Path B: Local SukiSU Build (Full Control)

```
1. mkdir /mnt/builds/los23-guacamole (needs 120 GB!)
2. repo init -b lineage-23 + repo sync (30-60 min)
3. source build/envsetup.sh && lunch lineage_guacamole-userdebug
4. Integrate SukiSU via setup.sh
5. m kernel && brunch lineage_guacamole (90+ min)
6. Package boot.img as AnyKernel3
7. Flash same as Path A
```

**Time:** 2-3 hours first build, 30-40 min subsequent  
**Disk:** 120-150 GB  
**Difficulty:** ⭐⭐⭐ (high)

### Path C: APatch (Newer Alternative)

```
Same as Path A or B, but:
- Fork https://github.com/bmax121/APatch instead
- Or manually patch kernel with APatch setup.sh
- Result: APatch manager instead of KernelSU
```

**Pros:** Newer, more stable, better non-GKI  
**Cons:** Smaller ecosystem

---

## Flash Methods

### Method 1: Recovery (SAFEST) ✅

```bash
adb push AnyKernel3_*.zip /data/local/tmp/
adb reboot recovery
# Menu: Install → /data/local/tmp/AnyKernel3_*.zip → Reboot
```

### Method 2: Fastboot (FASTEST)

```bash
adb reboot bootloader
# Extract boot.img from AnyKernel3 ZIP
fastboot flash boot boot.img
fastboot reboot
```

### Method 3: Magisk Module (If using Magisk)

```bash
adb push AnyKernel3_*.zip /sdcard/Download/
# Magisk Manager: Modules → Install from storage → Select ZIP → Reboot
```

---

## Verify Root Works

```bash
adb shell su -c "whoami"          # Should print 'root'
adb shell su -c "id"               # Should show uid=0 (gid=0)
adb shell ksud info                # KernelSU info (if KernelSU)
adb shell apd info                 # APatch info (if APatch)
```

---

## Common Problems

| Problem | Diagnosis | Fix |
|---------|-----------|-----|
| **Bootloop** | Check `dmesg \| tail -50` on device | Restore boot.img.backup from fastboot |
| **Wi-Fi broken** | `ifconfig wlan0` returns nothing | Full ROM flash needed, not just kernel |
| **No root** | `su` returns `Permission denied` | Kernel build missing SukiSU/APatch setup |
| **Wrong device** | ROM boots but kernel config is wrong | Flash correct kernel for guacamole (**not** oneplus7pro) |
| **Build failed in GHA** | Check Actions log | Check FILE.md for correct device name in repo |

---

## Backup & Restore

### Backup Current Kernel

```bash
adb shell su -c "dd if=/dev/block/bootdevice/by-name/boot of=/data/local/tmp/boot.img.backup"
adb pull /data/local/tmp/boot.img.backup ~/kernels/boot.img.$(date +%Y%m%d).backup
```

### Restore from Backup

```bash
adb reboot bootloader
fastboot flash boot ~/kernels/boot.img.backup
fastboot reboot
```

---

## Device Specs (guacamole)

| Spec | Value |
|------|-------|
| **Codename** | guacamole |
| **CPU** | Snapdragon 855 (SM8150) |
| **Kernel base** | 4.14.x (non-GKI) |
| **RAM** | 6/8/12 GB variants |
| **Storage** | 128/256 GB |
| **Recovery** | TWRP or LineageOS native |

---

## Tools Needed

### For GitHub Actions
- GitHub account (free)
- Web browser
- ADB + fastboot on your Linux machine
- USB cable

### For Local Build
- Arch Linux (or similar)
- `repo`, `ccache`, `clang`, `lld`, `openssl`
- 120+ GB free disk
- ~3 hours time

```bash
# Install on Arch
sudo pacman -S base-devel git curl jq ccache repo python3 openssl clang lld
```

---

## Reference Docs

| Doc | Purpose |
|-----|---------|
| `KERNEL-SOLUTIONS-OP7PRO-LOS23.md` | Full guide (this page's parent) |
| `OP7Pro-SukiSU-Ultra-Build-Guide.md` | Original SukiSU guide |
| `BUILD-GUIDE.md` | General LineageOS build instructions |
| `DEVICE-SPECS.md` | OP7Pro hardware specs |

---

## Support

- **SukiSU Telegram:** https://t.me/AndroidCoreLayer
- **Action-Build Issues:** https://github.com/Numbersf/Action-Build/issues
- **OP7Pro XDA:** https://xdaforums.com/t/oneplus-7-pro
- **Workspace Docs:** `/home/arch/dev/projects/cyberpunk-2077/09-DOCS/`

---

**Version:** 1.0  
**Updated:** May 16, 2026  
**Status:** Ready for production
