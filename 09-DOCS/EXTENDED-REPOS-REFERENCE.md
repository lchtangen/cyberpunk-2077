# Extended Repositories Reference Guide

**Focus:** Alternative ROM device trees, build system utilities, icon packs, and development tools  
**Platform:** OnePlus 7 Pro + Android 16 + LineageOS 23.2 (extensible to other ROMs)  
**Use cases:** Multi-ROM testing, custom ROM builds, icon pack integration, system customization

---

## Part 1: Alternative ROM Device Trees (OP7 Pro)

### Why Clone Alternative ROM Trees?

You're currently on **LineageOS 23.2**. Cloning alternative ROM device trees gives you:

1. **Compatibility testing** — Verify your Magisk module works across ROMs
2. **Partition layout reference** — Different ROMs may partition differently
3. **Build reference** — Study how other ROMs structure device code
4. **Feature comparison** — See what customizations other ROMs support
5. **Maintenance flexibility** — If you switch ROMs, you'll have the tree ready

### crDroid Device Tree
**Repo:** `crDroid-ROM/android_device_oneplus_guacamole`  
**Location:** `01-DEVELOPMENT/repos/oneplus-7-pro/device-crdroid-guacamole/`

**What it is:** Device tree for crDroid on OP7 Pro  
**crDroid characteristics:**
- Customization-focused ROM (lots of settings)
- Performance optimizations
- Pixel+ features integrated
- Active community maintenance

**Use for:**
- Test module compatibility on crDroid
- Study customization hooks (proprietary blobs, partitions)
- Reference build.prop values
- Compare BoardConfig.mk (partition layout may differ slightly)

**Key files to compare:**
```bash
# Your reference (LineageOS):
01-DEVELOPMENT/repos/oneplus-7-pro/lineage-device-guacamole/BoardConfig.mk

# crDroid equivalent:
01-DEVELOPMENT/repos/oneplus-7-pro/device-crdroid-guacamole/BoardConfig.mk

# Diff them:
diff LineageOS/BoardConfig.mk crDroid/BoardConfig.mk | head -50
```

**Expected differences:**
- SELinux policies (context paths may differ)
- System properties (ro.build.fingerprint, ro.build.version.all_codenames)
- Partition mount points (unlikely to differ for /product/media but good to verify)

---

### Evolution-X Device Tree
**Repo:** `Evolution-X/android_device_oneplus_guacamole`  
**Location:** `01-DEVELOPMENT/repos/oneplus-7-pro/device-evolution-x-guacamole/`

**What it is:** Device tree for Evolution-X on OP7 Pro  
**Evolution-X characteristics:**
- Performance-focused, minimal bloat
- Clean, stable code base
- Minimal customization (closer to AOSP)
- Good reference for pure Android

**Use for:**
- Minimal ROM testing (good baseline for module compatibility)
- AOSP-like behavior study
- Performance tuning reference
- Clean partition layout reference

**Comparison with LineageOS:**
Evolution-X is closer to AOSP → fewer custom properties → simpler module compatibility.

---

### Pixel Experience Device Tree
**Repo:** `PixelExperience/android_device_oneplus_guacamole`  
**Location:** `01-DEVELOPMENT/repos/oneplus-7-pro/device-pixel-experience-guacamole/`

**What it is:** Device tree for Pixel Experience on OP7 Pro  
**Pixel Experience characteristics:**
- Google Pixel-like experience (Pixel launcher, camera, etc.)
- Clean, stable, minimal customization
- Actively maintained
- Good for Material Design integration

**Use for:**
- Pixel-like UI testing
- Material Design color scheme integration
- Clean AOSP reference
- Launcher compatibility testing (your Lawnchair integration)

---

### DerpFest Device Tree
**Repo:** `DerpFest-GSI/android_device_oneplus_guacamole`  
**Location:** `01-DEVELOPMENT/repos/oneplus-7-pro/device-derpfest-guacamole/`

**What it is:** Device tree for DerpFest (Derp ROM) on OP7 Pro  
**DerpFest characteristics:**
- Humor-focused ROM name, serious codebase
- Based on LineageOS with additions
- Good customization support
- Active development

**Use for:**
- LineageOS-compatible testing (shares codebase)
- Extended customization reference
- Feature comparison with base LineageOS

---

## Part 2: SM8150 Common Device Code

### Why SM8150 Common?

Your OP7 Pro uses **SM8150** (Snapdragon 855). Other SM8150 devices share common code:
- OnePlus 7T, 7T Pro
- OnePlus 8 (early model)
- Oppo Reno (some variants)

Cloning SM8150 common gives you:
1. **Shared code reference** — Understand what's OP7-specific vs. SM8150-wide
2. **Partition layout baseline** — SM8150 common defines shared partitions
3. **Kernel bindings** — Device tree bindings shared across SM8150 devices
4. **Property definitions** — System properties shared across SM8150 devices

