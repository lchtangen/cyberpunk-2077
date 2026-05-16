<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════════╗
║  ░▒▓  WORKSPACE POLICY — CYBERPUNK 2077 MAGISK SUITE  ▓▒░                  ║
║  ────────────────────────────────────────────────────────────────────────── ║
║  Operating Rules · Development Flow · Security Gates · Naming Conventions   ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

[![Policy](https://img.shields.io/badge/POLICY-ENFORCED-FF003C?style=for-the-badge&labelColor=0a0a0a)](./)
[![Security](https://img.shields.io/badge/SECURITY-GATE_ACTIVE-00FF9F?style=for-the-badge&labelColor=0a0a0a)](./)
[![Quarantine](https://img.shields.io/badge/QUARANTINE-LOCKED-FCEE0C?style=for-the-badge&labelColor=0a0a0a)](./)

</div>

---

## ⚡ Core Invariants

```
╔══════════════════════════════════════════════════════════════════════════════╗
║  THESE RULES ARE NON-NEGOTIABLE — READ BEFORE TOUCHING ANYTHING            ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

<div align="center">

| 🔴 Rule | 📋 Enforcement |
|:--------|:--------------|
| 🚪 **Single entry point** | Use this workspace root for ALL CP2077 UI/theme/kernel/module work |
| 🔗 **Preserve git history** | Keep large repos linked — do not flatten or inline their history |
| 📦 **Artifact placement** | Generated production ZIPs → `02-PRODUCTION/` or `03-BUILD/` only |
| 📱 **Device dumps** | Android device pulls → `04-ANDROID/device/` only |
| 🚫 **Quarantine rule** | Malformed/suspicious downloads → `10-QUARANTINE-invalid-downloads/` — **NEVER INSTALL** |
| 🔒 **No quarantine installs** | Do not flash, sideload, repackage, or run quarantined files |
| 🛡 **Source-only editing** | Never edit production symlinks directly — always go through source |

</div>

---

## 🔄 Development Flow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                     CYBERPUNK 2077 BUILD PIPELINE                           │
│                                                                             │
│   ┌────────────────┐    ┌──────────────┐    ┌──────────────────────────┐   │
│   │  01-DEVELOPMENT │ →  │   BUILD      │ →  │  02-PRODUCTION           │   │
│   │  repos/cyberpunk│    │  python3     │    │  magisk-modules/         │   │
│   │  CP2077-OP7Pro/ │    │  build.py    │    │  CP2077-OP7Pro-release/  │   │
│   └────────────────┘    └──────────────┘    └──────────────────────────┘   │
│                                  │                        │                 │
│                                  ▼                        ▼                 │
│                         ┌──────────────┐    ┌──────────────────────────┐   │
│                         │  99-MANIFESTS│    │  DEVICE FLASH            │   │
│                         │  checksums   │    │  adb push → Magisk       │   │
│                         │  inventory   │    │  flash → reboot          │   │
│                         └──────────────┘    └──────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Step-by-Step Protocol

```bash
# ── STEP 1: Edit source ──────────────────────────────────────────────────────
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/
# Make your changes here — never edit production symlinks directly

# ── STEP 2: Build ────────────────────────────────────────────────────────────
python3 build.py                    # all variants
python3 build.py --variant glitch   # single variant

# ── STEP 3: Link or promote outputs ──────────────────────────────────────────
# Built ZIPs appear in: 01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/release/
# Symlink or copy to:   02-PRODUCTION/magisk-modules/CP2077-OP7Pro-release/

# ── STEP 4: Regenerate manifests ─────────────────────────────────────────────
bash 99-MANIFESTS/generate-manifests.sh

# ── STEP 5: Verify and install ───────────────────────────────────────────────
sha256sum -c 99-MANIFESTS/production-artifact-sha256.txt
adb push 02-PRODUCTION/magisk-modules/CP2077-OP7Pro-release/CP2077-OP7Pro-v3.1.0.zip \
  /sdcard/Download/
# Then: Magisk → Modules → Install from storage → Reboot
```

---

## 🗂 Directory Ownership Rules

<div align="center">

| 📁 Directory | 🎯 Purpose | ✅ Allowed | ❌ Forbidden |
|:-------------|:----------|:---------|:-----------|
| `01-DEVELOPMENT/` | Source editing | Edit files, run builds | Deploy to device directly |
| `02-PRODUCTION/` | Release artifacts | Add verified ZIPs + symlinks | Edit source files here |
| `03-BUILD/` | Build workspace + upstream refs | Store raw assets | Flash to device |
| `04-ANDROID/` | Device-side dumps | ADB pulls, APK staging | Production ZIPs |
| `05-LINUX/` | Arch host scripts | Edit / run scripts | Device flash scripts |
| `06-UI-THEMES-ANIMATIONS/` | Visual + audio assets | Store final assets | Partial/broken files |
| `07-KERNEL-PACKAGE-MODULES/` | Kernels + modules | Reference only | Modify kernel source |
| `08-HACKING-RESEARCH/` | NetHunter / security | Research work | Production installs |
| `09-DOCS/` | Documentation | Write docs | Store binary files |
| `10-QUARANTINE-invalid-downloads/` | Corrupt files | Audit/inspection | Install anything |
| `99-MANIFESTS/` | Auto-generated snapshots | Read, regenerate | Manual edits |
| `releases/` | GitHub release metadata | Update JSON + changelogs | Host ZIP files |

</div>

---

## 🔐 Security Gates

```
╔══════════════════════════════════════════════════════════════════════════════╗
║  NEVER SKIP THESE CHECKS BEFORE FLASHING TO DEVICE                         ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

```bash
# ── 1. Verify ZIP integrity ───────────────────────────────────────────────────
python3 -m zipfile -t CP2077-OP7Pro-v3.1.0.zip

# ── 2. Check SHA-256 against manifest ────────────────────────────────────────
sha256sum -c 99-MANIFESTS/production-artifact-sha256.txt

# ── 3. Confirm it's not from quarantine ──────────────────────────────────────
# Source must be: 02-PRODUCTION/magisk-modules/ OR freshly built release/
# NEVER from:     10-QUARANTINE-invalid-downloads/

# ── 4. Validate bootanimation format ─────────────────────────────────────────
python3 -c "
import zipfile
z = zipfile.ZipFile('bootanimation.zip')
print('desc.txt:', z.read('desc.txt').decode())
frames = [n for n in z.namelist() if n.endswith('.png')]
print(f'Frames: {len(frames)}')
"
```

---

## 🏷 Naming Conventions

<div align="center">

| 📦 Artifact | 🔤 Pattern | 📝 Example |
|:-----------|:---------|:---------|
| Full Edition ZIP | `CP2077-OP7Pro-v<VER>.zip` | `CP2077-OP7Pro-v3.1.0.zip` |
| Universal ZIP | `CP2077-Universal-v<VER>.zip` | `CP2077-Universal-v1.0.0.zip` |
| Ultimate ZIP | `CP2077-OP7Pro-Ultimate-v<VER>.zip` | `CP2077-OP7Pro-Ultimate-v3.0.0.zip` |
| Version code | `MAJOR*100000 + MINOR*1000 + PATCH` | v3.1.0 → `301000` |
| Config file | `/data/cp2077.conf` | Always at this path |
| Update JSON | `releases/update-<edition>.json` | `update-full.json` |

</div>

---

## 🚫 Quarantine Reference

The following files in `10-QUARANTINE-invalid-downloads/` are **corrupted and must never be installed**:

<div align="center">

| 🚫 File | ❌ Actual Type | 🔒 Status |
|:--------|:-------------|:---------|
| `cp2077-livewallpaper-original.apk` | HTML document | Quarantined |
| `cp2077-livewallpaper-vivid.apk` | HTML document | Quarantined |
| `cp2077-bootanimation-stock-oos.zip` | Zero-byte file | Quarantined |
| `cp2077-bootanimation-mega.zip` | HTML document | Quarantined |

</div>

> ⚠️ These files were downloaded from unverified sources and masquerade as valid APKs/ZIPs.
> They exist in quarantine for audit purposes only.

---

## 📋 Version Bump Checklist

When bumping a module version, update **all** surfaces in one commit:

```
☐  build.py          — version constants, release filenames, banner strings
☐  module.prop       — version= and versionCode= fields  
☐  release/*.zip     — module.prop inside the final ZIP
☐  releases/update-*.json  — version, versionCode, zipUrl, checksum
☐  releases/CHANGELOG-*.md — new section with changes
☐  99-MANIFESTS/     — regenerate: bash 99-MANIFESTS/generate-manifests.sh
```

> ❌ Version drift across surfaces is a P0 bug. Never update some fields and not others.

---

<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════════╗
║  ⚡  THE RULES ARE THE IMPLANT — IGNORE THEM AND FLATLINE  ⚡               ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

[![Docs](https://img.shields.io/badge/Docs-09--DOCS%2FINDEX.md-FCEE0C?style=flat-square&labelColor=0a0a0a)](../09-DOCS/INDEX.md)
[![Status](https://img.shields.io/badge/Status-PRODUCTION__STATUS.md-00FF9F?style=flat-square&labelColor=0a0a0a)](PRODUCTION-STATUS.md)
[![README](https://img.shields.io/badge/Overview-README.md-00FFFF?style=flat-square&labelColor=0a0a0a)](../README.md)

</div>
