# Cloned Reference Repositories

## Overview

This document catalogs the 10 reference repositories cloned into this workspace on **May 16, 2026**. These repos provide:

- **Framework references** for Magisk module development
- **Media processing tools** for animation optimization
- **CI/CD infrastructure** for release automation and supply chain security
- **Desktop environment tools** for Linux host theming
- **Build system examples** for Android and Wayland applications

All repos are cloned with `--depth 1` (shallow clone) to minimize disk footprint. **Total size: ~527 MB**

---

## Repository Catalog

### Magisk Ecosystem

#### 1. **topjohnwu/Magisk** (Core Framework)
- **Location:** `01-DEVELOPMENT/repos/magisk-ecosystem/magisk-core/`
- **Size:** 9.7 MB
- **Purpose:** Reference implementation of the Magisk framework
- **Useful for:**
  - Module architecture patterns (customize.sh, post-fs-data.sh, service.sh)
  - Property handling and version code formulas
  - post-fs-data lifecycle and binding strategies
- **Used by:** CP2077-OP7Pro/CP2077-Universal module development

---

### Media Tools

#### 2. **ffmpeg/ffmpeg** (Video/Audio Processing)
- **Location:** `01-DEVELOPMENT/repos/media-tools/ffmpeg/`
- **Size:** 134 MB
- **Purpose:** Comprehensive video encoding, scaling, and audio format conversion
- **Useful for:**
  - LANCZOS scaling reference for bootanimation frame upscaling (og1080p → og4k)
  - Audio format conversion (.ogg/.wav/etc) and normalization
  - Frame extraction and color space conversion
- **Used by:** `build.py` (v3.1.0) FFmpeg subprocess calls, audio generation pipeline

#### 3. **ImageMagick/ImageMagick** (Batch Image Processing)
- **Location:** `01-DEVELOPMENT/repos/media-tools/imagemagick/`
- **Size:** 81 MB
- **Purpose:** Advanced image manipulation, batch processing, PNG optimization
- **Useful for:**
  - Frame batch operations (color grading, contrast adjustment)
  - Animation preprocessing before FFmpeg encoding
  - PNG compression and metadata stripping
- **Used by:** Optional pre-processing stage for bootanimation variants

---

### CI/CD & Supply Chain

#### 4. **nektos/act** (GitHub Actions Simulator)
- **Location:** `01-DEVELOPMENT/repos/ci-cd-tools/act/`
- **Size:** 128 MB
- **Purpose:** Local GitHub Actions runtime for testing workflows
- **Useful for:**
  - Testing `.github/workflows/release.yml` before tag-triggered push
  - Offline validation of `nightly.yml` dry-run and supply chain checks
  - Debugging CodeQL and Scorecard workflows
- **Used by:** Pre-release validation with `cp2077-ci-local.sh` wrapper (v3.1.0+)

#### 5. **slsa-framework/slsa-github-generator** (Provenance Framework)
- **Location:** `01-DEVELOPMENT/repos/ci-cd-tools/slsa-framework/`
- **Size:** 40 MB
- **Purpose:** SLSA v1.0 provenance generation and supply chain security
- **Useful for:**
  - Reference implementation for `cp2077-slsa-provenance.sh`
  - In-toto Statement v1 schema validation
  - Release artifact attestation and verification
- **Used by:** GitHub Actions `release.yml` → SLSA v1.0 provenance step

---

### Linux Desktop Environment

#### 6. **hyprwm/Hyprland** (Wayland Compositor)
- **Location:** `05-LINUX/wayland-compositors/hyprland/`
- **Size:** 102 MB
- **Purpose:** Modern Wayland compositor with advanced animation and theming
- **Useful for:**
  - Animation timing/scaling logic reference for boot sequence
  - Wayland protocol integration for resource management
  - Theme configuration patterns (colors, fonts, borders)
  - Custom module scripting examples
- **Used by:** `05-LINUX/configs/cp2077-hyprland.conf`, Linux host desktop setup

#### 7. **davatorium/rofi** (Window Menu & Theming)
- **Location:** `05-LINUX/ui-tools/rofi/`
- **Size:** 28 MB
- **Purpose:** Dynamic window menu with Cyberpunk-compatible theming
- **Useful for:**
  - ANSI color palette and theme configuration
  - Application launcher and window switcher logic
  - CSS-like theming syntax adaptable to terminal UI
