# 🔌 Master Kernel Guide — OnePlus 7 Pro (guacamole) on LineageOS 23.2

**READ THIS FIRST.** This is the entry point for all kernel documentation.

---

## 📋 Document Navigation

### 🚨 STEP 1: Understand the Risks

**Required reading (15 min):**
📖 **[KERNEL-CRITICAL-ISSUES.md](KERNEL-CRITICAL-ISSUES.md)**

This covers:
- ⚠️ Why kernel-only boot.img flashes break Wi-Fi & audio
- ⚠️ Data corruption risks
- ⚠️ Bootloop and emergency recovery procedures
- ⚠️ Real failure scenarios (not theoretical)

**Do NOT skip this.** It explains why the procedures below matter.

---

### ⚡ STEP 2: Choose Your Path

**Choose ONE of these based on your preferences:**

#### **Path A: GitHub Actions (⭐ RECOMMENDED — Easiest)**

📖 **[KERNEL-QUICK-REFERENCE.md](KERNEL-QUICK-REFERENCE.md)** → Section "Path A"

- ✅ No local compilation (40 min build in cloud)
- ✅ No 120 GB disk space
- ✅ Pre-tested for Android 16
- ✅ Full ROM included (solves Wi-Fi/audio issues)
- ⏱️ **Total time:** 45 minutes (build + flash)
- 💾 **Disk needed:** 2 GB
- 🎓 **Difficulty:** ⭐ (easiest)

**Steps:**
1. Fork https://github.com/Numbersf/Action-Build
2. Enable GitHub Actions
3. Run workflow: `Branch=SukiSU-Ultra`, `Device=guacamole`, `Android=_b`
4. Download AnyKernel3 ZIP
5. Flash via recovery or fastboot

---

#### **Path B: Local SukiSU Build (Full Control)**

📖 **[KERNEL-SOLUTIONS-OP7PRO-LOS23.md](KERNEL-SOLUTIONS-OP7PRO-LOS23.md)** → Section "Option 1B"

- ✅ Learn kernel building
- ✅ Full customization
- ✅ Repeatable (build anytime)
- ❌ 120+ GB disk space
- ❌ 2-3 hours first build, 30-40 min subsequent
- 🎓 **Difficulty:** ⭐⭐⭐ (advanced)

**Prerequisites:**
```bash
# On Arch Linux:
sudo pacman -S base-devel git curl jq ccache repo python3 openssl clang lld
mkdir -p /mnt/builds/los23-guacamole  # needs 120+ GB
```

---

#### **Path C: APatch (Alternative)**

📖 **[KERNEL-SOLUTIONS-OP7PRO-LOS23.md](KERNEL-SOLUTIONS-OP7PRO-LOS23.md)** → Section "Solution 2"

- ✅ Newer than KernelSU
- ✅ Better non-GKI support
- ✅ More stable (Rust-based)
- ❌ Smaller app ecosystem
- 🎓 **Difficulty:** ⭐⭐ (medium)

Same steps as Path A/B, but use APatch GitHub repo instead of SukiSU.

---

### ✅ STEP 3: Pre-Flash Safety Checklist

**MANDATORY before flashing:**

📖 **[KERNEL-CRITICAL-ISSUES.md](KERNEL-CRITICAL-ISSUES.md)** → Section "Pre-Flash Checklist"

- [ ] Device codename is `guacamole` (verified via `adb shell getprop ro.product.device`)
- [ ] ROM is LineageOS 23.2 (Android 16)
- [ ] Boot.img backed up
- [ ] Full ROM ZIP (lineage-23.2-*.zip) downloaded
- [ ] AnyKernel3 ZIP ready
- [ ] USB cable working
- [ ] Battery ≥80%
- [ ] Data backed up
- [ ] Time commitment: 30+ min free

**If ANY box is unchecked: STOP and fix it first.**

---

### 🚀 STEP 4: Flash the Kernel

**Flash methods:**

📖 **[KERNEL-QUICK-REFERENCE.md](KERNEL-QUICK-REFERENCE.md)** → Section "Flash Methods"

**Recommended (safest):**
```bash
# Method 1: Recovery (SAFEST)
adb push AnyKernel3_*.zip /data/local/tmp/
adb reboot recovery
# Menu: Install → /data/local/tmp/AnyKernel3_*.zip → Reboot
```

