<div align="center">

<br>

# CYBERPUNK 2077 SYSTEM UI SUITE

### Magisk / KernelSU / APatch theme stack for OnePlus 7 Pro and Universal Android builds

<br>

[![Stable](https://img.shields.io/badge/STABLE-CP2077_OP7Pro_Full_v3.0.0-00ff9f?style=for-the-badge&labelColor=050505)](00-CONTROL/PRODUCTION-STATUS.md)
[![Sprint](https://img.shields.io/badge/SPRINT-v3.1.0_Hardening-fcee0c?style=for-the-badge&labelColor=050505)](09-DOCS/ROADMAP.md)
[![Universal](https://img.shields.io/badge/UNIVERSAL-v1.0.0_14_ROM_FAMILIES-00ffff?style=for-the-badge&labelColor=050505)](02-PRODUCTION/magisk-modules/CP2077-Universal-release)

[![Device](https://img.shields.io/badge/DEVICE-OnePlus_7_Pro_GM1911-ff003c?style=flat-square&labelColor=0a0a0a)](09-DOCS/DEVICE-SPECS.md)
[![Android](https://img.shields.io/badge/ANDROID-API_36_%2F_14--16+-fcee0c?style=flat-square&logo=android&logoColor=black&labelColor=0a0a0a)](09-DOCS/DEVICE-SPECS.md)
[![Root](https://img.shields.io/badge/ROOT-Magisk_30.7_%2B_KSU_%2B_APatch-00ff9f?style=flat-square&labelColor=0a0a0a)](09-DOCS/INSTALLATION-GUIDE.md)
[![Workspace](https://img.shields.io/badge/WORKSPACE-17G_%2F_53_repos-ff6b35?style=flat-square&labelColor=0a0a0a)](99-MANIFESTS/workspace-size.txt)

<br>

```
╭──────────────────────────────────────────────────────────────────────────────╮
│  BOOT ANIMATION  ▸  SHUTDOWN ANIMATION  ▸  SYSTEM AUDIO  ▸  WEBUI CONTROL   │
│  1440×3120 native OP7 Pro pipeline · Universal auto-scale · multi-ROM mount  │
╰──────────────────────────────────────────────────────────────────────────────╯
```

<br>

| Signal | Value |
|:--|:--|
| Active device | OnePlus 7 Pro `GM1911` / `guacamole` |
| Active ROM target | Android 16 / API 36 |
| Stable module | `CP2077_OP7Pro_Full` v3.0.0 |
| Active sprint | v3.1.0 hardening and UI expansion |
| Current variant | `CyberGlitch-2077` at 60 fps |
| Asset surface | 5 boot variants, 5 shutdown variants, 7 UI sounds |
| Root layer | Magisk 20.4+, KernelSU, APatch |
| Workspace snapshot | 17G, 310,578 files, 53 repo entries |

<br>

</div>

---

## Command Deck

| Intent | Entry Point |
|:--|:--|
| Install on OP7 Pro | [`09-DOCS/INSTALLATION-GUIDE.md`](09-DOCS/INSTALLATION-GUIDE.md) |
| Inspect active device | [`00-CONTROL/PRODUCTION-STATUS.md`](00-CONTROL/PRODUCTION-STATUS.md) |
| Compare animation variants | [`09-DOCS/VARIANTS.md`](09-DOCS/VARIANTS.md) |
| Build from source | [`09-DOCS/BUILD-GUIDE.md`](09-DOCS/BUILD-GUIDE.md) |
| Navigate the workspace | [`09-DOCS/WORKSPACE-GUIDE.md`](09-DOCS/WORKSPACE-GUIDE.md) |
| Track v3.1.0 and beyond | [`09-DOCS/ROADMAP.md`](09-DOCS/ROADMAP.md) |
| Debug boot/audio issues | [`09-DOCS/TROUBLESHOOTING.md`](09-DOCS/TROUBLESHOOTING.md) |
| Audit cloned references | [`09-DOCS/REPOS.md`](09-DOCS/REPOS.md) |

---

## System Overview

This workspace builds and maintains a Cyberpunk 2077 Android visual layer:

- systemless boot/shutdown animation replacement through Magisk-style modules
- OnePlus 7 Pro native packaging at `1440x3120`
- Universal all-device packaging with ROM and resolution detection
- CP2077-inspired system audio overlays
- WebUI and ADB control surfaces for variant switching and diagnostics
- Linux/Wayland theme references for a matching desktop environment

The root repository is intentionally a control and documentation repository. The
large source trees live under `01-DEVELOPMENT/` through `08-HACKING-RESEARCH/`
and many of them are nested repos with their own history.

---

## Module Matrix

<table>
<tr>
<td width="33%" valign="top">

<h3><code>CP2077_OP7Pro_Full</code></h3>

<p>
<strong>Status:</strong> Stable / active on device<br>
<strong>Version:</strong> v3.0.0 stable, v3.1.0 sprint metadata<br>
<strong>Target:</strong> OnePlus 7 Pro <code>guacamole</code><br>
<strong>Source:</strong> <code>01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/</code><br>
<strong>Release:</strong> <code>02-PRODUCTION/magisk-modules/CP2077-OP7Pro-release/</code>
</p>

<p>
Primary production module. Ships the native OP7 Pro animation pipeline,
shutdown animations, audio pack, config-driven variant selection, and
multi-path mount repair.
</p>

</td>
<td width="33%" valign="top">

<h3><code>CP2077_Universal</code></h3>

<p>
<strong>Status:</strong> Built / multi-device<br>
<strong>Version:</strong> v1.0.0<br>
<strong>Target:</strong> Android devices across 14 ROM families<br>
<strong>Source:</strong> <code>01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal/</code><br>
<strong>Release:</strong> <code>02-PRODUCTION/magisk-modules/CP2077-Universal-release/</code>
</p>

<p>
All-device package. Auto-detects ROM family, root solution, and display
resolution; includes the canonical all-variant ZIP plus per-variant builds.
</p>

</td>
<td width="33%" valign="top">

<h3><code>CP2077_OP7Pro_Ultimate</code></h3>

<p>
<strong>Status:</strong> Built / disabled<br>
<strong>Version:</strong> v3.0.0<br>
<strong>Target:</strong> OnePlus 7 Pro megapack testing<br>
<strong>Source:</strong> <code>01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro-Ultimate/</code><br>
<strong>Release:</strong> <code>02-PRODUCTION/magisk-modules/CP2077-OP7Pro-Ultimate-release/</code>
</p>

<p>
Superset package kept for megapack workflows. Not the active daily-driver
module; Full is the production path.
</p>

</td>
</tr>
</table>

---

## Visual Runtime

| Layer | Implementation |
|:--|:--|
| Boot animation | `bootanimation/<variant>/bootanimation.zip`, stored inner ZIP format |
| Shutdown animation | `shutdownanimation/<variant>/shutdownanimation.zip` |
| Audio overlay | `audio/ui/*.ogg`, 7 Android UI event sounds |
| Flash-time selector | `customize.sh`, reads `/data/cp2077.conf` |
| Early mount | `post-fs-data.sh`, bind-mounts ROM media paths |
| Late repair | `service.sh`, remounts if a stock stub under 5 MB wins |
| Live config | `cp2077-config.sh` and Magisk/MMRL WebUI bridge |
| Update channel | `releases/update-full.json`, `releases/update-universal.json` |

The 5 MB threshold in `service.sh` is the key production guardrail: CP2077
animation ZIPs are large, while stock stubs are tiny. If a ROM remounts `/product`
after `post-fs-data`, the late service pass can detect and repair it.

---

## Animation Variants

| Variant | Key | Boot | Shutdown | Role |
|:--|:--|:--|:--|:--|
| CyberGlitch-2077 | `glitch` | 1440x3120 / 60 fps | included | Default active profile |
| Cyberpunk Flatline | `flatline` | 1440x3120 / 60 fps | included | Red diagnostic profile |
| Re-Boot Animation | `reboot` | 1440x3120 / 60 fps | included | Looping reboot identity |
| Original 1080p | `og1080p` | 1080x2340 / 30 fps | included | Classic OnePlus port |
| Original 4K | `og4k` | 2160x4800 / 30 fps | included | Development high-res asset |

Full variant notes and source paths live in
[`09-DOCS/VARIANTS.md`](09-DOCS/VARIANTS.md).

---

## Quick Operations

<details open>
<summary><strong>Install or flash</strong></summary>

```bash
adb push 02-PRODUCTION/magisk-modules/CP2077-OP7Pro-release/CP2077-OP7Pro-v3.0.0.zip \
  /sdcard/Download/

# Then install from Magisk / KernelSU / APatch manager and reboot.
```

Universal build:

```bash
adb push 02-PRODUCTION/magisk-modules/CP2077-Universal-release/CP2077-Universal-v1.0.0.zip \
  /sdcard/Download/
```

</details>

<details>
<summary><strong>Switch animation profile without reflashing</strong></summary>

```bash
adb shell su -c 'printf "variant=flatline\naudio=yes\n" > /data/cp2077.conf'
adb shell su -c 'setprop ctl.restart bootanim'
```

Valid OP7 Pro keys:

```text
glitch | flatline | reboot | og1080p | og4k
```

</details>

<details>
<summary><strong>Run the ADB control panel</strong></summary>

```bash
cd 05-LINUX/arch-host/device-arch-scripts
./cp2077-adb-control.sh status
./cp2077-adb-control.sh switch glitch
./cp2077-adb-control.sh verify
./cp2077-adb-control.sh logs
```

</details>

<details>
<summary><strong>Build from source</strong></summary>

```bash
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro
python3 build.py --list-variants
python3 build.py --dry-run
python3 build.py
```

```bash
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal
python3 build-universal.py
```

</details>

<details>
<summary><strong>Regenerate manifests after release work</strong></summary>

```bash
bash 99-MANIFESTS/generate-manifests.sh
```

The manifest files are snapshots, not live truth. Regenerate them after adding
or changing release artifacts.

</details>

---

## Design System

| Token | Hex | Usage |
|:--|:--|:--|
| Neon Yellow | `#FCEE0C` | primary CP2077 identity, warnings, active selectors |
| Netrunner Cyan | `#00FFFF` | links, secondary accent, WebUI telemetry |
| Flatline Red | `#FF003C` | danger states, flatline variant, destructive actions |
| Signal Green | `#00FF9F` | success, verified state, active module |
| Warning Orange | `#FF6B35` | pending work, sprint state, warnings |
| Carbon Black | `#0A0A0A` | base background for WebUI and terminal themes |
| Grid Border | `#2A2A2A` | dividers, card outlines, low-emphasis UI chrome |

The palette is reused across module WebUI, ADB ANSI output, Waybar, eww,
hyprlock, Rofi, Plymouth, and README badges.

---

## Workspace Map

```text
cyberpunk-2077/
├── 00-CONTROL/                       production status and workspace policy
├── 01-DEVELOPMENT/repos/             module, root, ROM, kernel, and theme repos
│   ├── cyberpunk/                    CP2077 module source trees
│   ├── magisk-ecosystem/             Magisk, KernelSU, APatch, MMRL, Zygisk refs
│   ├── oneplus-7-pro/                guacamole device trees and kernels
│   └── android-roms/                 recovery and ROM references
├── 02-PRODUCTION/magisk-modules/     release symlinks and device copies
├── 03-BUILD/                         raw upstream assets and build workspace
├── 04-ANDROID/                       ADB tools, APK staging, device snapshots
├── 05-LINUX/                         Arch host scripts and desktop setup
├── 06-UI-THEMES-ANIMATIONS/          animations, wallpapers, themes, audio
├── 07-KERNEL-PACKAGE-MODULES/        kernel images, sources, modules, packages
├── 08-HACKING-RESEARCH/              NetHunter and security research
├── 09-DOCS/                          documentation vault
├── 10-QUARANTINE-invalid-downloads/  invalid APK/ZIP downloads; never install
├── 99-MANIFESTS/                     generated inventories and checksums
└── releases/                         Magisk update JSON and changelogs
```

---

## Compatibility Matrix

| Surface | Supported / tracked |
|:--|:--|
| Root managers | Magisk 20.4+, KernelSU, APatch |
| Tested active root | Magisk v30.7 |
| Android range | Android 8.0+ declared for OP7 Pro module, active test on Android 16 |
| OP7 Pro display | 1440x3120 / 90 Hz |
| Universal ROM families | AOSP, Pixel, CalyxOS, GrapheneOS, LineageOS, crDroid, DerpFest, OOS, ColorOS, MIUI, HyperOS, Samsung One UI, Evolution X, yaap, ArrowOS, PixelOS, RisingOS |
| Primary mount paths | `/product/media`, `/system/product/media`, `/system/media`, `/my_product/media`, `/data/local`, `/data/misc/bootanim` |

---

## Release and Version Rules

`module.prop` version codes use this formula:

```text
MAJOR * 100000 + MINOR * 1000 + PATCH
```

Examples:

| Version | Code |
|:--|--:|
| v1.0.0 | 100000 |
| v3.0.0 | 300000 |
| v3.1.0 | 301000 |

When bumping a release, update the build scripts, `module.prop`, release ZIP
filenames, root `releases/update-*.json`, ZIP-local `update.json`, changelogs,
and manifests together. See [`AGENTS.md`](AGENTS.md) for the short operational
checklist.

---

## Quarantine

Do not install, flash, repackage, or use anything from:

```text
10-QUARANTINE-invalid-downloads/
```

That directory contains malformed downloads such as HTML documents masquerading
as APKs or ZIPs. It exists so bad artifacts are retained for audit without
being confused with production inputs.

---

## Reference Layers

| Layer | Examples |
|:--|:--|
| Root ecosystem | Magisk, KernelSU, APatch, ZygiskNext, ReZygisk, LSPosed, MMRL |
| Device trees | LineageOS 23.2, DerpFest, Evolution X, crDroid references |
| Kernels | blu-spark, Neptune, KernelSU guacamole, LineageOS SM8150 |
| Linux themes | Cyberpunk-Neon, K-DE-Cyberpunk-Neon, cybrland, HyprPanel, rofi |
| Visual assets | CP2077 boot/shutdown ZIPs, wallpapers, splash assets, icon themes |

Full repository catalogue:
[`09-DOCS/REPOS.md`](09-DOCS/REPOS.md).

---

## Manifest Index

| Manifest | Contents |
|:--|:--|
| [`99-MANIFESTS/production-artifact-sha256.txt`](99-MANIFESTS/production-artifact-sha256.txt) | release ZIP checksums |
| [`99-MANIFESTS/artifact-inventory.tsv`](99-MANIFESTS/artifact-inventory.tsv) | file inventory |
| [`99-MANIFESTS/directory-map.txt`](99-MANIFESTS/directory-map.txt) | directory tree |
| [`99-MANIFESTS/git-repositories.txt`](99-MANIFESTS/git-repositories.txt) | repo paths, remotes, categories |
| [`99-MANIFESTS/workspace-size.txt`](99-MANIFESTS/workspace-size.txt) | workspace size snapshot |
| [`99-MANIFESTS/symlinks.txt`](99-MANIFESTS/symlinks.txt) | symlink map |

---

<div align="center">

### Fan-made theme suite. Not affiliated with CD PROJEKT RED.

CP2077 names and visual assets belong to their respective owners. This workspace
is maintained as a personal Android theming and systems research project.

[![Profile](https://img.shields.io/badge/GitHub-lchtangen-00ff9f?style=flat-square&logo=github&labelColor=050505)](https://github.com/lchtangen)
[![Docs](https://img.shields.io/badge/Docs-09--DOCS-fcee0c?style=flat-square&labelColor=050505)](09-DOCS/INDEX.md)
[![Status](https://img.shields.io/badge/Status-Production_Audit-ff6b35?style=flat-square&labelColor=050505)](00-CONTROL/PRODUCTION-STATUS.md)

</div>
