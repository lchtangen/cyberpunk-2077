# 🗺 ROADMAP — Cyberpunk 2077 Magisk Theme Suite

> Last updated: 2026-05-13 (build session) · Maintained by: lchtangen

---

## 📌 Current Release

| Module | Version | Status |
|--------|---------|--------|
| CP2077_OP7Pro_Full | v3.0.0 | ✅ Stable — active on device |
| CP2077_OP7Pro_Ultimate | v3.0.0 | 🟡 Built — disabled (superseded by Full) |
| CP2077_Universal | v1.0.0 | 🟢 Built — release ZIP at `release/CP2077-Universal-v1.0.0.zip` (278 MB) |

---

## 🐛 Known Bugs (open)

| ID | Severity | Description | Fix |
|----|----------|-------------|-----|
| BUG-01 | High | ~~`og4k` bootanimation dir is empty~~ **FIXED** — upscaled from og1080p via Pillow LANCZOS 2× (2160×4800, 267 frames, 358 MB). Shutdown adapted from glitch frames at 2160×4800. | ~~Source or upscale~~ |
| BUG-02 | Medium | ~~Full module has no shutdown animation for `og1080p`~~ **FIXED** — `shutdownanimation/og1080p/` created (reboot frames, desc rewritten to 1080×2340). `og4k` still pending. | ~~Create shutdown anim for og1080p~~ |
| BUG-03 | Medium | ~~CP2077-Universal `release/` dir is empty — OTA update.json URL will 404~~ **FIXED** — `CP2077-Universal-v1.0.0.zip` built (278 MB) + 4 per-variant ZIPs | ~~Build v1.0.0 Universal zip~~ |
| BUG-04 | Low | ~~`update.json` points to non-existent CP2077-OP7Pro repo~~ **FIXED** — `releases/update-full.json` + `releases/update-universal.json` now in workspace repo. GitHub releases v3.0.0-full and v1.0.0-universal published with ZIPs. | ~~Publish releases~~ |
| BUG-05 | Low | ~~`CP2077-OP7Pro-build-source` (v1.0 legacy) undocumented in all manifests and docs~~ **FIXED** — added to git-repositories.txt and README | ~~Add to manifests~~ |
| BUG-06 | Low | ~~Upstream `cyberpunk-technotronic-icon-theme` has ~20 broken SVG symlinks~~ **FIXED** — dangling symlinks removed locally (icons fall back to system theme for missing entries). | ~~Report or patch~~ |

---

## 🚀 Short-Term (v3.1.0 — next sprint)

### 🎬 Animation
- [ ] **Source og4k bootanimation** — upscale existing glitch/flatline to 4K using FFmpeg or obtain from CP2077 game assets (3840×2160 target)
- [x] **og1080p shutdown animation** — created (reboot frames adapted to 1080×2340)
- [ ] **og4k shutdown animation** — matching shutdown for the 4K variant once sourced
- [ ] **Reverse-boot (rboot) coverage** — verify `rbootanimation.zip` is correctly set for all 4 variants

### 📦 Build & Release
- [ ] **Publish v3.0.0 GitHub release** — tag, upload ZIPs, fix `update.json` OTA pointer
- [x] **Build CP2077-Universal v1.0.0 zip** — built 2026-05-13 (278 MB universal + 4 per-variant ZIPs)
- [ ] **Build megapack v3.0.0** — single ZIP containing all variants (replaces v2.0.0-beta-megapack)

### 🔧 Installer Improvements
- [ ] **Variant preview in installer** — print ASCII description of each variant during `customize.sh` selection
- [ ] **Silent/non-interactive install mode** — `cp2077.conf` pre-seeded install skips all prompts
- [ ] **Config migration** — detect v2.x config schema and auto-upgrade to v3 format on reflash

---

## 🔵 Mid-Term (v4.0.0)

### 📱 Universal Module
- [ ] **Full MIUI/HyperOS testing and validation** — verify `ROM_FAMILY=miui` path matrix works on Xiaomi devices
- [ ] **Samsung One UI validation** — test `/system/media/bootanimation.zip` path on Galaxy devices
- [ ] **Resolution auto-scaling pipeline** — `build-universal.py` generates per-resolution ZIPs (720p, 1080p, 1440p, 4K) at build time using FFmpeg frame scaling
- [ ] **Dynamic density selection** — pick 30fps vs 60fps based on `ro.sf.lcd_density` detection
- [ ] **KernelSU native module format** — `module.json` descriptor compliant with KernelSU module spec (no-Magisk install path)
- [ ] **APatch module packaging** — validate and test APatch install flow

