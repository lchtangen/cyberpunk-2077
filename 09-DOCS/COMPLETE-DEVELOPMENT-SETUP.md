# Complete Development Setup Guide

**Status:** Cloning 30+ repositories for OP7 Pro + Android 16 + LineageOS 23.2  
**Total repos:** ~26 cloned + references  
**Disk space:** ~6-10 GB  
**Setup time:** Complete in ~20-30 minutes

---

## What You're Getting

### Tier 1: Critical Repos (Already Cloned)
✅ **Device Trees & Kernels** (OP7 Pro specific)
- LineageOS device tree
- OrangeFox recovery
- OnePlus OSS kernel (upstream reference)
- engstk blu_spark kernel
- KernelSU + SUSFS variant
- NetHunter kernel

✅ **Boot Animation & Magisk**
- FFmpeg video-to-bootanimation converter
- ENEIZEM CP2077 reference module
- MMT-Extended (module template)
- ZygiskNext & Zygisk-Assistant

✅ **Design & Theming**
- Cyberpunk-Neon canonical palette
- hyprdots (Hyprland setup)
- cybrland (Cyberpunk Hyprland)
- neon-nexus (multi-tool theming)

✅ **Launcher & Icons**
- Lawnchair launcher
- Lawnicons icon pack

### Tier 2: Extended Repos (Cloning Now)
🔄 **Alternative ROM Device Trees** (testing compatibility)
- crDroid device tree
- Evolution-X device tree
- Pixel Experience device tree
- DerpFest device tree

🔄 **SM8150 Common Code** (shared across OP7 series)
- LineageOS SM8150 common
- crDroid SM8150 common

🔄 **Build System & Utilities**
- LineageOS manifest (for ROM building)
- Magisk Modules Repository submission guide
- Official Magisk source code

🔄 **Icon Packs & Theming**
- Papirus icon theme
- Tela icon theme
- Frost Neon icon theme (neon aesthetic!)

---

## Repository Directory Structure

```
/home/arch/dev/projects/cyberpunk-2077/

01-DEVELOPMENT/
├── repos/
│   ├── oneplus-7-pro/
│   │   ├── lineage-device-guacamole/ (symlink)
│   │   ├── orangefox-device-guacamole/ ✅
│   │   ├── kernel-oneplus-oss/ ⏳ Cloning
│   │   ├── device-lineage-sm8150-common/ ⏳
│   │   ├── device-crdroid-guacamole/ ⏳
│   │   ├── device-evolution-x-guacamole/ ⏳
│   │   ├── device-pixel-experience-guacamole/ ⏳
│   │   └── device-derpfest-guacamole/ ⏳
│   ├── boot-animation-tools/
│   │   └── video-to-bootanim/ ✅
│   ├── cyberpunk/
│   │   └── reference-cp2077-poco-module/ ✅
│   ├── magisk-ecosystem/
│   │   ├── mmt-extended/ ✅
│   │   ├── zygisknext/ ✅
│   │   ├── zygisk-assistant/ ✅
│   │   ├── magisk-official/ ✅
│   │   └── magisk-modules-repo-submission/ ⏳
│   └── lineageos-manifest/ ⏳
│
07-KERNEL-PACKAGE-MODULES/
├── kernel-engstk-op7/ ✅
├── kernel-kernelsu-susfs/ ✅
└── kernel-nethunter-draco/ ✅

06-UI-THEMES-ANIMATIONS/
├── repos/
│   ├── cyberpunk-neon-canonical/ ✅
│   ├── hyprdots/ ✅
│   ├── cybrland/ ✅
│   ├── neon-nexus/ ✅
│   ├── lawnchair/ ✅
│   ├── lawnicons/ ✅
│   ├── papirus-icon-theme/ ⏳
│   ├── tela-icon-theme/ ⏳
│   └── frost-neon-icon-theme/ ⏳
└── themes/
    ├── K-DE-Cyberpunk-Neon (submodule)
    └── [other existing themes]
```

