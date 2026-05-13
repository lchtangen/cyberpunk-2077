<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░▒▓  ROADMAP — CYBERPUNK 2077 MAGISK THEME SUITE  ▓▒░                 ║
║  ────────────────────────────────────────────────────────────────────── ║
║  Bug Tracker · Planned Features · Completed Items                       ║
║  Last updated: 2026-05-13 · 100 prioritised tasks added · v3.2.0 roadmap ║
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

## � v3.1.0 — LineageOS 23.2 · Android 16 · OnePlus 7 Pro *(active sprint)*

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ ACTIVE SPRINT — v3.1.0 TARGET ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
║  Device : OnePlus 7 Pro GM1911 · guacamole · Snapdragon 855             ║
║  ROM    : LineageOS 23.2 (Android 16 · API 36)                          ║
║  Root   : Magisk v30.7 + KernelSU compatibility pass                    ║
╚══════════════════════════════════════════════════════════════════════════╝
```

<div align="center">

| 🔷 Target | ⚡ Value |
|:---------|:--------|
| 📦 Release | **v3.1.0** |
| 📱 Device | OnePlus 7 Pro `GM1911` — `guacamole` |
| 🤖 Android | API **36** (Android 16) |
| 📀 ROM | **LineageOS 23.2** |
| 🔑 Root | Magisk v30.7 + KernelSU |
| 🎯 Focus | LOS 23.2 compat · 3 new variants · Linux UI themes · Bug fixes |

</div>

---

### 🔬 LineageOS 23.2 / Android 16 Compatibility

> **Critical path — must land before any other v3.1.0 work ships.**

- [ ] **LOS 23.2 mount path audit** — `adb shell su -c "mount | grep -E 'product|system'"` on fresh LOS 23.2 install; confirm `/product/media/` is the correct primary bind-mount target (unchanged from LOS 20–22 but must be verified on LOS 23.2 specifically)
- [ ] **Android 16 `post-fs-data` timing** — Android 16 compresses the boot timeline; run a timestamped `logcat` trace to verify `post-fs-data.sh` and `service.sh` both complete before SurfaceFlinger starts the bootanim stage; add `sleep` guards if race condition detected
- [ ] **SELinux audit on LOS 23.2** — Android 16 ships stricter default SELinux policies; check `adb shell dmesg | grep -i avc` for `bootanim` denials; generate and apply a custom `sepolicy.rule` if `/product/media/` bind-mount is blocked
- [ ] **LineageOS-specific `rbootanimation` path** — LOS 23.2 may have changed the LineageOS-specific path for `rbootanimation.zip`; confirm correct path is `/data/misc/bootanim/bootanimation.zip` or update `post-fs-data.sh` to match LOS 23.2 conventions
- [ ] **Audio OGG path on LOS 23.2** — verify LOS 23.2 reads system UI sounds from `/product/media/audio/ui/`; if relocated, update bind-mount targets in `post-fs-data.sh` accordingly
- [ ] **Magisk WebUI on LOS 23.2 WebView** — open the module's WebUI (`index.html`) in Magisk v30.7 on LOS 23.2; verify all 5 bridge calls (`refreshStatus`, `applyConfig`, `restartAnim`, `showDiag`, variant picker) function correctly on Android 16's WebView/Chromium stack
- [ ] **KernelSU module descriptor** — generate `module.json` compliant with KernelSU module spec for LOS 23.2 KernelSU kernel; test install via KernelSU Manager and verify mount-path parity with Magisk path
- [ ] **`service.sh` 5 MB threshold re-validation** — confirm stock LOS 23.2 bootanimation stub size is still under 5 MB (the current correctness invariant); update threshold constant if LOS 23.2 ships a larger stub

---

### 🎬 New Animation Variants (v3.1.0)

- [ ] **`netrunner` variant** — new animation built around cyan/blue neon palette (`#00FFFF` dominant); represent neural-interface / ICE intrusion aesthetic; 60fps, 1440×3120, part0 intro 3 s + part1 loop; add to `VARIANTS` list in `build.py` and `VARIANTS.md`
- [ ] **`corpo` variant** — corporate Arasaka/Militech aesthetic; gold/silver palette (`#D4AF37`, `#C0C0C0`), clean geometry, minimalist glitch; 60fps, 1440×3120
- [ ] **`streetkid` variant** — grunge Night City street aesthetic; orange/red palette (`#FF6B35`, `#FF003C`), scan-line noise, spray-paint stamp; 60fps, 1440×3120
- [ ] **Shutdown animations for all 3 new variants** — each new variant needs a matching `shutdownanimation.zip`; reuse adapted frame pipeline from `og1080p`/`glitch` shutdown
- [ ] **Fix BUG-07: `og4k` shutdown animation** — package glitch-adapted frames already upscaled to 2160×4800 as `shutdownanimation/og4k/shutdownanimation.zip`; add to `build.py` packaging pass *(closes BUG-07)*
- [ ] **Fix BUG-08: `rboot` coverage audit** — verify `rbootanimation.zip` is correctly set for all 4 existing variants via `post-fs-data.sh`; test on LOS 23.2 which has the LOS-specific reboot-to-recovery animation path *(closes BUG-08)*
- [ ] **Animation length tuning** — trim intro frames on `glitch`/`flatline` part0 to reduce time-to-desktop by ≥ 1 s; measure pre/post with `logcat -b events | grep boot_progress_enable_screen`

---

### 🎨 New UI Themes (v3.1.0)

> **Linux desktop theming for Arch host — Hyprland + Waybar + terminal ecosystem.**

- [ ] **`cybrland` ↔ `cyber-hyprland-theme` merge** — diff both repos; produce a single canonical `cp2077-hyprland.conf` that takes: `hyprland.conf` from `cyber-hyprland-theme/`, `waybar` config from `cybrland/`, `eww` widgets from `cyber-hyprland-theme/eww/`; retire duplicates
- [ ] **Terminal color scheme pack** — derive 16-color ANSI palette from `cybrcolors/` tokens:
  - `color0`/`color8` = `#0A0A0A` / `#2A2A2A` (bg/border)
  - `color3`/`color11` = `#FCEE0C` (yellow — primary)
  - `color6`/`color14` = `#00FFFF` (cyan — secondary)
  - `color1`/`color9` = `#FF003C` (red — danger)
  - `color2`/`color10` = `#00FF9F` (green — success)
  - `color5`/`color13` = `#FF6B35` (orange — warning)
  - Ship: `kitty.conf`, `alacritty.toml`, `wezterm.lua` → `05-LINUX/arch-host/terminal-themes/`
- [ ] **Papirus icon recolorization** — run `K-DE-Cyberpunk-Neon/papirus-kolorizer.sh --color '#FCEE0C'`; ship output as `papirus-cp2077/` under `06-UI-THEMES-ANIMATIONS/themes/`
- [ ] **`cp2077-hud-toggle.sh`** — script that toggles between `eww open cp2077-hud` and `pkill waybar && waybar &`; bind to `Super+H` in `cyber-hyprland-theme/theme.conf`
- [ ] **Waybar CP2077 HUD widget pack** — CPU/RAM/net/battery meters in `#FCEE0C`-on-`#0A0A0A` Night City HUD palette; `.config/waybar/config` + `.config/waybar/style.css` targeting `06-UI-THEMES-ANIMATIONS/themes/cp2077-linux-hud/`
- [ ] **Plymouth theme verification** — run `plymouth-set-default-theme -l` on Arch host; if `cp2077-linux-boot` not in list, install and call `mkinitcpio -p linux`; document exact install steps in `BUILD-GUIDE.md`
- [ ] **`hyprlock` CP2077 lock screen** — CP2077 lock screen config using `hyprlock.conf`; background = `Cyberpunk-Wallpapers/` random pick; clock font = CP2077 yellow; blur + scanline overlay

---

### 📦 Build & Release

- [x] **Build CP2077-Universal v1.0.0** — built 2026-05-13 (278 MB universal + 4 per-variant ZIPs)
- [x] **Publish v3.0.0 GitHub release** — tagged, ZIPs uploaded, `update.json` OTA pointer fixed
- [ ] **Build megapack v3.1.0** — single ZIP with all 7 variants (4 original + 3 new) + full audio pack; replace v2.0.0-beta-megapack as the "get everything" download
- [ ] **Per-variant SHA256SUMS** — generate `SHA256SUMS` file alongside every release ZIP; add generation step to `build.py` `[4/4] Packaging` phase
- [ ] **ZIP timestamp stripping** — pass `ZipInfo(date_time=(1980,1,1,0,0,0))` for every entry in `pack_zip()`; guarantees bit-identical SHA-256 across build machines
- [ ] **`build.py --variants` filter flag** — `python3 build.py --variants glitch,netrunner` builds only specified variants; speeds up iteration on new animations
- [ ] **`module.prop` `support=` URL** — add `support=https://github.com/…/issues` to `module.prop` in both `CP2077-OP7Pro` and `CP2077-Universal`; renders "Support" button in Magisk v26+ UI

---

### 🔧 Installer & Service

- [ ] **Variant preview in installer** — `ui_print` an ASCII-art label + color description for each variant during `customize.sh` selection prompt
- [ ] **Silent install mode** — if `/data/cp2077.conf` already exists and `SILENT=1` is set, skip all interactive prompts in `customize.sh`
- [ ] **Installation log export** — append every `ui_print` line to `/sdcard/cp2077-install-$(date +%Y%m%d-%H%M%S).log`; rotate keeping the 3 most recent
- [ ] **`service.sh` double-pass remount** — add a second `_remount_if_small` pass at `sleep 30` to repair ROMs that re-mount `/product` after `bootanim` starts (catches edge cases on LOS 23.2 with late-mount product partition)
- [ ] **`uninstall.sh` full cleanup** — extend to `rm -f /data/local/bootanimation.zip /data/local/shutdownanimation.zip /data/misc/bootanim/bootanimation.zip` and `umount` all lingering bind mounts at uninstall time

---

### 📚 Documentation Updates

- [ ] **`VARIANTS.md` frame-count table** — add frame count, part count, FPS, resolution, and uncompressed ZIP size for all 7 variants (4 existing + 3 new)
- [ ] **LOS 23.2 compatibility note in `INSTALLATION-GUIDE.md`** — add a callout block with the verified LOS 23.2 mount paths and the SELinux `sepolicy.rule` fragment
- [ ] **Update `DEVICE-SPECS.md` for Android 16** — refresh ROM compat matrix; add LOS 23.2 row with confirmed path matrix and audio paths
- [ ] **`REPOS.md` — add 3 new variant asset repos** if netrunner/corpo/streetkid source animation assets are cloned from upstream

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

## 🔮 Backlog — 25 Additional Items

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ EXTENDED BACKLOG — GROUNDED IN CODEBASE AUDIT ░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### 🖥 F — WebUI Panel Extensions

