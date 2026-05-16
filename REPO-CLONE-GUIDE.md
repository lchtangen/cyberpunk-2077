# Repository Cloning Guide & Summary

**Date:** 2026-05-16  
**Status:** Cloning in progress (OnePlus OSS kernel)  
**Platform:** OnePlus 7 Pro + Android 16 + LineageOS 23.2

---

## What Was Cloned

**Total repos:** 16 cloned + 2 skipped (already present)  
**Organized by:** Category + use case  
**All repos compatible with:** OP7 Pro, Android 16, LineageOS 23.2

### By Category

#### Device & Kernel (OP7 Pro Specific)
- ✅ LineageOS Device Tree (`guacamole`) — symlink to existing repo
- ✅ OrangeFox Recovery Tree — already present
- ⏳ **OnePlus OSS Kernel (SM8150)** — cloning now (large)
- ✅ engstk blu_spark Kernel
- ✅ KernelSU + SUSFS Variant
- ✅ NetHunter Kernel Variant

#### Boot Animation & Magisk
- ✅ Video-to-BootAnimation Converter
- ✅ ENEIZEM CP2077 Reference Module
- ✅ MMT-Extended (Magisk Module Template)
- ✅ ZygiskNext (Zygisk Implementation)
- ✅ Zygisk-Assistant (Root Framework Abstraction)

#### Design & Theming
- ✅ Cyberpunk-Neon Canonical Palette
- ✅ hyprdots (Hyprland Reference)
- ✅ cybrland (Cyberpunk Hyprland)
- ✅ neon-nexus (Multi-tool Neon)

#### Launcher & Icons
- ✅ Lawnchair Launcher
- ✅ Lawnicons (Icon Pack)

---

## Directory Structure

```
/home/arch/dev/projects/cyberpunk-2077/

01-DEVELOPMENT/repos/
├── oneplus-7-pro/
│   ├── lineage-device-guacamole → (symlink)
│   ├── orangefox-device-guacamole/
│   ├── kernel-oneplus-oss/ ⏳ CLONING
│   └── [other existing repos]
├── boot-animation-tools/
│   └── video-to-bootanim/
├── cyberpunk/
│   └── reference-cp2077-poco-module/
└── magisk-ecosystem/
    ├── mmt-extended/
    ├── zygisknext/
    └── zygisk-assistant/

07-KERNEL-PACKAGE-MODULES/
├── kernel-engstk-op7/
├── kernel-kernelsu-susfs/
└── kernel-nethunter-draco/

06-UI-THEMES-ANIMATIONS/
├── repos/
│   ├── cyberpunk-neon-canonical/
│   ├── hyprdots/
│   ├── cybrland/
│   ├── neon-nexus/
│   ├── lawnchair/
│   └── lawnicons/
└── themes/
    ├── K-DE-Cyberpunk-Neon (existing submodule)
    ├── cyberpunk-technotronic-icon-theme (existing)
    └── cp2077-linux-hud (existing)
```

---

## Key Repos for Your Project

### 🔴 MUST-KNOW (Critical for OP7 Pro + Android 16)

1. **LineageOS Device Tree** (`lineage-device-guacamole/`)
   - Defines partition layout, boot sequence, system properties
   - Why: Your module installs into partitions defined here
   - Key file: `BoardConfig.mk`, `init/*.rc`

2. **OnePlus OSS Kernel** (`kernel-oneplus-oss/`)
   - Official upstream kernel for SM8150
   - Why: Base for all other kernels; security patches originate here
   - Study: Device tree bindings, defconfig, patches

3. **ENEIZEM CP2077 Module** (`reference-cp2077-poco-module/`)
   - Reference CP2077 Magisk module (POCO variant)
   - Why: Learn what a working CP2077 module looks like
   - Compare: `customize.sh`, variant selection, mount strategy

4. **Cyberpunk-Neon Palette** (`cyberpunk-neon-canonical/`)
   - Canonical color definitions for Cyberpunk theme
   - Why: Ensure color consistency across WebUI, ANSI, CSS, Linux
   - Validate: Your `--yellow #FCEE0C` matches upstream

### 🟡 SHOULD-KNOW (High-Value References)

5. **Video-to-BootAnimation** (`video-to-bootanim/`)
   - FFmpeg-based animation builder
   - Why: Compare with your `build.py` LANCZOS scaling
   - Learn: FFmpeg optimization patterns, format validation

6. **hyprdots** (`hyprdots/`)
   - Production Hyprland dotfiles
   - Why: Reference for Waybar, eww, rofi, dunst configs
   - Adopt: Missing features, styling patterns