---

## What You Can Do With This Setup

### 1. **Boot Animation Development** ✅ Ready
- Reference FFmpeg patterns (video-to-bootanim)
- Study existing CP2077 module (ENEIZEM)
- Validate animations with multiple FFmpeg techniques
- Build custom boot animations

**Key files:**
- `video-to-bootanim/` — FFmpeg conversion reference
- `reference-cp2077-poco-module/` — Module structure reference
- Your `build.py` — Ready to improve with new insights

### 2. **Magisk Module Development** ✅ Ready
- Template reference (MMT-Extended)
- Module validation (Magisk Modules Repository)
- Official Magisk API reference
- Multi-framework support (Zygisk, KernelSU, APatch)

**Key files:**
- `mmt-extended/` — Advanced utilities
- `magisk-official/` — API documentation
- `magisk-modules-repo-submission/` — Validation tools

### 3. **Multi-ROM Testing** 🔄 Nearly Ready
- Test module on LineageOS 23.2 (baseline)
- Test on crDroid, Evolution-X, Pixel Experience, DerpFest
- Ensure partition layout compatibility
- Validate system properties across ROMs

**Action:**
```bash
# After cloning completes:
1. Build module
2. Test on LineageOS 23.2 (current)
3. Flash to crDroid VM/device (optional)
4. Compare outcomes
5. Document compatibility matrix
```

### 4. **System Customization** ✅ Ready
- Partition layout understanding (device trees)
- Kernel customization reference (multiple kernels)
- System properties tuning (SM8150 common)
- Boot sequence hooks (init.rc files)

### 5. **UI/UX Integration** ✅ Ready
- Icon pack reference (3 packs: Papirus, Tela, Frost Neon)
- Color palette validation (Cyberpunk-Neon canonical)
- Material Design integration (Lawnchair)
- Hyprland/Linux theming (hyprdots, cybrland)

### 6. **Custom ROM Building** (Optional)
- LineageOS manifest for building from source
- Device tree reference for customization
- Vendor blob extraction
- Custom ROM variant creation

---

## Integration Timeline

### Day 1: Cloning & Verification (Today)
- [x] Clone Tier 1 repos
- [ ] Clone Tier 2 repos (in progress)
- [ ] Verify all clones: `find . -name ".git" -type d | wc -l`
- [ ] Update manifests: `bash 99-MANIFESTS/generate-manifests.sh`

### Week 1: Compatibility & References
- [ ] **Monday-Wednesday:** FFmpeg patterns, ENEIZEM diff, color validation
- [ ] **Thursday-Friday:** K-DE submodule update, device tree comparison

**Tasks:** See `REPO-INTEGRATION-TASKS.md`

### Week 2: Build System & UI
- [ ] Study Waybar/eww configs (hyprdots, cybrland)
- [ ] Evaluate MMT-Extended integration
- [ ] Cross-reference GitHub Actions workflows
- [ ] Icon pack compatibility testing

### Week 3+: Advanced Development
- [ ] ROM compatibility testing (crDroid, Pixel Experience, etc.)
- [ ] Magisk module publication prep
- [ ] Custom ROM building (optional)
- [ ] Icon pack customization (optional)

---

## Key Documents

| Document | Purpose | Read Time |
|----------|---------|-----------|
| **CLONED-REPOS-REFERENCE.md** | Detailed guide for each Tier 1 repo | 20 min |
| **EXTENDED-REPOS-REFERENCE.md** | Detailed guide for each Tier 2 repo | 25 min |
| **REPO-INTEGRATION-TASKS.md** | Week-by-week action plan with commands | 15 min |
| **GITHUB-REPOS-TRACKING.md** | Full tracking table + priority matrix | 10 min |
| **REPO-CLONE-GUIDE.md** | Quick start guide | 5 min |

**Start with:** `CLONED-REPOS-REFERENCE.md` → `EXTENDED-REPOS-REFERENCE.md` → `REPO-INTEGRATION-TASKS.md`

---