- [ ] **WebUI variant preview animation** — embed a looping CSS keyframe animation (scanline sweep + glitch flash) in each variant card so users see the animation style before selecting; no external assets needed, pure CSS
- [ ] **WebUI localStorage persistence** — cache last-selected variant and audio state in `localStorage` so the panel reflects choices immediately on open, before `refreshStatus()` completes its `sh()` round-trip
- [ ] **WebUI "copy diagnostics" button** — add a one-tap button in the Diagnostics section that calls `navigator.clipboard.writeText()` on the full log panel contents; users can paste directly into XDA/GitHub issues without typing
- [ ] **WebUI OTA update badge** — on `DOMContentLoaded`, fetch the `update.json` URL stored in `module.prop`, compare `version` field against the installed version read from `getprop`, and show a yellow top banner if a newer version exists
- [ ] **WebUI mount path inspector** — add a collapsible "Mount Map" section that runs `sh('mount | grep bootanim')` and displays which source file is bound to which target path, color-coded green (CP2077 ZIP) vs red (stock stub)

---

### ⚙️ G — `build.py` Hardening

- [ ] **ZIP timestamp stripping for reproducible builds** — all `zipfile.ZipFile.write()` calls preserve host filesystem mtime, making SHA-256 non-reproducible across machines; pass a `ZipInfo` with `date_time=(1980,1,1,0,0,0)` for every entry to guarantee bit-identical output
- [ ] **`--variants` filter flag** — add `python3 build.py --variants glitch,og1080p` to build only specified variants; the current `VARIANTS` list requires code edits to skip variants, wasting build time when iterating on a single animation
- [ ] **Parallel `pack_zip()` calls** — `pack_zip()` runs sequentially per variant in the `[4/4] Packaging` phase; wrap the per-variant calls in the existing `ThreadPoolExecutor` (already imported) to pack all four ZIPs concurrently
- [ ] **`audio-specs.json` hot-reload** — `AUDIO_SPECS` dict is hardcoded in `build.py`; add an optional `audio-specs.json` override file in `BASE` that is loaded at runtime if present, so tone parameters can be tuned without editing the script
- [ ] **`--check-sources` upstream URL validator** — add a flag that `HEAD`-requests each URL in the `SOURCES` dict and prints status code + `Content-Length`; catches stale upstream release tags before a full build run tries to download them

---

### 📟 H — On-Device Service Layer

- [ ] **`service.sh` double-pass remount** — the current `_remount_if_small` fires once after `sleep 5`; add a second pass at `sleep 30` to catch ROMs (seen on some MIUI/HyperOS builds) that re-mount `/product` after `bootanim` starts, evicting the first bind-mount
- [ ] **`post-fs-data.sh` trace mode** — if `$MODDIR/trace.flag` exists, redirect every mount/copy action to `/data/local/tmp/cp2077-trace.log` without executing; lets maintainers debug path failures on new ROM families without risking a boot loop
- [ ] **`cp2077-config.sh` backup/restore** — add `backup` and `restore` sub-commands that save/load `/data/cp2077.conf` to/from `/sdcard/cp2077-config-backup.conf`; protects config across module reinstalls and ROM flashes
- [ ] **Module soft disable/enable scripts** — `disable.sh` touches `$MODDIR/disable` (Magisk skip flag) and `enable.sh` removes it; no Magisk Manager needed; expose as `cp2077-adb-control.sh enable` / `disable` sub-commands for CI test teardown
- [ ] **`uninstall.sh` full path cleanup** — `post-fs-data.sh` writes to `/data/local/bootanimation.zip`, `/data/local/shutdownanimation.zip`, and `/data/misc/bootanim/`; current `uninstall.sh` only removes the module overlay — extend it to `rm -f` all three data-partition artifacts and call `umount` on any lingering bind mounts

---

### 🐧 I — Linux Desktop Completions

- [ ] **`install-plymouth.sh` active-theme verification** — after installing, run `plymouth-set-default-theme -l` and assert `cp2077` appears in the list; print the current default theme name so users know if the initrd needs rebuilding with `mkinitcpio -p linux`
- [ ] **`cybrland` ↔ `cyber-hyprland-theme` merge** — `06-UI-THEMES-ANIMATIONS/themes/cybrland/` and `cyber-hyprland-theme/` are both Hyprland configs; diff them and produce a single canonical `cp2077-hyprland.conf` that takes the best elements from each; retire the duplicate
- [ ] **Papirus icon recolorization** — `K-DE-Cyberpunk-Neon/papirus-kolorizer.sh` exists but has never been run as part of the build; execute it with the CP2077 yellow `#FCEE0C` as the accent color and ship the resulting `papirus-cp2077` icon theme directory under `06-UI-THEMES-ANIMATIONS/themes/`
- [ ] **`cp2077-hud-toggle.sh`** — write a script that toggles between `eww open cp2077-hud` (floating overlay) and `pkill waybar && waybar &` (full panel bar); bind it to `Super+H` in `cyber-hyprland-theme/theme.conf`; avoids restarting the compositor on every switch
- [ ] **Terminal color scheme pack** — derive a 16-color ANSI palette from `cybrcolors` (yellow→color3/11, cyan→color6/14, red→color1/9, green→color2/10, `#0A0A0A`→background); ship ready-to-source configs for Kitty (`kitty.conf`), Alacritty (`alacritty.toml`), and WezTerm (`wezterm.lua`) under `05-LINUX/arch-host/terminal-themes/`

---

### 📚 J — Docs, CI & Distribution

- [ ] **`VARIANTS.md` frame-count table** — document frame count, part count, FPS, resolution, and uncompressed ZIP size for every variant; this data exists only in `build.py` constants and is invisible to end users trying to choose between variants
- [ ] **`module.prop` `support=` URL** — Magisk v26+ renders a "Support" button in the module card when `support=<url>` is set; add the GitHub issues URL to `module.prop` in both `CP2077-OP7Pro` and `CP2077-Universal` repos so users have a one-tap path to file bugs
- [ ] **CHANGELOG auto-generation script** — `scripts/gen-changelog.sh <from-tag> <to-tag>` extracts `git log` between two tags, groups commits by prefix (`fix:`, `feat:`, `chore:`), and appends a formatted block to `CHANGELOG-full.md`; run as the first step of the GitHub Actions release job
- [ ] **`scripts/check-repos.sh` sync status** — iterate over every directory in `01-DEVELOPMENT/repos/` that contains a `.git`, run `git -C <dir> fetch --dry-run 2>&1`, and print a table of which repos are behind their remote; critical for keeping `sodasoba1/ONEPLUS9-OOS13-BootAnimation` current before a build
- [ ] **`shellcheck` CI lint gate** — add a `lint` job to both `CP2077-OP7Pro/.github/workflows/build.yml` and `CP2077-Universal/.github/workflows/build.yml` that runs `shellcheck -S warning` against all `.sh` files; block merge on any SC2 or SC3 finding to prevent regressions like the stale-variable patterns in older `customize.sh` revisions

---

## ⚡ 25 FEATURES

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ FEATURE BACKLOG — END-USER CAPABILITIES ░░░░░░░░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### 🎬 Animation & Boot

- [ ] **FEAT-01 · Variant hot-swap (no reboot)** — `am broadcast -a android.intent.action.BOOT_COMPLETED` + `setprop ctl.restart bootanim` triggered from `cp2077-config.sh`; lets users switch variant and see it live without rebooting the device
- [ ] **FEAT-02 · FPS governor from display refresh rate** — detect `ro.surface_flinger.max_frame_buffer_acquired_buffers` / `ro.hardware.egl` to determine display refresh rate; auto-select 30fps vs 60fps vs 120fps `desc.txt` entry at install time rather than hardcoding 60fps for all variants
- [ ] **FEAT-03 · Battery-aware animation downgrade** — read `cat /sys/class/power_supply/BAT0/capacity` in `post-fs-data.sh`; if battery < 20%, mount the 30fps variant regardless of user selection to save power during low-battery boot
- [ ] **FEAT-04 · Display-cutout-aware centering** — parse `ro.config.notch_type` / `android.software.notch` at install; if notch present, patch the frame canvas offset in `desc.txt` so the key visual elements are not occluded by the camera cutout
- [ ] **FEAT-05 · Animated shutdown sequence** — full cinematic shutdown: `JACK OUT` title card → signal-loss glitch → flatline → black; packaged as `shutdownanimation.zip` for all 4 variants (currently og4k missing, glitch/flatline only partial)
- [ ] **FEAT-06 · Multi-language boot messages** — Plymouth and on-device messages cycle through English, Japanese, Simplified Chinese, and Spanish; language selected from `ro.product.locale` at install time, stored in `/data/cp2077.conf` as `LOCALE=`
- [ ] **FEAT-07 · Variants A/B rotation mode** — `cp2077.conf` key `AB_ROTATE=1` alternates between two user-specified variants on every other reboot; `service.sh` reads a boot counter from `/data/local/tmp/cp2077-bootcount` and flips the active variant
- [ ] **FEAT-08 · RAM-staged animation** — detect tmpfs free space on `/data/local/tmp`; if > 2× ZIP size, copy the active animation ZIP there at `post-fs-data` time so SurfaceFlinger reads from RAM rather than eMMC — measurably reduces animation stutter on slow storage devices
- [ ] **FEAT-09 · Custom accent color injection** — add `ACCENT_HEX=` key to `cp2077.conf`; `build.py --inject-color` pipeline replaces `#FCEE0C` yellow in all frame PNGs using Pillow palette remap; lets users brand the animation to a personal color without re-sourcing assets
- [ ] **FEAT-10 · Installation log export** — append every `ui_print` line in `customize.sh` to `/sdcard/cp2077-install-$(date +%Y%m%d-%H%M%S).log`; gives end users a shareable install record for XDA bug reports; log rotated, keeping the 3 most recent

### 📱 Device & System Integration

