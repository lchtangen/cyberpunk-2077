<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░▒▓  ROADMAP — CYBERPUNK 2077 MAGISK THEME SUITE  ▓▒░                 ║
║  ────────────────────────────────────────────────────────────────────── ║
║  Bug Tracker · Planned Features · Completed Items                       ║
║  Last updated: 2026-05-13 · Maintained by: lchtangen                   ║
╚══════════════════════════════════════════════════════════════════════════╝
```

</div>

---

## 📌 Current Release Status

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ MODULE RELEASE MATRIX ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

<div align="center">

| 📦 Module | 🔢 Version | 🏷 Status |
|:----------|:----------|:---------|
| `CP2077_OP7Pro_Full` | **v3.0.0** | ✅ Stable — active on device |
| `CP2077_OP7Pro_Ultimate` | v3.0.0 | 🟡 Built — disabled (superseded by Full) |
| `CP2077_Universal` | v1.0.0 | 🟢 Built — release ZIP published (278 MB) |

</div>

---

## 🐛 Bug Tracker

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ KNOWN BUGS ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

<div align="center">

| 🆔 ID | ⚠️ Severity | 📋 Description | 🏷 Status |
|:------|:----------|:--------------|:---------|
| BUG-01 | High | `og4k` bootanimation dir was empty | ✅ **FIXED** — upscaled from og1080p via Pillow LANCZOS 2× (2160×4800, 267 frames, 358 MB) |
| BUG-02 | Medium | Full module had no shutdown animation for `og1080p` | ✅ **FIXED** — `shutdownanimation/og1080p/` created (reboot frames, desc 1080×2340) |
| BUG-03 | Medium | CP2077-Universal `release/` was empty — OTA update.json URL 404 | ✅ **FIXED** — `CP2077-Universal-v1.0.0.zip` built (278 MB) + 4 per-variant ZIPs |
| BUG-04 | Low | `update.json` pointed to non-existent repo | ✅ **FIXED** — `releases/update-full.json` + `releases/update-universal.json` in workspace; GitHub releases v3.0.0-full and v1.0.0-universal published |
| BUG-05 | Low | `CP2077-OP7Pro-build-source` (v1.0 legacy) undocumented in manifests and docs | ✅ **FIXED** — added to `git-repositories.txt` and README |
| BUG-06 | Low | Upstream `cyberpunk-technotronic-icon-theme` had ~20 broken SVG symlinks | ✅ **FIXED** — dangling symlinks removed locally; fall back to system theme |
| BUG-07 | Medium | `og4k` has no matching shutdown animation | 🔴 **OPEN** — glitch frames adapted to 2160×4800 but not packaged |
| BUG-08 | Low | `rbootanimation.zip` coverage not verified for all 4 variants | 🟡 **OPEN** — `post-fs-data.sh` sets it, full per-variant test pending |

</div>

---

## 🚀 v3.1.0 — Short-Term *(next sprint)*

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ NEXT SPRINT ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### 🎬 Animation

- [x] **og1080p shutdown animation** — created (reboot frames adapted to 1080×2340)
- [x] **og4k boot animation** — upscaled from og1080p via Pillow LANCZOS 2× (2160×4800)
- [ ] **og4k shutdown animation** — package glitch-adapted frames as `shutdownanimation/og4k/shutdownanimation.zip`
- [ ] **rboot coverage audit** — verify `rbootanimation.zip` is correctly set for all 4 variants via `post-fs-data.sh`
- [ ] **Animation length tuning** — trim intro frames on glitch/flatline to reduce time-to-desktop

### 📦 Build & Release

- [x] **Build CP2077-Universal v1.0.0** — built 2026-05-13 (278 MB universal + 4 per-variant ZIPs)
- [x] **Publish v3.0.0 GitHub release** — tagged, ZIPs uploaded, `update.json` OTA pointer fixed
- [ ] **Build megapack v3.0.0** — single ZIP with all variants + audio (replaces v2.0.0-beta-megapack)
- [ ] **Per-variant SHA256SUMS** — generate `SHA256SUMS` file alongside every release ZIP

### 🔧 Installer Improvements

- [ ] **Variant preview in installer** — print ASCII art description of each variant during `customize.sh` selection
- [ ] **Silent/non-interactive install mode** — pre-seeded `cp2077.conf` skips all prompts (for CI / scripted installs)
- [ ] **Config schema migration** — detect v2.x config and auto-upgrade to v3 format on reflash
- [ ] **Dry-run mode** — `python3 build.py --dry-run` prints what would be built without writing files

---

## 🔵 v4.0.0 — Mid-Term

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ MID-TERM TARGETS ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### 📱 Universal Module Expansion

- [ ] **Full MIUI/HyperOS testing** — verify `ROM_FAMILY=miui` path matrix works on Xiaomi devices
- [ ] **Samsung One UI validation** — test `/system/media/bootanimation.zip` on Galaxy devices
- [ ] **Resolution auto-scaling pipeline** — `build-universal.py` generates per-resolution ZIPs (720p, 1080p, 1440p, 4K) at build time via FFmpeg frame scaling
- [ ] **Dynamic density/fps selection** — pick 30fps vs 60fps based on `ro.sf.lcd_density` at install time
- [ ] **KernelSU native module format** — `module.json` descriptor compliant with KernelSU module spec
- [ ] **APatch module packaging** — validate and document APatch install flow end-to-end

### 🎨 Theming

- [ ] **Splash screen per variant** — customize splash assets to match animation style (glitch-green vs flatline-red vs og-gold)
- [ ] **Boot logo overlay** — OEM logo replacement where ROM permits (overlay or system partition write)
- [ ] **Lock screen wallpaper** — bundled option to set a CP2077 wallpaper at install via Magisk overlay

### 🔊 Audio v2

- [ ] **Extended audio pack** — add `Notification.ogg`, `VideoRecord.ogg`, `VideoStop.ogg`, `Screenshot.ogg`, `LowBattery.ogg`
- [ ] **Variant-specific audio** — match audio tone palette to animation (glitch: harsh square waves; flatline: ECG beeps; og: retro synth)
- [ ] **Volume normalization** — normalize all OGG files to −18 LUFS for consistent playback level

### ⚙️ Infrastructure

- [ ] **GitHub Actions CI pipeline** — on push to `main`: build all variants, run `python3 -m zipfile -t` integrity check, publish draft release
- [ ] **OTA update server** — self-hosted `update.json` endpoint with version tracking (avoid raw GitHub URLs)
- [ ] **Automated asset pipeline** — FFmpeg + Python pipeline to ingest new source ZIPs and repack to target resolution

---

## 🟣 v5.0.0 — Long-Term

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ LONG-TERM VISION ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### 🌐 Multi-Device Expansion

- [ ] **Nothing Phone (2a / 3) glyph integration** — sync Glyph LED patterns with boot animation stages via Nothing Glyph SDK
- [ ] **Pixel 9/10 compatibility** — verify on Pixel-specific bootanimation path (`/data/local/bootanimation.zip` priority)
- [ ] **Fold/flip device support** — split-screen and cover-display boot animation variants for folding phones
- [ ] **Tablet support** — landscape-oriented animation variants for Android tablets

### 🖥 Linux / Desktop

- [ ] **Plymouth CP2077 boot theme** — native Plymouth animated boot theme for Arch Linux host (reuse animation frames from `K-DE-Cyberpunk-Neon/`)
- [ ] **GRUB theme expansion** — animated GRUB splash (currently static PNG) using GFXTERM + background_image cycling
- [ ] **Hyprland integration** — `hyprlock` lock screen theme + `swaylock` variant using CP2077 color tokens from `cybrcolors/`
- [ ] **Waybar / eww widget pack** — CP2077 HUD-style system monitor widgets (CPU/RAM/net meters in yellow-on-black palette)
- [ ] **Rofi CP2077 launcher skin** — custom Rofi theme matching Night City UI

### 📲 Live Wallpaper

- [ ] **Live wallpaper APK (actual)** — current quarantined APKs are HTML; build or source a real Android WallpaperService APK
  - **Option A:** Build with Android Studio — GLSurfaceView + GLSL shader pipeline
  - **Option B:** Source from a legitimate CP2077 live wallpaper release
- [ ] **Shader-based animated wallpaper** — GLSL rain/glitch shader wallpaper (no video decode overhead, battery-friendly)

---

## ✅ Completed

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ MISSION ACCOMPLISHED ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

<div align="center">

| ✅ Item | 🔢 Version | 📅 Date |
|:--------|:----------|:-------|
| Workspace consolidation (all dirs → numbered structure) | v3.0.0 | 2026-05-13 |
| Multi-path mount engine (AOSP + LineageOS + OOS + yaap) | v3.0.0 | 2026-05-13 |
| Config-file driven variant selection (`/data/cp2077.conf`) | v3.0.0 | 2026-05-13 |
| `service.sh` size-threshold remount repair | v3.0.0 | 2026-05-13 |
| Universal ROM detection (14 ROM families) | v1.0.0 | 2026-05-13 |
| KernelSU / APatch root detection in Universal installer | v1.0.0 | 2026-05-13 |
| All workspace symlinks repaired after home-dir restructure | v3.0.0 | 2026-05-13 |
| 17 reference repos cloned (themes, kernels, wallpapers) | v3.0.0 | 2026-05-13 |
| GitHub push with privacy-safe no-reply email | v3.0.0 | 2026-05-13 |
| v2.0.0-beta release (first public — 4 variants, audio pack) | v2.0.0-beta | 2026-05-13 |
| og4k upscaled via Pillow LANCZOS 2× (2160×4800, 267 frames) | v3.0.0 | 2026-05-13 |
| og1080p shutdown animation created (reboot frames, 1080×2340) | v3.0.0 | 2026-05-13 |
| CP2077-Universal v1.0.0 built (278 MB universal + 4 per-variant ZIPs) | v1.0.0 | 2026-05-13 |
| GitHub releases published — v3.0.0-full + v1.0.0-universal | v3.0.0 | 2026-05-13 |
| `update.json` OTA pointers fixed (update-full.json + update-universal.json) | v3.0.0 | 2026-05-13 |
| CP2077-OP7Pro-build-source (v1.0 legacy) documented in manifests | v3.0.0 | 2026-05-13 |
| Dangling SVG symlinks removed from cyberpunk-technotronic-icon-theme | v3.0.0 | 2026-05-13 |
| README.md fully redesigned (cyberpunk ASCII art, badges, emoji, tables) | v3.0.0 | 2026-05-13 |
| All 09-DOCS/ files upgraded to cyberpunk theme and expanded | v3.0.0 | 2026-05-13 |

</div>

---

## 💡 Ideas / Wishlist

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ NEURAL WISHLIST ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

- 🖥 **Magisk Webui panel** — browser-based variant switcher via Magisk Webui API (no reflash needed)
- 📱 **ADB variant switcher script** — `adb shell` one-liner to change active variant + restart `bootanim`
- 🔤 **CP2077 system font overlay** — Rajdhani/Orbitron font for system UI (requires system font overlay module)
- 🟢 **Netrunner mode variant** — all-green monochrome color variant for netrunner-diving aesthetic
- 🔧 **Dedicated test device profile** — ROM + kernel + module combination fully validated for CI
- 🤝 **Upstream PR to sodasoba1** — upstream the OP7 Pro resolution adaptation of glitch/flatline frames
- 🌙 **Dark mode animation variant** — dimmed/desaturated version of CyberGlitch for AMOLED power saving
- 🔐 **Secure boot compatibility check** — detect and warn when secure boot would block module mount

---

<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ⚡  THE ROAD TO NIGHT CITY IS PAVED WITH COMMITS  ⚡                   ║
╚══════════════════════════════════════════════════════════════════════════╝
```

</div>
