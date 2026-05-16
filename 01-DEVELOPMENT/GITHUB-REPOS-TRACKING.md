# GitHub Repository Integration Tracking

**Last updated:** 2026-05-16  
**Project:** CP2077 OnePlus 7 Pro / Linux Theming Suite  
**Workspace:** `/home/arch/dev/projects/cyberpunk-2077`

---

## Quick Reference Table

| Repo | Category | Priority | Status | Integration | Tech Stack |
|------|----------|----------|--------|-------------|-----------|
| [LineageOS/android_device_oneplus_guacamole](https://github.com/LineageOS/android_device_oneplus_guacamole) | Device Tree | ⭐⭐⭐ | Active | Reference | Makefile, Shell |
| [engstk/op7](https://github.com/engstk/op7) | Kernel | ⭐⭐⭐ | Active | Reference | C, Kconfig |
| [OnePlusOSS/android_kernel_oneplus_sm8150](https://github.com/OnePlusOSS/android_kernel_oneplus_sm8150) | Kernel | ⭐⭐⭐ | Active | Upstream | C, Kconfig |
| [rhythmcache/Video-to-BootAnimation-Creator-Script](https://github.com/rhythmcache/Video-to-BootAnimation-Creator-Script) | Boot Animation | ⭐⭐⭐ | Active | Code Reference | Python, FFmpeg |
| [Zackptg5/MMT-Extended](https://github.com/Zackptg5/MMT-Extended) | Magisk Module | ⭐⭐⭐ | Active | Optional Integration | Shell |
| [SAPTeamDEV/Magisk-Module-Template](https://github.com/SAPTeamDEV/Magisk-Module-Template) | Magisk Module | ⭐⭐ | Active | Reference | Shell, GitHub Actions |
| [Woomymy/Magisk-Module-GH-Actions-Template](https://github.com/Woomymy/Magisk-Module-GH-Actions-Template) | CI/CD | ⭐⭐ | Active | Reference | Shell, YAML |
| [ENEIZEM/Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO](https://github.com/ENEIZEM/Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO) | Boot Animation | ⭐⭐⭐ | Active | Code Reference | Shell, ZIP |
| [Roboron3042/Cyberpunk-Neon](https://github.com/Roboron3042/Cyberpunk-Neon) | Design Tokens | ⭐⭐⭐ | Active | Token Reference | CSS, QML, Shell |
| [UtkarshKunwar/K-DE-Cyberpunk-Neon](https://github.com/UtkarshKunwar/K-DE-Cyberpunk-Neon) | Linux Theme | ⭐⭐⭐ | Active | Submodule Upstream | QML, CSS |
| [Dr-TSNG/ZygiskNext](https://github.com/Dr-TSNG/ZygiskNext) | Root Framework | ⭐⭐ | Active | Future Integration | Java, C++ |
| [LawnchairLauncher/lawnchair](https://github.com/LawnchairLauncher/lawnchair) | Launcher | ⭐⭐ | Active | Reference | Kotlin, Android |
| [prasanthrangan/hyprdots](https://github.com/prasanthrangan/hyprdots) | Linux Config | ⭐⭐ | Active | Reference | Shell, Hyprland |
| [scherrer-txt/cybrland](https://github.com/scherrer-txt/cybrland) | Linux Theme | ⭐⭐ | Active | Reference | Shell, Hyprland |
| [OrangeFoxRecovery/device_oneplus_guacamole](https://github.com/OrangeFoxRecovery/device_oneplus_guacamole) | Recovery | ⭐ | Active | Reference | C, Makefile |
| [snake-4/Zygisk-Assistant](https://github.com/snake-4/Zygisk-Assistant) | Root Framework | ⭐ | Active | Optional | Java, C++ |
| [bootanimation/bootanimation.github.io](https://github.com/bootanimation/bootanimation.github.io) | Boot Animation | ⭐ | Active | Reference | JavaScript |
| [koro33e/BootAnimationMaker](https://github.com/koro33e/BootAnimationMaker) | Boot Animation | ⭐ | Active | Reference | Python |
| [AxonShell/BootanimationBuilder](https://github.com/AxonShell/BootanimationBuilder) | Boot Animation | ⭐ | Active | Reference | Python, GUI |
| [WildKernels/OnePlus_KernelSU_SUSFS](https://github.com/WildKernels/OnePlus_KernelSU_SUSFS) | Kernel | ⭐ | Active | Reference | C |
| [aranel616/neon-nexus](https://github.com/aranel616/neon-nexus) | Linux Theme | ⭐ | Active | Reference | Shell, TOML, YAML |
| [gwannon/Cyberpunk-2077-theme-css](https://github.com/gwannon/Cyberpunk-2077-theme-css) | WebUI Design | ⭐ | Active | Reference | CSS3 |
| [LawnchairLauncher/lawnicons](https://github.com/LawnchairLauncher/lawnicons) | Icon Theme | ⭐ | Active | Reference | SVG, Python |

---

## Priority Legend

- ⭐⭐⭐ **Critical:** Use immediately for reference or code patterns
- ⭐⭐ **High:** Study for implementation guidance  
- ⭐ **Medium:** Reference for edge cases or future work

---

## Integration by Category

### 1. Device Tree & Kernel (OP7 Pro Foundation)

#### LineageOS Device Tree
**Repo:** `LineageOS/android_device_oneplus_guacamole`  
**Priority:** ⭐⭐⭐ Critical  
**Purpose:** Official device tree for OP7 Pro (GM1911, codename `guacamole`)  
**Integration:**
- Reference for `BoardConfig.mk`, `device.mk`, partition layouts
- Use for ROM variant compatibility testing
- Store shallow clone at `01-DEVELOPMENT/repos/oneplus-7-pro/lineage-device-guacamole/` if not already present

**Key files to study:**
- `BoardConfig.mk` — partition sizes, SELinux contexts
- `device.mk` — system properties, init scripts
- `init/*.rc` — boot sequence hooks (where `customize.sh` fires)

---

#### OnePlus OSS Kernel (SM8150)
**Repo:** `OnePlusOSS/android_kernel_oneplus_sm8150`  
**Priority:** ⭐⭐⭐ Critical  
**Purpose:** Official OnePlus kernel source (Snapdragon 855)  
**Integration:**
- Upstream reference for all OP7 kernel work
- Use for defconfig baseline, security patches
- Cross-reference with custom kernels (engstk, NetHunter) to understand delta

**Action items:**
- Pin a specific tag (e.g., OOS 14.0.x for Android 14) in `01-DEVELOPMENT/repos/oneplus-7-pro/`
- Run `git log --oneline --all` to track OOS security patches

---

#### blu_spark Kernel (engstk)
**Repo:** `engstk/op7`  
**Priority:** ⭐⭐⭐ Critical  
**Purpose:** Popular OP7 Pro custom kernel; performance + stability focus  
**Integration:**
- Reference for tuning (governor, I/O scheduler, thermal)
- Study `arch/arm64/configs/guacamole_defconfig` for performance/stability tradeoffs
- Compare patch delta vs. OnePlus OSS to understand customization patterns

**Why relevant:** If your Linux host interacts with kernel features (e.g., thermal monitoring, power states), this kernel's optimizations apply to ADB-based monitoring scripts.

---

### 2. Boot Animation Framework (Core Functionality)

#### Video-to-BootAnimation-Creator-Script
**Repo:** `rhythmcache/Video-to-BootAnimation-Creator-Script`  
**Priority:** ⭐⭐⭐ Critical  
**Purpose:** Converts MP4/GIF → bootanimation.zip with FFmpeg LANCZOS scaling  
**Integration:**
- **Direct code pattern match:** Study `scripts/video_to_animation.py` and FFmpeg LANCZOS calls
- Compare scaling approach with your `build.py` logic (you use LANCZOS 2× upscaling for `og4k` variant)
- Reference for multi-resolution generation (12 target resolutions in Universal build)

**Action items:**
- Extract LANCZOS FFmpeg command chain and verify against your `build.py` line 127 (frame scaling logic)
- Document any command-line flag differences between their implementation and yours
- Consider contributing improvements if you find discrepancies

---

#### ENEIZEM's CP2077 Bootanimation Module
**Repo:** `ENEIZEM/Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO`  
**Priority:** ⭐⭐⭐ Critical  
**Purpose:** Reference CP2077 Magisk module (POCO variant)  
**Integration:**
- Study `customize.sh` for variant selection logic (compare with your `lib/config-v2.sh`)
- Review `post-fs-data.sh` mount path strategy; cross-reference with your module:prop mounting logic
- Examine `module.prop` format and versionCode scheme

**Action items:**
- Clone repo: `git clone --depth 1 https://github.com/ENEIZEM/Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO.git /tmp/eneizem-ref`
- Extract `customize.sh` and diff against your own (look for variant handling patterns)
- Check their boot audio integration (if any) vs. your audio system

**Expected diff:** Their module is simpler (single variant) vs. your 7-variant system; good baseline.

---

#### Other Boot Animation Tools
**Repos:**
- `bootanimation/bootanimation.github.io` — Web-based ZIP generator (UI reference)
- `koro33e/BootAnimationMaker` — Python with Magisk module output (workflow reference)
- `AxonShell/BootanimationBuilder` — Modern builder with safety focus

**Integration:**
- Use as reference for validation logic (ZIP integrity, desc.txt format)
- Study error handling for malformed animations (useful for your CI pre-checks)

---

### 3. Magisk Module Development (Build Scaffolding)

#### MMT-Extended
**Repo:** `Zackptg5/MMT-Extended`  
**Priority:** ⭐⭐⭐ Critical  
**Purpose:** Advanced Magisk Module Template with utilities  
**Integration:**
- Study hook system: `post-fs-data.sh` hook priority ordering
- Reference busybox utilities: `sh`, `find`, `sed`, `awk` wrapping
- Review modutils functions (e.g., `mount_mask()`, `uninstall_module()`)

**Your use case:**
- You already have custom `post-fs-data.sh` and `service.sh` logic
- MMT-Extended provides utilities to simplify mount operations (could reduce your shell boilerplate)
- **Optional:** Consider minimal MMT-Extended integration for utility functions only (don't replace your whole module structure)

**Decision point:** Your current approach is solid. Use MMT-Extended only if you find yourself duplicating utility functions.

---

#### GitHub Actions Templates
**Repos:**
- `SAPTeamDEV/Magisk-Module-Template` — GH Actions + auto-release
- `Woomymy/Magisk-Module-GH-Actions-Template` — Modern CI with update.json generation

**Integration:**
- Cross-reference against your `.github/workflows/release.yml` and `nightly.yml`
- Study their `update.json` generation step (compare with your supply chain tooling)
- Check for missing GitHub Actions features (e.g., draft release auto-cleanup, retry logic)

**Action items:**
- Review SAPTeamDEV's release action flow; compare with your own
- If their approach is simpler, consider backporting specific steps

---

### 4. Design Tokens & Theme Consistency

#### Cyberpunk-Neon (Roboron3042)
**Repo:** `Roboron3042/Cyberpunk-Neon`  
**Priority:** ⭐⭐⭐ Critical  
**Purpose:** Canonical cyberpunk color scheme + multi-platform themes  
**Integration:**
- **Cross-check your palette:**
  - Your `--yellow: #FCEE0C` vs. their palette
  - Your `--cyan: #00FFFF` vs. their secondary
  - Verify consistency across WebUI, ANSI, CSS, Plymouth

**Repository structure to study:**
- `/colors/` — color definitions (YAML, JSON, X11)
- `/kde/` — KDE Plasma theme (QML, CSS)
- `/gtk/` — GTK theme
- `/css/` — Generic CSS exports

**Action items:**
1. Run color diff tool (optional): Generate PNG palette swatches
2. Update your design tokens doc (`09-DOCS/design-tokens.md` if it exists) with canonical sources
3. Sync WebUI color variables with this repo's official definitions

**Expected outcome:** Unified color scheme across all surfaces (Android WebUI, Linux Waybar, Plymouth, Rofi).

---

#### K-DE-Cyberpunk-Neon (Your Submodule Upstream)
**Repo:** `UtkarshKunwar/K-DE-Cyberpunk-Neon`  
**Priority:** ⭐⭐⭐ Critical  
**Purpose:** KDE Plasma + GTK Cyberpunk Neon theme (your submodule upstream)  
**Integration:**
- Verify your submodule HEAD matches upstream
- Check for unmerged upstream patches (run `git log --oneline --all` in submodule)
- Study their KDE Plasma SVG/QML patterns for future Linux host customization

**Action items:**
```bash
cd 06-UI-THEMES-ANIMATIONS/themes/K-DE-Cyberpunk-Neon
git fetch origin
git log --oneline main..origin/main  # Check for unmerged commits
```

---

### 5. Linux Host Theming (Hyprland, Waybar, etc.)

#### hyprdots (prasanthrangan)
**Repo:** `prasanthrangan/hyprdots`  
**Priority:** ⭐⭐ High  
**Purpose:** Complete Hyprland dotfiles with aesthetic focus  
**Integration:**
- Reference for Waybar config structure (see your `05-LINUX/arch-host/`)
- Study dunst notification theme (NW corner Hyprland behavior)
- Review rofi/wofi config for launcher styling

**Why useful:** Provides production-grade configs that match your Linux theming scope (Hyprland, Waybar, eww, hyprlock).

**Action items:**
- Clone for reference: `git clone https://github.com/prasanthrangan/hyprdots /tmp/hyprdots-ref`
- Extract Waybar config and compare with yours
- Adopt any missing features (e.g., animated workspace indicators)

---

#### cybrland (scherrer-txt)
**Repo:** `scherrer-txt/cybrland`  
**Priority:** ⭐⭐ High  
**Purpose:** Cyberpunk dotfiles for Arch Hyprland (thematic match!)  
**Integration:**
- **Direct thematic alignment:** Cyberpunk-themed Hyprland setup
- Study color scheme (compare with your design tokens)
- Reference for eww (Elkowars Wacky Widgets) configuration

**Action items:**
- Clone: `git clone https://github.com/scherrer-txt/cybrland /tmp/cybrland-ref`
- Extract eww config and compare with your linux host setup
- Adopt styling patterns if they improve visual cohesion

---

#### neon-nexus (aranel616)
**Repo:** `aranel616/neon-nexus`  
**Priority:** ⭐ Medium  
**Purpose:** Neon-themed configs for Hyprland, Waybar, Rofi, Kitty, Firefox, Dolphin  
**Integration:**
- Secondary reference for multi-tool neon theming
- Study Firefox theme integration (useful for WebUI consistency)
- Review Kitty terminal colors (for ADB script ANSI output)

---

### 6. Root Frameworks (Future Integration)

#### ZygiskNext (Dr-TSNG)
**Repo:** `Dr-TSNG/ZygiskNext`  
**Priority:** ⭐⭐ High (Future)  
**Purpose:** Open-source Zygisk for Magisk/KernelSU/APatch  
**Integration:**
- Currently: Reference only (your modules don't require Zygisk)
- Future: If you add system hook features (e.g., intent interception for UI customization)
- Study for multi-root-framework compatibility pattern

**Action items:**
- Bookmark for future reference
- When/if adding Zygisk features, use this as primary reference
- Cross-reference with Zygisk-Assistant for root framework abstraction

---

### 7. Launcher & Icon Customization (Optional)

#### Lawnchair (LawnchairLauncher)
**Repo:** `LawnchairLauncher/lawnchair`  
**Priority:** ⭐⭐ High (Reference)  
**Purpose:** Open-source Pixel Launcher + Material 3 theming  
**Integration:**
- Reference for Material 3 color integration patterns
- Study for launcher customization depth (relevant to your Lawnchair-Launcher-Module submodule)
- Use for future UI consistency work

**Action items:**
- Check your Lawnchair-Launcher-Module submodule against upstream
- Study Material 3 color override system (could apply to WebUI)

---

#### Lawnicons (Icon Pack)
**Repo:** `LawnchairLauncher/lawnicons`  
**Priority:** ⭐ Medium  
**Purpose:** Monochrome outlined icon pack  
**Integration:**
- Reference for icon design patterns (if expanding cyberpunk icon theme)
- Study for SVG theming system

---

### 8. Recovery & Device Management

#### OrangeFox Recovery (OP7 Pro)
**Repo:** `OrangeFoxRecovery/device_oneplus_guacamole`  
**Priority:** ⭐ Medium  
**Purpose:** Official OrangeFox recovery for OP7 Pro  
**Integration:**
- Reference for device-specific recovery configuration
- Use for flashing compatibility validation
- Low-priority; mainly informational for ROM/Magisk workflows

---

## Implementation Roadmap

### Phase 1: Immediate (This Week)
- [ ] Clone ENEIZEM CP2077 module to `/tmp/` for `customize.sh` diff
- [ ] Review `rhythmcache/Video-to-BootAnimation-Creator-Script` FFmpeg patterns
- [ ] Verify Roboron3042 color palette against your design tokens
- [ ] Run `git fetch` on K-DE-Cyberpunk-Neon submodule; check for upstream patches

### Phase 2: This Month
- [ ] Study MMT-Extended utility functions (decide: integrate or skip)
- [ ] Cross-reference GitHub Actions workflows (SAPTeamDEV vs. yours)
- [ ] Clone hyprdots and cybrland for Waybar/eww configuration reference
- [ ] Update design-tokens.md with canonical source URLs

### Phase 3: Next Quarter
- [ ] Evaluate ZygiskNext for future module features
- [ ] Integrate Lawnchair launcher variant if pursuing deeper customization
- [ ] Consider color sync automation (design tokens → CSS/QML/JSON exports)

---

## CSV Export (for spreadsheet import)

| Repo URL | Category | Priority | Status | Integration Type | Tech Stack | Notes |
|----------|----------|----------|--------|------------------|-----------|-------|
| https://github.com/LineageOS/android_device_oneplus_guacamole | Device Tree | 3 | Active | Reference | Makefile,Shell | OP7 Pro official device tree |
| ... | ... | ... | ... | ... | ... | ... |

*(Full CSV available on request for import into Google Sheets / Excel)*

---

## Notes for Future Reference

- **Color Palette Drift:** If you update design tokens, audit these files: WebUI (`webroot/index.html`), ANSI output (`cp2077-adb-control.sh`), Waybar config, Plymouth theme.
- **Version Drift:** Keep `module.prop` versions in sync across: `build.py`, `build-universal.py`, `releases/update-*.json`, ZIP-local `update.json`.
- **Submodule Tracking:** Monitor upstream for K-DE-Cyberpunk-Neon, Lawnchair-Launcher-Module, cyberpunk-technotronic-icon-theme; quarterly pull.

