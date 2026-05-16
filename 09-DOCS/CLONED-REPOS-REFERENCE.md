# Cloned Repositories Reference Guide

**Platform:** OnePlus 7 Pro (GM1911 / guacamole)  
**Target OS:** LineageOS 23.2 (API 36 / Android 16)  
**Magisk:** v30.7+  
**Status:** All repos cloned and organized

---

## Repository Locations & Purpose

### 🔴 CRITICAL: Device & Kernel (OP7 Pro Specific)

#### LineageOS Device Tree
**Location:** `01-DEVELOPMENT/repos/oneplus-7-pro/lineage-device-guacamole/` (symlink)  
**What it is:** Official LineageOS device tree for OP7 Pro  
**Use for:**
- BoardConfig.mk: partition layout, SELinux policies
- device.mk: system properties, init scripts
- init/*.rc: boot sequence (where `customize.sh` fires)

**Key files:**
- `BoardConfig.mk` — Partition sizes, device codename
- `device.mk` — System properties, init hooks
- `extract-files.sh` — Proprietary blob extraction

**Why it matters:** Defines what partitions exist, where bootanim loads, system properties at boot time.

---

#### OrangeFox Recovery Tree
**Location:** `01-DEVELOPMENT/repos/oneplus-7-pro/orangefox-device-guacamole/` (already present)  
**What it is:** OrangeFox recovery device-specific configuration  
**Use for:**
- Device detection during flashing (ensures correct recovery)
- Partition mapping for Magisk module installation
- Recovery ZIP compatibility

---

#### OnePlus OSS Kernel (SM8150)
**Location:** `07-KERNEL-PACKAGE-MODULES/kernel-oneplus-oss/`  
**What it is:** Official OnePlus kernel source code  
**Use for:**
- Upstream reference for all OP7 kernel work
- Security patches and bug fixes
- Understanding SM8150 (Snapdragon 855) specifics

**Why it matters:** Bleeding-edge security patches flow from this repo → engstk/blu_spark.

**Key branches:**
- `op7-release` — Production kernel for OP7 Pro
- Other branches tied to specific OOS versions

---

#### engstk blu_spark Kernel (Custom)
**Location:** `07-KERNEL-PACKAGE-MODULES/kernel-engstk-op7/`  
**What it is:** Popular community kernel with performance + stability focus  
**Use for:**
- Performance tuning reference (governors, I/O schedulers)
- Stability patches beyond official OnePlus
- Learning kernel customization patterns

**Key features:**
- Performance governors (schedutil, interactive)
- I/O schedulers (CFQ, deadline)
- Thermal management tweaks

---

#### KernelSU + SUSFS Variant
**Location:** `07-KERNEL-PACKAGE-MODULES/kernel-kernelsu-susfs/`  
**What it is:** OnePlus kernel pre-integrated with KernelSU + SUSFS  
**Use for:**
- Future KernelSU integration (alternative to Magisk)
- Root framework flexibility on device

**Why useful:** Allows testing KernelSU modules without flashing Magisk.

---

#### NetHunter Kernel Variant (Optional)
**Location:** `07-KERNEL-PACKAGE-MODULES/kernel-nethunter-draco/`  
**What it is:** Security-focused kernel for penetration testing  
**Use for:**
- OmniSec integration (if expanding security features)
- Network monitoring capabilities
- Reference for security-oriented patches

---

### 🟡 IMPORTANT: Boot Animation & Magisk

#### FFmpeg Video-to-BootAnimation Converter
**Location:** `01-DEVELOPMENT/repos/boot-animation-tools/video-to-bootanim/`  
**What it is:** Python/FFmpeg tool to convert video → bootanimation.zip  
**Use for:**
- **Code reference:** Study FFmpeg LANCZOS scaling patterns
- Validate your `build.py` FFmpeg commands
- Alternative build approach if needed

**Key file:** `scripts/video_to_animation.py`  
**Compare with:** Your `CP2077-OP7Pro/build.py` line ~127 (frame scaling logic)

**Compatibility:** Works with any bootanimation.zip format (your format too).

---

#### ENEIZEM CP2077 Reference Module
**Location:** `01-DEVELOPMENT/repos/cyberpunk/reference-cp2077-poco-module/`  
**What it is:** Existing Cyberpunk 2077 Magisk module (POCO device variant)  
**Use for:**
- Study `customize.sh` variant selection logic
- Compare mount strategies with yours
- Reference `module.prop` format

**Key files:**
- `customize.sh` — variant selection, install logic
- `post-fs-data.sh` — mount operations
- `module.prop` — version info, update JSON pointer

**What to diff:**
```bash
diff reference-cp2077-poco-module/customize.sh \
     repos/cyberpunk/CP2077-OP7Pro/customize.sh
```

**Expected differences:**
- Your module has 7 variants (theirs has 1)
- Your config system is more complex (`lib/config-v2.sh`)
- You handle audio separately; theirs may be bundled

---

### 🟢 MAGISK ECOSYSTEM & FRAMEWORKS

#### MMT-Extended (Magisk Module Template)
**Location:** `01-DEVELOPMENT/repos/magisk-ecosystem/mmt-extended/`  
**What it is:** Advanced Magisk module template with utilities  
**Use for:**
- Reference for hook system (post-fs-data vs service timing)
- Busybox abstraction layer (if needed)
- Best-practices for module structure

**Key utilities:**
- `install_module_framework()` — Setup hooks
- Mount abstraction functions
- Module backup/restore helpers

**Decision:** Study to decide if integration helps your module.

---

#### ZygiskNext (Zygisk Implementation)
**Location:** `01-DEVELOPMENT/repos/magisk-ecosystem/zygisknext/`  
**What it is:** Open-source Zygisk (Magisk runtime hooks)  
**Use for:**
- **Future reference:** Zygisk features you might add later
- Multi-root-framework support (Magisk/KernelSU/APatch)
- Runtime code injection capabilities

**When you'll need it:** If you want to hook into app launch, intent interception, etc.

**Status:** Bookmark for now; research only.

---

#### Zygisk-Assistant (Root Framework Abstraction)
**Location:** `01-DEVELOPMENT/repos/magisk-ecosystem/zygisk-assistant/`  
**What it is:** Abstraction layer for Zygisk across Magisk/KernelSU/APatch  
**Use for:**
- Multi-framework module compatibility patterns
- Learning root framework detection

---

### 🎨 DESIGN & THEMING (Color Palette Sync)

#### Cyberpunk-Neon Canonical Palette
**Location:** `06-UI-THEMES-ANIMATIONS/repos/cyberpunk-neon-canonical/`  
**What it is:** Authoritative Cyberpunk Neon color scheme  
**Use for:**
- Cross-check your palette against canonical source
- Ensure WebUI, ANSI, CSS, and Linux configs use same colors

**Your colors (from CLAUDE.md):**
```
--yellow:  #FCEE0C
--cyan:    #00FFFF
--red:     #FF003C
--orange:  #FF6B35
--green:   #00FF9F
--bg:      #0A0A0A
--border:  #2A2A2A
```

**Action:** Compare these against Roboron3042's definitions.

---

#### hyprdots (Hyprland Reference)
**Location:** `06-UI-THEMES-ANIMATIONS/repos/hyprdots/`  
**What it is:** Complete, production-grade Hyprland dotfiles  
**Use for:**
- Waybar configuration (modules, styling)
- dunst notification styling
- rofi launcher theming
- General Hyprland best practices

**Key directories:**
- `.config/waybar/` — Waybar config + stylesheet
- `.config/hyprland/` — Hyprland config
- `.config/dunst/` — Notification styling
- `.config/rofi/` — Launcher themes

**Why useful:** Mature, actively maintained reference for your Linux host setup.

---

#### cybrland (Cyberpunk Hyprland Theme)
**Location:** `06-UI-THEMES-ANIMATIONS/repos/cybrland/`  
**What it is:** Cyberpunk-themed Hyprland setup (direct thematic match!)  
**Use for:**
- Waybar cyberpunk styling
- eww widget configuration
- Color scheme application across Hyprland tools
- Direct reference for your aesthetic goals

**Key files:**
- `.config/hyprland/hyprland.conf` — Hyprland config
- `.config/waybar/config` — Waybar layout
- `.config/eww/` — Elkowars Wacky Widgets config
- `.config/rofi/` — Rofi theme

---

#### neon-nexus (Multi-Tool Neon Theming)
**Location:** `06-UI-THEMES-ANIMATIONS/repos/neon-nexus/`  
**What it is:** Neon-themed configs for Hyprland, Waybar, rofi, Kitty, Firefox, Dolphin  
**Use for:**
- Waybar + rofi styling patterns
- Terminal (Kitty) color scheme
- Firefox theme integration
- File manager (Dolphin) theming

---

### 🚀 LAUNCHER & ICONS (Optional)

#### Lawnchair Launcher
**Location:** `06-UI-THEMES-ANIMATIONS/repos/lawnchair/`  
**What it is:** Open-source Pixel Launcher with Material 3 support  
**Use for:**
- Material 3 color integration patterns
- Launcher customization depth reference
- Future Material 3 sync (if adopting)

**Why included:** Your project has Lawnchair-Launcher-Module submodule; this is the upstream reference.

---

#### Lawnicons (Icon Pack)
**Location:** `06-UI-THEMES-ANIMATIONS/repos/lawnicons/`  
**What it is:** Monochrome outlined icon pack  
**Use for:**
- Icon design patterns (if expanding cyberpunk icon theme)
- SVG theming system reference

---

## Integration Checklist

### Week 1 Actions
- [ ] **Kernels:** Compare OnePlus OSS, engstk, KernelSU variants
- [ ] **Boot animation:** FFmpeg LANCZOS vs. your `build.py`
- [ ] **ENEIZEM module:** Diff `customize.sh` patterns
- [ ] **Colors:** Validate palette against Cyberpunk-Neon canonical

### Week 2 Actions
- [ ] **Linux host:** Extract Waybar/eww configs from hyprdots/cybrland
- [ ] **Magisk:** Evaluate MMT-Extended for utility integration
- [ ] **Themes:** Sync design tokens across WebUI, ANSI, CSS

### Month 2+ Actions
- [ ] **Future:** ZygiskNext evaluation (if adding Zygisk features)
- [ ] **Launcher:** Material 3 color sync (optional)

---

## Quick Reference: Which Repo for Which Problem?

| Problem | Repo | Location |
|---------|------|----------|
| "How do I partition the device?" | LineageOS Device Tree | `01-DEVELOPMENT/repos/.../lineage-device-guacamole/` |
| "What kernel should I use?" | engstk blu_spark, OnePlus OSS | `07-KERNEL-PACKAGE-MODULES/kernel-*` |
| "How do I scale boot animation?" | Video-to-BootAnimation | `01-DEVELOPMENT/repos/boot-animation-tools/` |
| "How do other CP2077 modules work?" | ENEIZEM module | `01-DEVELOPMENT/repos/cyberpunk/reference-*` |
| "Are my colors right?" | Cyberpunk-Neon | `06-UI-THEMES-ANIMATIONS/repos/cyberpunk-neon-*` |
| "How do I style Waybar?" | hyprdots, cybrland | `06-UI-THEMES-ANIMATIONS/repos/` |
| "Should I use MMT-Extended?" | MMT-Extended | `01-DEVELOPMENT/repos/magisk-ecosystem/mmt-extended/` |

---

## Storage & Cleanup

**Total disk space used:** ~5-8 GB (mostly kernels)

**Cleanup (if needed):**
```bash
# Remove large kernel sources (if not needed)
rm -rf 07-KERNEL-PACKAGE-MODULES/kernel-oneplus-oss

# Remove temporary clones
rm -rf 01-DEVELOPMENT/repos/boot-animation-tools  # if not integrating code
```

**.gitignore status:** All cloned repos should be gitignored (per CLAUDE.md).

---

## Next Steps

1. **Verify all clones:** `find . -name ".git" -type d | wc -l` → should be ~14
2. **Update manifests:** `bash 99-MANIFESTS/generate-manifests.sh`
3. **Start integration:** `cat 09-DOCS/REPO-INTEGRATION-TASKS.md`