7. **cybrland** (`cybrland/`)
   - Cyberpunk-themed Hyprland (thematic match!)
   - Why: Applies Cyberpunk colors to Hyprland ecosystem
   - Copy: Waybar theme, eww widgets

### 🟢 NICE-TO-HAVE (Optional References)

8. **engstk blu_spark Kernel** (`kernel-engstk-op7/`)
   - Popular performance kernel variant
   - Why: Study optimization patterns, performance tuning
   - When: If you expand kernel customization

9. **MMT-Extended** (`mmt-extended/`)
   - Advanced Magisk module template
   - Why: Reference for utilities, decide on integration
   - When: If you want to simplify module boilerplate

10. **ZygiskNext** (`zygisknext/`)
    - Zygisk implementation for multiple root frameworks
    - Why: Future-proof for system-level customization
    - When: If you add code injection features

---

## What to Do Next

### Immediate (Today)
1. **Wait for cloning to complete**
   - Monitor OnePlus OSS kernel clone
   - Once done, verify: `find . -name ".git" -type d | wc -l`

2. **Update workspace manifests**
   ```bash
   bash 99-MANIFESTS/generate-manifests.sh
   ```

### This Week
Follow integration tasks: `cat 09-DOCS/REPO-INTEGRATION-TASKS.md`

**Week 1 focus (4 hours):**
- [ ] FFmpeg LANCZOS patterns (video-to-bootanim)
- [ ] ENEIZEM module diff (customize.sh comparison)
- [ ] Design token validation (Cyberpunk-Neon)
- [ ] K-DE submodule status check

### This Month
**Week 2 focus:**
- [ ] Waybar/eww extraction (hyprdots/cybrland)
- [ ] MMT-Extended evaluation (integration decision)
- [ ] GitHub Actions cross-reference

---

## Cloned Repos Documentation

### Where to Learn About Each Repo

| Document | Content | Location |
|----------|---------|----------|
| **CLONED-REPOS-REFERENCE** | Detailed guide for each cloned repo | `09-DOCS/CLONED-REPOS-REFERENCE.md` |
| **REPO-INTEGRATION-TASKS** | Week-by-week action plan with shell commands | `09-DOCS/REPO-INTEGRATION-TASKS.md` |
| **GITHUB-REPOS-TRACKING** | Full tracking table + priority matrix | `01-DEVELOPMENT/GITHUB-REPOS-TRACKING.md` |
| **REPO-RESEARCH-SUMMARY** | Quick reference + synergies | `09-DOCS/REPO-RESEARCH-SUMMARY.md` |

**Start with:** `CLONED-REPOS-REFERENCE.md` for repo-by-repo breakdown

---

## Troubleshooting

### "Some clone failed — how do I retry?"

The script is idempotent (safe to re-run):
```bash
bash clone-repos.sh
```

It will skip already-cloned repos and retry failed ones.

### "I want to clone just one repo"

```bash
git clone --depth 1 <URL> <target-directory>
```

Example:
```bash
git clone --depth 1 https://github.com/hyprdots/hyprdots 06-UI-THEMES-ANIMATIONS/repos/hyprdots
```

### "Can I remove a cloned repo?"

Yes, safely delete the directory:
```bash
rm -rf 01-DEVELOPMENT/repos/boot-animation-tools/video-to-bootanim
```

It's gitignored, won't affect git state.

### "OnePlus OSS kernel clone is taking too long"

It's normal — the repo is ~2.7 GB. Wait 5-10 minutes or check progress:
```bash
du -sh 01-DEVELOPMENT/repos/oneplus-7-pro/kernel-oneplus-oss/.git
```

---

## Storage Considerations

**Disk space used:**
- OnePlus OSS kernel: ~2.7 GB
- All kernels combined: ~4-5 GB
- Boot animation tools: ~50 MB
- Magisk/Design repos: ~200 MB
- **Total: ~5-8 GB**

**If space is tight:**
```bash
# Remove OnePlus OSS (you have engstk as alternative)
rm -rf 01-DEVELOPMENT/repos/oneplus-7-pro/kernel-oneplus-oss

# Or compress kernels
cd 07-KERNEL-PACKAGE-MODULES
tar -czf kernel-sources-backup.tar.gz kernel-*
rm -rf kernel-*
```

---

## Next Milestone

✅ Repos cloned  
⏳ Verify all clones complete  
📋 Run `generate-manifests.sh`  
🎯 Start Week 1 integration tasks  

---

**Questions?** See:
- `CLONED-REPOS-REFERENCE.md` — Per-repo details
- `REPO-INTEGRATION-TASKS.md` — Action items
- `GITHUB-REPOS-TRACKING.md` — Full tracking table

