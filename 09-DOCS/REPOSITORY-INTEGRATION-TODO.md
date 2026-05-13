# Cloned Repository Integration Audit TODO

Updated: 2026-05-13

Scope: 53 repository entries from `99-MANIFESTS/git-repositories.txt`.

This document converts the cloned repository audit into an implementation TODO
list. It is intentionally plain Markdown so VS Code, GitHub, markdownlint, and
search tools can manage it without custom rendering.

## Audit Method

- Source of truth: `99-MANIFESTS/git-repositories.txt`.
- Status input: `99-MANIFESTS/git-repositories-status.txt`.
- Local inspection: README files, module metadata, build scripts, WebUI files,
  shell scripts, device trees, kernel files, recovery trees, theme configs, and
  asset folders.
- Integration rule: only promote ideas that can improve the CP2077 module,
  Universal module, release pipeline, device support, desktop theme system, or
  workspace governance.

## Audit Snapshot

| Category | Count | Repositories Audited | Best Integration Direction |
|:--|--:|:--|:--|
| `module-primary` | 3 | `CP2077-OP7Pro`, `CP2077-OP7Pro-Ultimate`, `CP2077-Universal` | Shared module runtime, release parity, root-manager support |
| `module-legacy` | 1 | `CP2077-OP7Pro-build-source` | Historical behavior reference only |
| `module-reference` | 4 | `GlitchedCyberBoot`, `ONEPLUS9-OOS13-BootAnimation`, `CyberPunk-2077-OOS13-Modded-Boot-and-Shutdown-Animation`, `Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO` | Animation provenance, OOS path handling, shutdown animation packaging |
| `magisk-root` | 10 | `Magisk`, `KernelSU`, `APatch`, `ZygiskNext`, `ReZygisk`, `LSPosed`, `Vector`, `zygisk-module-sample`, `MMRL`, `awesome-android-root` | Root compatibility, WebUI bridge, module metadata, future hook research |
| `theme-linux` | 18 | `hyprdots`, `HyprPanel`, `rofi`, `plymouth-themes`, `mechabar`, `proxzima-plymouth`, `diinki-retrofuture`, `dotfiles`, `dots`, `widgets`, `Tokyonight-rofi-theme`, `catppuccin`, `Cyberpunk-Neon`, `K-DE-Cyberpunk-Neon`, `cyber-hyprland-theme`, `cybrland`, `cybrcolors`, `cyberpunk-technotronic-icon-theme` | Host theme profile, Rofi skins, Plymouth boot theme, icon packaging, design tokens |
| `wallpapers` | 1 | `cybrpapers` | Wallpaper catalogue, color extraction, variant pairing |
| `ui-android` | 1 | `AndroidCyberpankIcons` | Android icon-pack experiment and visual asset source |
| `kernel` | 5 | `blu-spark-kernel-op7`, `neptune-kernel-sm8150`, `kernelsu-lineageos-guacamole`, `op8`, `op5` | Boot timing research, KernelSU kernel validation, boot image registry |
| `device-tree` | 8 | `lineage-device-guacamole`, `lineage-device-sm8150-common`, `lineage-kernel-sm8150`, `evolution-x-device-guacamole`, `device_oneplus_guacamole`, `device_oneplus_sm8150-common`, `kernel_oneplus_sm8150`, `android_kernel_oneplus_sm8150` | ROM path profiles, SELinux checks, audio path validation |
| `recovery` | 2 | `android_device_oneplus_guacamole_unified_TWRP`, `android_device_oneplus_guacamole-pbrp` | Recovery install test plan and direct-write guardrails |

## Best Features to Integrate