- **Used by:** Cyberpunk palette application in `cp2077-adb-control.sh` output

#### 8. **Alexays/Waybar** (Status Bar)
- **Location:** `05-LINUX/ui-tools/waybar/`
- **Size:** 3.2 MB
- **Purpose:** Modular status bar for Wayland compositors
- **Useful for:**
  - Real-time device status display (boot animation state, variant info)
  - Custom module scripting for device integration
  - System tray and notification area configuration
- **Used by:** Optional Linux host integration showing connected device status

---

## Repository Size Breakdown

| Category | Repos | Total Size | Purpose |
|----------|-------|-----------|---------|
| **Magisk Ecosystem** | 1 | 9.7 MB | Core framework reference |
| **Media Tools** | 2 | 215 MB | Animation/audio processing |
| **CI/CD Infrastructure** | 2 | 168 MB | Release automation & provenance |
| **Linux Desktop** | 3 | 133 MB | Wayland compositor & UI tools |
| **TOTAL** | **8** | **527 MB** | — |

---

## Failed Clones (2 repos)

The following repos were not cloned due to incorrect URLs or access issues:

1. **topjohnwu/KernelSU** — Repository URL not found
   - Alternative: Check main KernelSU org repository or AOSP kernel fork
   - Status: Deferred (not critical for current module workflow)

2. **rofi/rofi** — Repository not found under `rofi/rofi.git`
   - Resolution: Successfully cloned from `davatorium/rofi` (maintained fork)
   - Reason: Original URL was stale; davatorium maintains active fork

---

## .gitignore Integration

All reference repos are excluded from git tracking via updated `.gitignore`:

```gitignore
01-DEVELOPMENT/repos/media-tools/
01-DEVELOPMENT/repos/ci-cd-tools/
01-DEVELOPMENT/repos/android-frameworks/
01-DEVELOPMENT/repos/magisk-ecosystem/
05-LINUX/ui-tools/
05-LINUX/wayland-compositors/
```

These directories will NOT be pushed to GitHub. To re-clone locally:

```bash
cd /home/arch/dev/projects/cyberpunk-2077
bash 99-MANIFESTS/generate-manifests.sh  # Regenerate repo inventory
git clone --depth 1 [upstream-url] [local-path]  # Individual clone
```

---

## Integration Checklist

- [x] 8/10 repos successfully cloned
- [x] Organized into logical categories (magisk-ecosystem, media-tools, ci-cd-tools, ui-tools, wayland-compositors)
- [x] Added to `.gitignore` with explanatory comments
- [x] Shallow clones only (`--depth 1`) — no full history
- [x] Created this reference document
- [ ] (Optional) Run `bash 99-MANIFESTS/generate-manifests.sh` to update repo inventory
- [ ] (Optional) Test `act` with existing `.github/workflows/`
- [ ] (Optional) Validate SLSA provenance schema with existing `cp2077-slsa-provenance.sh`

---

## Next Steps

### Immediate (Production Ready)
- Reference existing clones for architecture patterns in module development
- Use FFmpeg/ImageMagick repos as build system documentation
- Validate CI/CD workflows against act runner

### Future Enhancement Opportunities
1. **Build System Optimization**
   - Compare `build.py` FFmpeg usage against upstream ffmpeg examples
   - Consider imagemagick batch operations for frame preprocessing

2. **CI/CD Hardening**
   - Implement offline workflow testing with `act` before tag push
   - Validate SLSA provenance schema after release

3. **Desktop Environment Integration**
   - Reference Hyprland animation timing for boot sequence choreography
   - Implement rofi-based variant switcher on Arch host
   - Add Waybar module for real-time device status

4. **Module Architecture Refinement**
   - Compare KernelSU approach to Magisk post-fs-data binding (defer pending URL resolution)
   - Evaluate shared module structure between KernelSU and Magisk implementations

---

**Document generated:** May 16, 2026  
**Cloned by:** GitHub Copilot  
**Workspace:** `/home/arch/dev/projects/cyberpunk-2077`