- [ ] **FEAT-11 · OTA delta update** — `update.json` gains a `deltaUrl` field pointing to a patch ZIP containing only changed frames; `service.sh` fetches and applies the delta in background to `/data/adb/modules/CP2077_OP7Pro_Full/`, no reinstall required
- [ ] **FEAT-12 · Module update notification** — on first boot after an OTA version bump is detected (compare `/data/cp2077-version` to `module.prop`), fire `am broadcast` notification via NotificationManager intent so user is informed without opening Magisk
- [ ] **FEAT-13 · Haptic pattern sync** — write a vibration pattern array to `/sys/class/leds/vibrator/` timed to key animation frames (title-card impact, glitch flash, boot-complete); falls back gracefully on devices without sysfs vibrator node
- [ ] **FEAT-14 · Fingerprint sensor unlock animation** — on OEMs that expose `/sys/class/fingerprint/` status node, overlay a scanline ring animation on the sensor region during biometric scan; requires Magisk overlay of `frameworks-res.apk` `ic_fingerprint` drawable
- [ ] **FEAT-15 · CP2077 Monet color injection** — generate a Monet-compatible color palette XML from the CP2077 hex constants and place it in `res/values/` of a system resource overlay; on Android 12+ with Monet support, overrides dynamic accent with CP2077 yellow/cyan permanently
- [ ] **FEAT-16 · Screenshot-during-boot capture** — `service.sh` calls `screencap /sdcard/cp2077-boot-frame.png` at `sleep 2` (mid-animation) for QA purposes; saved file gives maintainers a real-device render to verify framing without screen recording
- [ ] **FEAT-17 · Night mode audio variant** — check `date +%H` in `post-fs-data.sh`; between 22:00–07:00, mount a quieter audio set (`volume_factor=0.4` in `AUDIO_SPECS`) instead of the full-volume pack; respects user sleep without requiring manual toggle
- [ ] **FEAT-18 · Audio fade-out on animation complete** — detect `getprop sys.boot_completed=1` in `service.sh`; play a 2-second fade envelope on the audio channel before `am broadcast BOOT_COMPLETED` fires; prevents the hard audio cut that currently occurs on fast devices
- [ ] **FEAT-19 · Secure boot compatibility check** — `customize.sh` reads `ro.boot.verifiedbootstate` and `ro.boot.flash.locked`; if `locked` AND `verified`, warn user that the module may not survive a system integrity check reboot and recommend MagiskHide or Zygisk equivalent
- [ ] **FEAT-20 · Dynamic wallpaper extraction** — after successful install, extract frame 1 from the selected bootanimation ZIP (first PNG in `part0/`) via `unzip -p`, run through a Pillow letterbox-crop to device resolution, and set as lockscreen wallpaper via `am broadcast` WallpaperManager intent

### 🖥 Linux / Desktop

- [ ] **FEAT-21 · Netrunner color mode** — all-green monochrome variant: replace yellow `#FCEE0C` with green `#00FF9F` and cyan `#00FFFF` with `#00CC44` in all Linux HUD configs; shipped as an alternate `eww.scss`, `style.css`, and `hyprlock.conf` set under `cp2077-linux-hud/variants/netrunner/`
- [ ] **FEAT-22 · GRUB animated splash** — use GRUB's `background_image` + GFXTERM with a sequence of pre-rendered PNGs (extracted from the reboot animation) displayed via a GRUB script loop; `install-grub-theme.sh` patches `/etc/default/grub` and rebuilds with `grub-mkconfig`
- [ ] **FEAT-23 · Rofi launcher skin** — CP2077 Rofi theme: `#0A0A0A` background, 1px `#2A2A2A` border, `#FCEE0C` selected row, `#00FFFF` input text, JetBrains Mono; shipped as `06-UI-THEMES-ANIMATIONS/themes/cp2077-linux-hud/rofi/cp2077.rasi` with a keybind snippet for Hyprland
- [ ] **FEAT-24 · Terminal color scheme pack** — derive 16-color ANSI palette from `cybrcolors` (yellow→color3/11, cyan→color6/14, red→color1/9, green→color2/10, `#0A0A0A`→background); ship ready-to-source configs for Kitty (`kitty.conf`), Alacritty (`alacritty.toml`), and WezTerm (`wezterm.lua`) under `05-LINUX/arch-host/terminal-themes/`
- [ ] **FEAT-25 · OTA update notifier (host)** — `cp2077-ota-poller.sh` runs as a systemd user timer every 6 hours; fetches `update.json`, compares version to local `installed-version.txt`, fires `notify-send "CP2077 Module Update Available: vX.X.X"` with `notify-send --icon=emblem-package`; optionally launches the ADB flash workflow automatically

---

## 🔧 25 TOOLS

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ TOOL BACKLOG — BUILD · DEV · HOST · QA SCRIPTS ░░░░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### 🛠 Build & Packaging Tools

- [ ] **TOOL-01 · `cp2077-frame-inspector.py`** — open any animation ZIP, list all parts + frame counts, and render a chosen frame to terminal via the Kitty/Sixel graphics protocol (`term-image` library); replace the need to unzip locally just to preview a frame
- [ ] **TOOL-02 · `cp2077-zip-diff.py`** — diff two animation ZIPs by per-frame SHA-256; output a table of `ADDED / REMOVED / CHANGED / IDENTICAL` frames between two releases; critical for verifying that a patch ZIP changed only the intended frames
- [ ] **TOOL-03 · `cp2077-zip-stats.py`** — parse `desc.txt` from any animation ZIP and print resolution, FPS, part count, total frame count, compressed size, and uncompressed size in a CP2077-styled table; aliased as `cp2077 stats <zipfile>`
- [ ] **TOOL-04 · `cp2077-desc-gen.py`** — CLI tool: `cp2077-desc-gen --width 1080 --height 2340 --fps 60 --parts part0:267:0:0 part1:1:0:0` generates a valid `desc.txt`; replaces hand-editing which has caused malformed desc bugs in past releases
- [ ] **TOOL-05 · `cp2077-build-matrix.py`** — build all 3 modules × 4 variants × audio-on/off = 24 artifacts in one invocation; uses `concurrent.futures.ProcessPoolExecutor` with configurable worker count; writes a `build-matrix-manifest.json` listing SHA-256 and size of every artifact
- [ ] **TOOL-06 · `cp2077-archive-audit.py`** — scan all ZIP archives in the workspace for: corrupt entries (`testzip()`), zero-byte frames, missing `desc.txt`, frame filenames not matching `^[0-9]{5}\.png$`, and duplicate frame hashes; output a color-coded report
- [ ] **TOOL-07 · `cp2077-palette-gen.py`** — generate a 1920×120px color palette PNG from the CP2077 hex constants in `build.py`; embed in README and VARIANTS.md as a visual reference strip; auto-regenerated as part of the release workflow
- [ ] **TOOL-08 · `cp2077-wallpaper-extract.py`** — extract the first frame of the selected bootanimation variant, resize to host display resolution via Pillow LANCZOS, and save as `~/.config/wallpapers/cp2077-boot-frame.png`; hook into `cp2077-adb-control.sh pull-frame`
- [ ] **TOOL-09 · `cp2077-version-bumper.py`** — atomically update version string in `module.prop` (`version=`, `versionCode=`), `CHANGELOG.md` (insert header), and `update.json` (`version`, `versionCode`, `zipUrl`) in one pass; validates that `versionCode` is an integer and greater than the current value

### 🔍 QA & Validation Tools

- [ ] **TOOL-10 · `cp2077-module-lint.py`** — static analysis for Magisk modules: verify all required `module.prop` fields, check `customize.sh` exits with `0` on the happy path (shell `set -e` dry parse), verify file permissions (`755` for scripts, `644` for data), and assert `META-INF/` hierarchy is intact
- [ ] **TOOL-11 · `cp2077-bench.sh`** — ADB boot-timing benchmark: power-cycle the device, parse `adb logcat -T 1` for `Displayed com.android.launcher` timestamp, compute delta from `ro.boottime.init`; run 3 times and report mean ± stddev boot time with vs without CP2077 module enabled
- [ ] **TOOL-12 · `cp2077-rom-probe.sh`** — ADB device interrogation tool: read 30+ `ro.*` props and map them to ROM family, API level, device codename, and recommended CP2077 install path; output as both terminal table and `device-profile.yaml` for archiving in `02-PRODUCTION/device-profiles/`
- [ ] **TOOL-13 · `cp2077-health-dashboard.sh`** — terminal TUI (no ncurses, pure ANSI) showing: module enabled/disabled state, active variant name, mounted animation file size, mount path, last-boot timestamp, audio state, and a `pass/WARN/FAIL` per-check summary; callable from `cp2077-adb-control.sh health`
- [ ] **TOOL-14 · `cp2077-ci-local.sh`** — run the full `build.yml` GitHub Actions workflow locally via `act` (nektos/act); wrapper that sets the correct secrets env vars, mounts the workspace, and streams structured output in CP2077 ANSI colors; catches CI failures before push
- [ ] **TOOL-15 · `scripts/shellcheck-all.sh`** — run `shellcheck -S warning` against every `.sh` in the workspace; output grouped by severity; non-zero exit if any SC2 or SC3 finding; intended as a pre-commit hook and CI lint gate
- [ ] **TOOL-16 · `cp2077-audio-preview.sh`** — iterate over all `*.ogg` in the module audio directory; play each through `aplay` (with `--device default`) and print file name, duration via `soxi -D`, and peak level via `sox stat`; validates levels before packaging

### 🚀 Deployment & Distribution Tools

- [ ] **TOOL-17 · `cp2077-module-sign.sh`** — sign a module ZIP with a detached GPG signature (`module.zip.asc`); verify script bundled as `cp2077-verify.sh` for end users; signature URL added to `update.json` as `signatureUrl` field
- [ ] **TOOL-18 · `cp2077-release-drafter.sh`** — extract CHANGELOG.md entries between two version tags, format them as a GitHub release body (emoji headers, bullet lists), and `gh release create` with the formatted body and all artifact ZIPs attached; replace the manual release process
- [ ] **TOOL-19 · `cp2077-port-wizard.sh`** — interactive shell wizard for porting to a new device: prompts for resolution (WxH), ROM family, boot animation path, and optional shutdown path; generates a device-specific `customize.sh` block and `module.prop` stub; outputs to `devices/<codename>.sh`
- [ ] **TOOL-20 · `cp2077-ota-poller.sh`** — systemd user timer that fetches `update.json` every 6 hours, compares version to `~/.local/share/cp2077/installed-version`, and fires `notify-send` on update available; `--install` flag creates the systemd `.service` and `.timer` units automatically
- [ ] **TOOL-21 · `cp2077-device-profile-gen.sh`** — connect ADB device, pull 20 key props, detect ROM family, measure bootanimation size, and write a `device-profile.yaml` to `02-PRODUCTION/device-profiles/<codename>-<date>.yaml`; used to build the multi-device compatibility matrix
- [ ] **TOOL-22 · `cp2077-merge-tool.sh`** — three-way diff between `CP2077-OP7Pro`, `CP2077-OP7Pro-Ultimate`, and `CP2077-Universal` scripts; highlights lines that exist in one but not others; specifically watches `post-fs-data.sh` and `service.sh` for divergence caused by copy-paste propagation failures
- [ ] **TOOL-23 · `cp2077-hook-manager.sh`** — install or remove individual Magisk hooks (`post-fs-data.sh`, `service.sh`) without reinstalling the full module ZIP; writes directly to `$MODDIR` via ADB root; useful for testing individual script changes in under 5 seconds
- [ ] **TOOL-24 · `cp2077-plymouth-preview.sh`** — launch a Xephyr nested X server at 1080×2340, run `plymouthd --mode=boot` against the `cp2077-linux-boot` theme, and display it on host; lets developers preview boot animations without rebooting
- [ ] **TOOL-25 · `scripts/check-repos.sh`** — iterate every `01-DEVELOPMENT/repos/**/.git` directory; run `git fetch --dry-run 2>&1`; print a table of repos with available upstream updates (commits behind); exit non-zero if any critical reference repo (sodasoba1, Magisk-Modules-Alt-Repo) is > 30 commits behind

