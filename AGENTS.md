# AGENTS.md - cyberpunk-2077 workspace

Operational guidance for coding agents working in `/home/arch/cyberpunk-2077`.
For fuller background, read `CLAUDE.md` first; it has the architecture notes,
build lifecycle, and device control commands.

## What this workspace is

This is a Cyberpunk 2077 Android theme/module workspace for OnePlus 7 Pro and
Universal Android builds. It also contains Arch/Linux theming references and
device/kernel research material.

The root repository is now intended to expose the full workspace to GitHub
agents. Source trees under `01-DEVELOPMENT/` through `08-HACKING-RESEARCH/`
may still be nested git repositories with their own history, but their working
tree files should remain visible from the root checkout.

## Critical invariants

- `service.sh` unmounts any mounted bootanimation under 5 MB. CP2077 animation
  ZIPs are always above 5 MB; stock ROM stubs are usually under 100 KB. This is
  the correctness guarantee for the three-stage mount strategy.
- `module.prop` version code is `MAJOR * 100000 + MINOR * 1000 + PATCH`
  (`v3.0.0` -> `300000`, `v3.1.0` -> `301000`).
- Do not edit any `module.prop` version fields unless the matching build script
  constants, release ZIP names, and `releases/update-*.json` files are updated
  in the same change.
- Each release ZIP also contains its own `update.json`; that is separate from
  the root `releases/update-full.json` and `releases/update-universal.json`.
- `99-MANIFESTS/` files are generated snapshots. Treat them as stale until
  `bash 99-MANIFESTS/generate-manifests.sh` has been run.

## Git workflow

The root repo should make workspace source, scripts, docs, manifests, release
metadata, themes, and research files available to GitHub agents. The root
`.gitignore` excludes only local tool state, nested `.git/` internals, cache
directories, device download dumps, and known artifacts too large for normal
GitHub git hosting without Git LFS.

Before staging broad workspace changes, check for large files:

```bash
find . -path './.git' -prune -o -path '*/.git/*' -prune -o -type f -size +95M -print
```

For code under nested repos, avoid committing their `.git/` directories into the
root repo. Do not rewrite or clean unrelated user changes.

## Important paths

| Path | Purpose |
|------|---------|
| `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/` | Primary OnePlus 7 Pro Full module |
| `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro-Ultimate/` | Ultimate/megapack module, disabled on device |
| `01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal/` | Universal all-device module |
| `02-PRODUCTION/magisk-modules/` | Release-ready module artifacts and symlinks |
| `05-LINUX/arch-host/device-arch-scripts/` | ADB/device control scripts |
| `06-UI-THEMES-ANIMATIONS/` | Boot animations, shutdown animations, audio, wallpapers, Linux themes |
| `07-KERNEL-PACKAGE-MODULES/` | Kernel images, kernel sources, root-related packages |
| `08-HACKING-RESEARCH/` | NetHunter/security research workspace |
| `09-DOCS/` | Human documentation |
| `10-QUARANTINE-invalid-downloads/` | Invalid downloads; never install from here |
| `99-MANIFESTS/` | Generated inventories, checksums, repo status |
| `releases/` | GitHub/Magisk update JSON and changelogs |

## Build commands

Full Edition, OnePlus 7 Pro:

```bash
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro
python3 build.py                         # all variants
python3 build.py --dry-run               # print plan without writing files
python3 build.py --check-sources         # HEAD-check upstream source URLs
python3 build.py --list-variants         # list known variant keys
python3 build.py --no-audio              # skip FFmpeg audio generation
python3 build.py --variants glitch       # build one variant
python3 build.py --variants glitch,og4k  # build selected variants
```

Universal Edition:

```bash
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal
python3 build-universal.py
```

Build outputs land in each module's `release/` directory. Source ZIPs are cached
under `.downloads/` by filename. Re-running builds should skip unchanged
downloads.

## Build dependencies and format rules

- `build.py` and `build-universal.py` require Python 3 and standard zip tooling.
- `build.py` uses `ffmpeg` for generated audio. If `ffmpeg` is missing, audio is
  silently skipped.
- `build-universal.py` requires FFmpeg with LANCZOS scaling support.
- Bootanimation inner ZIPs must use `ZIP_STORED`/no compression.
- Reproducible release ZIPs use normalized timestamps (`1980-01-01`) for stable
  SHA-256 values.
- `desc.txt` first line is either traditional `<width> <height> <fps>` or global
  `g W H offsetX offsetY fps`. The `rewrite_desc()` functions handle both.

## Release checklist

When bumping a version, update all matching surfaces in one pass:

1. `build.py`: banner/version strings, release filenames, `VARIANT_LABELS`, and
   any hardcoded changelog/update references.
2. `build-universal.py`: same pattern for Universal release filenames and
   hardcoded `v1.0.0`-style strings.
3. `module.prop` in every affected module source tree.
4. `module.prop` inside each final release ZIP.
5. Root update pointers: `releases/update-full.json` and/or
   `releases/update-universal.json`.
6. ZIP-local `update.json` files, if present.
7. Changelogs under `releases/`.
8. Manifests:

```bash
bash 99-MANIFESTS/generate-manifests.sh
```

Before finishing a release change, check that version strings and version codes
match across `module.prop`, build scripts, release filenames, and update JSON.

## Device and install operations

ADB helper script:

```bash
cd 05-LINUX/arch-host/device-arch-scripts
./cp2077-adb-control.sh status
./cp2077-adb-control.sh switch glitch
./cp2077-adb-control.sh flash
./cp2077-adb-control.sh verify
./cp2077-adb-control.sh logs
```

Direct on-device config entry point:

```bash
adb shell su -c /data/adb/modules/CP2077_OP7Pro_Full/cp2077-config.sh
```

Only flash verified production artifacts from `02-PRODUCTION/magisk-modules/` or
freshly built release ZIPs from the correct source module.

## Quarantine and safety

`10-QUARANTINE-invalid-downloads/` contains HTML files masquerading as APKs or
ZIPs. Never install, flash, repackage, or use those files as source artifacts.

Treat device-flash commands as production-affecting. Prefer inspect/build/verify
steps before changing the connected device.

## Quick architecture reference

Boot lifecycle:

1. `customize.sh` runs during flash, reads/writes `/data/cp2077.conf`, and
   installs the selected animation into the module tree.
2. `post-fs-data.sh` runs early on boot, copies fallback ZIPs, and bind-mounts
   the selected boot/shutdown animation and audio files over ROM paths.
3. `service.sh` runs late, checks for too-small mounted files, unmounts stock
   stubs, and reapplies CP2077 bind mounts.

Known bootanimation target paths include:

- `/product/media/bootanimation.zip`
- `/product/media/bootanimation-dark.zip`
- `/system/product/media/bootanimation.zip`
- `/system/media/bootanimation.zip`
- `/my_product/media/bootanimation/bootanimation.zip`
- `/data/local/bootanimation.zip`
- `/data/misc/bootanim/bootanimation.zip`

## Documentation maintenance

Keep `AGENTS.md` concise and operational. Put detailed user-facing procedures in
`09-DOCS/`, and keep architecture/build details synchronized with `CLAUDE.md`.