| ID | Priority | Importance | Source Repositories | Feature |
|:--|:--|:--:|:--|:--|
| FEATURE-001 | High | 5 | `Magisk`, `KernelSU`, `APatch`, `MMRL` | Root-manager-neutral compatibility report before install. |
| FEATURE-002 | High | 5 | `MMRL`, `CP2077-OP7Pro` | WebUI diagnostics drawer with copyable status, mount map, root manager, and active variant. |
| FEATURE-003 | High | 5 | Device trees, `CP2077-Universal` | ROM profile registry for boot paths, shutdown paths, audio paths, and SELinux notes. |
| FEATURE-004 | High | 5 | Animation source repos | Variant provenance panel with upstream repo, local source file, SHA-256, resolution, and frame count. |
| FEATURE-005 | High | 4 | `KernelSU`, `APatch` | Native metadata for KernelSU/APatch while preserving Magisk compatibility. |
| FEATURE-006 | Medium | 4 | `hyprdots`, `cybrland`, `cyber-hyprland-theme` | Layered CP2077 Hyprland desktop profile. |
| FEATURE-007 | Medium | 4 | `rofi`, `Tokyonight-rofi-theme` | CP2077 Rofi launcher, power menu, screenshot menu, and variant selector. |
| FEATURE-008 | Medium | 4 | `plymouth-themes`, `proxzima-plymouth` | CP2077 Plymouth theme and preview workflow. |
| FEATURE-009 | Medium | 4 | `cybrcolors`, `catppuccin`, `Cyberpunk-Neon` | Generated design tokens for docs, WebUI, shell, Android XML, and Linux themes. |
| FEATURE-010 | Medium | 3 | `AndroidCyberpankIcons`, `cyberpunk-technotronic-icon-theme` | Cross-platform icon asset catalogue and Android icon-pack prototype. |
| FEATURE-011 | Medium | 3 | `cybrpapers` | Wallpaper manifest with resolution, palette, license, and recommended variant pairing. |
| FEATURE-012 | Low | 2 | `ZygiskNext`, `ReZygisk`, `LSPosed`, `Vector` | Future native/hook research lane for status bar, lockscreen, and SystemUI extensions. |

## Best Tools to Implement

| ID | Priority | Importance | Source Repositories | Tool |
|:--|:--|:--:|:--|:--|
| TOOL-001 | High | 5 | `Magisk`, `KernelSU`, `APatch` | `cp2077-root-smoke.sh` for install, status, enable, disable, config write, mount check, and uninstall tests. |
| TOOL-002 | High | 5 | `99-MANIFESTS`, all repos | `cp2077-workspace-audit.sh` for stale repos, dirty state, broken symlinks, quarantine leaks, and manifest freshness. |
| TOOL-003 | High | 5 | Release ZIPs, module repos | `cp2077-release-verify.py` for ZIP integrity, SHA-256, update JSON, module metadata, and source lock checks. |
| TOOL-004 | High | 4 | Device trees, ADB target | `cp2077-device-profile-gen.sh` to collect props, mount paths, file sizes, SELinux mode, and ROM family. |
| TOOL-005 | High | 4 | Animation source repos | `cp2077-source-audit.py` to compare `.downloads`, `SOURCES`, `sources.lock.json`, and packaged ZIP contents. |
| TOOL-006 | Medium | 4 | Theme repos | `cp2077-theme-switch.sh` for apply, diff, backup, rollback, and dry-run of desktop theme layers. |
| TOOL-007 | Medium | 4 | Assets, wallpaper, icon repos | `cp2077-asset-catalog.py` for thumbnails, dominant colors, duplicate detection, and missing-license warnings. |
| TOOL-008 | Medium | 3 | Kernel repos | `cp2077-bootimg-registry.py` for boot image SHA-256, source ROM, patch tool, root manager, kernel source, and rollback path. |
| TOOL-009 | Medium | 3 | WebUI | Playwright smoke runner for bridge detection, variant cards, diagnostics output, and responsive layout. |
| TOOL-010 | Low | 2 | Docs and manifests | `cp2077-research-map.py` to link roadmap tasks to source repos and audit evidence. |

## Best Implementations to Extract

| ID | Priority | Importance | Source Repositories | Implementation |
|:--|:--|:--:|:--|:--|
| IMPL-001 | High | 5 | `CP2077-OP7Pro`, `CP2077-Universal`, `Magisk` | Shared `lib/root-runtime.sh` for root-manager detection, module path discovery, and shell bridge dispatch. |
| IMPL-002 | High | 5 | `CP2077-OP7Pro`, `GlitchedCyberBoot` | Shared `lib/mount-runtime.sh` for bind mounts, copy fallback, remount threshold checks, and retry logging. |
| IMPL-003 | High | 5 | `CP2077-Universal`, device trees | `devices/*.yaml` profile registry consumed by Universal install logic. |
| IMPL-004 | High | 5 | Animation repos, `.downloads` | `sources.lock.json` with source URL, content length, SHA-256, upstream repo, and verification timestamp. |
| IMPL-005 | High | 4 | `MMRL`, WebUI | WebUI bridge adapter with MMRL, KernelSU, APatch, Magisk, and mock backends. |
| IMPL-006 | Medium | 4 | `hyprdots`, `cybrland`, `cyber-hyprland-theme` | Layered host profile under `06-UI-THEMES-ANIMATIONS/profiles/cp2077-hyprland/`. |
| IMPL-007 | Medium | 4 | `cybrcolors`, `catppuccin` | `design-tokens.json` generator with CSS, shell, Android XML, and Markdown outputs. |
| IMPL-008 | Medium | 3 | `99-MANIFESTS` | Generated `repo-registry.json` as the single structured source for repo docs. |
| IMPL-009 | Medium | 3 | Recovery trees | Recovery installer test harness with safe assertions and no destructive default writes. |
| IMPL-010 | Low | 2 | Hook research repos | Decision record for whether Zygisk/LSPosed work belongs in this project or a separate module. |

