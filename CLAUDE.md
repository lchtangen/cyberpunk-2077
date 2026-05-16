# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

---

## What this repo is

A Magisk theme suite workspace for Android (OnePlus 7 Pro, plus a Universal all-device edition). It installs Cyberpunk 2077 boot/shutdown animations, UI audio, and splash assets via Magisk/KernelSU/APatch. The workspace also contains Linux desktop theming for the Arch host (Plymouth, Waybar, eww, hyprlock, Hyprland).

The **root git repo is intended to expose the workspace to GitHub agents**:
- `README.md`, `CLAUDE.md`, `AGENTS.md`, `.gitignore`, `.markdownlint.json`
- `00-CONTROL/` — workspace policy and live device status
- `01-DEVELOPMENT/` through `08-HACKING-RESEARCH/` — source trees, scripts, themes, kernels, and research files
- `09-DOCS/` — all documentation
- `99-MANIFESTS/` — auto-generated inventories and checksums
- `releases/` — `update-*.json` OTA pointers and changelogs

The root `.gitignore` excludes local tool state, nested `.git/` internals,
cache directories, device download dumps, and known artifacts too large for
normal GitHub git hosting without Git LFS. Nested repos are catalogued in
`99-MANIFESTS/git-repositories.txt`; do not commit their `.git/` directories.

## Current release state

| Module | Version | versionCode | Status |
|--------|---------|-------------|--------|
| `CP2077_OP7Pro_Full` | **v3.1.0** | 301000 | Active on device |
| `CP2077_OP7Pro_Ultimate` | v3.0.0 | 300000 | Disabled on device |
| `CP2077_Universal` | v1.0.0 | 100000 | Built |

Active device: OnePlus 7 Pro `GM1911` (codename `guacamole`) · Android 16 (API 36) · Magisk v30.7 · variant `glitch`.

## Cloned reference repos

The workspace maintains shallow `--depth 1` clones of upstream references in these directories:

| Directory | What lives here |
|-----------|-----------------|
| `01-DEVELOPMENT/repos/magisk-ecosystem/` | Magisk, KernelSU, APatch, LSPosed, Vector, ZygiskNext, ReZygisk, zygisk-module-sample, MMRL, awesome-android-root |
| `01-DEVELOPMENT/repos/cyberpunk/` | Primary modules (CP2077-OP7Pro, CP2077-OP7Pro-Ultimate, CP2077-Universal) + reference bootanimation repos + Lawnchair/Lawnicons |
| `01-DEVELOPMENT/repos/oneplus-7-pro/` | LineageOS, DerpFest, Evolution-X, crDroid device trees; engstk, Neptune, KernelSU-LineageOS, OnePlus OSS kernels; OrangeFox recovery; crDroid vendor blobs |
| `01-DEVELOPMENT/repos/android-roms/` | TWRP/PBRP recovery trees |
| `06-UI-THEMES-ANIMATIONS/repos/` | hyprdots, HyprPanel, rofi, plymouth-themes, mechabar, proxzima-plymouth, diinki-retrofuture, dotfiles, dots, widgets, TokyoNight-rofi-theme, catppuccin |
| `06-UI-THEMES-ANIMATIONS/themes/` | Cyberpunk-Neon, K-DE-Cyberpunk-Neon, cyber-hyprland-theme, cybrland, cybrcolors, cyberpunk-technotronic-icon-theme |
| `07-KERNEL-PACKAGE-MODULES/` | engstk op8 (blu-spark-16), op5 (blu-spark-10); Neptune SM8150 kernel |

---

## Build commands

### Full Edition (OnePlus 7 Pro)

```bash
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro
python3 build.py                                    # all variants + megapack
python3 build.py --variants glitch,flatline         # specific variants
python3 build.py --no-audio                         # skip audio generation
python3 build.py --check-sources                    # validate upstream URLs against sources.lock.json
python3 build.py --dry-run                          # print plan without writing files
python3 build.py --list-variants                    # list known variant keys
```

Output lands in `release/`. Source ZIPs are downloaded to `.downloads/` (cached by filename) and re-encoded to `1440×3120` with `ZIP_STORED` for the bootanimation inner ZIPs, while the release ZIP uses `ZIP_DEFLATED`. Timestamps are stripped to 1980-01-01 for reproducible SHA-256. After build, `build.py` writes the real SHA-256 into `update.json` (supply chain gate).

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