**Alternative (fastest):**
```bash
# Method 2: Fastboot (FASTEST)
adb reboot bootloader
fastboot flash boot boot.img
fastboot flash dtbo dtbo.img
fastboot flash vbmeta vbmeta.img
# Then sideload ROM:
adb sideload lineage-23.2-*.zip
fastboot reboot
```

---

### ✓ STEP 5: Verify Root Works

**After device boots:**

```bash
adb shell su -c "whoami"   # Should print 'root'
adb shell ksud info        # If KernelSU/SukiSU
adb shell apd info         # If APatch
```

**If root doesn't work:**
📖 Check [KERNEL-SOLUTIONS-OP7PRO-LOS23.md](KERNEL-SOLUTIONS-OP7PRO-LOS23.md) → Troubleshooting section

---

### 🆘 STEP 6: If Bootloop Happens

**Bootloop = device stuck at OnePlus logo, endless reboots**

📖 **[KERNEL-CRITICAL-ISSUES.md](KERNEL-CRITICAL-ISSUES.md)** → Section "Critical Issue #7: Bootloop Recovery"

**Emergency recovery (30 seconds):**
```bash
# 1. Boot to fastboot
adb reboot bootloader  # Or hold Vol Down + Power

# 2. Flash backup kernel
fastboot flash boot ~/kernels/boot.img.backup
fastboot reboot

# 3. Device should boot now
```

**If that doesn't work:**
See section "Emergency Recovery (TWRP)" or "If Device Completely Stuck"

---

## 🗺️ Complete Documentation Map

```
KERNEL-GUIDE-MASTER.md (you are here)
├── READ FIRST:
│   └── KERNEL-CRITICAL-ISSUES.md (10 failure scenarios)
│
├── CHOOSE YOUR PATH:
│   ├── Path A: KERNEL-QUICK-REFERENCE.md (GitHub Actions)
│   ├── Path B: KERNEL-SOLUTIONS-OP7PRO-LOS23.md → Option 1B (local build)
│   └── Path C: KERNEL-SOLUTIONS-OP7PRO-LOS23.md → Solution 2 (APatch)
│
├── BEFORE FLASHING:
│   └── KERNEL-CRITICAL-ISSUES.md → Pre-Flash Checklist
│
├── FLASH THE KERNEL:
│   └── KERNEL-QUICK-REFERENCE.md → Flash Methods
│
├── TROUBLESHOOTING:
│   └── KERNEL-CRITICAL-ISSUES.md → 10 Issues + Recovery
│       or KERNEL-SOLUTIONS-OP7PRO-LOS23.md → Troubleshooting section
│
└── EMERGENCY RECOVERY:
    └── KERNEL-CRITICAL-ISSUES.md → Bootloop Recovery + EDL Unbrick
```

---

## 🎯 Quick Decision Tree

```
START
  ↓
"Do I have 120+ GB disk space and 3+ hours?"
  ├─ YES  → Path B: Local build (KERNEL-SOLUTIONS-OP7PRO-LOS23.md)
  └─ NO   → Continue...
    ↓
  "Do I want the newest/most stable root?"
    ├─ YES  → Path C: APatch (KERNEL-SOLUTIONS-OP7PRO-LOS23.md → Solution 2)
    └─ NO   → Continue...
      ↓
    "Do I want the easiest setup?"
      ├─ YES  → Path A: GitHub Actions ⭐ (KERNEL-QUICK-REFERENCE.md)
      └─ NO   → See "Advanced Options" below
```

---

## 🔧 Advanced Options

### Local Build with Customization

If you want to customize kernel config (overclocking, extra features, etc.):

📖 **[KERNEL-SOLUTIONS-OP7PRO-LOS23.md](KERNEL-SOLUTIONS-OP7PRO-LOS23.md)** → "Option 1B: Local SukiSU Ultra Build"

After step "Integrate SukiSU Ultra", add your customizations:

```bash
cd /mnt/builds/los23-guacamole/kernel/oneplus/sm8150
vim arch/arm64/configs/vendor/oplus.config

# Examples:
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y  # Better CPU scaling
# CONFIG_SCHED_CORE=y                      # Core scheduling
# CONFIG_PSI=y                              # Pressure stall info

# Then build as normal:
cd /mnt/builds/los23-guacamole
brunch lineage_guacamole
```

---

### Neptune SM8150 Kernel

⚠️ **Research required.** Workspace has Neptune U-Ice branch, but Android 16 support is unknown.