### LineageOS SM8150 Common
**Repo:** `LineageOS/android_device_oneplus_sm8150-common`  
**Location:** `01-DEVELOPMENT/repos/oneplus-7-pro/device-lineage-sm8150-common/`

**What it includes:**
- Shared init scripts (init.qcom.rc files)
- Kernel device tree overlays (.dtb files)
- System properties (build.prop, system.prop)
- Partition mount script
- Audio configuration

**Key files to reference:**
```
device/oneplus/sm8150-common/
├── init.qcom.rc              # Shared boot scripts
├── Audio_Device.xml           # Audio routing (for audio boot animations)
├── device.mk                  # Shared system properties
├── BoardConfig.mk             # Shared partition config
└── rootdir/                   # init.d scripts
```

**Why it matters:** When your module binds mounts `/product/media/bootanimation.zip`, it's mounting to a path defined in SM8150 common partition layout.

---

### crDroid SM8150 Common
**Repo:** `crDroid-ROM/android_device_oneplus_sm8150-common`  
**Location:** `01-DEVELOPMENT/repos/oneplus-7-pro/device-crdroid-sm8150-common/`

**Comparison with LineageOS:**
crDroid's common tree likely has:
- Additional customization hooks
- Extra system properties for features
- Modified audio configuration
- Performance tuning patches

**Use for:**
- Understanding ROM-specific customizations
- Comparing partition/mount strategies
- Testing module on crDroid

---

## Part 3: Build System & Development Utilities

### LineageOS Manifest (For Building Custom ROMs)
**Repo:** `LineageOS/android_manifest`  
**Location:** `01-DEVELOPMENT/repos/lineageos-manifest/`

**What it is:** Official LineageOS repo manifest (list of all repos to sync)  
**Use for:**
- Setting up a LineageOS build environment
- Understanding repo dependencies
- Custom ROM building (future development)
- Manifest structure reference

**Key file:** `default.xml` — lists all repos needed for full build

**Example use case:**
```bash
# If you wanted to build LineageOS from source:
mkdir ~/los-build && cd ~/los-build
repo init -u git@github.com:LineageOS/android_manifest.git -b lineage-23.1
repo sync -j$(nproc)
```

**For your project:** Reference only. Useful if you want to:
- Build custom LineageOS variant
- Understand repo dependencies
- Customize Android system (advanced)

---

### Magisk Modules Repository Submission Guide
**Repo:** `Magisk-Modules-Repo/submission`  
**Location:** `01-DEVELOPMENT/repos/magisk-modules-repo-submission/`

**What it is:** Official guide + utilities for submitting modules to Magisk Modules Repository  
**Use for:**
- Module submission checklist
- Automated validation scripts
- Best practices for module structure
- Publishing your CP2077 module (future)

**Key files to study:**
- `README.md` — Submission guidelines
- Validation scripts — Module structure checkers
- Examples — Well-structured module examples

**For your project:**
- Validate your module structure
- Prepare for eventual publication to Magisk Modules Repo
- Follow best practices early

**Action item:**
```bash
cd 01-DEVELOPMENT/repos/magisk-modules-repo-submission
# Review submission guidelines
cat README.md | grep -A 50 "Requirements\|Structure"

# Run validation against your module
bash validate.sh ../../cyberpunk/CP2077-OP7Pro/
```

---

### Official Magisk Source Code
**Repo:** `topjohnwu/Magisk`  
**Location:** `01-DEVELOPMENT/repos/magisk-ecosystem/magisk-official/`

**What it is:** Official Magisk source (Magisk manager + daemon)  
**Use for:**
- Understanding Magisk internals
- Magisk API reference
- Module execution flow
- Module.prop format specification
- Latest Magisk features

**Key files:**
- `docs/install.md` — Installation process
- `docs/develop.md` — Module development guide
- `src/boot_stage.cpp` — Module execution order

**For your project:**
- Reference for understanding module execution timeline
- API documentation for advanced features
- Magisk version compatibility check

---

## Part 4: Icon Packs & Theming

### Why Clone Icon Packs?

Icon packs give you:
1. **Color palette reference** — Study how others use Cyberpunk colors
2. **SVG structure** — Learn icon design patterns
3. **Launcher integration** — Test with your Lawnchair setup
4. **Customization source** — Create cyberpunk-themed variants
5. **Visual consistency** — Icons matching your theme

### Papirus Icon Theme
**Repo:** `Papirus-Team/papirus-icon-theme`  
**Location:** `06-UI-THEMES-ANIMATIONS/repos/papirus-icon-theme/`

**Characteristics:**
- Highly customizable
- Monochrome + colorful variants
- 10,000+ icons
- Actively maintained
- Works with cyberpunk colors