## High Priority TODO

| ID | Status | Importance | Source Repositories | Task | Acceptance Criteria |
|:--|:--|:--:|:--|:--|:--|
| AUDIT-H001 | [ ] | 5 | `CP2077-OP7Pro`, `CP2077-Universal` | Create shared `lib/root-runtime.sh`. | Installer, service, config script, and WebUI can call the same root detection helpers. |
| AUDIT-H002 | [ ] | 5 | `Magisk`, module repos | Validate every `module.prop`. | CI fails on missing `id`, invalid `versionCode`, bad `updateJson`, CRLF, or mismatched version. |
| AUDIT-H003 | [ ] | 5 | `KernelSU`, `CP2077-Universal` | Add KernelSU `module.json`. | KernelSU Manager reads name, version, description, WebUI, and update metadata correctly. |
| AUDIT-H004 | [ ] | 5 | `APatch`, module repos | Add APatch install and status smoke tests. | APatch install flow is documented and tested without Magisk assumptions. |
| AUDIT-H005 | [ ] | 5 | `MMRL` | Generate MMRL module listing metadata. | Metadata includes icon, screenshots, category, compatibility, changelog, files, and checksums. |
| AUDIT-H006 | [ ] | 5 | `MMRL`, WebUI | Replace WebUI direct shell calls with a bridge adapter. | WebUI supports MMRL, KernelSU, APatch, Magisk fallback, and local mock mode. |
| AUDIT-H007 | [ ] | 5 | LineageOS, DerpFest, Evolution X, crDroid refs | Create `devices/guacamole-los-23.2.yaml`. | Profile includes boot paths, shutdown paths, audio paths, ROM props, SELinux mode, and test status. |
| AUDIT-H008 | [ ] | 5 | `CP2077-Universal` | Teach Universal installer to read device profiles. | Installer uses profile data before falling back to generic path detection. |
| AUDIT-H009 | [ ] | 5 | Animation source repos | Add `sources.lock.json`. | Every downloaded source ZIP has source URL, SHA-256, content length, and verification date. |
| AUDIT-H010 | [ ] | 5 | Release ZIPs | Add `cp2077-release-verify.py`. | A release ZIP can be verified against checksum, update JSON, source lock, and embedded module metadata. |
| AUDIT-H011 | [ ] | 5 | `99-MANIFESTS`, all repos | Generate `repo-registry.json`. | Registry includes path, category, branch, remote, dirty count, last commit, purpose, and sync tier. |
| AUDIT-H012 | [ ] | 5 | `99-MANIFESTS`, all repos | Add `cp2077-workspace-audit.sh`. | Script reports stale manifests, dirty nested repos, missing docs, broken symlinks, and quarantine leaks. |
| AUDIT-H013 | [ ] | 5 | `CP2077-OP7Pro` | Extract `lib/mount-runtime.sh`. | `post-fs-data.sh` and `service.sh` share one mount/copy/remount implementation. |
| AUDIT-H014 | [ ] | 5 | `CP2077-OP7Pro` | Replace fixed sleeps with property waits. | Boot logic waits for relevant system properties and logs timeout reason. |
| AUDIT-H015 | [ ] | 5 | `CP2077-OP7Pro`, `CP2077-Universal` | Add atomic config write helper. | `/data/cp2077.conf` updates are written through temp file, chmod, and atomic rename. |
| AUDIT-H016 | [ ] | 5 | `10-QUARANTINE-invalid-downloads` | Add quarantine leak gate. | Build and release checks fail if quarantined HTML/APK/ZIP files are referenced. |
| AUDIT-H017 | [ ] | 5 | `releases/`, module release dirs | Add ZIP integrity gate. | Every release artifact passes `python3 -m zipfile -t` and SHA-256 generation. |
| AUDIT-H018 | [ ] | 4 | Kernel repos | Create boot image registry. | Registry records boot image SHA-256, source ROM, kernel source, patch tool, root manager, and rollback file. |
| AUDIT-H019 | [ ] | 4 | TWRP, PBRP | Write recovery install test plan. | Plan documents adb sideload, install output assertions, rollback, and direct-write restrictions. |
| AUDIT-H020 | [ ] | 4 | Asset repos | Create third-party asset license manifest. | Every animation, wallpaper, icon, splash, and audio asset has source and license status. |
| AUDIT-H021 | [ ] | 4 | `cybrcolors`, `catppuccin`, WebUI | Add `design-tokens.json`. | Tokens generate CSS vars, shell colors, Android XML colors, and Markdown palette tables. |
| AUDIT-H022 | [ ] | 4 | Theme repos | Create canonical CP2077 Hyprland profile directory. | Profile has monitor, input, keybind, panel, launcher, lock, wallpaper, and rollback layers. |
| AUDIT-H023 | [ ] | 4 | `rofi`, `Tokyonight-rofi-theme` | Build CP2077 Rofi base theme. | Launcher, power menu, screenshot menu, and variant switcher share one palette. |
| AUDIT-H024 | [ ] | 4 | `plymouth-themes`, `proxzima-plymouth` | Build Plymouth prototype. | Preview script runs locally and install docs include rollback steps. |
| AUDIT-H025 | [ ] | 4 | Root repo | Add issue report bundle template. | Bug reports capture device, ROM, root manager, module version, logs, mount map, and active variant. |