---

## 📦 25 MODULES

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ MODULE BACKLOG — MAGISK · ANDROID · SYSTEM MODULES ░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### 🎨 UI & Theming Modules

- [ ] **MOD-01 · `CP2077-Sounds-Extended`** — standalone Magisk module shipping the full Android audio surface: `Notification.ogg`, `VideoRecord.ogg`, `VideoStop.ogg`, `Screenshot.ogg`, `LowBattery.ogg`, `Ringtone_CP2077.ogg`; decoupled from the animation module so users can install audio independently; normalised to −18 LUFS
- [ ] **MOD-02 · `CP2077-Fonts`** — Magisk overlay module injecting Rajdhani as `sans-serif` and JetBrains Mono as `monospace` into `/system/fonts/` and patching `fonts.xml` via a Python post-install script; covers system UI, settings, and notification text
- [ ] **MOD-03 · `CP2077-Icons`** — Magisk module packaging the patched `cyberpunk-technotronic-icon-theme` (broken symlinks removed) as an Android icon pack APK with a proper `AndroidManifest.xml`; installable from Settings → Display → Icon shape without root
- [ ] **MOD-04 · `CP2077-Bootlogo`** — Magisk module replacing the OEM boot logo (kernel splash) by `dd`-writing a CP2077 logo BMP to the `logo` partition with full backup/restore; restricted to OnePlus 7 Pro first, expanded to other devices with known logo partition layouts
- [ ] **MOD-05 · `CP2077-LiveWallpaper-GLShader`** — real Android `WallpaperService` APK built with Kotlin + OpenGL ES 3.0 GLSL; renders a rain/glitch shader on an `#0A0A0A` background; replaces the quarantined HTML-masquerading APKs in the Ultimate module; battery governor drops to 5fps when screen-off
- [ ] **MOD-06 · `CP2077-StatusBar`** — LSPosed (Xposed) module that recolors Android status bar: clock text `#FCEE0C`, icon tint `#00FFFF`, battery indicator fill gradient `#FCEE0C→#FF003C`; targets AOSP SystemUI, OOS, and HyperOS SystemUI variants
- [ ] **MOD-07 · `CP2077-Navbar`** — Magisk resource overlay replacing the gesture navigation home pill with a 2px yellow line (`#FCEE0C`) and the back arrow with a thin `◄` glyph; adapts stroke width from `ro.config.navbar_style` device prop
- [ ] **MOD-08 · `CP2077-LockscreenClock`** — Magisk resource overlay changing the AOSP/OOS lockscreen clock: font family → Rajdhani, color → `#00FFFF`, date color → `#AAAAAA`; implemented as `res/values/styles.xml` overlay targeting `com.android.systemui`
- [ ] **MOD-09 · `CP2077-QuickSettings`** — Magisk overlay restyling Quick Settings: tile background → `rgba(10,10,10,0.92)`, active tint → `#FCEE0C`, label font → JetBrains Mono 10sp; targets `SystemUI` QS layout XML; tested on OOS 15 / AOSP 14

### ⚙️ System & Infrastructure Modules

- [ ] **MOD-10 · `CP2077-SplashScreen`** — Magisk overlay targeting Android 12+ `windowSplashScreenBackground` and `windowSplashScreenAnimatedIcon` attrs; replaces app launch splash with CP2077 black background + animated yellow horizontal bar; visible on all apps with default splash
- [ ] **MOD-11 · `CP2077-Charging-Animation`** — Magisk module replacing the OOS/MIUI charging animation ZIP at `/system/media/charginganimation.zip` with a CP2077 power-cell fill sequence; checks `ro.build.version.sdk ≥ 28` and `ro.boot.anim.charging` before installing
- [ ] **MOD-12 · `CP2077-Shutdown-Sounds`** — Magisk `service.sh` module that monitors `getprop sys.powerctl` in a loop; on `shutdown` or `reboot` value detected, triggers `MediaPlayer` via `am start` intent to play `powerdown.ogg` before the device halts; graceful with a 3s watchdog timeout
- [ ] **MOD-13 · `CP2077-Kernel-Params`** — Magisk `post-fs-data.sh` module writing CP2077-tuned kernel parameters: `vm.swappiness=10`, `kernel.sched_latency_ns=2000000`, `kernel.sched_min_granularity_ns=500000`; measurably reduces bootanimation frame drops on SM8150 per `simpleperf` profiling
- [ ] **MOD-14 · `CP2077-Hosts-Adblocker`** — Magisk systemless hosts file module styled as Night City Corporate Firewall; curated blocklist merging StevenBlack/hosts + AdAway defaults; header comment reads `# ARASAKA NETRUNNER FIREWALL v3.0.0`; auto-updates via `service.sh` weekly fetch
- [ ] **MOD-15 · `CP2077-SafetyNet-Fix`** — Magisk module incorporating the latest Play Integrity Fix (chiteroman variant); ensures `MEETS_DEVICE_INTEGRITY` passes after rooting; required prerequisite for users who also play CP2077 Mobile (when/if released) or use banking apps
- [ ] **MOD-16 · `CP2077-MagiskWebUI-Hub`** — unified WebUI dashboard aggregating status panels from all installed CP2077 modules in a single tabbed interface (`<module-id>` tabs); reads `MODDIR` of each installed sibling module to pull its status; works as the top-level `webroot/index.html` for a future `CP2077-Suite` meta-module
- [ ] **MOD-17 · `CP2077-Locale-Overlay`** — Magisk string overlay changing core Android system strings: `Settings` → `SYSTEM CONFIG`, `About phone` → `HARDWARE SPECS`, `Battery` → `POWER CELL`, `Storage` → `CYBERWARE`; implemented as `res/values/strings.xml` overlay targeting `com.android.settings`
- [ ] **MOD-18 · `CP2077-NetworkMonitor`** — Magisk `service.sh` module running a bandwidth monitor using `cat /proc/net/dev` delta every 5s; logs spikes > 10 MB/s to `/data/local/tmp/netrunner.log` with timestamp and interface name; optionally fires a notification via `am broadcast` on sustained high usage
- [ ] **MOD-19 · `CP2077-Fingerprint-Anim`** — Magisk resource overlay replacing the fingerprint sensor animation drawable (`ic_fingerprint_animation`) with a glitch/scanline animated vector drawable in `#00FFFF`; targets OOS 15 and HyperOS 2.0 SystemUI drawables verified against their APK resource IDs
- [ ] **MOD-20 · `CP2077-Universal-v2`** — next-gen Universal module: unified Python build system, 20+ ROM family detection, per-device config profiles in `devices/*.yaml`, resolution matrix (720p/1080p/1440p/4K) auto-built at CI time; parallel release track alongside `CP2077-OP7Pro` v4.x

### 🔀 Alternative Root & Distribution Modules

- [ ] **MOD-21 · `CP2077-KSU-Module`** — KernelSU-native format: `module.json` descriptor, `webroot/` for KSU WebUI API, no Magisk dependency; feature-parity with `CP2077-OP7Pro` including multi-path mount engine and `cp2077-config.sh`; parallel CI track in `.github/workflows/build-ksu.yml`
- [ ] **MOD-22 · `CP2077-APatch-Module`** — APatch-compatible package: tested against APatch ≥ 10340; `apd module install` support; `apd_module_compat=true` flag in `module.prop`; `service.sh` uses `apd` path detection already present in the Universal module
- [ ] **MOD-23 · `CP2077-AnyKernel3`** — AnyKernel3 flashable ZIP packaging the Neptune kernel with the CP2077 module pre-staged in `/data/adb/modules/` for a single-flash kernel+theme install from TWRP; avoids the two-step kernel-flash → Magisk-install sequence
- [ ] **MOD-24 · `CP2077-TWRP-Installer`** — TWRP-compatible flashable ZIP that bypasses Magisk entirely; direct-writes `bootanimation.zip` to `/system/media/` using TWRP's busybox `mount -o rw,remount`; targets users on unofficial builds where Magisk is incompatible
- [ ] **MOD-25 · `CP2077-Pixel-Port`** — dedicated port targeting Pixel 8 / 8 Pro / 9 (husky/shiba/tokay): `/data/local/bootanimation.zip` path priority per Pixel boot sequence; Tensor SoC timing adjustments; CI builds against Pixel factory image profile; released on separate `pixel` branch

---

## 🖼 25 ELEMENTS

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ ELEMENT BACKLOG — UI · VISUAL · CONFIG COMPONENTS ░░░░░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### 🌐 WebUI Elements

- [ ] **ELEM-01 · Variant card hover glow** — CSS `box-shadow: 0 0 20px rgba(252,238,12,0.4)` on `.variant-card:hover` with `transition: box-shadow 150ms ease`; currently cards have no hover feedback making them feel static and non-interactive
- [ ] **ELEM-02 · Status LED pulse chip** — `<span class="status-led">` beside each live readout with a `@keyframes pulse` cycling `#00FF9F → #FCEE0C → #00FF9F` at 2s; stops animating and turns red when the `sh()` exec bridge returns an error
- [ ] **ELEM-03 · CRT scanline overlay** — `::before` pseudo-element on `.cp2077-panel` with `repeating-linear-gradient(transparent 0, transparent 1px, rgba(0,0,0,0.07) 1px, rgba(0,0,0,0.07) 2px)` scrolling top→bottom at 3s cycle; adds CRT texture without impacting readability
- [ ] **ELEM-04 · Audio waveform visualizer** — 8-bar CSS bar chart (`div.bar` inside `.audio-viz`); when audio is enabled, bars animate from `height: 2px` to randomized `4–18px` via `@keyframes bar-dance` with staggered `animation-delay`; paused when audio disabled
- [ ] **ELEM-05 · Notification toast component** — `<div class="cp2077-toast">` slide-in from bottom-right, 3s auto-dismiss with `@keyframes toast-slide`; used for "Config saved ✓", "Reboot required", "ZIP not found — check /sdcard/Download"; replaces `alert()` calls currently in the WebUI
- [ ] **ELEM-06 · Mount path inspector panel** — collapsible `<details>` section labeled `◈ MOUNT MAP`; on expand, runs `mount | grep -E 'bootanim|product/media'` via `mmrl_exec` and displays each mount line color-coded: green if source contains `CP2077`, red if source is `/system/media` stock stub
- [ ] **ELEM-07 · OTA update banner** — on `DOMContentLoaded`, fetch `update.json` URL from `module.prop updateJson` line, compare `version` to installed; if newer, render a `<div class="ota-banner">` fixed at top with pulsing yellow border and "UPDATE AVAILABLE: vX.X.X — tap to flash" link
- [ ] **ELEM-08 · Variant comparison modal** — "COMPARE" button on each card opens a `<dialog>` side-by-side panel showing the key specs of two variants (FPS, resolution, frame count, file size) in a two-column table with a yellow divider; no external dependencies, pure HTML/CSS

