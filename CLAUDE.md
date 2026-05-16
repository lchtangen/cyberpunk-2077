# Cyberpunk Magisk Theme Workspace

Magisk theme suite for Android (OnePlus 7 Pro + Universal all-device). Installs Cyberpunk 2077 boot/shutdown animations, UI audio, splash assets via Magisk/KernelSU/APatch. Also contains Linux desktop theming (Plymouth, Waybar, eww, hyprlock, Hyprland).

**Git tracks only:** `README.md`, `CLAUDE.md`, `.gitignore`, `00-CONTROL/`, `09-DOCS/`, `99-MANIFESTS/`, `releases/`. Everything under `01-DEVELOPMENT/`–`08-HACKING-RESEARCH/` is `.gitignore`d (nested repos tracked by their own remotes, catalogued in `99-MANIFESTS/git-repositories.txt`).

## Build Commands

### OnePlus 7 Pro (Full Edition)

```bash
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro
python3 build.py                         # all 5 variants + megapack
python3 build.py --variants glitch,flatline
python3 build.py --no-audio
python3 build.py --check-sources
```

Output: `release/`. Sources cached in `.downloads/`, re-encoded to `1440×3120`, `ZIP_STORED` inner ZIPs, `ZIP_DEFLATED` release ZIP. Timestamps stripped to 1980-01-01 for reproducible SHA-256.

### Universal Edition

```bash
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal
python3 build-universal.py               # full ZIP + per-variant packs
```

Scales to 12 resolutions via FFmpeg LANCZOS. Auto-detects ROM family via `getprop`.

### Regenerate Manifests

```bash
bash 99-MANIFESTS/generate-manifests.sh  # run after new release artifacts
```

## ADB Control

```bash
cd 05-LINUX/arch-host/device-arch-scripts
./cp2077-adb-control.sh status          # device info, config, mount sizes
./cp2077-adb-control.sh switch [glitch] # variant picker
./cp2077-adb-control.sh flash           # push + install release ZIP
./cp2077-adb-control.sh restart-anim
./cp2077-adb-control.sh logs
./cp2077-adb-control.sh verify          # validate bootanimation ZIPs
./cp2077-adb-control.sh build
```

Uses `adb shell su -c` for privileged ops. On-device config: `adb shell su -c /data/adb/modules/CP2077_OP7Pro_Full/cp2077-config.sh`

## Module Architecture

**Three-stage boot lifecycle:**
1. `customize.sh` — Magisk flash in recovery; reads `/data/cp2077.conf`, installs bootanimation ZIP
2. `post-fs-data.sh` — every boot; copies ZIPs, bind-mounts over all known system paths + audio `.ogg` files
3. `service.sh` — after boot completes (sleep 5); re-mounts if file is under 5 MB (stock stub detection — all CP2077 ZIPs are well above 5 MB; stock stubs are under 100 KB)

**Mount path matrix:** `/product/media/bootanimation.zip` (AOSP/LineageOS), `/system/product/media/` (OOS 14+), `/system/media/` (Samsung), `/my_product/media/bootanimation/` (MIUI/HyperOS), `/data/local/` (Pixel/GrapheneOS priority), `/data/misc/bootanim/` (LineageOS)

**Config:** `/data/cp2077.conf` — `variant=glitch` | `flatline` | `reboot` | `og1080p`, `audio=yes`

**Version code:** `MAJOR * 100000 + MINOR * 1000 + PATCH` (v3.0.0 = `300000`)

## bootanimation.zip Format

```
bootanimation.zip (ZIP_STORED)
├── desc.txt    "1440 3120 60\np 0 0 part0\np 1 0 part1"
├── part0/      intro (p 0 = play once) — frame*.png
└── part1/      loop  (p 1 = loop forever) — frame*.png
```

## OTA Update Flow

`releases/update-full.json` and `releases/update-universal.json` served via `raw.githubusercontent.com`, referenced in `module.prop`'s `updateJson=`. Schema: `version`, `versionCode`, `zipUrl`, `changelog`.

Always update `module.prop` version + `build.py` constants + `releases/update-*.json` together.

## WebUI Panel

`01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/webroot/index.html` — served by Magisk's built-in WebView (v26+). Uses `window.mmrl.exec()` (MMRL) or `window.__ksuExec` (KernelSU) bridges; falls back to mock if unavailable. Config written via `printf 'variant=...\naudio=...' > /data/cp2077.conf`.

## Design Tokens (CP2077 Palette)

```
--yellow:  #FCEE0C   primary accent
--cyan:    #00FFFF   secondary
--red:     #FF003C   danger / flatline
--orange:  #FF6B35   warning
--green:   #00FF9F   success / health
--bg:      #0A0A0A   background
--border:  #2A2A2A   dividers
```

Used consistently across WebUI, ADB script ANSI, Waybar, eww, hyprlock, Rofi, Plymouth.

## Key Relationships

- Source: `01-DEVELOPMENT/repos/cyberpunk/<module>/`
- Release ZIPs: `<module>/release/` → symlinked from `02-PRODUCTION/magisk-modules/`
- Host scripts: `05-LINUX/arch-host/device-arch-scripts/` — reference `$WORKSPACE_ROOT`
- Manifests in `99-MANIFESTS/` are stale until `generate-manifests.sh` is re-run

## What NOT to Do

- Do not install from `10-QUARANTINE-invalid-downloads/` — those are HTML files masquerading as APKs/ZIPs
- Do not `git add -A` from workspace root — only `00-CONTROL/`, `09-DOCS/`, `99-MANIFESTS/`, `releases/`, `README.md` belong in git
- Do not edit `module.prop` version strings without also updating `build.py` constants and `releases/update-*.json`