## Medium Priority TODO

| ID | Status | Importance | Source Repositories | Task | Acceptance Criteria |
|:--|:--|:--:|:--|:--|:--|
| AUDIT-M001 | [ ] | 4 | `CP2077-OP7Pro`, `CP2077-Universal` | Build `cp2077-root-smoke.sh`. | Script runs install/status/config/mount/disable/enable/uninstall probes. |
| AUDIT-M002 | [ ] | 4 | `MMRL` | Add module file transparency output. | MMRL metadata lists major files, scripts, WebUI assets, and release ZIP size. |
| AUDIT-M003 | [ ] | 4 | `awesome-android-root` | Document supported root tool versions. | Docs state tested Magisk, KernelSU, APatch, MMRL, Android, and WebView versions. |
| AUDIT-M004 | [ ] | 4 | `zygisk-module-sample`, `ZygiskNext`, `ReZygisk` | Write hook research decision record. | Decision explains why Zygisk is in scope, out of scope, or split to a future repo. |
| AUDIT-M005 | [ ] | 4 | `LSPosed`, `Vector` | Evaluate SystemUI theming path. | Decision compares LSPosed hook, resource overlay, and pure Magisk overlay options. |
| AUDIT-M006 | [ ] | 4 | `GlitchedCyberBoot`, OOS repos | Document OOS `my_product` compatibility. | Docs list copy and bind-mount behavior for boot, dark boot, shutdown, and reboot animations. |
| AUDIT-M007 | [ ] | 4 | POCO module reference | Document splash-screen feasibility. | Decision covers bootlogo risk, device specificity, rollback, and whether to ship separately. |
| AUDIT-M008 | [ ] | 4 | OnePlus 9 animation source | Add source frame inspection task. | Tool reports resolution, frame count, FPS, desc format, and missing sequence gaps. |
| AUDIT-M009 | [ ] | 4 | DerpFest device trees | Add DerpFest profile candidate. | Profile maps product/system/media paths and audio paths with unverified status. |
| AUDIT-M010 | [ ] | 4 | Evolution X device tree | Add Evolution X profile candidate. | Profile maps product/system/media paths and audio paths with unverified status. |
| AUDIT-M011 | [ ] | 4 | crDroid kernel/device refs | Add crDroid compatibility notes. | Docs describe kernel source, branch, boot path assumptions, and root-manager risk. |
| AUDIT-M012 | [ ] | 3 | `kernelsu-lineageos-guacamole` | Validate KernelSU build script prerequisites. | README lists toolchain, defconfig, inputs, outputs, and known blockers. |
| AUDIT-M013 | [ ] | 3 | `neptune-kernel-sm8150` | Add boot timing benchmark plan. | Plan compares stock LOS, Neptune, and KernelSU kernel boot animation timing. |
| AUDIT-M014 | [ ] | 3 | `blu-spark-kernel-op7` | Identify reusable boot performance patches. | Patch notes list candidates and explain whether to port or leave reference-only. |
| AUDIT-M015 | [ ] | 3 | `op8`, `op5` | Mark cross-device kernel repos as reference-only. | Registry includes purpose and prevents accidental OP7 package mixing. |
| AUDIT-M016 | [ ] | 3 | `TWRP`, `PBRP` | Create recovery output assertion checklist. | Checklist verifies install log, mount target, file size, backup, and reboot behavior. |
| AUDIT-M017 | [ ] | 3 | `hyprdots` | Extract install dependency list. | Host theme docs list required packages and optional packages for Arch. |
| AUDIT-M018 | [ ] | 3 | `HyprPanel` | Mark HyprPanel as reference, not primary. | Docs note maintenance status and prefer Waybar/eww unless HyprPanel is explicitly selected. |
| AUDIT-M019 | [ ] | 3 | `mechabar`, `widgets` | Prototype HUD widgets. | CPU, RAM, network, battery, and active variant widgets render from shared tokens. |
| AUDIT-M020 | [ ] | 3 | `dotfiles`, `dots` | Build host package compatibility matrix. | Matrix covers hyprland, waybar, rofi-wayland, swww, dunst, kitty, and lock tools. |
| AUDIT-M021 | [ ] | 3 | `Cyberpunk-Neon`, `K-DE-Cyberpunk-Neon` | Package KDE/GTK theme references. | Docs separate reusable colors/icons from upstream-specific install steps. |
| AUDIT-M022 | [ ] | 3 | `cybrcolors` | Promote palette source of truth. | `cybrcolors` values map into `design-tokens.json` with CP2077 naming. |
| AUDIT-M023 | [ ] | 3 | `cybrpapers` | Generate wallpaper catalogue. | Catalogue includes path, resolution, color tags, license status, and recommended use. |
| AUDIT-M024 | [ ] | 3 | `AndroidCyberpankIcons` | Audit Android icon pack assets. | Report lists appfilter coverage, duplicate icons, missing licenses, and packaging blockers. |
| AUDIT-M025 | [ ] | 3 | `cyberpunk-technotronic-icon-theme` | Package cleaned icon theme. | Broken symlink state is documented and install path is tested. |
| AUDIT-M026 | [ ] | 3 | `catppuccin` | Add softer CP2077 palette variant. | Docs show mapping between neon CP2077 tokens and lower-contrast desktop tokens. |
| AUDIT-M027 | [ ] | 3 | `diinki-retrofuture` | Extract typography and spacing notes. | Design notes describe usable conventions without copying unrelated config wholesale. |
| AUDIT-M028 | [ ] | 3 | `Tokyonight-rofi-theme` | Add Rofi contrast test. | Theme passes readable selected, urgent, active, and disabled states. |
| AUDIT-M029 | [ ] | 3 | `plymouth-themes` | Add Plymouth preview command wrapper. | Wrapper previews theme and records screenshots or frame captures. |
| AUDIT-M030 | [ ] | 3 | `proxzima-plymouth` | Compare Plymouth animation structure. | Notes identify which structure is easiest to adapt to CP2077 frames. |
| AUDIT-M031 | [ ] | 3 | `99-MANIFESTS` | Generate `repo-health.md`. | Report lists dirty count, branch, remote, last commit, and sync tier per repo. |
| AUDIT-M032 | [ ] | 3 | `99-MANIFESTS` | Add `WHY-CLONED.md` requirement. | Every clone has purpose, source, sync priority, integration target, and removal rule. |
| AUDIT-M033 | [ ] | 3 | Root repo | Add VS Code tasks. | Tasks cover manifest generation, release verify, module lint, source audit, and local docs lint. |
| AUDIT-M034 | [ ] | 3 | Root repo | Add markdown lint config coverage. | Docs render in VS Code/GitHub and avoid raw HTML except where explicitly allowed. |
| AUDIT-M035 | [ ] | 3 | Root repo | Add task ownership labels. | Every task has module, root, device, kernel, theme, asset, release, or docs ownership. |

