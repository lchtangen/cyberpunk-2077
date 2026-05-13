# CP2077 Roadmap

Release strategy, active sprint, backlog lanes, and completion ledger for the
Cyberpunk 2077 Android theme stack.

## At a Glance

| Item | Value |
|:----|:-----|
| **Track** | v3.2.0 Roadmap |
| **Stable** | v3.0.0 OP7Pro Full |
| **Active Sprint** | v3.1.0 Hardening |
| **Universal** | v1.0.0 |
| **Bugs** | 8 fixed / 0 open |
| **Device** | OnePlus 7 Pro GM1911 |
| **Android** | 16 / API 36 |
| **Backlog** | 210+ tasks |
| **Updated** | 2026-05-13 |

## Mission Control

| | |
|:---|:---|
| **Release Health** | Stable module v3.0.0 live · Bugs: 8/0 · Universal: v1.0.0 built |
| **Active Sprint** | Build: 100% · Installer: 100% · Docs: 67% · LOS 23.2: pending |
| **Next Tracks** | v4.0.0: Universal v2, CI, root-manager packaging · v5.0.0: Multi-device, live wallpaper · Backlog: 210+ tasks |

## Navigation

| Section | Use It For |
|:--|:--|
| [Release Matrix](#release-matrix) | Module status and version-code rules |
| [Bug Register](#bug-register) | Closed bug history and regression context |
| [v3.1.0 Active Sprint](#v310-active-sprint) | Current release blockers and work lanes |
| [v4.0.0 Mid-Term](#v400-mid-term) | Universal expansion and CI |
| [v5.0.0 Vision](#v500-vision) | Device expansion and ecosystem ideas |
| [Execution Backlog](#execution-backlog) | Prioritized implementation queues |
| [Implementation Tracks](#implementation-tracks) | CI, automation, developer experience |
| [Repository Integration TODO](REPOSITORY-INTEGRATION-TODO.md) | Audit-driven tasks from all cloned repositories |

## Design System

| Token | Hex | Roadmap Use |
|:--|:--|:--|
| Neon Yellow | `#FCEE0C` | active sprint, warnings, work in progress |
| Netrunner Cyan | `#00FFFF` | roadmap track, Universal, links |
| Signal Green | `#00FF9F` | done, stable, verified |
| Flatline Red | `#FF003C` | blockers, failures, risk |
| Warning Orange | `#FF6B35` | pending verification, deferred decisions |
| Carbon Black | `#0A0A0A` | badge background and WebUI base |

### Priority Model

| Priority | Scope | Rule |
|:--|:--|:--|
| P0 Critical | v3.1.0 release blockers | Must be green before tagging |
| P1 High | v3.1.0 feature parity | Should land in the active sprint unless blocked |
| P2 Medium | Polish and v4.0.0 groundwork | Useful next, but not release-blocking |
| P3 Low | v4.0.0/v5.0.0 backlog | Deferred or exploratory |

---

## Release Matrix

| Module | Status | Version | Notes |
|:--|:--|:--|:--|
| **CP2077_OP7Pro_Full** | Active on device | v3.0.0 stable / v3.1.0 source | Primary production path for OnePlus 7 Pro |
| **CP2077_Universal** | Built | v1.0.0 | All-device package with ROM and resolution detection; 14 ROM families |
| **CP2077_OP7Pro_Ultimate** | Disabled | v3.0.0 | Preserved for megapack workflows and regression checks |

**Production path:** `02-PRODUCTION/magisk-modules/CP2077-OP7Pro-release/`

**Core release invariant:** `versionCode = MAJOR * 100000 + MINOR * 1000 + PATCH`

| Version | Code |
|:--|--:|
| v1.0.0 | 100000 |
| v3.0.0 | 300000 |
| v3.1.0 | 301000 |

---

## Bug Register

| ID | Severity | Issue | Resolution |
|:--|:--|:--|:--|
| BUG-01 | High | `og4k` bootanimation directory was empty | Fixed by upscaling `og1080p` via Pillow LANCZOS to 2160x4800 |
| BUG-02 | Medium | Full module lacked `og1080p` shutdown animation | Fixed with `shutdownanimation/og1080p/` |
| BUG-03 | Medium | Universal `release/` was empty and OTA URL would 404 | Fixed by building `CP2077-Universal-v1.0.0.zip` and per-variant packs |
| BUG-04 | Low | `update.json` pointed at a non-existent repo path | Fixed root `releases/update-full.json` and `releases/update-universal.json` |
| BUG-05 | Low | Legacy v1.0 source repo was undocumented | Added to manifests and docs |
| BUG-06 | Low | `cyberpunk-technotronic-icon-theme` had broken SVG symlinks | Removed dangling symlinks locally |
| BUG-07 | Medium | `og4k` had no matching shutdown animation | Fixed with `shutdownanimation/og4k/shutdownanimation.zip` and variant registration |
| BUG-08 | Low | `rbootanimation.zip` coverage was not verified | Verified mounted reboot animation paths on LOS 23.2 |

---

## v3.1.0 Active Sprint

| Target | Value |
|:--|:--|
| Release candidate | v3.1.0 |
| Device | OnePlus 7 Pro `GM1911` |
| ROM | LineageOS 23.2 / Android 16 |
| Root | Magisk v30.7 plus KernelSU validation |
| Main risk | Android 16 timing, SELinux, and mount-path verification |
| Theme work | New animation variants and Arch/Hyprland visual system |

### Sprint Progress

| Area | Status |
|:--|:--|
| Build | 7/7 complete |
| Service | 5/5 complete |
| Docs | 4/6 in progress |
| LOS 23.2 | 0/8 pending |

### Critical Path — Release Blockers

- [ ] LOS 23.2 mount path audit: verify `/product/media`, `/system/product/media`, `/data/local`, and `/data/misc/bootanim` behavior on a fresh LOS 23.2 install.
- [ ] Android 16 boot timing trace: prove `post-fs-data.sh` and `service.sh` run early enough before boot animation completion.
- [ ] SELinux audit: inspect `avc` denials for bootanim/media paths and generate `sepolicy.rule` if enforcing mode blocks mounts.
- [ ] Audio path verification: confirm LOS 23.2 still reads UI sounds from `/product/media/audio/ui/`.
- [ ] Magisk WebUI verification: test `refreshStatus`, `applyConfig`, `restartAnim`, `showDiag`, and variant selection on Android 16 WebView.
- [ ] KernelSU descriptor: add or validate `module.json` and check parity with Magisk install behavior.
- [ ] 5 MB remount threshold re-validation: confirm LOS 23.2 stock stubs remain below threshold.
- [ ] Device docs update: refresh `DEVICE-SPECS.md` with confirmed LOS 23.2 results.

### Variant Work

| Variant | Status | Visual Direction | Ship Criteria |
|:--|:--|:--|:--|
| `og4k` | Done | High-res original | Boot and shutdown packaged |
| `rboot` coverage | Done | Reboot path | Verified on device |
| `netrunner` | Planned | Cyan neural interface | 1440x3120, 60 fps, shutdown match |
| `corpo` | Planned | Gold/silver corporate geometry | 1440x3120, 60 fps, shutdown match |
| `streetkid` | Planned | Orange/red street scanlines | 1440x3120, 60 fps, shutdown match |
| Length tuning | Planned | Faster handoff | Boot intro latency reduced by at least 1 second |

### Linux Theme Work

**Desktop Shell**
- Merge `cybrland` and `cyber-hyprland-theme` into one canonical Hyprland config.
- Ship terminal palette configs for Kitty, Alacritty, and WezTerm.
- Recolor Papirus assets with `#FCEE0C`.

**HUD Surface**
- Add `cp2077-hud-toggle.sh` for Waybar/eww HUD switching.
- Build Waybar CP2077 HUD widgets for CPU, RAM, network, and battery.
- Verify and document Plymouth theme activation.
- Add `hyprlock` CP2077 lock-screen theme.

### Completed in v3.1.0 Track

- [x] `og4k` added to `VARIANTS` and packaged with shutdown ZIP.
- [x] `rbootanimation.zip` verified mounted on LOS 23.2 paths.
- [x] `service.sh` double-pass remount added.
- [x] `uninstall.sh` cleanup extended for `my_product`, `rbootanimation`, and `/data/cp2077-version`.
- [x] `module.prop` bumped to v3.1.0 metadata with `support=` URL.
- [x] Variant preview added to `customize.sh`.
- [x] `VARIANTS.md` frame-count tables added.
- [x] Terminal color scheme pack added.

---

## v4.0.0 Mid-Term

Focus: Universal v2, native root-manager packaging, CI, and audio v2.

| | | |
|:--|:--|:--|
| **Universal v2** | **Build System** | **Root Managers** |
| MIUI/HyperOS validation | 720p/1080p/1440p/4K matrix | KernelSU-native descriptor |
| Samsung One UI validation | FFmpeg LANCZOS scaling | APatch install flow |
| Pixel priority path verification | ZIP integrity checks | Magisk parity |
| Per-device profile archive | Reproducible build gate | WebUI compatibility |

### Key Tasks

- [ ] Full MIUI/HyperOS path matrix validation.
- [ ] Samsung One UI `/system/media/bootanimation.zip` validation.
- [ ] `build-universal.py` resolution matrix.
- [ ] Dynamic density/FPS selection at install time.
- [ ] KernelSU-native module descriptor and WebUI compatibility.
- [ ] APatch install and service-script validation.
- [ ] GitHub Actions build and validation pipeline.
- [ ] Extended audio pack with `Notification.ogg`, `VideoRecord.ogg`, `VideoStop.ogg`, `Screenshot.ogg`, and `LowBattery.ogg`.

---

## v5.0.0 Vision

Focus: broader device support, real live wallpaper, and full Linux desktop theming.

| Track | Direction | Theme |
|:--|:--|:--|
| Device expansion | Nothing Phone glyph sync, Pixel 8/9 port, fold/flip layouts, tablet variants | hardware-aware ports |
| Desktop | Plymouth, GRUB, Hyprland, Waybar, eww, Rofi, KDE/GNOME packages | full host visual identity |
| Wallpaper | Android `WallpaperService`, OpenGL ES shader pipeline, battery-aware renderer | real live wallpaper |
| Distribution | Device profile archive, port wizard, signed artifacts, update notifier | safer release delivery |

---

## Completed Ledger

| Item | Version | Date |
|:--|:--|:--|
| Workspace consolidation into numbered structure | v3.0.0 | 2026-05-13 |
| Multi-path mount engine for AOSP, LineageOS, OOS, yaap | v3.0.0 | 2026-05-13 |
| Config-file variant selection via `/data/cp2077.conf` | v3.0.0 | 2026-05-13 |
| `service.sh` size-threshold remount repair | v3.0.0 | 2026-05-13 |
| Universal ROM detection for 14 ROM families | v1.0.0 | 2026-05-13 |
| KernelSU/APatch root detection in Universal installer | v1.0.0 | 2026-05-13 |
| Workspace symlink repair after home-dir restructure | v3.0.0 | 2026-05-13 |
| Reference repos cloned for themes, kernels, wallpapers | v3.0.0 | 2026-05-13 |
| v2.0.0-beta public release | v2.0.0-beta | 2026-05-13 |
| `og4k` asset generated from `og1080p` | v3.0.0 | 2026-05-13 |
| `og1080p` shutdown animation created | v3.0.0 | 2026-05-13 |
| CP2077-Universal v1.0.0 built | v1.0.0 | 2026-05-13 |
| GitHub release metadata fixed for Full and Universal | v3.0.0 | 2026-05-13 |
| Legacy source repo documented | v3.0.0 | 2026-05-13 |
| Broken SVG symlinks removed locally | v3.0.0 | 2026-05-13 |
| README and documentation visual refresh | v3.0.0 | 2026-05-13 |
| `og4k` added to build and installer variant lists | v3.1.0 | 2026-05-13 |
| `rbootanimation.zip` verified on LOS 23.2 | v3.1.0 | 2026-05-13 |
| `service.sh` double-pass remount | v3.1.0 | 2026-05-13 |
| `uninstall.sh` cleanup expansion | v3.1.0 | 2026-05-13 |
| `module.prop` v3.1.0 metadata | v3.1.0 | 2026-05-13 |
| Variant preview in installer | v3.1.0 | 2026-05-13 |
| `VARIANTS.md` frame-count tables | v3.1.0 | 2026-05-13 |
| Terminal color scheme pack | v3.1.0 | 2026-05-13 |

---

## Execution Backlog

The detailed backlog is grouped by implementation surface so the next work can
be selected by risk and ownership rather than by a flat task number.

### P0 Hardening Queue

- [x] Extract `detect_root_manager()` into `lib/root-detect.sh`.
- [x] Extract `mount_with_fallback()` into `lib/mount.sh`.
- [x] Extract `ansi()` and `cp2077_logo()` into `lib/ui.sh`.
- [x] Replace fixed service sleeps with `wait_for_prop()`.
- [x] Add `module.prop` `updateJson` URL validation in CI.
- [x] Add boot-time mount verification and retry logging to `service.sh`.
- [x] Add atomic `/data/cp2077.conf` write helper.
- [x] Add config schema validation for `VARIANT`, `AUDIO`, and `SILENT`.
- [x] Add `python3 -m zipfile -t` CI gate for every release artifact.

### P1 Feature Parity Queue

- [x] `cp2077-config.sh` arrow-key TUI.
- [ ] Boot-counter A/B variant rotation.
- [ ] Audio ducking or fade-out at boot-complete.
- [ ] RAM-staged animation mount for slow storage.
- [ ] `cp2077-health-dashboard.sh` pure ANSI health TUI.
- [ ] `cp2077-version-bumper.py` atomic release bump tool.
- [ ] GitHub Actions artifact retention policy.
- [ ] Parallel variant packaging in `build.py`.
- [ ] `cp2077-frame-inspector.py` terminal preview.
- [ ] `cp2077-archive-audit.py` workspace ZIP scanner.

### P2 Build, QA, and Tooling Queue

- [ ] `cp2077-rom-probe.sh` device interrogation.
- [ ] `shellcheck` pre-commit hook.
- [ ] `cp2077-ci-local.sh` wrapper for `act`.
- [ ] Parallel hash computation in `generate-manifests.sh`.
- [ ] Per-variant audio tone table in `VARIANTS.md`.
- [ ] `cp2077-zip-diff.py` patch verifier.
- [ ] `cp2077-palette-gen.py` README/VARIANTS palette asset.
- [ ] `cp2077-wallpaper-extract.py`.
- [ ] `build-universal.py --res-matrix`.
- [ ] `cp2077-module-lint.py`.

### P2 Module and Theme Queue

- [ ] `CP2077-Bootlogo`.
- [ ] `CP2077-Charging-Animation`.
- [ ] `CP2077-LiveWallpaper-GLShader`.
- [ ] `CP2077-Hosts-Adblocker`.
- [ ] `CP2077-Navbar`.
- [ ] `CP2077-SafetyNet-Fix`.
- [ ] `CP2077-MagiskWebUI-Hub`.
- [ ] `CP2077-Locale-Overlay`.
- [ ] `CP2077-NetworkMonitor`.
- [ ] `CP2077-Fingerprint-Anim`.

### P2 Linux Desktop and Automation Queue

- [ ] `cp2077-plymouth-preview.sh`.
- [ ] `cp2077-release-drafter.sh`.
- [ ] `cp2077-device-profile-gen.sh`.
- [ ] `cp2077-merge-tool.sh`.
- [ ] `cp2077-hook-manager.sh`.
- [ ] Waybar active mission module.
- [ ] eww workspace dot indicators.
- [ ] hyprlock faction label.
- [ ] hyprlock uptime badge.
- [ ] Rofi CP2077 launcher skin.

### P3 Device Expansion Queue

- [ ] `CP2077-Universal-v2`.
- [ ] KernelSU-native module track.
- [ ] APatch-native compatibility pass.
- [ ] AnyKernel3 package.
- [ ] TWRP direct-write installer.
- [ ] Pixel 8/9 dedicated port.
- [ ] Samsung One UI validation.
- [ ] MIUI/HyperOS validation.
- [ ] Resolution auto-scaling pipeline.
- [ ] Dynamic FPS selection.

### P3 Audio and Visual Queue

- [ ] Extended audio pack v2.
- [ ] Loudness normalization to -18 LUFS.
- [ ] Night-mode audio variant.
- [ ] Variant-specific audio tone palettes.
- [ ] Audio fade-out on animation complete.
- [ ] Custom accent color injection.
- [ ] Dynamic wallpaper extraction.
- [ ] Haptic pattern sync.
- [ ] Monet color injection.
- [ ] Display-cutout-aware centering.

### P3 Installer, OTA, Security, and Docs Queue

- [ ] OTA delta update system.
- [ ] On-device module update notification.
- [ ] Module soft disable/enable scripts.
- [ ] Full cleanup v2 for uninstall.
- [ ] SELinux `sepolicy.rule` generator.
- [ ] Secure boot compatibility check.
- [ ] Android 16 updates in `DEVICE-SPECS.md`.
- [ ] New variant asset repos in `REPOS.md`.
- [ ] Changelog auto-generation script.
- [ ] Version-code consistency enforcement in CI.

---

## Backlog Index

| Lane | Representative Items |
|:--|:--|
| WebUI | variant preview animation, diagnostics copy button, mount map, OTA banner, comparison modal |
| Build | reproducible ZIPs, source URL validator, hot-reload audio specs, parallel packaging |
| Service | trace mode, backup/restore config, soft disable, full cleanup, mount retry |
| Desktop | Plymouth install verification, Hyprland merge, Papirus recolor, HUD toggle, terminal schemes |
| Distribution | release drafter, signed ZIPs, OTA poller, port wizard, upstream sync |
| Functions | root detection, mount fallback, property wait, config read/write, ROM family detection |
| Elements | WebUI LED/status components, lock-screen labels, Waybar modules, Plymouth progress elements |
| Cross-platform | Steam Deck/HoloISO, Android Auto, Termux, Tasker, KDE, GNOME, sway/i3/Hyprland |

---

## Implementation Tracks

### CI/CD

- [ ] Parallel build matrix for all variants.
- [ ] ZIP integrity and desc.txt compliance gate.
- [ ] Shell lint and module lint jobs.
- [ ] KernelSU track with `module.json` validation.
- [ ] Reproducible build verification by building twice and comparing SHA-256.
- [ ] Release automation through `gh release create`.

### Automation

- [ ] Upstream sync checker for reference animation repos.
- [ ] One-command release tagging and version bump.
- [ ] Hotfix delta generator for frame/audio patches.
- [ ] Device compatibility matrix generator.
- [ ] Workspace audit script.
- [ ] README and docs regeneration from build constants.

### Developer Experience

- [ ] VS Code tasks for build, lint, frame inspection, and single-variant builds.
- [ ] Docker/Arch build container.
- [ ] `shfmt` and Python linter integration.
- [ ] `.editorconfig` workspace standard.
- [ ] Device debug shell bundle for issue reports.

---

## Telemetry and Feedback

Telemetry is opt-in only. No personal data should be collected.

| Item | Goal |
|:--|:--|
| Anonymous variant stats | Learn which variants and ROM families are actually used |
| Boot failure report bundle | Collect logs only after explicit user consent |
| Variant popularity endpoint | Prioritize future variant work |
| Module health score | Surface degraded mount/audio/config state in WebUI |
| Crash dump preservation | Keep last failure logs for post-mortem debugging |

---

## GitHub Research Expansion — Repo Operations

Research inputs: [`Magisk module guide`](https://github.com/topjohnwu/Magisk/blob/master/docs/guides.md), [`MMRL`](https://github.com/MMRLApp/MMRL), [`actions/upload-artifact`](https://github.com/actions/upload-artifact), [`slsa-github-generator`](https://github.com/slsa-framework/slsa-github-generator), [`ossf/scorecard`](https://github.com/ossf/scorecard), and local `99-MANIFESTS/git-repositories.txt`.

| ID | Priority | Importance | Repos / Scope | Task |
|:--|:--|:--:|:--|:--|
| GH-OPS-001 | High | 5 | All 53 repo entries | Generate a canonical `repo-registry.json` from `99-MANIFESTS/git-repositories.txt` with path, branch, remote, category, sync tier, and owner. |
| GH-OPS-002 | High | 5 | All GitHub remotes | Add `scripts/check-github-remotes.sh` to verify every GitHub URL returns HTTP 200/301 and every branch still exists upstream. |
| GH-OPS-003 | High | 5 | `CP2077-OP7Pro`, `CP2077-Universal` | Add release workflow inputs for version, variant list, audio flag, artifact retention days, and draft-release mode. |
| GH-OPS-004 | High | 5 | `releases/`, module release dirs | Generate SLSA provenance for every release ZIP and publish provenance beside `SHA256SUMS`. |
| GH-OPS-005 | High | 5 | Root repo | Run OpenSSF Scorecard weekly and publish SARIF/code-scanning output where supported. |
| GH-OPS-006 | High | 5 | Shell/Python/WebUI code | Add CodeQL advanced setup for JavaScript plus SARIF upload for ShellCheck and Python linters. |
| GH-OPS-007 | High | 4 | All release workflows | Pin third-party GitHub Actions by SHA or locked major tags and document upgrade cadence. |
| GH-OPS-008 | High | 4 | `99-MANIFESTS/` | Add a manifest freshness badge that fails CI if generated manifests are older than the latest release artifact. |
| GH-OPS-009 | Medium | 4 | All nested repos | Create `WHY-CLONED.md` for every GitHub clone explaining source, purpose, sync priority, and removal criteria. |
| GH-OPS-010 | Medium | 4 | All nested repos | Add `repo-health.md` summarizing dirty state, last commit date, branch, remote, and behind/ahead count. |
| GH-OPS-011 | Medium | 4 | `MMRL`, release metadata | Create an MMRL-ready metadata generation task with screenshots, categories, compatibility, and file transparency. |
| GH-OPS-012 | Medium | 4 | `releases/CHANGELOG-*` | Add a changelog generator that groups commits by `feat`, `fix`, `docs`, `build`, `security`, and `compat`. |
| GH-OPS-013 | Medium | 3 | All release artifacts | Enforce `actions/upload-artifact` retention settings: 7 days for CI artifacts, 30 days for release candidates, 90 days for stable artifacts. |
| GH-OPS-014 | Medium | 3 | Root repo | Add GitHub issue templates for ROM compatibility, install failure, animation artifact, and root-manager compatibility. |
| GH-OPS-015 | Medium | 3 | Root repo | Add PR templates with required sections: touched module, tested variant, artifact checksum, device/ROM, and rollback notes. |
| GH-OPS-016 | Medium | 3 | `99-MANIFESTS/git-repositories.txt` | Add category-level ownership: module, root, theme, kernel, device tree, recovery, wallpaper, Android UI. |
| GH-OPS-017 | Low | 2 | Reference repos | Add a stale-reference dashboard that marks repos unused for 90 days as `review`, 180 days as `archive-candidate`. |
| GH-OPS-018 | Low | 2 | `README.md`, `ROADMAP.md` | Auto-generate repo count and workspace size badges from manifests. |
| GH-OPS-019 | Low | 2 | Root repo | Add GitHub discussion category plan for installs, variant requests, ports, and development notes. |
| GH-OPS-020 | Low | 1 | Root repo | Add `.github/FUNDING.yml` and maintainer metadata only if public project support becomes relevant. |

## GitHub Research Expansion — Root Ecosystem

Research inputs: [`Magisk docs`](https://github.com/topjohnwu/Magisk/blob/master/docs/guides.md), [`KernelSU`](https://github.com/tiann/KernelSU), [`APatch`](https://github.com/bmax121/APatch), [`MMRL`](https://github.com/MMRLApp/MMRL), [`zygisk-module-sample`](https://github.com/topjohnwu/zygisk-module-sample), and root ecosystem clones.

| ID | Priority | Importance | Repos / Scope | Task |
|:--|:--|:--:|:--|:--|
| ROOT-001 | High | 5 | `Magisk`, all modules | Validate every `module.prop` against Magisk requirements: stable `id`, integer `versionCode`, LF endings, valid `updateJson`. |
| ROOT-002 | High | 5 | `CP2077-OP7Pro`, `CP2077-Universal` | Add automated check that `versionCode` equals `MAJOR * 100000 + MINOR * 1000 + PATCH`. |
| ROOT-003 | High | 5 | `Magisk`, `KernelSU`, `APatch` | Implement a shared `detect_root_manager()` library used by installer, service, config, and WebUI shell bridge. |
| ROOT-004 | High | 5 | `KernelSU` | Add KernelSU `module.json` and verify install, enable, disable, uninstall, and WebUI behavior. |
| ROOT-005 | High | 5 | `APatch` | Add APatch install test flow and document `apd` path assumptions, module status checks, and rollback. |
| ROOT-006 | High | 5 | `MMRL` | Build MMRL metadata with icon, screenshots, categories, cover image, changelog, root compatibility, and file transparency. |
| ROOT-007 | High | 4 | `Magisk`, modules | Replace any hardcoded module path with `MODDIR=${0%/*}` where scripts run inside module context. |
| ROOT-008 | High | 4 | `Magisk`, modules | Add `ASH_STANDALONE=1` compatibility testing for installer scripts that run through Magisk busybox shell. |
| ROOT-009 | Medium | 4 | `ZygiskNext`, `ReZygisk`, `zygisk-module-sample` | Decide whether WebUI/system UI future modules need Zygisk hooks or should remain pure Magisk overlay modules. |
| ROOT-010 | Medium | 4 | `LSPosed` | Document whether status bar, lockscreen, and Quick Settings theming belongs in LSPosed modules or resource overlays. |
| ROOT-011 | Medium | 4 | `Vector` | Research whether Vector module patterns can simplify future Zygisk/native extensions. |
| ROOT-012 | Medium | 4 | `MMRL`, `WebUI` | Add WebUI feature parity matrix for Magisk app, MMRL, KernelSU manager, and APatch manager. |
| ROOT-013 | Medium | 3 | `awesome-android-root` | Cross-reference CP2077 dependencies and document accepted root/tool versions. |
| ROOT-014 | Medium | 3 | All modules | Add `module-lint` check for required scripts, executable bits, forbidden CRLF, and required `META-INF` entries. |
| ROOT-015 | Medium | 3 | All modules | Add root-manager smoke test script that confirms module installed state, enabled state, and mount result. |
| ROOT-016 | Low | 2 | `MMRL-Util` | Evaluate using MMRL repository tooling to publish a private CP2077 module repository. |
| ROOT-017 | Low | 2 | `Magisk` releases | Track Magisk release notes for overlayfs/module behavior changes and open compatibility tasks when needed. |
| ROOT-018 | Low | 2 | `KernelSU` releases | Track KernelSU manager/API changes and update `module.json` rules when upstream changes. |
| ROOT-019 | Low | 2 | `APatch` releases | Track APatch manager/API changes and update compatibility docs. |
| ROOT-020 | Low | 1 | Root ecosystem refs | Add quarterly root-ecosystem repo sync and summarize important upstream changes in `REPOS.md`. |

## GitHub Research Expansion — Device, Kernel, and Recovery

Research inputs: [`AnyKernel3`](https://github.com/osm0sis/AnyKernel3), [`Kernel-SU/AnyKernel3`](https://github.com/Kernel-SU/AnyKernel3), LineageOS/DerpFest/Evolution/crDroid device trees, TWRP/PBRP recovery trees, and OP7 kernel repos.

| ID | Priority | Importance | Repos / Scope | Task |
|:--|:--|:--:|:--|:--|
| DEVICE-001 | High | 5 | `lineage-device-guacamole`, `lineage-device-sm8150-common` | Diff LOS 23.2 device trees for bootanimation, product media, audio UI, and recovery paths. |
| DEVICE-002 | High | 5 | `lineage-kernel-sm8150` | Record kernel config relevant to boot timing, SELinux, dm-verity, overlayfs, and filesystem mount order. |
| DEVICE-003 | High | 5 | `kernelsu-lineageos-guacamole` | Build or validate KernelSU kernel and test CP2077 module parity against Magisk. |
| DEVICE-004 | High | 5 | `neptune-kernel-sm8150` | Benchmark bootanimation timing and thermal behavior under Neptune vs stock LOS kernel. |
| DEVICE-005 | High | 5 | `boot.img`, `magisk_patched-*.img` | Create boot-image registry with SHA-256, source ROM, patch tool, root manager, flash date, and rollback image. |
| DEVICE-006 | High | 4 | `AnyKernel3`, `op7` kernels | Prototype an AnyKernel3 package that can stage CP2077 helper modules safely without overwriting user data. |
| DEVICE-007 | High | 4 | TWRP/PBRP trees | Validate whether direct-write recovery installer should target `/system/media`, `/product/media`, or only systemless installs. |
| DEVICE-008 | Medium | 4 | DerpFest device trees | Compare bootanimation/media paths with LOS 23.2 and add DerpFest rows to `DEVICE-SPECS.md`. |
| DEVICE-009 | Medium | 4 | Evolution X device tree | Compare product path behavior and add Evolution X compatibility notes. |
| DEVICE-010 | Medium | 4 | crDroid kernel/device refs | Add crDroid path and kernel compatibility notes to the universal compatibility matrix. |
| DEVICE-011 | Medium | 3 | `blu-spark-kernel-op7` | Identify performance patches relevant to boot animation smoothness and document whether to port them. |
| DEVICE-012 | Medium | 3 | `op8`, `op5` blu-spark refs | Document reusable kernel/package patterns but keep OP8/OP5 as reference-only. |
| DEVICE-013 | Medium | 3 | `android_device_oneplus_guacamole-pbrp` | Add recovery flashing test plan for CP2077 ZIPs under PBRP. |
| DEVICE-014 | Medium | 3 | TWRP unified tree | Add TWRP install flow test plan and required assertions for installer output. |
| DEVICE-015 | Medium | 3 | All device trees | Generate `device-profile.yaml` for every supported ROM family with boot paths, audio paths, API, SELinux state. |
| DEVICE-016 | Low | 2 | `kali-nethunter-kernel-builder` | Evaluate NetHunter kernel boot timing and whether CP2077 mount repair must wait longer. |
| DEVICE-017 | Low | 2 | Recovery trees | Add `adb sideload` screenshots/log capture checklist for docs. |
| DEVICE-018 | Low | 2 | Kernel refs | Add quarterly kernel ref sync to catch security-patch and branch changes. |
| DEVICE-019 | Low | 2 | Device tree refs | Add branch freshness warnings if local branch falls behind upstream by more than 30 days. |
| DEVICE-020 | Low | 1 | All device/kernel repos | Add `WHY-CLONED.md` and sync tier for each kernel/device/recovery repository. |

## GitHub Research Expansion — UI, Theme, and Asset System

Research inputs: [`hyprdots theming`](https://github.com/prasanthrangan/hyprdots/wiki/Theming), [`waybar-themes topic`](https://github.com/topics/waybar-themes), [`adi1090x/rofi`](https://github.com/adi1090x/rofi), `plymouth-themes`, `cybrcolors`, `Cyberpunk-Neon`, and local theme repos.

| ID | Priority | Importance | Repos / Scope | Task |
|:--|:--|:--:|:--|:--|
| UI-001 | High | 5 | `cybrcolors`, all UI docs | Promote the CP2077 palette to a single `design-tokens.json` with hex, RGB, ANSI, CSS var, and Android XML outputs. |
| UI-002 | High | 5 | WebUI, README, docs | Generate badges, palette strips, and README/ROADMAP color references from `design-tokens.json`. |
| UI-003 | High | 5 | `cyber-hyprland-theme`, `cybrland` | Merge Hyprland configs into one canonical CP2077 profile with documented keybinds and module ownership. |
| UI-004 | High | 4 | `HyprPanel`, Waybar, eww | Decide one primary panel path and document when HyprPanel, Waybar, or eww should be used. |
| UI-005 | High | 4 | `rofi`, `Tokyonight-rofi-theme` | Build CP2077 Rofi theme variants for launcher, power menu, screenshot menu, and variant switcher. |
| UI-006 | High | 4 | `plymouth-themes`, `proxzima-plymouth` | Build a Plymouth prototype using CP2077 frame assets and test with `plymouthd --debug`. |
| UI-007 | High | 4 | `Cyberpunk-Neon`, `K-DE-Cyberpunk-Neon` | Reconcile KDE/GTK assets into an installable host theme bundle and document conflicts. |
| UI-008 | Medium | 4 | `catppuccin`, `cybrcolors` | Create a CP2077-to-Catppuccin compatibility palette for users who want softer desktop colors. |
| UI-009 | Medium | 4 | `wallpapers/cybrpapers`, `Cyberpunk-Wallpapers` | Create wallpaper manifest with resolution, license, dominant colors, and recommended lockscreen/desktop use. |
| UI-010 | Medium | 3 | `cyberpunk-technotronic-icon-theme` | Package cleaned icon theme and document missing icon coverage. |
| UI-011 | Medium | 3 | `AndroidCyberpankIcons` | Audit Android icon pack assets and define a legal/technical path to Android icon pack packaging. |
| UI-012 | Medium | 3 | `widgets`, eww | Port useful widget patterns into CP2077 HUD components with CPU, RAM, net, battery, and active mission. |
| UI-013 | Medium | 3 | `mechabar` | Research whether mechabar components can replace or augment Waybar for the CP2077 host HUD. |
| UI-014 | Medium | 3 | `diinki-retrofuture` | Extract reusable retrofuture typography/spacing conventions and map them to CP2077 docs. |
| UI-015 | Medium | 3 | `dotfiles`, `dots`, `hyprdots` | Build a compatibility matrix for expected host packages: hyprland, waybar, rofi-wayland, swww, dunst, kitty. |
| UI-016 | Low | 2 | `cp2077-linux-boot` | Add boot-theme preview GIF generation task for README and docs. |
| UI-017 | Low | 2 | Wallpapers | Add automatic thumbnail sheet generation for wallpaper selection. |
| UI-018 | Low | 2 | Docs | Add design review checklist for contrast, font sizing, table density, badge consistency, and mobile readability. |
| UI-019 | Low | 2 | WebUI | Add reduced-motion mode for users who disable animation effects. |
| UI-020 | Low | 1 | Theme repos | Add quarterly theme sync and de-duplication review across all Linux theme references. |

## GitHub Research Expansion — Build, Release, and Supply Chain

Research inputs: [`github/codeql-action`](https://github.com/github/codeql-action), [`actions/upload-artifact`](https://github.com/actions/upload-artifact), [`slsa-github-generator`](https://github.com/slsa-framework/slsa-github-generator), [`ossf/scorecard-action`](https://github.com/ossf/scorecard-action), [`AnyKernel3`](https://github.com/osm0sis/AnyKernel3), and all local module/build repos.

| ID | Priority | Importance | Repos / Scope | Task |
|:--|:--|:--:|:--|:--|
| SUPPLY-001 | High | 5 | All release ZIPs | Add `zipfile -t`, SHA-256, file size, manifest membership, and update JSON validation to one release gate. |
| SUPPLY-002 | High | 5 | `build.py`, `build-universal.py` | Enforce reproducible ZIP metadata and fail if two builds from the same commit produce different hashes. |
| SUPPLY-003 | High | 5 | GitHub Actions | Add CodeQL plus SARIF upload for ShellCheck, Python lint, and custom module lint output. |
| SUPPLY-004 | High | 5 | GitHub Actions | Generate SLSA provenance for every stable artifact and add verification instructions to release notes. |
| SUPPLY-005 | High | 5 | GitHub Actions | Run OpenSSF Scorecard weekly and open tasks for low-scoring checks. |
| SUPPLY-006 | High | 4 | `build.py` | Add source URL HEAD-check gate for `SOURCES` before downloading animation ZIPs. |
| SUPPLY-007 | High | 4 | `.downloads/` | Add cache integrity manifest so stale or corrupted upstream downloads are detected before packaging. |
| SUPPLY-008 | High | 4 | `10-QUARANTINE-invalid-downloads` | Add CI assertion that quarantine files are never referenced by build scripts or release metadata. |
| SUPPLY-009 | Medium | 4 | `releases/update-*.json` | Validate version, versionCode, zipUrl, changelog URL, content type, and checksum before publish. |
| SUPPLY-010 | Medium | 4 | `releases/` | Add detached signature or checksum bundle for stable ZIPs. |
| SUPPLY-011 | Medium | 4 | All workflows | Add minimum permissions blocks and avoid broad `contents: write` except release jobs. |
| SUPPLY-012 | Medium | 3 | `actions/upload-artifact` | Set retention policy by artifact type and add artifact naming convention with module, version, variant, and commit SHA. |
| SUPPLY-013 | Medium | 3 | Build scripts | Add max artifact size warnings and fail threshold for accidental megapack bloat. |
| SUPPLY-014 | Medium | 3 | Build scripts | Add build matrix JSON output with variant, audio, source SHA, output SHA, size, and elapsed time. |
| SUPPLY-015 | Medium | 3 | Android assets | Add license/source manifest for every third-party image, icon, wallpaper, and animation asset. |
| SUPPLY-016 | Low | 2 | GitHub Releases | Add release asset download statistics to `releases/download-stats.json`. |
| SUPPLY-017 | Low | 2 | GitHub Pages / raw URLs | Evaluate moving update JSON to a controlled GitHub Pages endpoint with history and rollback. |
| SUPPLY-018 | Low | 2 | CI | Add nightly dry-run build with `--check-sources` and no artifact upload. |
| SUPPLY-019 | Low | 2 | CI | Add dependency update reminders for Python packages and GitHub Actions. |
| SUPPLY-020 | Low | 1 | Docs | Add supply-chain threat model covering source ZIPs, release artifacts, update JSON, and root-manager install paths. |

---

## Repository Research Section 01 — Module Store Metadata

Research sources: `topjohnwu/Magisk`, `MMRLApp/MMRL`, `Magisk-Modules-Alt-Repo/GlitchedCyberBoot`, local `CP2077-OP7Pro`, local `CP2077-Universal`.

| Type | Priority | Importance | Work Item |
|:--|:--|:--:|:--|
| Feature | High | 5 | Add a generated module listing pack with `module.prop`, MMRL metadata, icon, screenshots, changelog link, support link, root-manager support, and release ZIP checksums. |
| Implementation | High | 5 | Create `scripts/gen-module-listing.py` that reads module metadata and emits `mmrl.json`, `module-store.md`, and validation output for every CP2077 module. |
| Tool | Medium | 4 | Add `scripts/check-module-listing.sh` to fail when the MMRL metadata, `module.prop`, and `releases/update-*.json` disagree. |

## Repository Research Section 02 — Root Manager Compatibility Lab

Research sources: `topjohnwu/Magisk`, `tiann/KernelSU`, `bmax121/APatch`, `MMRLApp/MMRL`, local module scripts.

| Type | Priority | Importance | Work Item |
|:--|:--|:--:|:--|
| Feature | High | 5 | Add a root-manager compatibility dashboard covering Magisk, KernelSU, APatch, and MMRL WebUI bridge behavior for every module release. |
| Implementation | High | 5 | Extract `detect_root_manager()`, `detect_module_dir()`, and `run_root_command()` into a shared `lib/root-runtime.sh` used by installer, service, config, and WebUI diagnostics. |
| Tool | High | 5 | Add `cp2077-root-smoke.sh` to run install, status, config write, remount check, WebUI shell bridge check, disable, enable, and uninstall probes per root manager. |

## Repository Research Section 03 — Animation Source Governance

Research sources: `sodasoba1/ONEPLUS9-OOS13-BootAnimation`, `sodasoba1/CyberPunk-2077-OOS13-Modded-Boot-and-Shutdown-Animation`, `GlitchedCyberBoot`, local `.downloads/`.

| Type | Priority | Importance | Work Item |
|:--|:--|:--:|:--|
| Feature | High | 5 | Add a source provenance panel for every animation variant showing upstream repo, release tag, downloaded file, SHA-256, resolution, frame count, and license note. |
| Implementation | High | 4 | Add `sources.lock.json` beside `build.py` so source URLs, content length, SHA-256, and last verified timestamp are committed and reviewed. |
| Tool | Medium | 4 | Add `cp2077-source-audit.py` to compare `.downloads/`, `SOURCES`, `sources.lock.json`, and generated release ZIP contents. |

## Repository Research Section 04 — Universal Device Profile Registry

Research sources: LineageOS device trees, DerpFest device trees, Evolution X device tree, crDroid kernel/device refs, local `CP2077-Universal`.

| Type | Priority | Importance | Work Item |
|:--|:--|:--:|:--|
| Feature | High | 5 | Add device profiles for every supported ROM family with bootanimation paths, shutdown paths, audio paths, SELinux status, root manager, and verified module version. |
| Implementation | High | 5 | Add `devices/*.yaml` and teach `build-universal.py` to package and use those profiles during install-time ROM detection. |
| Tool | High | 4 | Add `cp2077-device-profile-gen.sh` to pull ADB props, mounted paths, file sizes, and SELinux mode into a reproducible `device-profile.yaml`. |

## Repository Research Section 05 — Kernel and Recovery Packaging

Research sources: `osm0sis/AnyKernel3`, `Kernel-SU/AnyKernel3`, OP7 kernel repos, TWRP/PBRP recovery trees, local `07-KERNEL-PACKAGE-MODULES`.

| Type | Priority | Importance | Work Item |
|:--|:--|:--:|:--|
| Feature | Medium | 4 | Add an optional kernel-and-theme bundle track for advanced users who want a single recovery flash to install kernel support plus CP2077 module staging. |
| Implementation | Medium | 4 | Prototype `CP2077-AnyKernel3/` with strict device checks, backup/restore hooks, and no automatic destructive writes. |
| Tool | Medium | 4 | Add `cp2077-bootimg-registry.py` to track boot image SHA-256, source ROM, patch tool, kernel repo, root manager, and rollback file. |

## Repository Research Section 06 — Hyprland and Desktop Theme Unification

Research sources: `prasanthrangan/hyprdots`, `Jas-SinghFSU/HyprPanel`, `cybrland`, `cyber-hyprland-theme`, `mechabar`, local `06-UI-THEMES-ANIMATIONS`.

| Type | Priority | Importance | Work Item |
|:--|:--|:--:|:--|
| Feature | Medium | 4 | Add a CP2077 desktop profile that can switch between Waybar, HyprPanel, eww HUD, and mechabar without replacing the whole Hyprland config. |
| Implementation | Medium | 4 | Create `05-LINUX/arch-host/profiles/cp2077-hyprland/` with layered config fragments for monitor, input, keybinds, panel, launcher, and lock screen. |
| Tool | Medium | 3 | Add `cp2077-theme-switch.sh` to apply, diff, backup, and rollback desktop theme layers. |

## Repository Research Section 07 — Rofi, Wallpaper, and Icon Asset Pipeline

Research sources: `adi1090x/rofi`, `Tokyonight-rofi-theme`, `cybrpapers`, `Cyberpunk-Wallpapers`, `AndroidCyberpankIcons`, `cyberpunk-technotronic-icon-theme`.

| Type | Priority | Importance | Work Item |
|:--|:--|:--:|:--|
| Feature | Medium | 4 | Add a visual asset browser that links variants, wallpapers, Rofi styles, icon packs, and Android module thumbnails by shared palette tags. |
| Implementation | Medium | 3 | Add `assets/catalog.json` with asset type, repo source, path, license, resolution, dominant colors, and recommended use. |
| Tool | Medium | 3 | Add `cp2077-asset-catalog.py` to generate thumbnail sheets, color summaries, duplicate detection, and missing-license warnings. |

## Repository Research Section 08 — WebUI and On-Device Control

Research sources: `MMRLApp/MMRL`, `KernelSU`, `APatch`, local `webroot/index.html`, local `cp2077-config.sh`.

| Type | Priority | Importance | Work Item |
|:--|:--|:--:|:--|
| Feature | High | 5 | Add a root-manager-neutral WebUI with status, variant selection, audio toggle, mount map, diagnostics copy, and update availability. |
| Implementation | High | 5 | Refactor WebUI shell bridge calls into a single adapter that supports MMRL, KernelSU, APatch, and mock mode. |
| Tool | High | 4 | Add `cp2077-webui-test.html` plus Playwright smoke checks for bridge detection, variant card rendering, and diagnostics output. |

## Repository Research Section 09 — Release Quality and Supply Chain

Research sources: `github/codeql-action`, `actions/upload-artifact`, `slsa-framework/slsa-github-generator`, `ossf/scorecard`, local release scripts.

| Type | Priority | Importance | Work Item |
|:--|:--|:--:|:--|
| Feature | High | 5 | Add a release quality gate that shows artifact integrity, provenance, manifest freshness, source lock freshness, and update JSON validity before publish. |
| Implementation | High | 5 | Add `.github/workflows/release-quality.yml` with lint, build, ZIP test, SHA-256, SLSA provenance, Scorecard, and update JSON validation jobs. |
| Tool | High | 4 | Add `cp2077-release-verify.py` to verify a downloaded release ZIP against checksum, provenance, update JSON, and embedded module metadata. |

## Repository Research Section 10 — Workspace Registry and Maintenance

Research sources: local `99-MANIFESTS`, all cloned repos, root `.gitignore`, workspace docs.

| Type | Priority | Importance | Work Item |
|:--|:--|:--:|:--|
| Feature | Medium | 4 | Add a workspace registry view that groups every cloned repo by category, sync tier, dirty state, purpose, owner, and prune policy. |
| Implementation | Medium | 4 | Generate `99-MANIFESTS/repo-registry.json` and `09-DOCS/REPOS.md` tables from one parser instead of manually maintaining both. |
| Tool | Medium | 4 | Add `cp2077-workspace-audit.sh` to check stale repos, broken symlinks, quarantine leaks, missing `WHY-CLONED.md`, and manifest freshness. |

## Additional Features from Repository Research

| ID | Priority | Importance | Source Repos | Feature |
|:--|:--|:--:|:--|:--|
| FEAT-R01 | High | 5 | Magisk, KernelSU, APatch | Root-manager-neutral install mode with explicit compatibility report before flashing. |
| FEAT-R02 | High | 5 | MMRL, CP2077 WebUI | WebUI diagnostics drawer with one-tap copy for mount table, config, module version, and root manager. |
| FEAT-R03 | High | 4 | LineageOS, DerpFest, Evolution X | ROM-family compatibility profile selector for Universal module installs. |
| FEAT-R04 | Medium | 4 | hyprdots, HyprPanel, cybrland | Host desktop profile switcher for CP2077 Hyprland/Waybar/HyprPanel/eww setups. |
| FEAT-R05 | Medium | 4 | Rofi, wallpapers, icon repos | Visual asset browser tying animation variants to wallpapers, launchers, and icons. |
| FEAT-R06 | Medium | 4 | AnyKernel3, kernel repos | Optional kernel bundle track with strict warnings and rollback instructions. |
| FEAT-R07 | Medium | 3 | GitHub Actions, SLSA | Release trust panel listing checksum, provenance, source lock, and manifest freshness. |
| FEAT-R08 | Medium | 3 | Android icon repos | Android icon pack experiment using cleaned CP2077 icon assets. |
| FEAT-R09 | Low | 2 | Plymouth repos | Plymouth preview gallery generated from installed themes and boot frames. |
| FEAT-R10 | Low | 2 | Wallpapers, cybrpapers | Wallpaper rotation profile tied to active boot animation variant. |

## Additional Implementations from Repository Research

| ID | Priority | Importance | Source Repos | Implementation |
|:--|:--|:--:|:--|:--|
| IMPL-R01 | High | 5 | CP2077 modules | Shared `lib/root-runtime.sh` for root manager detection and command dispatch. |
| IMPL-R02 | High | 5 | CP2077 modules | `sources.lock.json` for animation source URLs, SHA-256, content length, and verification date. |
| IMPL-R03 | High | 5 | Universal, device trees | `devices/*.yaml` ROM profile registry consumed by `build-universal.py`. |
| IMPL-R04 | High | 4 | GitHub Actions | `release-quality.yml` workflow with build, lint, ZIP test, and provenance jobs. |
| IMPL-R05 | Medium | 4 | MMRL, WebUI | WebUI bridge adapter with MMRL, KernelSU, APatch, and mock backends. |
| IMPL-R06 | Medium | 4 | Theme repos | Layered Hyprland config under `05-LINUX/arch-host/profiles/cp2077-hyprland/`. |
| IMPL-R07 | Medium | 3 | Assets repos | `assets/catalog.json` for wallpapers, icons, splash assets, thumbnails, and licenses. |
| IMPL-R08 | Medium | 3 | 99-MANIFESTS | `repo-registry.json` generated from `git-repositories.txt`. |
| IMPL-R09 | Low | 2 | Recovery/kernel repos | AnyKernel3 prototype folder with device guards and rollback docs. |
| IMPL-R10 | Low | 2 | Docs | Generated `RESEARCH-SOURCES.md` linking every task to source repos and docs. |

## Additional Tools from Repository Research

| ID | Priority | Importance | Source Repos | Tool |
|:--|:--|:--:|:--|:--|
| TOOL-R01 | High | 5 | Root ecosystem | `cp2077-root-smoke.sh` for Magisk, KernelSU, APatch, and MMRL checks. |
| TOOL-R02 | High | 5 | Release repos | `cp2077-release-verify.py` for checksum, provenance, update JSON, and metadata verification. |
| TOOL-R03 | High | 4 | Device trees | `cp2077-device-profile-gen.sh` for ADB-derived ROM/device profiles. |
| TOOL-R04 | Medium | 4 | Animation repos | `cp2077-source-audit.py` for `.downloads`, `SOURCES`, `sources.lock.json`, and ZIP content checks. |
| TOOL-R05 | Medium | 4 | Workspace manifests | `cp2077-workspace-audit.sh` for stale repos, broken links, quarantine leaks, and manifest freshness. |
| TOOL-R06 | Medium | 3 | Theme repos | `cp2077-theme-switch.sh` for applying and rolling back desktop profile layers. |
| TOOL-R07 | Medium | 3 | Assets repos | `cp2077-asset-catalog.py` for thumbnails, colors, duplicates, and licenses. |
| TOOL-R08 | Medium | 3 | WebUI | Playwright WebUI smoke test runner for bridge and rendering checks. |
| TOOL-R09 | Low | 2 | Kernel repos | `cp2077-bootimg-registry.py` for boot image metadata and rollback tracking. |
| TOOL-R10 | Low | 2 | Docs/repos | `cp2077-research-map.py` to link roadmap tasks to cloned repos and GitHub sources. |

---

## Kernel Development

Device: OnePlus 7 Pro `GM1911` / `guacamole` · SM8150 (Snapdragon 855).

Path: `07-KERNEL-PACKAGE-MODULES/kernel/`

| Kernel | Path | Status | Purpose |
|:--|:--|:--|:--|
| `neptune-kernel-sm8150` | `kernel/neptune-kernel-sm8150/` | Staged | Primary custom kernel target for CP2077 module |
| `blu-spark-kernel-op7` | `kernel/blu-spark-kernel-op7/` | Reference | blu-spark-16 OP7 Pro — patch source |
| `kernelsu-lineageos-guacamole` | `kernel/kernelsu-lineageos-guacamole/` | Planned | KernelSU-patched LOS 23.2 kernel for guacamole |
| `oneplus-7-pro-lineage-kernel-sm8150` | `kernel/oneplus-7-pro-lineage-kernel-sm8150/` | Reference | LOS kernel source reference |
| `magisk_patched-30700_rLeMH.img` | `kernel/` | Active | Current Magisk-patched boot image on device |
| `boot.img` | `kernel/` | Backup | Stock boot image before patching |
| `kali-nethunter-kernel-builder` | `kernel/` | Pending | NetHunter kernel build toolchain |

Tasks:

- [ ] Audit boot animation timing under Neptune vs stock LOS kernel using `simpleperf`.
- [ ] Build `kernelsu-lineageos-guacamole` against LOS 23.2 source and verify CP2077 mount parity with Magisk.
- [ ] Add `boot.img` SHA-256 and build fingerprint to a boot image registry in `07-KERNEL-PACKAGE-MODULES/packages/`.
- [ ] Cherry-pick energy-aware scheduling and TCP BBR patches from `blu-spark-kernel-op7` into Neptune.
- [ ] Run NetHunter kernel builder and verify CP2077 `post-fs-data.sh` timing still passes under NetHunter `init.d` ordering.
- [ ] Rename `magisk_patched-30700_rLeMH.img` to a versioned filename and add it to `production-artifact-sha256.txt`.
- [ ] Test CP2077 install and all variant mounts under `kernelsu-lineageos-guacamole`.

---

## NetHunter and Security Research

Path: `08-HACKING-RESEARCH/nethunter/hightech-kali-nethunter-suite`

All work here is performed on personally-owned hardware for educational purposes only. No offensive use against systems without explicit authorization.

| Item | Status | Notes |
|:--|:--|:--|
| NetHunter kernel (guacamole) | Staged | `kali-nethunter-kernel-builder` in `07-KERNEL/kernel/` |
| `hightech-kali-nethunter-suite` | Research | Contents not fully catalogued yet |
| `security-repos/` | Research | Contents not fully catalogued |
| NetHunter × CP2077 boot animation | Planned | `netrunner-nh` variant concept |

Tasks:

- [ ] Verify CP2077 Magisk module mount succeeds under a NetHunter-patched Neptune kernel — specifically test `post-fs-data.sh` bind-mount timing against NetHunter's `init.d` sequence on LOS 23.2.
- [ ] Design a `netrunner-nh` boot animation variant using Kali NetHunter visual language (terminal green, `KALI LINUX NETHUNTER` watermark) to complement the NetHunter kernel install.
- [ ] Fully catalogue `hightech-kali-nethunter-suite` contents, document which tools require the NetHunter kernel, and add the entry to `REPOS.md` and `99-MANIFESTS/git-repositories.txt`.
- [ ] Research dual-slot setup: primary slot for LOS 23.2 + Magisk + CP2077, secondary slot for NetHunter kernel + Kali chroot; document slot management steps.
- [ ] Audit `security-repos/` directory and remove or document any repos that are stale for more than six months.

---

## Production Artifact Governance

Path: `02-PRODUCTION/magisk-modules/`
Checksums: `99-MANIFESTS/production-artifact-sha256.txt`

| Artifact | Type | Status |
|:--|:--|:--|
| `CP2077-OP7Pro-release` | Symlink → `CP2077-OP7Pro/release/` | Active |
| `CP2077-OP7Pro-Ultimate-release` | Symlink → `CP2077-OP7Pro-Ultimate/release/` | Disabled — superseded |
| `CP2077-Universal-release` | Symlink → `CP2077-Universal/release/` | Active |
| `device-beta-fix-applied/` | Directory — patched beta artifacts | Archive |
| `device-copy-CP2077-OP7Pro-v2.0.0-beta.zip` | Legacy release ZIP | Archive |
| `device-copy-CP2077-OP7Pro-v2.0.0-ultimate-all-in-one.zip` | Legacy release ZIP | Archive |

Tasks:

- [ ] Add a CI step that resolves all symlinks in `02-PRODUCTION/magisk-modules/` and asserts each target exists and is non-empty — catches breakage when a module release directory is rebuilt to a new filename.
- [ ] Define a retention policy: legacy `device-copy-*.zip` files older than two versions move to a `legacy-builds/` subdirectory and are noted in `artifact-inventory.tsv`.
- [ ] Automate `production-artifact-sha256.txt` generation as part of `generate-manifests.sh` step 5 instead of running it manually.
- [ ] Add a `NOTES.md` inside `device-beta-fix-applied/` explaining what fix was applied, which device it tested on, and what problem it solved.
- [ ] Assert in `build.py` that no single output ZIP exceeds 350 MB, with a warning at 90% of that threshold.

---

## Performance and Benchmarking

Device: OnePlus 7 Pro GM1911 · SM8150 · 8 GB LPDDR4x · 256 GB UFS 3.0.

| Benchmark | Target | Measured | Status |
|:--|:--|:--|:--|
| Cold boot — no module (baseline) | — | TBD | Pending |
| Cold boot — `glitch` 60fps | < +2.0 s vs baseline | TBD | Pending |
| Cold boot — `og4k` 60fps | < +2.5 s vs baseline | TBD | Pending |
| `post-fs-data.sh` total execution | < 800 ms | TBD | Pending |
| `service.sh` first-pass overhead | 5.0 s + < 200 ms | TBD | Pending |
| Variant hot-swap (no reboot) | < 3 s | TBD | Pending |
| Animation frame-drop rate | < 2 dropped frames per boot | TBD | Pending |
| Battery drain per boot cycle vs baseline | < +0.5% | TBD | Pending |

Tasks:

- [ ] Implement `cp2077-bench.sh`: power-cycle device, parse `adb logcat -T 1` for `Displayed com.android.launcher`, compute delta from `ro.boottime.init`, run five times, report mean and standard deviation.
- [ ] Add `date +%s%3N` timestamps at start and end of `post-fs-data.sh` and log the diff to `/data/local/tmp/cp2077-timing.log`.
- [ ] Use `adb shell dumpsys SurfaceFlinger --latency bootanim` to capture per-frame render latency for `glitch` vs `og4k` variants on SM8150 UFS 3.0.
- [ ] Measure charge drain over 30 minutes of idle after CP2077 boot vs stock bootanimation baseline.
- [ ] Benchmark tmpfs RAM-staging (FEAT-08): measure bootanimation frame-read latency from UFS 3.0 vs `/data/local/tmp`; enable by default on devices with over 8 GB RAM if tmpfs is measurably faster.
- [ ] Run `simpleperf` against the FFmpeg audio generation phase in `build.py` to identify hotspots in `generate_tone()`.
- [ ] Test `og4k` thermal behavior under five consecutive cold boots: verify CPU does not exceed 95°C or skin temperature 85°C during 4K animation decode on SM8150.

---

## Community and Distribution

| Channel | Status | Action |
|:--|:--|:--|
| GitHub Releases | Active — v3.0.0-full, v1.0.0-universal | Automate via `gh release create` |
| XDA Developers | Pending — not yet posted | Create OP7 Pro forum thread |
| Magisk Modules Alt Repo | Pending — not submitted | Submit `module.json` PR |
| MMRL listing | Pending — not listed | Add `mmrl.json` descriptor |
| Telegram | Planned | v4.0.0 announcement channel |
| Kali NetHunter forums | Planned | Post `netrunner-nh` variant after NH-02 |

Tasks:

- [ ] Create an XDA Developers thread in the OnePlus 7 Pro forum section with variant screenshots, download links, ROM compat matrix, and installation steps; link from `README.md` and `module.prop support=`.
- [ ] Prepare `module.json` in the Magisk Modules Alt Repo format and submit a PR to `Magisk-Modules-Alt-Repo/submit`.
- [ ] Create `mmrl.json` with module ID, name, description, author, `minMagisk`, `minApi`, and screenshot URLs; submit to the MMRL repository.
- [ ] Rewrite `CHANGELOG-full.md` and `CHANGELOG-universal.md` in user-facing language grouped by: What's New, Bug Fixes, Compatibility — suitable as an XDA post body.
- [ ] Track GitHub release asset download counts weekly via `gh release view vX.X.X --json assets` and append to `releases/download-stats.json`.

---

## Workspace Maintenance Schedule

Root: `/home/arch/cyberpunk-2077`
Policy files: `AGENTS.md`, `CLAUDE.md`, `00-CONTROL/WORKSPACE-POLICY.md`

| Task | Frequency | Command |
|:--|:--|:--|
| Regenerate all manifests | After every release | `bash 99-MANIFESTS/generate-manifests.sh` |
| Reference repo sync check | Weekly | `bash scripts/check-repos.sh` |
| Symlink health audit | Weekly | `find 02-PRODUCTION -type l ! -e` |
| Quarantine audit | Monthly | `file 10-QUARANTINE-invalid-downloads/**/*` |
| Workspace size check | Monthly | `du -sh /home/arch/cyberpunk-2077` |

Tasks:

- [ ] Add a `generate-manifests.sh` call as the final step of `build.py` so manifests are never stale after a new artifact is produced; add `--no-manifest` flag to skip when not needed.
- [ ] Add broken-symlink detection to `cp2077-audit-workspace.sh` for `02-PRODUCTION/magisk-modules/` and `06-UI-THEMES-ANIMATIONS/`; log broken links with suggested repair commands but do not auto-delete.
- [ ] Run `file 10-QUARANTINE-invalid-downloads/**/*` in CI to confirm all quarantine entries are correctly identified as HTML; alert if a non-HTML file is found and prompt for relocation.
- [ ] Append `$(date +%Y-%m-%d) $(du -sb /home/arch/cyberpunk-2077 | cut -f1)` to `99-MANIFESTS/workspace-size-history.txt` on each manifest run to track growth trends.
- [ ] Update `00-CONTROL/PRODUCTION-STATUS.md` after every release with current module versions, device boot-verified state, last flash date, active variant, and audio state.

---

## Splash Screen and System UI Theming

| Asset | Path | Status |
|:--|:--|:--|
| Module thumbnail | `splash/module-thumbnail.png` | Present — 512×512 PNG |
| About page | `splash/about/` | Present |
| Boot splash | `splash/boot/` | Present |
| Splash asset pack | `06-UI-THEMES-ANIMATIONS/themes/CP2077-splash-assets/` | Needs audit |

Tasks:

- [ ] Create per-variant module thumbnails (512×512): one each for `glitch` (green), `flatline` (red), `og` (gold), and `netrunner` (cyan) so Magisk Manager and MMRL can display variant-specific artwork.
- [ ] Implement `windowSplashScreenBackground=#0A0A0A` and `windowSplashScreenAnimatedIcon` as a resource overlay targeting the `android` package to bring CP2077 branding to all app launch splashes on Android 12+.
- [ ] Update `splash/about/` — the page Magisk serves as the module about screen — with current version badge, variant count, ROM compat table, palette strip, and link to the GitHub release.
- [ ] Audit `06-UI-THEMES-ANIMATIONS/themes/CP2077-splash-assets/` contents, verify asset licensing, and document the asset list in a `ASSET-MANIFEST.md` inside the directory.
- [ ] Prepend a half-second `JACK OUT` title card (black background, `#FF003C` text, JetBrains Mono) to all shutdown animations as a `p 1 15 part0` entry in `desc.txt`.
- [ ] Refresh `webroot/index.html` header: embed `module-thumbnail.png` as an inline base64 data URI, add variant count badge, and add a link to the XDA thread once COMM-01 is complete.

---

## Reference Repo Sync Registry

Source of truth: `99-MANIFESTS/git-repositories.txt` and `git-repositories-status.txt`.
Clone policy: `--depth 1` shallow, synced before each major build.

| Repo | Location | Usage | Sync Priority |
|:--|:--|:--|:--|
| `sodasoba1/ONEPLUS9-OOS13-BootAnimation` | `01-DEVELOPMENT/repos/cyberpunk/` | Animation frame source | Critical — before each build |
| `GlitchedCyberBoot` | `01-DEVELOPMENT/repos/cyberpunk/` | Glitch variant reference | High |
| `topjohnwu/Magisk` | `01-DEVELOPMENT/repos/magisk-ecosystem/` | Magisk API reference | High |
| `tiann/KernelSU` | `01-DEVELOPMENT/repos/magisk-ecosystem/` | KSU module spec | High — before KSU build |
| `lineageos/lineage-device-guacamole` | `01-DEVELOPMENT/repos/oneplus-7-pro/` | LOS device tree reference | Medium — per LOS release |
| `hyprdots` | `06-UI-THEMES-ANIMATIONS/repos/` | Hyprland dotfiles reference | Medium |
| `engstk op8 (blu-spark-16)` | `07-KERNEL-PACKAGE-MODULES/repos/` | Kernel patch reference | Medium |
| `proxzima-plymouth` | `06-UI-THEMES-ANIMATIONS/repos/` | Plymouth theme reference | Low |

Tasks:

- [ ] Check whether `sodasoba1/ONEPLUS9-OOS13-BootAnimation` is ahead of local HEAD before running `build.py`; prompt to sync if it has new commits.
- [ ] Implement `AUTO-01` as a weekly systemd user timer running `scripts/check-repos.sh`; write output to `99-MANIFESTS/git-repositories-status.txt` automatically.
- [ ] Add a sidecar `WHY-CLONED.md` to each cloned reference repo explaining what it provides, which build steps use it, and the minimum sync frequency.
- [ ] Define a stale-repo policy: if a reference repo has not been accessed in 90 days and is not in the Critical tier, mark it as `ARCHIVED` in `git-repositories.txt` and consider pruning the working tree.
- [ ] Generate `git-repositories-status.txt` automatically in `generate-manifests.sh`, recording `HEAD` SHA, `origin/main` SHA, commits-behind count, and last-commit date for every tracked repo.

---

## Device Test Lab

Device under test: OnePlus 7 Pro GM1911 · guacamole · SM8150 · 8 GB · 256 GB UFS 3.0
ROM: LineageOS 23.2 (Android 16 · API 36)
Root: Magisk v30.7 (active) · KernelSU (pending) · APatch (pending)

### Test Matrix — CP2077-OP7Pro v3.0.0 on LOS 23.2 + Magisk v30.7

| Test Case | glitch | flatline | reboot | og1080p | og4k | Notes |
|:--|:--:|:--:|:--:|:--:|:--:|:--|
| Boot animation plays | ✅ | ✅ | ✅ | ✅ | ✅ | Verified 2026-05-13 |
| Shutdown animation plays | ✅ | ✅ | ✅ | ✅ | ✅ | BUG-07 fix applied |
| `rbootanimation.zip` mounted | ✅ | ✅ | ✅ | ✅ | ✅ | BUG-08 fix applied |
| Audio plays on boot | ✅ | ✅ | ✅ | ✅ | ✅ | Verified 2026-05-13 |
| Variant switch via `cp2077-config.sh` | ✅ | ✅ | ✅ | ✅ | ✅ | All combinations tested |
| `uninstall.sh` clean removal | ✅ | — | — | — | — | v3.1.0 script |
| `service.sh` double-pass remount | ✅ | — | — | — | — | Verified 2026-05-13 |
| WebUI panel in Magisk | ⏳ | — | — | — | — | LOS 23.2 WebView needed |
| KernelSU install | ⏳ | ⏳ | ⏳ | ⏳ | ⏳ | Pending kernel build |
| APatch install | ⏳ | ⏳ | ⏳ | ⏳ | ⏳ | Pending APatch pass |

Tasks:

- [ ] After a clean flash of LOS 23.2, install the module and capture full `logcat -b main,system,events` from power-on to confirm all 7 mount paths bind without falling back to `service.sh` reapplication.
- [ ] Cycle through all five variants via `cp2077-config.sh` without rebooting; verify `service.sh` correctly remounts each time and no residual mounts from the previous variant remain.
- [ ] Open the Magisk WebUI for the CP2077 module on LOS 23.2 and trigger all five bridge functions: `refreshStatus`, `applyConfig`, `restartAnim`, `showDiag`, and the variant picker.
- [ ] Run `uninstall.sh`, then confirm via ADB that no bind-mounts remain, no data-partition artifacts remain, and the device boots cleanly on the stock bootanimation.
- [ ] Temporarily run `setenforce 1` and reboot with CP2077 active; capture any `avc` denials for `bootanim` and generate a `sepolicy.rule` if denials block the mount.
- [ ] Run the `og4k` variant for five consecutive cold boots and monitor thermal zone temperatures to confirm the SM8150 does not throttle during 4K animation decode.
- [ ] Flash a ROM update on top of an existing CP2077 install and verify the module either survives cleanly or fails gracefully without a boot loop.

---

## APK and Native Android Development

Path: `04-ANDROID/` — `apk/` · `arm64/` · `device/sdcard-Download/` · `android-tools`
Target: Android 16 · API 36 · `arm64-v8a` · min API 26

| Path | Contents | Status |
|:--|:--|:--|
| `apk/livewallpaper-invalid-source-files/` | HTML files masquerading as APKs | Do not install — quarantine reference copy |
| `arm64/` | arm64-v8a native tool binaries | Staged — needs inventory |
| `device/sdcard-Download/` | Files staged for device SD card push | Working area |
| `android-tools` | ADB/fastboot tooling | In use |

Tasks:

- [ ] Write a design spec for a real Android `WallpaperService` APK to replace the quarantined HTML fakes: Kotlin, OpenGL ES 3.0, `GLSurfaceView`, rain/glitch GLSL shader on `#0A0A0A`, 5 fps when screen-off, `arm64-v8a` only. Store the spec in `04-ANDROID/apk/livewallpaper-design-spec.md`.
- [ ] Create an Android Studio project scaffold in `04-ANDROID/apk/CP2077-LiveWallpaper/` with `minSdk 26`, `targetSdk 36`, and a GLSL shader stub in `assets/shaders/`; do not build until the design spec is approved.
- [ ] Inventory `04-ANDROID/arm64/`: for each binary, record name, version, source, license, and SHA-256; remove binaries that duplicate functionality already available in `android-tools`.
- [ ] Define a naming convention for files in `device/sdcard-Download/` (`MODULE-VERSION-DATE.zip`) and add a `STAGED.md` manifest listing what is present and what device action is needed.
- [ ] Research F-Droid and GitHub for a legitimately licensed live wallpaper APK; if found, verify via `apksigner verify`, document the license, and record in `04-ANDROID/apk/SOURCES.md`; if none found, proceed with the APK design spec above.
- [ ] Package the patched `cyberpunk-technotronic-icon-theme` (broken symlinks removed in BUG-06) as an Android icon pack APK with a minimal `AndroidManifest.xml` using `aapt2`, and place the output in `04-ANDROID/apk/`.
- [ ] Research whether a Magisk Manager UI overlay APK is feasible on Android 16 without writing to the system partition; document the conclusion in `TROUBLESHOOTING.md`.

---

## Related Docs

| Document | Purpose |
|:--|:--|
| [`../README.md`](../README.md) | Project dashboard |
| [`INSTALLATION-GUIDE.md`](INSTALLATION-GUIDE.md) | Install and flash workflow |
| [`BUILD-GUIDE.md`](BUILD-GUIDE.md) | Build and package workflow |
| [`VARIANTS.md`](VARIANTS.md) | Animation variants and assets |
| [`DEVICE-SPECS.md`](DEVICE-SPECS.md) | Device and ROM compatibility |
| [`TROUBLESHOOTING.md`](TROUBLESHOOTING.md) | Diagnostics and fixes |
| [`REPOS.md`](REPOS.md) | Repository catalogue |
| [`../AGENTS.md`](../AGENTS.md) | Agent operating rules |

---

### Palette

`#FCEE0C` · `#00FFFF` · `#FF003C` · `#00FF9F` · `#FF6B35` · `#0A0A0A`

Roadmap owner: `lchtangen`

Workspace: `/home/arch/cyberpunk-2077`