**Directories:**
```
papirus-icon-theme/
├── Papirus/                   # Default
├── Papirus-Dark/              # Dark variant
├── Papirus-Adapta/            # Adapta theme variant
└── [other variants]
```

**Use for:**
- Extract icon color scheme
- Study SVG structure (icons are SVG files)
- Create Cyberpunk variant (clone → recolor → install)
- Launcher icon testing

**Create cyberpunk variant:**
```bash
cd 06-UI-THEMES-ANIMATIONS/repos/papirus-icon-theme
# Copy theme
cp -r Papirus Papirus-Cyberpunk

# Use your color palette to recolor
# (convert #FCEE0C cyan #00FFFF, etc.)
# Tools: ImageMagick, Inkscape scripting, or Python PIL
```

---

### Tela Icon Theme
**Repo:** `vinceliuice/Tela-icon-theme`  
**Location:** `06-UI-THEMES-ANIMATIONS/repos/tela-icon-theme/`

**Characteristics:**
- Modern, clean design
- Colorful + monochrome variants
- Well-organized icon library
- Active maintenance
- Popular on Linux

**Use for:**
- Modern icon reference
- Color palette application study
- Cyberpunk recolor (similar to Papirus)
- Launcher integration testing

---

### Frost Neon Icon Theme
**Repo:** `Frost-Team/Frost-Neon-Icon-Theme`  
**Location:** `06-UI-THEMES-ANIMATIONS/repos/frost-neon-icon-theme/`

**Characteristics:**
- Neon aesthetic (direct thematic match!)
- Bright, vibrant colors
- Cyberpunk-friendly out of the box
- Well-suited to Cyberpunk color palette

**Use for:**
- **Direct reference** — Already has neon aesthetic
- Color palette validation (compare neon colors with yours)
- Icon design reference
- Minimal recoloring needed for cyberpunk theme

**Key colors in Frost Neon:**
Compare with your palette:
```
Your colors:     Frost Neon:
#FCEE0C yellow   ≈ bright yellow
#00FFFF cyan     ≈ bright cyan
#FF003C red      ≈ bright red
```

---

## Integration Plan for Extended Repos

### Week 1: Device Tree Compatibility Testing
- [ ] Clone 4 alternative ROM device trees
- [ ] Compare BoardConfig.mk across all ROMs
- [ ] Verify partition mount paths consistent
- [ ] Test module on LineageOS 23.2 (baseline)

### Week 2: Build System Study
- [ ] Review LineageOS manifest structure
- [ ] Run Magisk Modules submission validation
- [ ] Study official Magisk source (module execution order)
- [ ] Document findings in `09-DOCS/MODULE-COMPATIBILITY.md`

### Week 3: Icon Pack Integration
- [ ] Study Papirus color application
- [ ] Study Tela modern design patterns
- [ ] Review Frost Neon neon aesthetic
- [ ] Create cyberpunk icon variant (optional advanced task)

### Month 2+: Advanced Development
- [ ] Build custom LineageOS variant (if desired)
- [ ] Test CP2077 module compatibility on crDroid + Evolution-X
- [ ] Publish module to Magisk Modules Repo (using submission guide)
- [ ] Create icon pack variant with CP2077 cyberpunk colors

---

## Quick Reference: Which Repo for What?

| Goal | Repo |
|------|------|
| "Does my module work on other ROMs?" | Clone all 4 device trees; test |
| "How are partitions laid out?" | SM8150 common trees (both) |
| "What are system properties I should know?" | All device trees → build.prop |
| "Can I build a custom ROM?" | LineageOS manifest + device trees |
| "Should I publish my module?" | Magisk Modules Repository submission |
| "How does Magisk execute modules?" | Official Magisk source |
| "What icons should I use?" | Frost Neon (neon), Papirus (versatile), Tela (modern) |
| "How do I recolor icons?" | Papirus/Tela (SVG-based, easiest to recolor) |

---

## Storage Considerations

**Disk space for extended repos:**
- 4 ROM device trees: ~200 MB total
- 2 SM8150 common trees: ~100 MB total
- LineageOS manifest: ~5 MB
- Magisk official source: ~150 MB
- Icon packs (3): ~500 MB total
- **Total: ~1 GB**

**Total with original clones: ~6-9 GB**

---

## Next Steps

1. **Run extended cloning script:**
   ```bash
   bash clone-repos-extended.sh
   ```

2. **Verify all clones:**
   ```bash
   find . -name ".git" -type d | wc -l
   ```

3. **Update manifests:**
   ```bash
   bash 99-MANIFESTS/generate-manifests.sh
   ```

4. **Start extended integration tasks:**
   - Compatibility testing across ROMs
   - Icon pack evaluation
   - Build system study

---

*Extended repositories provide multi-ROM compatibility testing, build system utilities, and design asset references for advanced customization and module publication.*

