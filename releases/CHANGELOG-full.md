<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════════╗
║  ░▒▓  CHANGELOG — CP2077 OP7PRO FULL EDITION  ▓▒░                          ║
║  ────────────────────────────────────────────────────────────────────────── ║
║  OnePlus 7 Pro · Magisk / KernelSU / APatch · All Release Notes            ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

[![Latest](https://img.shields.io/badge/LATEST-v3.1.0-00FF9F?style=for-the-badge&labelColor=0a0a0a)](./update-full.json)
[![Module](https://img.shields.io/badge/Module-CP2077__OP7Pro__Full-FF003C?style=for-the-badge&labelColor=0a0a0a)](../09-DOCS/INSTALLATION-GUIDE.md)
[![Device](https://img.shields.io/badge/Device-OnePlus_7_Pro-FCEE0C?style=for-the-badge&labelColor=0a0a0a)](../09-DOCS/DEVICE-SPECS.md)

</div>

---

## 🔥 v3.1.0 — Security Hardening & CI/CD  *(2026-05-14)*

```
╔══════════════════════════════════════════════════════════════════════════════╗
║  ░░░ HARDENING SPRINT — SUPPLY CHAIN · CI/CD · ROOT MANAGER PARITY  ░░░  ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

### 🛡 Security & Supply Chain

| ✅ Feature | 📋 Detail |
|:----------|:---------|
| `sources.lock.json` | SHA-256 lock file for all upstream source ZIPs; CI gate fails on mismatch |
| `SOURCES` | Upstream URL inventory consumed by `build.py --check-sources` and lock validator |
| SLSA provenance | `cp2077-slsa-provenance.sh` generates in-toto Statement v1 for every release ZIP |
| `sepolicy.rule` fix | Corrected invalid SELinux source domain syntax (`{ init magisk_client }` was missing) |
| OpenSSF Scorecard | Weekly scan via `scorecard.yml` with SARIF upload to GitHub code scanning |

### 🤖 CI/CD Pipeline

| ⚙️ Workflow | 📋 Trigger | 🎯 Purpose |
|:-----------|:----------|:---------|
| `release.yml` | Git tag push | Validate sources → build variants → SLSA provenance → draft GitHub Release |
| `nightly.yml` | Daily schedule | `--check-sources`, per-variant verify, ShellCheck, lock drift detection |
| `codeql.yml` | Push + PR | CodeQL for Python + JavaScript; ShellCheck SARIF upload |
| `scorecard.yml` | Weekly | OpenSSF Scorecard + SARIF to GitHub Advanced Security |
| `.pre-commit-config.yaml` | Pre-commit hook | shellcheck, shfmt, ruff, JSON/YAML, ZIP integrity, sepolicy lint |
| `cp2077-ci-local.sh` | Manual | `act` wrapper — run any workflow locally without pushing |

### 🔑 Root Manager Parity

| ✅ Feature | 📋 Detail |
|:----------|:---------|
| `mmrl.json` | MMRL module metadata — variants array, root manager list, WebUI features |
| `module.json` | KernelSU module JSON parity; APatch v0.10+ compatibility declared |
| WebUI APatch bridge | `webroot/cp2077.js` detects `window.ksu` (APatch native) before mock fallback |
| `lib/config-v2.sh` | `phantom-lib` and `dogtown` variants added to registry and validator |

### 🔧 New Tooling

| 🔧 Script | 📋 Purpose |
|:---------|:---------|
| `scripts/cp2077-zip-diff.py` | OTA safety diff — added/removed/changed files, desc.txt delta, versionCode regression |
| `scripts/cp2077-palette-gen.py` | Design token SVG/CSS/JSON/PNG generator — 14 tokens + 10 variant palettes |
| `scripts/cp2077-bench.sh` | 5-run ADB boot timing benchmark with mean/min/max/stddev |
| `scripts/check-github-remotes.sh` | Parallel HTTP check for all 53 workspace remotes; `--fix-stale` flag |
| `99-MANIFESTS/generate-manifests.sh` | Parallel SHA-256 hashing (8 workers, deterministic output order) |
| `device-profile.schema.yaml` | Strict YAML schema for `cp2077-rom-probe.sh`, consumed by `build-universal.py` |

### 📚 Documentation

- **`DEVICE-SPECS.md`** — full audit: 8-path mount matrix, Android 16 timing budgets, APatch binary paths, ROM + root compat matrix
- **`module.json`** — KernelSU module JSON with 5-variant metadata, mount path matrix, config schema

---

## ⚡ v3.0.0 — Workspace Merge & Upgrade  *(2026-05-13)*

```
╔══════════════════════════════════════════════════════════════════════════════╗
║  ░░░ PRODUCTION RELEASE — FULL WORKSPACE RESTRUCTURE + MULTI-ROM  ░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

| ✅ Change | 📋 Detail |
|:---------|:---------|
| Unified workspace | All sources consolidated under numbered directory structure |
| `customize.sh` | Merged Full+Ultimate logic — config-file, OOS `my_product` path, modular functions; `og1080p` shutdown now correct |
| `post-fs-data.sh` | Upgraded to multi-path mount engine (AOSP, LineageOS, OOS, yaap) |
| `service.sh` | Replaced fixed-path checks with 5 MB size-threshold remount helper |
| `uninstall.sh` | Now cleans `/data/local` and `/data/misc/bootanim` paths |
| `META-INF/update-binary` | Fixed undefined variable bugs; standard Magisk trampoline |
| `module.prop` | Broadened `androidApi=26` (was 36); version → v3.0.0 |
| `build.py` | Upgraded with parallel variant builds and metadata embedding |
| `update.json` | Bumped to v3.0.0 |
| `og1080p` shutdown | All 4 variants now have matching shutdown animations ✅ |

---

## 🟡 v2.0.0-beta — Initial Public Beta  *(2026-05-13)*

```
╔══════════════════════════════════════════════════════════════════════════════╗
║  ░░░ INITIAL BETA — 3 VARIANTS + AUDIO + MULTI-PATH INSTALL  ░░░░░░░░░░  ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

### 🎬 Boot Animation Variants

| 🎬 Variant | ⚡ FPS | �� Resolution | 📝 Source |
|:----------|:------|:------------|:---------|
| CyberGlitch-2077 | 60 | 1440×3120 | sodasoba1 OOS 13 modded |
| Cyberpunk-Flatline-2077 | 60 | 1440×3120 | sodasoba1 OOS 13 modded |
| Re-Boot Animation | 60 | 1440×3120 | sodasoba1 OOS 13 modded |
| Original 1080p | 30 | 1080×2340 | OP8T SE port |

### ✅ Initial Features

- Shutdown animation — color-matched for all 3 main variants
- Audio — CP2077-themed lock/unlock, charging, camera, and UI sounds (7 OGG files)
- Installer — interactive variant selection via `customize.sh`
- Compatibility — Android 14–16+ · OnePlus 7 Pro (guacamole)
- Paths — automatic detection for AOSP (`/product/media`) and OOS (`/my_product/media`)

---

<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════════╗
║  ⚡  JACK IN. BOOT UP. NIGHT CITY NEVER SLEEPS.  ⚡                         ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

[![Variants](https://img.shields.io/badge/Variants-VARIANTS.md-00FFFF?style=flat-square&labelColor=0a0a0a)](../09-DOCS/VARIANTS.md)
[![Install](https://img.shields.io/badge/Install-INSTALLATION--GUIDE.md-00FF9F?style=flat-square&labelColor=0a0a0a)](../09-DOCS/INSTALLATION-GUIDE.md)
[![Roadmap](https://img.shields.io/badge/Roadmap-ROADMAP.md-FF6B35?style=flat-square&labelColor=0a0a0a)](../09-DOCS/ROADMAP.md)

</div>
