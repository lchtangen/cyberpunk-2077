# CP2077 OP7Pro Full Edition — Changelog

## v3.1.0 (2026-05-14)
### Security & Supply Chain
- **`sources.lock.json`** — SHA-256 lock file for all upstream source ZIPs; CI gate fails on mismatch
- **`SOURCES`** — upstream source URL inventory consumed by `build.py --check-sources` and lock validator
- **SLSA provenance** — `cp2077-slsa-provenance.sh` generates in-toto Statement v1 for every release ZIP
- **`sepolicy.rule` fix** — corrected invalid SELinux source domain syntax (was missing `{ init magisk_client }`)
- **OpenSSF Scorecard** — weekly scan via `scorecard.yml` with SARIF upload to GitHub code scanning

### CI/CD Pipeline
- **`release.yml`** — tag-triggered workflow: validates sources → builds all variants → generates SLSA provenance → creates draft GitHub Release with provenance attachment
- **`nightly.yml`** — daily dry-run: `--check-sources`, per-variant build verification, ShellCheck, source lock drift detection
- **`codeql.yml`** — CodeQL security-and-quality analysis for Python + JavaScript; ShellCheck SARIF upload
- **`scorecard.yml`** — OpenSSF Scorecard weekly + SARIF publish to GitHub Advanced Security
- **`.pre-commit-config.yaml`** — shellcheck, shfmt, ruff, JSON/YAML validation, ZIP integrity, and sepolicy lint hooks
- **`cp2077-ci-local.sh`** — `act` wrapper to run any workflow locally without pushing

### Root Manager Parity
- **`mmrl.json`** — MMRL module metadata with variants array, root manager list, WebUI features
- **`module.json`** — KernelSU module JSON parity; APatch v0.10+ compatibility declared
- **WebUI APatch bridge** — `webroot/cp2077.js` now detects `window.ksu` (APatch native) before falling back to mock
- **`lib/config-v2.sh`** — `phantom-lib` and `dogtown` variants added to registry and validator

### Tooling
- **`scripts/cp2077-zip-diff.py`** — OTA safety diff: added/removed/changed files, desc.txt delta, versionCode regression detection
- **`scripts/cp2077-palette-gen.py`** — design token SVG/CSS/JSON/PNG generator for all 14 tokens + 10 variant palettes
- **`scripts/cp2077-bench.sh`** — 5-run ADB boot timing benchmark with mean/min/max/stddev aggregation
- **`scripts/check-github-remotes.sh`** — parallel HTTP 200/301 check for all 53 workspace remotes; `--fix-stale` flag
- **`99-MANIFESTS/generate-manifests.sh`** — parallel SHA-256 hashing (8 workers, deterministic output order)
- **`device-profile.schema.yaml`** — strict YAML schema for `cp2077-rom-probe.sh` output, consumed by `build-universal.py`

### Documentation
- **`docs/DEVICE-SPECS.md`** — full audit: 8-path mount matrix, Android 16 timing budgets, APatch binary paths, ROM+root compat matrix
- **`module.json`** — KernelSU module JSON with 5-variant metadata, mount path matrix, config schema

---

## v3.0.0 (2026-05-13)
### Workspace Merge & Upgrade
- **Unified workspace**: all sources consolidated under numbered directory structure
- **`customize.sh`**: merged Full+Ultimate logic — config-file support, OOS `my_product` path, modular functions; `og1080p` variant now correctly installs shutdown animation
- **`post-fs-data.sh`**: upgraded to multi-path mount engine (covers AOSP, LineageOS, OOS, yaap)
- **`service.sh`**: replaced fixed-path checks with 5 MB size-threshold remount helper
- **`uninstall.sh`**: now cleans `/data/local` and `/data/misc/bootanim` paths
- **`META-INF/update-binary`**: fixed undefined variable bugs, standard Magisk trampoline
- **`module.prop`**: broadened `androidApi=26` (was 36), version bumped to v3.0.0
- **`build.py`**: upgraded with parallel variant builds and proper metadata embedding
- **`update.json`**: bumped to v3.0.0
- **`og1080p` shutdown animation**: all 4 variants now have matching shutdown animations

---

## v2.0.0-beta (2026-05-13)
### Initial Public Beta
- Boot animation: 3 variants + original at 1440×3120 (OP7 Pro native)
  - CyberGlitch-2077 (glitch logo, 60fps)
  - Cyberpunk-Flatline-2077 (flatline style, 60fps)
  - Re-Boot Animation (OP logo + glitch, 60fps)
  - Original 1080p (8T SE port, 30fps)
- Shutdown animation: color-matched for all 3 main variants
- Audio: CP2077-themed lock/unlock, charging, camera, and UI sounds
- Installer: interactive variant selection via `customize.sh`
- Compatibility: Android 14–16+ — OnePlus 7 Pro (guacamole)
- Paths: automatic detection for AOSP (`/product/media`) and OOS (`/my_product/media`)