### 🎨 Theming
- [ ] **Splash screen per variant** — customize splash assets to match animation style (glitch-green vs flatline-red vs og-gold)
- [ ] **Boot logo overlay** — OEM logo replacement where ROM permits (requires system partition write or overlay)
- [ ] **Lock screen wallpaper** — bundled option to set a CP2077 wallpaper on install (via Magisk overlay or WallpaperManager Intent hook)

### 🔊 Audio
- [ ] **Extended audio pack** — add `Notification.ogg`, `VideoRecord.ogg`, `VideoStop.ogg`, `Screenshot.ogg`, `LowBattery.ogg` to match full UI sound surface
- [ ] **Variant-specific audio** — match audio tone palette to animation (glitch: harsh square waves; flatline: ECG beeps; og: retro synth)
- [ ] **Volume-normalization pass** — normalize all OGG files to -18 LUFS for consistent playback level

---

## 🟣 Long-Term (v5.0.0+)

### 🌐 Multi-Device Expansion
- [ ] **Nothing Phone (2a / 3) glyph integration** — sync Glyph LED patterns with boot animation stages via Nothing Glyph SDK
- [ ] **Pixel 9/10 compatibility test** — verify on Pixel-specific bootanimation path (`/data/local/bootanimation.zip` priority)
- [ ] **Fold/flip device support** — split-screen and cover-display boot animation variants for folding phones

### ⚙️ Infrastructure
- [ ] **GitHub Actions CI pipeline** — on push to `main`: build all variants, run `python3 -m zipfile -t` integrity check, publish draft release
- [ ] **OTA update server** — self-hosted `update.json` endpoint with version tracking (avoid depending on raw GitHub URLs)
- [ ] **Automated asset pipeline** — FFmpeg + Python pipeline to ingest new source ZIPs and repack to target resolution automatically
- [ ] **Checksums manifest** — generate `SHA256SUMS` alongside every release ZIP for verification

### 🖥 Linux / Desktop
- [ ] **Plymouth CP2077 boot theme** — native Plymouth animated boot theme for Arch Linux host (reuse animation frames)
- [ ] **GRUB theme expansion** — animated GRUB splash (currently static PNG) using GFXTERM + background_image
- [ ] **Hyprland integration** — `hyprlock` lock screen theme + `swaylock` variant using CP2077 color tokens from `cybrcolors`
- [ ] **Waybar / eww widget pack** — CP2077 HUD-style system monitor widgets (CPU/RAM/net meters in yellow-on-black palette)

### 📲 Live Wallpaper
- [ ] **Live wallpaper APK (actual)** — current quarantined APKs are HTML documents; obtain or build a real Android WallpaperService APK
  - Option A: Build with Android Studio using GLSurfaceView + shader pipeline
  - Option B: Source from a legitimate CP2077 live wallpaper release
- [ ] **Shader-based animated wallpaper** — GLSL rain/glitch shader wallpaper (no video decode overhead)

---

## ✅ Completed

| Item | Version | Date |
|------|---------|------|
| Workspace consolidation (all dirs → numbered structure) | v3.0.0 | 2026-05-13 |
| Multi-path mount engine (AOSP + LineageOS + OOS + yaap) | v3.0.0 | 2026-05-13 |
| Config-file driven variant selection | v3.0.0 | 2026-05-13 |
| service.sh size-threshold remount repair | v3.0.0 | 2026-05-13 |
| Universal ROM detection (14 ROM families) | v1.0.0 | 2026-05-13 |
| KernelSU / APatch root detection | v1.0.0 | 2026-05-13 |
| All workspace symlinks repaired after home-dir restructure | v3.0.0 | 2026-05-13 |
| 16 reference repos cloned (themes, kernels, wallpapers) | v3.0.0 | 2026-05-13 |
| GitHub push with privacy-safe no-reply email | v3.0.0 | 2026-05-13 |
| v2.0.0-beta release (first public, 4 variants, audio) | v2.0.0-beta | 2026-05-13 |

---

## 💡 Ideas / Wishlist

- **Magisk Webui panel** — browser-based variant switcher via Magisk Webui API (no reflash needed)
- **ADB variant switcher** — `adb shell` one-liner to change active variant + restart `bootanim`
- **CP2077 system font** — Rajdhani/Orbitron font overlay for system UI (requires system font overlay module)
- **Netrunner mode** — all-green color variant for "netrunner diving" aesthetic
- **Collaboration** — upstream PR to sodasoba1/ONEPLUS9-OOS13-BootAnimation with OP7 Pro resolution adaptation
