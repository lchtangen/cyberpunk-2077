# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## What this repo is

A Magisk theme suite workspace for Android (OnePlus 7 Pro, plus a Universal all-device edition). It installs Cyberpunk 2077 boot/shutdown animations, UI audio, and splash assets via Magisk/KernelSU/APatch. The workspace also contains Linux desktop theming for the Arch host (Plymouth, Waybar, eww, hyprlock, Hyprland).

The **git repo itself only tracks**:
- `README.md`, `CLAUDE.md`, `.gitignore`
- `00-CONTROL/` — workspace policy and live device status
- `09-DOCS/` — all documentation
- `99-MANIFESTS/` — auto-generated inventories and checksums
- `releases/` — `update.json` OTA pointers and changelogs (no ZIPs)

Everything under `01-DEVELOPMENT/` through `08-HACKING-RESEARCH/` is `.gitignore`d. Those directories contain nested git repos tracked by their own remotes (catalogued in `99-MANIFESTS/git-repositories.txt`).

---

## Build commands

### Full Edition (OnePlus 7 Pro)

```bash
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro
python3 build.py                                    # all 5 variants + megapack
python3 build.py --variants glitch,flatline         # specific variants
python3 build.py --no-audio                         # skip audio generation
python3 build.py --check-sources                    # validate upstream URLs
```

Output lands in `release/`. Source ZIPs are downloaded to `.downloads/` (cached by filename) and re-encoded to `1440×3120` with `ZIP_STORED` for the bootanimation inner ZIPs, while the release ZIP uses `ZIP_DEFLATED`. Timestamps are stripped to 1980-01-01 for reproducible SHA-256.

### Universal Edition (all devices)

```bash
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal
python3 build-universal.py           # full universal ZIP + per-variant packs
```

`build-universal.py` scales frames to 12 target resolutions via FFmpeg LANCZOS and auto-detects ROM family at install time via `getprop`. Output goes to `release/` and `release/per-variant/`.

### Regenerate workspace manifests

```bash
# From workspace root
bash 99-MANIFESTS/generate-manifests.sh
```

Runs 5 passes: directory map, workspace size, artifact inventory (TSV), git repo status, and SHA-256 of all production ZIPs. Always run this after adding new release artifacts.

---

## ADB control (host → device)

```bash
cd 05-LINUX/arch-host/device-arch-scripts
./cp2077-adb-control.sh status          # device info, config, mount sizes
./cp2077-adb-control.sh switch          # interactive variant picker
./cp2077-adb-control.sh switch glitch   # non-interactive
./cp2077-adb-control.sh flash           # push + install release ZIP
./cp2077-adb-control.sh restart-anim    # setprop ctl.restart bootanim
./cp2077-adb-control.sh logs            # pull filtered logcat
./cp2077-adb-control.sh verify          # validate all bootanimation ZIPs
./cp2077-adb-control.sh build           # trigger python3 build.py for all modules
```

Requires `adb` in PATH and USB debugging with root authorisation. The script uses `adb shell su -c` for privileged operations.

### On-device config (via ADB shell)

```bash
adb shell su -c /data/adb/modules/CP2077_OP7Pro_Full/cp2077-config.sh
```

Interactive prompt to change variant and audio, then reinstall without reflashing from a ZIP.

---

## Module architecture

### Three-stage boot lifecycle

1. **`customize.sh`** — runs during Magisk flash inside recovery. Reads `/data/cp2077.conf` for defaults. Calls `install_bootanimation <variant>` which copies the correct ZIP into `$MODPATH/system/product/media/`. Writes the chosen config back to `/data/cp2077.conf`.

2. **`post-fs-data.sh`** — runs at `post-fs-data` on every boot. Copies ZIPs to `/data/local/` and `/data/misc/bootanim/` (LineageOS path), then bind-mounts `$MODDIR/system/product/media/bootanimation.zip` over every known system path. Also bind-mounts individual `.ogg` files for audio.

3. **`service.sh`** — runs after boot completes (late-start, after `sleep 5`). Re-runs `_remount_if_small` on all paths: if the mounted file is under 5 MB it's a stock stub that won — unmounts it and re-applies the bind-mount. This repairs ROMs that re-mount `/product` after `post-fs-data`.

### Mount path matrix

The module tries all of these in `post-fs-data.sh`:

| Path | ROM |
|------|-----|
| `/product/media/bootanimation.zip` | AOSP, LineageOS, yaap |
| `/product/media/bootanimation-dark.zip` | AOSP dark-mode fallback |
| `/system/product/media/bootanimation.zip` | OOS 14+ |
| `/system/media/bootanimation.zip` | Samsung One UI |
| `/my_product/media/bootanimation/bootanimation.zip` | MIUI/HyperOS |
| `/data/local/bootanimation.zip` | universal fallback (highest priority on Pixel/GrapheneOS) |
| `/data/misc/bootanim/bootanimation.zip` | LineageOS custom path |

The `service.sh` 5 MB threshold is the key correctness invariant — all CP2077 ZIPs are well above it; stock stubs are under 100 KB.

### Config file

`/data/cp2077.conf` — plain key=value:

```
variant=glitch    # glitch | flatline | reboot | og1080p
audio=yes
```

Re-read by `customize.sh` on every flash and by `cp2077-config.sh` for live changes.

### `module.prop` version code formula

`MAJOR * 100000 + MINOR * 1000 + PATCH` → v3.0.0 = `300000`, v1.0.0 = `100000`

---

## bootanimation.zip format

```
bootanimation.zip (ZIP_STORED — no compression)
├── desc.txt        "1440 3120 60\np 0 0 part0\np 1 0 part1"
├── part0/          intro — p 0 = play once
│   └── frame*.png
└── part1/          loop  — p 1 = loop forever
    └── frame*.png
```

`desc.txt` first line: `<width> <height> <fps>`. The `rewrite_desc()` function in `build.py` handles both the traditional `W H fps` format and the global `g W H offsetX offsetY fps` format. `build.py` rewrites it to `1440 3120` for OP7Pro and to the target resolution for Universal.

---

## OTA update flow

`releases/update-full.json` and `releases/update-universal.json` are served via `raw.githubusercontent.com` and referenced in each `module.prop`'s `updateJson=` field. Magisk Manager polls these on module refresh. The JSON schema:

```json
{
  "version": "v3.0.0",
  "versionCode": 300000,
  "zipUrl": "https://github.com/.../releases/download/.../CP2077-OP7Pro-v3.0.0.zip",
  "changelog": "https://raw.githubusercontent.com/.../releases/CHANGELOG-full.md"
}
```

---

## WebUI panel

`01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/webroot/index.html` — served by Magisk's built-in WebView (v26+). Communicates with the device via `window.mmrl.exec()` (MMRL bridge) or `window.__ksuExec` (KernelSU bridge). Falls back to mock responses if neither bridge is available so the UI still renders.

Key JS functions: `refreshStatus()`, `applyConfig()`, `restartAnim()`, `showDiag()`. Config is written by `printf 'variant=...\naudio=...' > /data/cp2077.conf` via the exec bridge.

---

## Design tokens (CP2077 palette)

Used consistently across WebUI, ADB script ANSI output, Waybar, eww, hyprlock, Rofi, and Plymouth:

```
--yellow:  #FCEE0C   (primary accent, corp-ID gold)
--cyan:    #00FFFF   (secondary, netrunner blue)
--red:     #FF003C   (danger / flatline)
--orange:  #FF6B35   (warning)
--green:   #00FF9F   (success / health)
--bg:      #0A0A0A   (background)
--border:  #2A2A2A   (dividers)
```

---

## Key relationships across directories

- **Source** lives in `01-DEVELOPMENT/repos/cyberpunk/<module>/`
- **Release ZIPs** output to `<module>/release/` and are symlinked from `02-PRODUCTION/magisk-modules/`
- **Linux host scripts** are in `05-LINUX/arch-host/device-arch-scripts/` — they reference workspace paths relative to `$WORKSPACE_ROOT` (three levels up from the script)
- **Manifests** in `99-MANIFESTS/` are always stale until `generate-manifests.sh` is re-run; never trust them as live state

---

## What NOT to do

- Do not install anything from `10-QUARANTINE-invalid-downloads/` — those files are HTML documents masquerading as APKs/ZIPs.
- Do not run `git add -A` or commit from the workspace root — only `00-CONTROL/`, `09-DOCS/`, `99-MANIFESTS/`, `releases/`, and `README.md` belong in the workspace git history.
- Do not edit `module.prop` version strings without also updating `build.py` constants and the corresponding `releases/update-*.json`.