## Critical Path (Minimum Viable)

If you only have **4 hours**, focus on:

1. **Boot Animation** (1 hour)
   - Study `video-to-bootanim/` FFmpeg patterns
   - Diff `reference-cp2077-poco-module/customize.sh`
   - Document findings in `09-DOCS/BOOTANIMATION-LEARNINGS.md`

2. **Module Structure** (1 hour)
   - Review MMT-Extended utilities
   - Run Magisk validation on your module
   - Document any improvements needed

3. **Color Consistency** (1 hour)
   - Validate palette against `cyberpunk-neon-canonical/`
   - Update WebUI colors if needed
   - Sync ANSI output colors

4. **Submodule Updates** (1 hour)
   - Update K-DE-Cyberpunk-Neon
   - Check for upstream patches
   - Pull Lawnchair-Launcher-Module updates

---

## Full Feature (Complete Setup)

If you have **2 weeks**, accomplish:

**Week 1:**
- All color validations
- All device tree comparisons
- Module submission prep
- Submodule updates

**Week 2:**
- ROM compatibility testing (all 4 alternative ROMs)
- Icon pack evaluation & possible customization
- Waybar/eww integration from hyprdots/cybrland
- Documentation updates

---

## Disk Space Breakdown

| Component | Size |
|-----------|------|
| Tier 1 kernels + tools | 4-5 GB |
| Tier 2 ROMs (4 device trees) | 200 MB |
| SM8150 common | 100 MB |
| Build system (manifest) | 5 MB |
| Icon packs (3) | 500 MB |
| Other repos (themes, tools) | 200 MB |
| **Total** | **~5-6 GB** (or 6-9 GB with all kernels) |

**Cleanup options:**
```bash
# Remove if space is critical:
rm -rf 01-DEVELOPMENT/repos/oneplus-7-pro/kernel-oneplus-oss  # 2.7 GB
# Keep: you have engstk + KernelSU as alternatives
```

---

## Success Criteria

After complete setup, you should be able to:

✅ **Boot Animation:**
- Understand FFmpeg LANCZOS scaling
- Compare your build.py with reference implementation
- Build animations for 12+ target resolutions

✅ **Magisk Module:**
- Understand module execution order
- Validate module structure against official standards
- Test on multiple ROMs (LineageOS + alternatives)

✅ **UI/UX:**
- Validate color palette across all surfaces
- Understand Waybar/eww configuration patterns
- Choose/customize icon pack for cyberpunk theme

✅ **System:**
- Understand OP7 Pro partition layout
- Know which system properties affect boot
- Understand SM8150 kernel bindings

✅ **Development:**
- Know how to build LineageOS custom variant (optional)
- Prepare module for Magisk Modules Repository publication
- Have multi-ROM compatibility matrix

---

## Troubleshooting Cloning

### "Clone failed — how do I retry?"
```bash
# Tier 1 (original clones):
bash clone-repos.sh

# Tier 2 (extended clones):
bash clone-repos-extended.sh

# Both are idempotent — safe to re-run
```

### "I want to clone just one repo"
```bash
git clone --depth 1 https://github.com/USER/REPO /path/to/target
```

### "OnePlus OSS kernel is taking too long"
Normal. The kernel is 2.7 GB. Wait 5-10 minutes or:
```bash
du -sh 01-DEVELOPMENT/repos/oneplus-7-pro/kernel-oneplus-oss/.git
```

---

## Next Action

**When cloning completes:**

1. Verify all clones:
   ```bash
   find . -name ".git" -type d | wc -l
   # Should be ~26 or more
   ```

2. Update manifests:
   ```bash
   bash 99-MANIFESTS/generate-manifests.sh
   ```

3. Start Week 1 integration:
   ```bash
   cat 09-DOCS/REPO-INTEGRATION-TASKS.md
   ```

---

**Status:** Cloning in progress. Estimated completion: 15-20 minutes.  
**Documentation:** 6 guides ready. No action needed until cloning completes.