### 🔒 Lock Screen Elements

- [ ] **ELEM-09 · hyprlock glitch bar** — second `shape {}` block at `y = 30%, width = 40%`; position randomly shifts `x` by `cmd[update:500] shuf -n1 -e 0 5 10 15 20`px on each 500ms tick, simulating a scanline glitch artifact; purely decorative, dims after 5s of input
- [ ] **ELEM-10 · hyprlock faction label** — `label {}` reading `FACTION=` from `/data/cp2077.conf` (via a wrapper script) and displaying `◈ CORPO EMPLOYEE ◈` / `◈ STREET KID ◈` / `◈ NOMAD ◈`; color-coded cyan/yellow/orange respectively; set once during `cp2077-config.sh` interactive setup
- [ ] **ELEM-11 · hyprlock uptime badge** — dim small label `cmd[update:60000] uptime -p | sed 's/up /UP: /'` positioned below the date; shows how long the system has been running; colour `rgba(68,68,68,0.60)` so it does not distract from the clock
- [ ] **ELEM-12 · hyprlock CAPSLOCK glyph** — replace the default `capslock_key_symbol = CAPS` text with a custom `⚠ CAPS ENGAGED` string in `rgba(255,107,53,1.0)` orange; ring color already set to orange; the glyph makes the state unambiguous on a dark background
- [ ] **ELEM-13 · swaylock date overlay** — add `--timestr "%H:%M"` and `--datestr "%A  %d %B  %Y"` to `swaylock.conf` for `swaylock-effects ≥ 1.7` which supports the time overlay natively; removes need for a separate lock-screen clock widget when swaylock is used as the sole locker
- [ ] **ELEM-14 · swaylock fail counter badge** — `--show-failed-attempts` already enabled; style the attempt count text with `--text-wrong-color ff003cff` and prepend `ACCESS DENIED ×` via `--text-wrong-text "ACCESS DENIED ×"` so the counter reads naturally in CP2077 language

### 📊 eww & Waybar Elements

- [ ] **ELEM-15 · eww temperature gauge** — `defpoll temp_cpu :interval "5s" \`cat /sys/class/thermal/thermal_zone*/temp | sort -n | tail -1 | awk '{printf "%.0f", $1/1000}'\`` added to the `PROCESSOR / ICE` section; color-coded `ok < 70°C`, `warn < 85°C`, `crit ≥ 85°C`
- [ ] **ELEM-16 · eww GPU load row** — `defpoll gpu_load :interval "3s" \`cat /sys/class/drm/card*/device/gpu_busy_percent 2>/dev/null | head -1 || echo "--"\`` shown under `PROCESSOR` section when the sysfs node is present; falls back to `--` gracefully on non-AMD/Intel GPUs
- [ ] **ELEM-17 · eww workspace dot indicators** — mini dot row `deflistener active_workspace` pulling from `hyprctl -j activeworkspace`; yellow dot = active, dim dot = occupied, hidden = empty; replaces need for a separate workspace indicator bar and keeps the HUD self-contained
- [ ] **ELEM-18 · Waybar clock urgent flash** — CSS `#clock.urgent { animation: clock-flash 0.5s 6; }` `@keyframes clock-flash { 50% { color: rgba(255,255,255,1); } }`; `format-alt` mode triggers the `urgent` class on the hour mark for 3s via a custom `exec-on-event` format string
- [ ] **ELEM-19 · Waybar active mission module** — custom `exec` module reads `~/cp2077-mission.txt` if present and displays `◈ ACTIVE MISSION: {contents} ◈` in dim italic in the center-right; if file absent, module returns empty string and is hidden; updated via `signal: 8` for instant refresh via `pkill -SIGRTMIN+8 waybar`
- [ ] **ELEM-20 · Waybar network direction arrows** — augment the existing `cp2077-net.sh` output with Unicode arrows: `↑ X.X KB/s  ↓ X.X KB/s`; color upload arrow in `#FF6B35` orange (outbound = danger) and download in `#00FFFF` cyan; direction makes bandwidth direction immediately readable

### 🐧 Plymouth & Script Elements

- [ ] **ELEM-21 · Plymouth glitch frame element** — random horizontal pixel-shift of the title sprite every 60th frame; implemented using Plymouth script's integer modulo on the frame counter: `if (count % 60 == 0) { title.SetX(title.GetX() + (count * 7919) % 11 - 5); }`; creates subtle glitch without breaking readability
- [ ] **ELEM-22 · Plymouth faction watermark** — dim `ARASAKA SYSTEMS` or `MILITECH DEFENSE NET` text rendered at bottom-left corner; selected by `(GetBootCount() % 2)` to alternate between them across reboots; color `rgba(42,42,42,0.4)` so it is barely visible
- [ ] **ELEM-23 · Plymouth secondary progress bar** — thin `rgba(42,42,42,0.6)` bar at 60% screen height tracking kernel module load count via the `Plymouth.SetMessageFunction` hook fed by an mkinitcpio hook that counts `modprobe` calls; gives kernel-load progress separately from disk-decrypt progress
- [ ] **ELEM-24 · `generate-manifests.sh` colorized TSV header** — print the `INDEX\tSIZE_BYTES\tPATH` header row in yellow `\033[38;2;252;238;12m` to match the existing ANSI palette; add a dim separator line `───────────────` below the header; purely cosmetic, consistent with the script's existing visual style
- [ ] **ELEM-25 · `cp2077-config.sh` arrow-key menu** — render the variant selection as a `for` loop printing `▶` before the highlighted item and `  ` before others; move cursor with `\033[<N>A` ANSI escape on key input parsed via `read -rsn1`; no ncurses/dialog dependency, pure bash; interactive navigation replaces the current numbered-prompt approach

---

## ⚙️ 25 FUNCTIONS

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ FUNCTION BACKLOG — SHELL · PYTHON · JAVASCRIPT IMPLEMENTATIONS ░░  ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### 🐚 Shell Functions (shared across `.sh` scripts)

- [ ] **FUNC-01 · `detect_root_manager()`** — shell: returns `magisk|kernelsu|apatch|none`; checks `/data/adb/ksud` (KSU), `command -v apd` (APatch), then `su -c id` (Magisk) in order; eliminates the duplicated detection blocks currently copy-pasted across `customize.sh`, `post-fs-data.sh`, `service.sh`, and `cp2077-config.sh`
- [ ] **FUNC-02 · `mount_with_fallback()`** — shell: accepts `src` path and a space-separated list of `dst` paths; attempts `mount --bind "$src" "$dst"` for each in order, logs result to `$MODDIR/mount.log`, returns 0 on first success; replaces the 40-line repeated mount blocks in `post-fs-data.sh`
- [ ] **FUNC-03 · `wait_for_prop()`** — shell: `wait_for_prop <key> <expected_value> [timeout_seconds=10]`; polls `getprop <key>` every 500ms; returns 0 when value matches, 1 on timeout; used in `service.sh` before the remount check to wait for `sys.boot_completed=1` rather than using a fixed `sleep 5`
- [ ] **FUNC-04 · `get_variant_from_conf()`** — shell: reads `VARIANT=` from `/data/cp2077.conf`, validates against `glitch|flatline|reboot|og1080p|og4k`, defaults to `glitch` if absent, empty, or invalid; single source of truth replacing inline `grep VARIANT` patterns across 3 separate scripts
- [ ] **FUNC-05 · `audio_enabled()`** — shell: parses `AUDIO=` from `/data/cp2077.conf`; returns 0 (true) for `1`, `true`, `yes`, `on` (case-insensitive); returns 1 for anything else including absent key; eliminates per-caller string comparison logic
- [ ] **FUNC-06 · `write_conf()`** — shell: atomically writes `/data/cp2077.conf` by writing to `${TMPDIR:-/data/local/tmp}/cp2077.conf.tmp` then `mv`ing it; prevents half-written config if interrupted at shutdown; sets `chmod 600` to protect against world-read; accepts key=value pairs as arguments
- [ ] **FUNC-07 · `find_module_zip()`** — shell: searches `/sdcard/Download/`, `/sdcard/`, `/storage/emulated/0/Download/` in order for `CP2077-OP7Pro-v*.zip` or `CP2077-Universal-v*.zip`; returns full path or empty string; used by `cp2077-config.sh` reinstall and the WebUI reflash button
- [ ] **FUNC-08 · `get_anim_size()`** — shell: `stat -c%s` the mounted bootanimation path (first existing of the known 6 paths); returns size in bytes or `0` if not found; used by `service.sh` threshold check and `cp2077-config.sh` health display; avoids per-caller path guessing
- [ ] **FUNC-09 · `is_anim_playing()`** — shell: `[ "$(getprop init.svc.bootanim)" = "running" ]`; returns 0 if running, 1 otherwise; called in `service.sh` before `setprop ctl.restart bootanim` to prevent restarting an animation that has already stopped cleanly
- [ ] **FUNC-10 · `detect_rom_family()`** — shell: probe `ro.product.brand`, `ro.build.flavor`, `ro.build.type`, `ro.miui.ui.version.name`, `ro.lineage.releasetype` in priority order; return one of `oos|lineage|miui|pixel|samsung|yaap|evolution|crDroid|unknown`; consolidates ROM detection from `customize.sh` and `post-fs-data.sh` into a single sourced file `lib/rom-detect.sh`
- [ ] **FUNC-11 · `ansi()`** — shell: `ansi R G B text` → `printf '\033[38;2;%d;%d;%dm%s\033[0m' "$1" "$2" "$3" "$4"`; tiny 24-bit color helper sourced at the top of all interactive scripts; eliminates the `YLW='\033[38;2;252;238;12m'` variable blocks currently duplicated in every script
- [ ] **FUNC-12 · `cp2077_logo()`** — shell: print the `░▒▓ CYBERPUNK 2077 ▓▒░` ASCII banner with correct 24-bit ANSI yellow; sourced by all interactive scripts so the visual header is consistent and maintained in a single `lib/logo.sh` file rather than being copy-pasted
- [ ] **FUNC-13 · `notify_sd_write()`** — shell: after writing any file to `/sdcard`, trigger `am broadcast -a android.intent.action.MEDIA_SCANNER_SCAN_FILE --eu android.intent.extra.STREAM "file://<path>"` so the file appears in MTP without remounting; prevents the common "file written but invisible in PC file browser" confusion
- [ ] **FUNC-14 · `cp2077_adb()`** — shell: wrapper in `cp2077-adb-control.sh` around `adb shell su -c '...'`; checks `adb devices` for a connected device, handles `unauthorized` state with a human-readable message, and prepends `export PATH=/data/adb/magisk:$PATH` to every command for consistent Magisk binary access

