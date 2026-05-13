# AGENTS.md — cyberpunk-2077 workspace

See also: `CLAUDE.md` (build commands, architecture, boot lifecycle).

## Critical invariants

- `service.sh` unmounts any mounted bootanimation under 5 MB — CP2077 ZIPs are always >5 MB, stock stubs are <100 KB. This is the correctness guarantee for the three-stage mount strategy.
- `module.prop` version code = `MAJOR * 100000 + MINOR * 1000 + PATCH` (v3.0.0 = 300000). Never edit `module.prop` without also updating `build.py` constants and `releases/update-*.json`.

## Must-run after releasing

```bash
bash 99-MANIFESTS/generate-manifests.sh
```
Manifests in `99-MANIFESTS/` are always stale — they track checked-in state, not live workspace.

## Git workflow

The workspace root only tracks: `README.md`, `CLAUDE.md`, `.gitignore`, `00-CONTROL/`, `09-DOCS/`, `99-MANIFESTS/`, `releases/`.
Never `git add -A` or commit from the workspace root. Sub-repos in `01-DEVEL/`–`08-HACKING/` manage their own git history.

## Quarantine

`10-QUARANTINE-invalid-downloads/` contains HTML files masquerading as APKs/ZIPs — never install from there.

## Build dependencies

- `build.py` requires `ffmpeg` for audio generation; without it, audio is silently skipped.
- `build-universal.py` requires FFmpeg with LANCZOS scaling support.

## bootanimation.zip format

`desc.txt` first line: `<width> <height> <fps>` (traditional) or `g W H offsetX offsetY fps` (global). The `rewrite_desc()` function in `build.py` handles both.

## build.py — useful flags

```bash
python3 build.py --dry-run          # print plan without writing files
python3 build.py --check-sources    # HEAD-request every upstream URL
python3 build.py --list-variants    # show known variants and source URLs
python3 build.py --no-audio        # skip FFmpeg audio generation
python3 build.py --variants glitch  # single variant (default: all 5)
```

Reproducible builds: ZIP timestamps are stripped to 1980-01-01 for bit-identical SHA-256.

Source ZIPs are cached in `.downloads/` by filename — re-running skips unchanged downloads.

## Version update checklist

When bumping version (e.g. v2.0.0 → v3.0.0), update ALL of:
1. `build.py` — `VERSION`, `VARIANT_LABELS`, hardcoded version strings, and `release/` filenames
2. `build-universal.py` — same pattern (`v1.0.0` strings)
3. `module.prop` inside each release ZIP — `version=` and `versionCode=`
4. `releases/update-full.json` and `releases/update-universal.json`

`module.prop` `versionCode` = `MAJOR * 100000 + MINOR * 1000 + PATCH` (v3.0.0 = 300000).

Note: each ZIP also contains its own `update.json` — different from `releases/update-*.json`.

## Directory ownership

| Directory | What lives here |
|-----------|-----------------|
| `01-DEVELOPMENT/repos/cyberpunk/<module>/` | Source repos (nested git) — CP2077-OP7Pro, CP2077-Universal |
| `<module>/release/` | Release ZIPs (gitignored) |
| `02-PRODUCTION/magisk-modules/` | Symlinks to release ZIPs |
| `99-MANIFESTS/` | Auto-generated workspace manifests (always stale) |
| `10-QUARANTINE-invalid-downloads/` | HTML masquerading as APKs/ZIPs — never install |