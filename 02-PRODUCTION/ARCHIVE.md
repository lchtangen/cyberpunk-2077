# 🗂 02-PRODUCTION Archive — Outdated & Deprecated Artifacts

> **Last updated:** 2026-05-16
>
> This file documents artifacts that have been **archived, superseded, or quarantined** in the `02-PRODUCTION/magisk-modules/` directory.
> These items are no longer suitable for installation on the OnePlus 7 Pro running Android 16.

---

## 🚫 Removed / Broken Symlinks (v2.0.0 Beta Era)

These symlinks pointed to v2.0.0 beta artifacts that no longer exist on disk.
They were removed from the production staging area on 2026-05-16.

| Symlink | Target (broken) | Reason Archived |
|:--------|:----------------|:----------------|
| `device-beta-fix-applied` | `04-ANDROID/device/sdcard-Download/Download/cp2077-beta-fix` | v2.0.0 beta patch — superseded by v3.0.0 full audit |
| `device-copy-CP2077-OP7Pro-v2.0.0-beta.zip` | `.../Download/CP2077-OP7Pro-v2.0.0-beta.zip` | Beta build — superseded by v3.1.0 |
| `device-copy-CP2077-OP7Pro-v2.0.0-ultimate-all-in-one.zip` | `.../Download/CP2077-OP7Pro-v2.0.0-ultimate-all-in-one.zip` | v2.0.0 Ultimate — superseded by v3.0.0 Ultimate |

**Action taken:** Symlinks removed via `git rm`. The v3.x release series (v3.0.0, v3.1.0) completely supersedes all v2.x builds.

---

## ⚠️ Invalid LineageOS ROM Stubs

These files in `magisk-modules/` are **HTML "Not Found" error pages** masquerading as ZIP files —
they are not real ROM ZIPs. They were incorrectly staged here during device setup.

| File | Actual Content | Size | Status |
|:-----|:--------------|:-----|:-------|
| `lineage-22.1.zip` | HTML 404 page | ~1 KB | ❌ Invalid — not a ROM |
| `lineage-23.2.zip` | HTML 404 body | 9 bytes | ❌ Invalid — not a ROM |

**Action taken:** Moved to `10-QUARANTINE-invalid-downloads/` or removed.
Real LineageOS 23.2 ROM must be downloaded from [download.lineageos.org](https://download.lineageos.org/devices/guacamole).

---

## 🗃 Kernel Images — SurfaceOcean LOS 21 (surfaceocean-los21/)

These are partition images from the SurfaceOcean pre-built KernelSU+LineageOS 21 build.

| File | Purpose | Status |
|:-----|:--------|:-------|
| `surfaceocean-los21/dtbo.img` | Device Tree Blob Overlay | 🗃 Reference only |
| `surfaceocean-los21/vbmeta.img` | Verified Boot Metadata | 🗃 Reference only |

**Status:** Archived — LOS 21 (Android 14) images. The active target is **LOS 23.2 (Android 16)**.
These images are not compatible with LOS 23.2 builds without a full flash cycle.
Reference source: `surfaceocean/kernelsu_oneplus_7_pro_lineageos_guacamole` v20251215.

> ⚠️ Full flash required when switching to a different LineageOS major version:
> `boot.img` + `dtbo.img` + `vbmeta.img` + lineage ZIP. Kernel-only swap breaks Wi-Fi and audio on guacamole.

---

## ✅ Active Production Symlinks (Current)

These symlinks remain active and point to valid module release directories:

| Symlink | Target | Module Version | Status |
|:--------|:-------|:--------------|:-------|
| `CP2077-OP7Pro-release` | `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/release/` | v3.1.0 | ✅ Active |
| `CP2077-OP7Pro-Ultimate-release` | `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro-Ultimate/release/` | v3.0.0 | ⚪ Disabled |
| `CP2077-Universal-release` | `01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal/release/` | v1.0.0 | 🟡 Built |

---

## 📋 Archive Policy

- **v2.x builds**: All v2.x artifacts are archived. The v2.x codebase lacked the prop-poll Android 16 fix,
  the multi-path mount engine, and the SELinux `sepolicy.rule`. Do not install on Android 16.
- **Beta ZIPs**: Never flash beta ZIPs on the production device without first verifying SHA-256 against `sources.lock.json`.
- **LOS 21 kernel images**: Only compatible with the LOS 21 (Android 14) SurfaceOcean build.
  Do not use with LOS 23.2 or Android 16.