### 🐍 Python Functions (`build.py` and tools)

- [ ] **FUNC-15 · `pack_variant()`** — Python: `pack_variant(name, src_dir, out_dir, compress=ZIP_DEFLATED)`; handles `desc.txt` rewrite, frame sorting by `int(stem)`, `ZipInfo` timestamp normalization to `(1980,1,1,0,0,0)` for reproducible builds; refactors the 60-line inline block currently repeated per-variant in `build.py`
- [ ] **FUNC-16 · `validate_desc_txt()`** — Python: parse `desc.txt` string; assert `width > 0`, `height > 0`, `fps in {15,24,30,60,120}`, at least one `p` line with `frame_count > 0`; raise `ValueError("<field>: <reason>")` on failure; called from `build.py` after rewrite and in the GitHub Actions `validate` job
- [ ] **FUNC-17 · `zip_integrity_check()`** — Python: `zipfile.ZipFile(path).testzip()` returns `None` (ok) or the first bad filename; wraps in `try/except BadZipFile`; integrated into `build.py` post-pack step and the CI `validate` job; replaces the current `python3 -m zipfile -t` one-liner that lacks per-entry reporting
- [ ] **FUNC-18 · `desc_rewrite()`** — Python: read a `desc.txt` string, replace `width height fps` header, rewrite `p <count> <pause> <part>` lines preserving part directory names; handles the `c`-type continuation lines present in newer Android desc formats; used in the og4k upscale pipeline
- [ ] **FUNC-19 · `frame_count_from_zip()`** — Python: open a bootanimation ZIP; count PNGs inside `part*/` dirs; return `dict[part_name, count]` and total; called by `cp2077-zip-stats.py` and the CI validation step to assert expected frame counts match the desc.txt header
- [ ] **FUNC-20 · `parse_module_prop()`** — Python: read a Magisk `module.prop` `key=value` file into a `dict[str,str]`; used by `cp2077-version-bumper.py`, the CI release drafter, and `cp2077-module-lint.py` to extract `version`, `versionCode`, `id`, `updateJson` without per-tool regex duplication
- [ ] **FUNC-21 · `compute_sha256()`** — Python: `hashlib.sha256(path.read_bytes()).hexdigest()`; centralize SHA computation used in `build.py` artifact record, `generate-manifests.sh` step 5, and the GitHub Actions `sha256` step; stream-reads in 64 KB chunks for large ZIPs to avoid loading 358 MB into memory

### 🟨 JavaScript Functions (`webroot/index.html`)

- [ ] **FUNC-22 · `mmrl_exec()`** — JavaScript: central exec bridge accepting `cmd` string, returning `Promise<string>`; tries `window.mmrl.exec` → `window.__ksuExec` → console-warning mock in order; eliminates the inline `try/catch` currently scattered across 6 separate call sites in the WebUI; all `sh()` callers become `mmrl_exec(cmd).then(...)`
- [ ] **FUNC-23 · `refresh_status()`** — JavaScript: reads device model, Android version, active variant, animation size, and module version in a single `mmrl_exec` call using `&&`-chained shell commands; updates all DOM status elements atomically to prevent partial-load flicker when the version call is slower than the model call
- [ ] **FUNC-24 · `apply_variant()`** — JavaScript: validates the selected variant string against `/^(glitch|flatline|reboot|og1080p|og4k)$/` before calling `sh()`; prevents shell injection if the variant value is sourced from a URL hash parameter or modified DOM; logs invalid input to the diagnostic panel via `log_panel_append()`
- [ ] **FUNC-25 · `log_panel_append()`** — JavaScript: `log_panel_append(level, message)` appends `[HH:MM:SS] [LEVEL] message\n` to `#diag-log` and calls `scrollTop = scrollHeight`; replaces the 5 separate `diagLog.textContent +=` calls across WebUI event handlers with a single function that handles timestamping and auto-scroll

---

## 🎯 100 NEXT TASKS — Prioritised

```
╔══════════════════════════════════════════════════════════════════════════╗
║  ░░░ 100 NEXT TASKS · SORTED BY PRIORITY ░░░░░░░░░░░░░░░░░░░░░░░░░░░  ║
║  🔴 P0 CRITICAL · 🟠 P1 HIGH · 🟡 P2 MEDIUM · 🟢 P3 LOW              ║
╚══════════════════════════════════════════════════════════════════════════╝
```

### 🔴 P0 — CRITICAL · Must ship before v3.1.0 tag

> These are **blockers**. Nothing releases until all P0s are green.

- [ ] 🔴 **#001 · BUG-07 fix: package og4k shutdown ZIP** — glitch frames already adapted to 2160×4800 but not packed; run `build.py --shutdown og4k` and add `shutdownanimation/og4k/shutdownanimation.zip` to the `CP2077-OP7Pro` release; closes BUG-07 🐛
- [ ] 🔴 **#002 · BUG-08 fix: rboot coverage audit** — run `adb shell su -c "ls -la /data/misc/bootanim/"` and verify `rbootanimation.zip` is correctly bind-mounted for all 4 variants on LOS 23.2; patch `post-fs-data.sh` if path changed; closes BUG-08 🐛
- [ ] 🔴 **#003 · LOS 23.2 mount path validation** — fresh LOS 23.2 install: run `mount | grep -E 'product|bootanim'` and confirm the full mount table; verify `/product/media/bootanimation.zip` is still the correct primary target; document result in `DEVICE-SPECS.md` ✅ or ❌
- [ ] 🔴 **#004 · Android 16 boot timing race** — capture timestamped `logcat -b events` trace; confirm `post-fs-data.sh` completes before `bootanimation` service starts; if race found, add `sleep 1` guard or move critical mounts to `SKIPUNZIP=1` init.d path 🕐
- [ ] 🔴 **#005 · SELinux audit on LOS 23.2 / Android 16** — run `adb shell dmesg | grep -i avc | grep bootanim` after first boot; if denials exist, generate `sepolicy.rule` using `audit2allow` and add it to `$MODDIR/sepolicy.rule`; test that mount succeeds afterward 🛡️
- [ ] 🔴 **#006 · `uninstall.sh` — full data-partition wipe** — currently only removes the module overlay; extend to `rm -f /data/local/bootanimation.zip /data/local/shutdownanimation.zip /data/misc/bootanim/bootanimation.zip` and call `umount` on all lingering bind-mounts to avoid ghost files confusing future installs 🗑️
- [ ] 🔴 **#007 · `shellcheck` CI gate** — add `shellcheck -S warning` lint job to both `.github/workflows/build.yml` files; block merge on any SC2xxx / SC3xxx finding; run locally via `scripts/shellcheck-all.sh` before push; catches the copy-paste variable bugs in older `customize.sh` revisions 🚧
- [ ] 🔴 **#008 · `detect_root_manager()` shared lib** — extract root detection into `lib/root-detect.sh`; source it from `customize.sh`, `post-fs-data.sh`, `service.sh`, `cp2077-config.sh`; eliminates 4 divergent copies of the `/data/adb/ksud` / `apd` / `su` probe chain 🔧
- [ ] 🔴 **#009 · `mount_with_fallback()` refactor** — extract the repeated 40-line `mount --bind` blocks in `post-fs-data.sh` into `lib/mount.sh:mount_with_fallback src dst1 dst2 …`; log each attempt to `$MODDIR/mount.log`; return 0 on first success; halve the line count and make failures observable 🔧
- [ ] 🔴 **#010 · `mmrl_exec()` — central JS exec bridge** — replace the 6 scattered `try { window.mmrl.exec(…) } catch` blocks in `webroot/index.html` with a single `mmrl_exec(cmd)` returning `Promise<string>`; chain order: `window.mmrl.exec` → `window.__ksuExec` → mock; eliminates duplicated fallback logic 🌐

---

### 🟠 P1 — HIGH · Core v3.1.0 sprint work