Runs 5 passes: directory map, workspace size, artifact inventory (TSV), git repo status, and SHA-256 of all production ZIPs (parallelised — 8 workers, deterministic order). Always run this after adding new release artifacts.

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
variant=glitch    # glitch | flatline | reboot | og1080p | og4k | phantom-lib | dogtown
audio=yes
```

Re-read by `customize.sh` on every flash and by `cp2077-config.sh` for live changes. `lib/config-v2.sh` contains the authoritative variant registry and validator.

### `module.prop` version code formula

`MAJOR * 100000 + MINOR * 1000 + PATCH` → v3.1.0 = `301000`, v3.0.0 = `300000`, v1.0.0 = `100000`

---

## Animation variants

| Key | Style | FPS | Resolution | Notes |
|-----|-------|-----|------------|-------|
| `glitch` | CP2077 logo glitch effect, neon cyan/yellow | 60 | 1440×3120 | **Active / recommended** |
| `flatline` | Flatline ECG motif | 60 | 1440×3120 | |
| `reboot` | OnePlus logo + glitch overlay | 60 | 1440×3120 | |
| `og1080p` | Authentic OP8T Cyberpunk SE port | 30 | 1080×2340 | Lower res is intentional |
| `og4k` | og1080p LANCZOS 2× upscale | 30 | 2160×4800 | Dev asset — not bundled by default |
| `phantom-lib` | — | — | — | Added in v3.1.0 via `lib/config-v2.sh` |
| `dogtown` | — | — | — | Added in v3.1.0 via `lib/config-v2.sh` |

Each variant has matching boot + shutdown + reverse-boot animations. ZIP sizes range from 0.5 MB (shutdown) to 358 MB (og4k boot).

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

Three update JSON files under `releases/`, served via `raw.githubusercontent.com` and referenced in each `module.prop`'s `updateJson=` field. Magisk Manager polls these on module refresh.

| File | Module | Current version |
|------|--------|-----------------|
| `releases/update-full.json` | `CP2077_OP7Pro_Full` | v3.1.0 |
| `releases/update-ultimate.json` | `CP2077_OP7Pro_Ultimate` | v3.0.0 |
| `releases/update-universal.json` | `CP2077_Universal` | v1.0.0 |

JSON schema:

```json
{
  "version": "v3.1.0",
  "versionCode": 301000,
  "zipUrl": "https://github.com/lchtangen/cyberpunk-2077/releases/download/v3.1.0-full/CP2077-OP7Pro-v3.1.0.zip",
  "checksum": "<sha256-written-by-build.py>",
  "changelog": "https://raw.githubusercontent.com/lchtangen/cyberpunk-2077/main/releases/CHANGELOG-full.md"
}
```

Each release ZIP also embeds its own local `update.json`. That file is separate from the root `releases/` pointers.

---

## WebUI panel

`01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/webroot/index.html` — served by Magisk's built-in WebView (v26+). Communicates with the device via bridge priority order:

1. `window.mmrl.exec()` — MMRL
2. `window.__ksuExec` — KernelSU
3. `window.ksu` — APatch native (added v3.1.0)
4. Mock responses — no bridge available (UI still renders)

Key JS functions: `refreshStatus()`, `applyConfig()`, `restartAnim()`, `showDiag()`. Config is written by `printf 'variant=...\naudio=...' > /data/cp2077.conf` via the exec bridge.

MMRL module metadata: `mmrl.json`. KernelSU module JSON: `module.json`.

---

## CI/CD and supply chain tooling (v3.1.0+)

Located under `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/`:

| File | Purpose |
|------|---------|
| `.github/workflows/release.yml` | Tag-triggered: validate sources → build all variants → SLSA provenance → draft GitHub Release |
| `.github/workflows/nightly.yml` | Daily dry-run: `--check-sources`, per-variant verify, ShellCheck, lock drift detection |
| `.github/workflows/codeql.yml` | CodeQL for Python + JavaScript; ShellCheck SARIF upload |
| `.github/workflows/scorecard.yml` | OpenSSF Scorecard weekly scan + SARIF to GitHub Advanced Security |
| `.pre-commit-config.yaml` | shellcheck, shfmt, ruff, JSON/YAML validation, ZIP integrity, sepolicy lint |
| `sources.lock.json` | SHA-256 lock for all upstream source ZIPs — CI gate fails on mismatch |
| `SOURCES` | Upstream source URL inventory consumed by `build.py --check-sources` |
| `cp2077-slsa-provenance.sh` | Generates in-toto Statement v1 for every release ZIP |
| `cp2077-ci-local.sh` | `act` wrapper to run any workflow locally without pushing |

---

## Utility scripts (v3.1.0+)

Located under `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/scripts/`:

| Script | Purpose |
|--------|---------|
| `cp2077-zip-diff.py` | OTA safety diff: added/removed/changed files, desc.txt delta, versionCode regression detection |
| `cp2077-palette-gen.py` | Design token SVG/CSS/JSON/PNG generator for all 14 tokens + 10 variant palettes |
| `cp2077-bench.sh` | 5-run ADB boot timing benchmark with mean/min/max/stddev aggregation |
| `check-github-remotes.sh` | Parallel HTTP check for all workspace remotes; `--fix-stale` flag |

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
- **Linux theming references** live in `06-UI-THEMES-ANIMATIONS/repos/` (hyprdots, rofi, plymouth-themes, etc.) and `themes/` (cyberpunk-themed dotfiles)
- **Magisk/Root ecosystem** references live in `01-DEVELOPMENT/repos/magisk-ecosystem/`
- **OP7 device trees & kernels** live in `01-DEVELOPMENT/repos/oneplus-7-pro/` and `07-KERNEL-PACKAGE-MODULES/`
- **Manifests** in `99-MANIFESTS/` are always stale until `generate-manifests.sh` is re-run; never trust them as live state

---

## Release checklist

When bumping a version, update all of these in one pass — version drift across surfaces is a P0 bug:

1. `build.py`: banner/version strings, release filenames, `VARIANT_LABELS`, hardcoded changelog/update references
2. `build-universal.py`: same pattern for Universal release filenames
3. `module.prop` in every affected module source tree
4. `module.prop` inside each final release ZIP
5. `releases/update-full.json`, `releases/update-universal.json`, `releases/update-ultimate.json`
6. ZIP-local `update.json` files
7. Changelogs under `releases/`
8. Run `bash 99-MANIFESTS/generate-manifests.sh`

---

## What NOT to do

- Do not install anything from `10-QUARANTINE-invalid-downloads/` — those files are HTML documents masquerading as APKs/ZIPs.
- Do not commit nested `.git/` directories, local tool state, virtualenvs, device download dumps, or >95 MB artifacts without Git LFS.
- Do not edit `module.prop` version strings without also updating `build.py` constants and the corresponding `releases/update-*.json` files.
- Do not trust `99-MANIFESTS/` files as live state — they are snapshots from the last manifest generation run.
- Do not treat `10-QUARANTINE-invalid-downloads/` files as source artifacts — they are invalid downloads flagged for disposal.