## Low Priority TODO

| ID | Status | Importance | Source Repositories | Task | Acceptance Criteria |
|:--|:--|:--:|:--|:--|:--|
| AUDIT-L001 | [ ] | 2 | `CP2077-OP7Pro-build-source` | Preserve legacy behavior notes. | Docs explain what legacy behavior is still useful and what is obsolete. |
| AUDIT-L002 | [ ] | 2 | `CP2077-OP7Pro-Ultimate` | Define retirement policy. | Ultimate is either archived with notes or folded into active module docs. |
| AUDIT-L003 | [ ] | 2 | Animation source repos | Add variant preview gallery. | Gallery links boot and shutdown previews with source repo and generated ZIP. |
| AUDIT-L004 | [ ] | 2 | `Vector` | Track native extension patterns. | Notes identify reusable build or hook patterns, or mark as no action. |
| AUDIT-L005 | [ ] | 2 | `ReZygisk`, `ZygiskNext` | Track Zygisk compatibility changes quarterly. | Sync note records upstream branch, last commit, and CP2077 relevance. |
| AUDIT-L006 | [ ] | 2 | `awesome-android-root` | Add quarterly root ecosystem review. | Review adds or removes root-manager compatibility tasks. |
| AUDIT-L007 | [ ] | 2 | Kernel repos | Add quarterly kernel freshness review. | Review marks stale branches and unsupported reference repos. |
| AUDIT-L008 | [ ] | 2 | Device tree repos | Add branch freshness warnings. | Warning triggers when a local branch is over 30 days behind upstream. |
| AUDIT-L009 | [ ] | 2 | Recovery repos | Add sideload screenshot checklist. | Docs describe screenshots/logs needed for recovery install reports. |
| AUDIT-L010 | [ ] | 2 | Theme repos | Add de-duplication review. | Duplicate themes or inactive references are marked keep, archive, or remove. |
| AUDIT-L011 | [ ] | 2 | Wallpapers | Add variant-based wallpaper rotation. | Wallpaper profile maps each boot animation variant to matching desktop/lockscreen art. |
| AUDIT-L012 | [ ] | 2 | Android icons | Add icon preview sheet. | Preview sheet groups icons by package, style, and missing metadata. |
| AUDIT-L013 | [ ] | 2 | Rofi themes | Add accessibility contrast report. | Report documents contrast for normal, selected, active, urgent, and disabled states. |
| AUDIT-L014 | [ ] | 2 | Plymouth themes | Add boot-theme GIF export. | GIF export is generated from preview frames without requiring system install. |
| AUDIT-L015 | [ ] | 2 | `catppuccin` | Add theme compatibility note. | Note explains when to use CP2077 neon vs softer desktop palettes. |
| AUDIT-L016 | [ ] | 1 | Root repo | Add discussion category plan. | Plan covers installs, ports, variants, releases, and development notes. |
| AUDIT-L017 | [ ] | 1 | Release docs | Add download statistics placeholder. | Stable release docs have a future location for asset download metrics. |
| AUDIT-L018 | [ ] | 1 | Docs | Add glossary for root/module terms. | Glossary covers Magisk, KernelSU, APatch, WebUI, bind mount, profile, and provenance. |
| AUDIT-L019 | [ ] | 1 | `REPOS.md` | Replace manual counts with generated counts. | Repo counts match `git-repositories.txt` without hand editing. |
| AUDIT-L020 | [ ] | 1 | All repos | Add archive candidate policy. | Clones unused for 180 days get an archive-candidate review entry. |

## Suggested Implementation Order

1. `repo-registry.json` and `cp2077-workspace-audit.sh`.
2. Shared root runtime and module metadata validation.
3. KernelSU/APatch/MMRL metadata and smoke tests.
4. Device profile registry and Universal installer integration.
5. Source lock and release verification tooling.
6. Mount runtime extraction and boot timing hardening.
7. Asset license manifest and visual asset catalogue.
8. Design tokens and WebUI/theme generation.
9. Hyprland, Rofi, Plymouth, wallpaper, and icon packaging.
10. Zygisk/LSPosed/native hook decision records.

## Risk Notes

- Several kernel source repos show very large dirty counts in the generated
  status manifest. Treat those as source/reference worktrees and do not commit
  from the workspace root.
- `HyprPanel` is in maintenance mode upstream, so it should inform design and
  dependency planning, not become the default CP2077 desktop panel path.
- `10-QUARANTINE-invalid-downloads/` must remain isolated from all build,
  release, and asset catalogue tasks.
- Recovery/direct-write installers must default to documentation and test plans
  until rollback behavior is proven on the target device.