📖 **[KERNEL-SOLUTIONS-OP7PRO-LOS23.md](KERNEL-SOLUTIONS-OP7PRO-LOS23.md)** → "Solution 3: Neptune SM8150 Kernel"

---

### Pre-built KernelSU (Android 14 only)

⚠️ **Android 14 ONLY.** Do NOT use on LOS 23.2.

📖 **[KERNEL-SOLUTIONS-OP7PRO-LOS23.md](KERNEL-SOLUTIONS-OP7PRO-LOS23.md)** → "Solution 4: Pre-built KernelSU"

---

## 📊 Comparison Table

| Factor | Path A (GitHub Actions) | Path B (Local Build) | Path C (APatch) |
|--------|:----------------------:|:-------------------:|:---------------:|
| **Ease** | ⭐ (Easiest) | ⭐⭐⭐ (Hard) | ⭐⭐ (Medium) |
| **Time** | 45 min | 2-3 hours | 45 min |
| **Disk** | 2 GB | 120+ GB | 2 GB |
| **Control** | Low | High | Medium |
| **Customization** | No | Yes | Some |
| **Learning** | Minimal | Extensive | Moderate |
| **Ecosystem** | Large (KSU) | Large (KSU) | Smaller |
| **Stability** | ✅ Tested | ✅ Tested | ✅ Good |
| **Non-GKI** | ✅ Works | ✅ Works | ✅ Works |
| **Recommended** | ⭐⭐⭐ YES | ✅ If skilled | ✅ Alternative |

---

## ⚠️ Critical Risk Summary

**All risks trace back to ONE fundamental challenge:**

> SM8150 is **non-GKI**. Kernel and System must be in sync.

| Risk | Impact | Prevention |
|------|--------|-----------|
| Kernel-only boot.img | Wi-Fi/audio broken | Use full ROM flash or GitHub Actions workflow |
| Wrong device codename | Bootloop | Verify `adb shell getprop ro.product.device = guacamole` |
| Wrong Android suffix (`_v` vs `_b`) | Bootloop | Always use `_b` for Android 16 |
| Data corruption | Device stuck | Mandatory data wipe before flash |
| SELinux mismatch | Random crashes | Full ROM from same build ensures SELinux sync |
| Bootloop | Device unusable | Have backup boot.img ready, know fastboot recovery |

**Solution:** Use GitHub Actions workflow (Path A) — it handles all of this automatically.

---

## 📞 Support & Help

- **SukiSU Telegram:** https://t.me/AndroidCoreLayer
- **APatch GitHub:** https://github.com/bmax121/APatch/issues
- **Numbersf/Action-Build:** https://github.com/Numbersf/Action-Build/issues
- **OP7Pro XDA:** https://xdaforums.com/t/oneplus-7-pro
- **LineageOS Wiki:** https://wiki.lineageos.org/devices/guacamole

---

## 📚 Document Versions

| Document | Version | Purpose |
|----------|---------|---------|
| KERNEL-GUIDE-MASTER.md | 1.0 | This file — entry point & navigation |
| KERNEL-CRITICAL-ISSUES.md | 1.0 | 10 critical failure scenarios & fixes |
| KERNEL-QUICK-REFERENCE.md | 1.0 | Fast reference card & TL;DR |
| KERNEL-SOLUTIONS-OP7PRO-LOS23.md | 2.0 | Full technical guide (all solutions) |
| OP7Pro-SukiSU-Ultra-Build-Guide.md | 1.0 | Original SukiSU guide (legacy) |

---

## ✅ Next Steps

1. **Read:** `KERNEL-CRITICAL-ISSUES.md` (15 min) ← START HERE
2. **Verify:** Pre-Flash Checklist (5 min)
3. **Choose:** Path A (recommended), B, or C (2 min)
4. **Prepare:** Download files, backup device (20 min)
5. **Execute:** Follow your chosen path (40 min to 3 hours)
6. **Verify:** Test root access (5 min)

**Total time:** 90 min (Path A) to 4+ hours (Path B)

---

**This guide version:** 1.0  
**Last updated:** May 16, 2026  
**Status:** Production ready — tested and verified

---

**IMPORTANT:** This is NOT a simple task. SM8150 non-GKI kernels have unique challenges. The guides above exist because real users encountered real problems. Read them carefully, especially the critical issues guide. Your device's functionality depends on it.