- [ ] 🟠 **#011 · Variant preview in `customize.sh`** — before displaying the variant selection menu, `ui_print` a one-line ASCII description per variant (palette, fps, resolution, character); users choosing blind currently have no information at flash time 🖼️
- [ ] 🟠 **#012 · Silent install mode** — if `/data/cp2077.conf` exists and contains `SILENT=1`, skip all `customize.sh` interactive prompts and use stored values directly; critical for CI device tests where interactive input is impossible 🤫
- [ ] 🟠 **#013 · `build.py --dry-run` mode** — print every file that would be written without writing anything; useful for CI plan-phase checks and for verifying that a new variant entry is wired up correctly before committing build time 🏃
- [ ] 🟠 **#014 · `build.py --variants` filter** — `python3 build.py --variants glitch,netrunner` builds only the named variants; avoids the full 4+ variant build cycle when iterating on a single animation during development 🎯
- [ ] 🟠 **#015 · ZIP timestamp stripping** — pass `ZipInfo(date_time=(1980,1,1,0,0,0))` for every entry in `pack_zip()`; current builds are non-reproducible because host mtime leaks into ZIPs, making SHA-256 differ across machines and CI runs 🔒
- [ ] 🟠 **#016 · `module.prop` `support=` URL** — add `support=https://github.com/lchtangen/cyberpunk-2077/issues` to both `CP2077-OP7Pro/module.prop` and `CP2077-Universal/module.prop`; Magisk v26+ renders a one-tap "Support" button in the module card 🆘
- [ ] 🟠 **#017 · `cp2077-config.sh` backup/restore** — add `cp2077-config.sh backup` (copies `/data/cp2077.conf` → `/sdcard/cp2077-config-backup.conf`) and `restore` (copies back); protects user's variant choice across module reinstalls and ROM flashes 💾
- [ ] 🟠 **#018 · `service.sh` double-pass remount** — add a second `_remount_if_small` pass at `sleep 30`; catches MIUI/HyperOS and LOS 23.2 behaviour where `/product` is re-mounted late, evicting the first bind-mount and restoring the stock stub 🔄
- [ ] 🟠 **#019 · `post-fs-data.sh` trace mode** — if `$MODDIR/trace.flag` exists, write every mount/copy action to `/data/local/tmp/cp2077-trace.log` without executing; enables safe debugging on new ROM families without risking a boot loop 🔍
- [ ] 🟠 **#020 · Installation log export** — mirror every `ui_print` call to `/sdcard/cp2077-install-$(date +%Y%m%d-%H%M%S).log`; rotate keeping the 3 most recent; gives users a pasteable artifact for XDA / GitHub bug reports 📋
- [ ] 🟠 **#021 · `get_variant_from_conf()` — single source of truth** — shell function in `lib/conf.sh`; reads `VARIANT=` from `/data/cp2077.conf`, validates against the known set, defaults to `glitch`; sourced by `post-fs-data.sh`, `service.sh`, and `cp2077-config.sh` instead of each reimplementing the grep 📝
- [ ] 🟠 **#022 · `wait_for_prop()` — replace `sleep 5`** — `wait_for_prop sys.boot_completed 1 10`; polls every 500ms up to 10s timeout; replaces the fixed `sleep 5` in `service.sh` that causes the remount to run too early on fast devices (Snapdragon 8 Gen 3+) or too late on slow ones ⏱️
- [ ] 🟠 **#023 · `pack_variant()` — `build.py` refactor** — extract the 60-line per-variant packaging block into `pack_variant(name, src_dir, out_dir)`; includes `desc.txt` rewrite, frame sorting, ZipInfo timestamp normalisation, and post-pack integrity check; eliminates 4 copies of the same logic 🐍
- [ ] 🟠 **#024 · `validate_desc_txt()` — Python + CI** — assert `width>0`, `height>0`, `fps in {15,24,30,60,120}`, at least one `p` line with `count>0`; raise `ValueError` on failure; call from `build.py` after rewrite AND as a separate `validate` job in `build.yml` that runs on every PR 🐍
- [ ] 🟠 **#025 · Toast notification in WebUI** — `<div class="cp2077-toast">` sliding in from bottom-right, 3s auto-dismiss; replaces the 4 bare `alert()` calls in `webroot/index.html`; states: `✓ Config saved`, `⚠ Reboot required`, `✗ ZIP not found` 🔔
- [ ] 🟠 **#026 · Terminal color scheme pack** — 16-color ANSI palette from `cybrcolors/`: yellow→`color3/11`, cyan→`color6/14`, red→`color1/9`, green→`color2/10`, `#0A0A0A`→bg; ship `kitty.conf`, `alacritty.toml`, `wezterm.lua` under `05-LINUX/arch-host/terminal-themes/` 🖥️
- [ ] 🟠 **#027 · `cp2077-hud-toggle.sh`** — toggles between `eww open cp2077-hud` and `pkill waybar && waybar &`; bound to `Super+H` in `cyber-hyprland-theme/theme.conf`; avoids full compositor restart when switching display modes 🔀
- [ ] 🟠 **#028 · `cybrland` ↔ `cyber-hyprland-theme` canonical merge** — diff both repos; produce `06-UI-THEMES-ANIMATIONS/themes/cp2077-canonical-hyprland/`; take `hyprland.conf` from `cyber-hyprland-theme/`, `waybar/` from `cybrland/`, `eww/` from `cyber-hyprland-theme/`; retire duplicates ♻️
- [ ] 🟠 **#029 · Plymouth theme install verification** — after `install-plymouth.sh`, assert `cp2077` appears in `plymouth-set-default-theme -l` output; print the current default; if not active, automatically call `mkinitcpio -p linux` and print the rebuild output 🐧
- [ ] 🟠 **#030 · Papirus icon recolorization** — execute `K-DE-Cyberpunk-Neon/papirus-kolorizer.sh` with `--color '#FCEE0C'`; output to `06-UI-THEMES-ANIMATIONS/themes/papirus-cp2077/`; document install steps: `gtk-update-icon-cache`, XFCE/GNOME/KDE setting path 🎨
- [ ] 🟠 **#031 · `CP2077-Sounds-Extended` module** — standalone Magisk module: `Notification.ogg`, `VideoRecord.ogg`, `VideoStop.ogg`, `Screenshot.ogg`, `LowBattery.ogg`, `Ringtone.ogg`; normalised to −18 LUFS; decoupled from animation module; own `module.prop` + `update.json` 🔊
- [ ] 🟠 **#032 · `cp2077-zip-stats.py`** — parse `desc.txt` inside any animation ZIP; print resolution, fps, part count, frame count, compressed+uncompressed size in a CP2077-styled table; first arg = ZIP path; used to populate `VARIANTS.md` frame-count table 📊
- [ ] 🟠 **#033 · `cp2077-module-lint.py`** — static analysis: required `module.prop` fields, `customize.sh` set -e dry-parse, file permissions (`755` scripts / `644` data), `META-INF/` hierarchy, `webroot/` present if `flags=webui` set; exit 1 on any failure 🔍
- [ ] 🟠 **#034 · `cp2077-version-bumper.py`** — atomically update `module.prop` (`version=`, `versionCode=`), insert a CHANGELOG header, and update `update.json` (`version`, `versionCode`, `zipUrl`) in one invocation; validates `versionCode` is an int greater than current 🔢
- [ ] 🟠 **#035 · `VARIANTS.md` frame-count table** — document frame count, part count, fps, resolution, and uncompressed ZIP size for all 7 variants; data currently exists only in `build.py` constants and is invisible to users choosing between variants 📑

---

### 🟡 P2 — MEDIUM · v3.1.0 polish + v4.0.0 groundwork

- [ ] 🟡 **#036 · Rofi CP2077 launcher skin** — `cp2077.rasi`: bg `#0A0A0A`, border `#2A2A2A 1px`, selected row `#FCEE0C`, input text `#00FFFF`, JetBrains Mono; shipped under `cp2077-linux-hud/rofi/`; Hyprland keybind snippet included 🔍
- [ ] 🟡 **#037 · eww CPU temperature gauge** — `defpoll temp_cpu :interval "5s"` reading the highest thermal zone; added to `PROCESSOR / ICE` section; colour-coded ok `<70°C` / warn `<85°C` / crit `≥85°C` 🌡️
- [ ] 🟡 **#038 · eww GPU load row** — `defpoll gpu_load :interval "3s"` reading `/sys/class/drm/card*/device/gpu_busy_percent`; shown under PROCESSOR when sysfs node present; graceful `--` fallback 🎮
- [ ] 🟡 **#039 · eww workspace dot indicators** — `deflistener active_workspace` from `hyprctl -j activeworkspace`; yellow dot = active, dim dot = occupied, hidden = empty; keeps the HUD self-contained without a separate taskbar 🔵
- [ ] 🟡 **#040 · Waybar clock urgent flash** — CSS `@keyframes clock-flash` triggers on the hour mark via `exec-on-event` format string; pulses white for 3s; makes the hour transition visually noticeable on a busy desktop ⚡
- [ ] 🟡 **#041 · Waybar active-mission module** — `exec` module reads `~/cp2077-mission.txt`; displays `◈ ACTIVE MISSION: … ◈` in dim italic; hidden when file absent; instant refresh via `pkill -SIGRTMIN+8 waybar` 🎯
- [ ] 🟡 **#042 · Waybar network direction arrows** — augment `cp2077-net.sh` with `↑ X.X KB/s ↓ X.X KB/s`; upload arrow `#FF6B35` orange, download arrow `#00FFFF` cyan 🌐
- [ ] 🟡 **#043 · hyprlock glitch bar element** — second `shape {}` at `y=30%, width=40%`; x-position shifts randomly every 500ms via `cmd[update:500] shuf -n1 -e 0 5 10 15 20`; dims after 5s of input 👾
- [ ] 🟡 **#044 · hyprlock faction label** — `label {}` reading `FACTION=` from `/data/cp2077.conf`; displays `◈ CORPO ◈` / `◈ STREET KID ◈` / `◈ NOMAD ◈`; colour-coded cyan/yellow/orange 🏷️
- [ ] 🟡 **#045 · hyprlock uptime badge** — dim `cmd[update:60000] uptime -p` label below the date; colour `rgba(68,68,68,0.60)` so it doesn't compete with the clock ⏱️
- [ ] 🟡 **#046 · WebUI variant card hover glow** — `box-shadow: 0 0 20px rgba(252,238,12,0.4)` on `.variant-card:hover`, transition 150ms ease; cards currently feel static with zero hover feedback ✨
- [ ] 🟡 **#047 · WebUI status LED pulse** — `<span class="status-led">` with `@keyframes pulse` cycling `#00FF9F→#FCEE0C→#00FF9F` at 2s; turns solid red when exec bridge returns an error 🚦
- [ ] 🟡 **#048 · WebUI CRT scanline overlay** — `::before` on `.cp2077-panel`; `repeating-linear-gradient` 1px lines scrolling top→bottom at 3s; adds CRT texture without impacting text readability 📺
- [ ] 🟡 **#049 · WebUI audio waveform visualizer** — 8-bar CSS chart inside `.audio-viz`; bars animate `2px→4–18px` via `@keyframes bar-dance` when audio is enabled; paused when disabled 🎵
- [ ] 🟡 **#050 · WebUI mount path inspector** — collapsible `<details>◈ MOUNT MAP</details>`; on expand, runs `mount | grep -E 'bootanim|product/media'` and displays results colour-coded: green = CP2077 source, red = stock stub 🗺️
- [ ] 🟡 **#051 · WebUI OTA update banner** — on `DOMContentLoaded`, fetch `updateJson` URL from `module.prop`, compare `version`; if newer, show a fixed top `<div class="ota-banner">` with pulsing yellow border and "UPDATE AVAILABLE: vX.X.X — tap to flash" link 🔔
- [ ] 🟡 **#052 · WebUI variant comparison modal** — `<dialog>` opened by a "COMPARE" button on each card; side-by-side specs table (fps, resolution, frames, size); pure HTML/CSS, no deps 🔬
- [ ] 🟡 **#053 · WebUI localStorage persistence** — cache last-selected variant + audio state in `localStorage`; panel reflects choices instantly on open, before `refreshStatus()` async round-trip completes 💾
- [ ] 🟡 **#054 · Build megapack v3.1.0** — single ZIP containing all 7 variants + full audio pack; replaces v2.0.0-beta-megapack as the canonical "download everything" artifact; SHA-256 published in `production-artifact-sha256.txt` 📦
- [ ] 🟡 **#055 · Per-variant SHA256SUMS** — generate a `SHA256SUMS` file alongside every release ZIP in the `build.py` packaging phase; CI uploads it as a separate artifact; users can `sha256sum --check SHA256SUMS` 🔐
- [ ] 🟡 **#056 · Build matrix — 24-artifact parallel run** — `cp2077-build-matrix.py`: 3 modules × 4 variants × audio-on/off; `ProcessPoolExecutor` with configurable worker count; writes `build-matrix-manifest.json` with SHA-256 + size per artifact 🏗️
- [ ] 🟡 **#057 · `cp2077-frame-inspector.py`** — open animation ZIP, list parts + frame counts, render a chosen frame to terminal via Kitty/Sixel `term-image`; eliminates need to unzip locally to preview a single frame 🖼️
- [ ] 🟡 **#058 · `cp2077-zip-diff.py`** — diff two animation ZIPs by per-frame SHA-256; table of ADDED / REMOVED / CHANGED / IDENTICAL frames; verifies patch ZIPs only changed intended frames 🔍
- [ ] 🟡 **#059 · `cp2077-archive-audit.py`** — scan all workspace ZIPs for: corrupt entries (`testzip()`), zero-byte frames, missing `desc.txt`, non-numeric frame filenames, duplicate frame hashes; colour-coded report 🔎
- [ ] 🟡 **#060 · `cp2077-palette-gen.py`** — generate 1920×120px colour palette PNG from `build.py` hex constants; embed in README + VARIANTS.md; auto-regenerate in release workflow 🎨
- [ ] 🟡 **#061 · `cp2077-wallpaper-extract.py`** — extract frame 1 from selected variant ZIP, resize to host display resolution via Pillow LANCZOS, save to `~/.config/wallpapers/cp2077-boot-frame.png`; hooked into `cp2077-adb-control.sh pull-frame` 🖼️
- [ ] 🟡 **#062 · `cp2077-rom-probe.sh`** — read 30+ `ro.*` props from ADB device; map to ROM family + API level + device codename + recommended install path; output as terminal table + `device-profile.yaml` 📱
- [ ] 🟡 **#063 · `cp2077-health-dashboard.sh`** — pure-ANSI terminal TUI: module state, active variant, mounted ZIP size, mount path, audio state, last-boot timestamp, pass/WARN/FAIL checks; callable as `cp2077-adb-control.sh health` 🏥
- [ ] 🟡 **#064 · `CP2077-Fonts` Magisk overlay** — Rajdhani as `sans-serif`, JetBrains Mono as `monospace`; inject into `/system/fonts/` + patch `fonts.xml` via post-install Python script; covers system UI, settings, notification text 🔤
- [ ] 🟡 **#065 · `CP2077-Icons` APK module** — patched `cyberpunk-technotronic-icon-theme` (no broken symlinks) packaged as an Android icon pack APK with a proper `AndroidManifest.xml`; installable from Settings without root 🎨
- [ ] 🟡 **#066 · `CP2077-StatusBar` LSPosed module** — recolour status bar: clock `#FCEE0C`, icon tint `#00FFFF`, battery fill gradient `#FCEE0C→#FF003C`; targets AOSP SystemUI + OOS + HyperOS SystemUI variants 📱
- [ ] 🟡 **#067 · `CP2077-LockscreenClock` overlay** — AOSP/OOS lockscreen: font → Rajdhani, colour → `#00FFFF`, date → `#AAAAAA`; `res/values/styles.xml` overlay targeting `com.android.systemui` ⏰
- [ ] 🟡 **#068 · `CP2077-QuickSettings` overlay** — tile bg `rgba(10,10,10,0.92)`, active tint `#FCEE0C`, label font JetBrains Mono 10sp; tested against OOS 15 / AOSP 14 QS layout XML ⚙️
- [ ] 🟡 **#069 · `CP2077-SplashScreen` overlay** — Android 12+ `windowSplashScreenBackground` + animated `windowSplashScreenAnimatedIcon`; CP2077 black bg + animated yellow horizontal bar on every app launch splash 🚀
- [ ] 🟡 **#070 · `CP2077-Hosts-Adblocker`** — systemless hosts module; StevenBlack/hosts + AdAway merged; header `# ARASAKA NETRUNNER FIREWALL v3.0.0`; weekly auto-update via `service.sh` fetch 🛡️
- [ ] 🟡 **#071 · `CP2077-KSU-Module` native format** — `module.json` descriptor + `webroot/` for KSU WebUI; feature-parity with `CP2077-OP7Pro`; parallel CI track `.github/workflows/build-ksu.yml` 🔑
- [ ] 🟡 **#072 · `audio_enabled()` shared function** — parses `AUDIO=` from `/data/cp2077.conf`; returns 0/1 for `1|true|yes|on` vs everything else; sourced by all scripts that gate on audio state 🔊
- [ ] 🟡 **#073 · `write_conf()` atomic write** — write `/data/cp2077.conf` to a `.tmp` file then `mv`; sets `chmod 600`; prevents half-written config if interrupted at power-off 📝
- [ ] 🟡 **#074 · `find_module_zip()` search helper** — searches `/sdcard/Download/`, `/sdcard/`, `/storage/emulated/0/Download/` for `CP2077-*.zip`; returns path or empty string; used by `cp2077-config.sh` and WebUI reflash button 🔍
- [ ] 🟡 **#075 · `get_anim_size()` helper** — `stat -c%s` on the first existing of the 7 known bootanimation paths; returns size or 0; used by both `service.sh` threshold check and `cp2077-config.sh` health display; removes per-caller path duplication 📏

---

### 🟢 P3 — LOW · v4.0.0 – v5.0.0 / wishlist

- [ ] 🟢 **#076 · Netrunner all-green color mode** — alternate Linux HUD: yellow `#FCEE0C` → `#00FF9F`, cyan `#00FFFF` → `#00CC44`; shipped under `cp2077-linux-hud/variants/netrunner/` with alternate `eww.scss`, `style.css`, `hyprlock.conf` 🟢
- [ ] 🟢 **#077 · GRUB animated splash** — `background_image` + GFXTERM loop over pre-rendered PNGs extracted from the reboot animation; `install-grub-theme.sh` patches `/etc/default/grub` and runs `grub-mkconfig` 💻
- [ ] 🟢 **#078 · Variants A/B rotation mode** — `AB_ROTATE=1` in `cp2077.conf` alternates two specified variants on every other reboot; `service.sh` reads a boot counter from `/data/local/tmp/cp2077-bootcount` and flips the active variant 🔄
- [ ] 🟢 **#079 · Battery-aware animation downgrade** — read `/sys/class/power_supply/BAT0/capacity` in `post-fs-data.sh`; if `< 20`, mount the 30fps variant regardless of user selection; no user intervention needed 🔋
- [ ] 🟢 **#080 · FPS governor from display refresh rate** — detect `ro.surface_flinger.max_frame_buffer_acquired_buffers` at install; auto-select 30 / 60 / 120fps `desc.txt` entry rather than hardcoding 60fps for all devices 📺
- [ ] 🟢 **#081 · Display-cutout-aware centering** — parse `ro.config.notch_type` at install; if notch present, patch `desc.txt` canvas offset so key visual elements clear the camera cutout 📷
- [ ] 🟢 **#082 · Custom accent color injection** — `ACCENT_HEX=` in `cp2077.conf`; `build.py --inject-color` replaces `#FCEE0C` in all frame PNGs via Pillow palette remap; allows personal branding without re-sourcing assets 🎨
- [ ] 🟢 **#083 · OTA delta update** — `update.json` gains `deltaUrl` pointing to a patch ZIP with only changed frames; `service.sh` downloads and applies it in background without a full reinstall ⬇️
- [ ] 🟢 **#084 · On-device module update notification** — compare `/data/cp2077-version` to `module.prop` on first boot after update; fire `am broadcast` NotificationManager intent so user is informed without opening Magisk 📲
- [ ] 🟢 **#085 · Haptic pattern sync** — write vibration pattern to `/sys/class/leds/vibrator/` timed to title-card impact, glitch flash, and boot-complete frames; graceful no-op fallback on devices without sysfs vibrator node 📳
- [ ] 🟢 **#086 · CP2077 Monet color injection** — Monet-compatible `res/values/colors.xml` overlay placing `#FCEE0C` / `#00FFFF` as system accent colors; on Android 12+ Monet overrides dynamic colour-extraction with CP2077 tokens permanently 🎨
- [ ] 🟢 **#087 · Night mode audio** — check `date +%H` in `post-fs-data.sh`; between 22:00–07:00, mount a quieter audio set (`volume_factor=0.4`); respects user sleep without requiring manual toggle 🌙
- [ ] 🟢 **#088 · Audio fade-out on boot complete** — detect `sys.boot_completed=1` in `service.sh`; play a 2-second fade envelope via `am start` MediaPlayer intent before broadcast fires; prevents the hard audio cut on fast devices 🔇
- [ ] 🟢 **#089 · Dynamic wallpaper extraction** — after install, `unzip -p` the first frame of the selected variant, Pillow letterbox-crop to device resolution, set as lockscreen wallpaper via WallpaperManager intent 🖼️
- [ ] 🟢 **#090 · `CP2077-Bootlogo` partition module** — `dd`-write a CP2077 logo BMP to the `logo` partition; full backup/restore; OP7 Pro first, expand to other devices with known logo partition layouts 🖥️
- [ ] 🟢 **#091 · `CP2077-LiveWallpaper-GLShader` APK** — real Android `WallpaperService` APK; Kotlin + OpenGL ES 3.0 GLSL rain/glitch shader on `#0A0A0A` background; battery governor drops to 5fps when screen-off; replaces quarantined HTML files 🎮
- [ ] 🟢 **#092 · `CP2077-AnyKernel3` package** — AnyKernel3 ZIP bundling Neptune kernel + CP2077 module pre-staged in `/data/adb/modules/`; single TWRP flash = kernel + theme; avoids two-step install 📦
- [ ] 🟢 **#093 · `CP2077-TWRP-Installer` direct-write** — TWRP flashable ZIP bypassing Magisk; `mount -o rw,remount /system` + copy `bootanimation.zip` → `/system/media/`; for users on Magisk-incompatible unofficial ROMs 🔧
- [ ] 🟢 **#094 · `CP2077-Pixel-Port`** — dedicated port for Pixel 8/8 Pro/9 (husky/shiba/tokay); `/data/local/bootanimation.zip` path priority; Tensor SoC timing adjustments; separate `pixel` branch + CI matrix 📱
- [ ] 🟢 **#095 · Plymouth glitch frame shift** — random horizontal pixel-shift of title sprite every 60th frame via `(count * 7919) % 11 - 5` offset in Plymouth script; subtle glitch without breaking readability 👾
- [ ] 🟢 **#096 · Plymouth faction watermark** — dim `ARASAKA SYSTEMS` / `MILITECH DEFENSE NET` at bottom-left; alternated by `GetBootCount() % 2`; colour `rgba(42,42,42,0.4)` 🌑
- [ ] 🟢 **#097 · Plymouth kernel-module progress bar** — thin dim bar at 60% screen height tracking `modprobe` call count via an mkinitcpio hook feeding `Plymouth.SetMessage`; separates kernel-load from disk-decrypt progress 📊
- [ ] 🟢 **#098 · Nothing Phone glyph sync** — sync Nothing Glyph LED patterns with boot animation stages (title-card → glyph pattern A, glitch flash → glyph pattern B, boot complete → glyph all-off) via Nothing Glyph SDK service hook 📱
- [ ] 🟢 **#099 · Self-hosted OTA update server** — `update.json` endpoint on a VPS or GitHub Pages with version tracking; eliminates dependency on raw `githubusercontent.com` URLs for OTA delivery; add `lastChecked` + `downloadCount` telemetry opt-in 🌐
- [ ] 🟢 **#100 · Upstream PR to sodasoba1** — submit the OP7 Pro resolution adaptation of `glitch` + `flatline` frames as a PR to `sodasoba1/ONEPLUS9-OOS13-BootAnimation`; credit the workspace; contributes back to the source animation community 🤝

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
