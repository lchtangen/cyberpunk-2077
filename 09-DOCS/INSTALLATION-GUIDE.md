# Installation Guide — Cyberpunk 2077 Full Edition

**Module:** `CP2077_OP7Pro_Full` · **Version:** v3.0.0  
**Target:** OnePlus 7 Pro (`GM1911` / guacamole) · **Display:** 1440×3120  
**Android:** 14–16+ (API 34–36) · **Magisk:** 20400+

---

## Requirements

| Requirement | Minimum |
|---|---|
| Device | OnePlus 7 Pro (guacamole / GM1911) |
| Android | 14 (API 34) |
| Magisk | 20.4 (20400) |
| ROM | AOSP · LineageOS · yaap · OOS 14+ |
| Storage | ~50 MB free on /data |

---

## Quick Install

1. Copy the module ZIP to your device:
   ```
   adb push 02-PRODUCTION/magisk-modules/CP2077-OP7Pro-release/CP2077-OP7Pro-v3.0.0.zip /sdcard/Download/
   ```
2. Open **Magisk → Modules → Install from storage**.
3. Select the ZIP — the interactive installer launches.
4. Choose your boot animation variant (see [VARIANTS.md](VARIANTS.md)).
5. Choose whether to install the CP2077 audio pack.
6. Flash completes → **Reboot**.

---

## Installer Prompts

The `customize.sh` installer runs inside Magisk recovery. It reads
`/data/cp2077.conf` on re-installs to restore your previous selection.

```
[1] CyberGlitch-2077    — glitch logo, 60 fps  ← recommended
[2] Cyberpunk-Flatline  — flatline style, 60 fps
[3] Re-Boot Animation   — OP logo + glitch, 60 fps
[4] Original 1080p      — 8T SE port, 30 fps
```

Audio prompt:
```
[Y] Install CP2077 UI sounds (lock, unlock, charging, camera, tick)
[N] Keep stock audio
```

---

## Installed File Locations

After flashing, the module mounts files at:

| File | Path |
|---|---|
| Boot animation | `/product/media/bootanimation.zip` |
| Boot anim (dark) | `/product/media/bootanimation-dark.zip` |
| Shutdown animation | `/product/media/shutdownanimation.zip` |
| Reboot animation | `/product/media/rbootanimation.zip` |
| UI sounds | `/product/media/audio/ui/*.ogg` |
| OOS compat copy | `/my_product/media/` (auto-detected) |

Config is saved to `/data/cp2077.conf` for future updates.

---

## Uninstall

Remove `CP2077_OP7Pro_Full` from **Magisk → Modules** and reboot.  
The `uninstall.sh` script cleans `/data/cp2077.conf` automatically.

---

## ADB Sideload (no Magisk UI)

```bash
adb push CP2077-OP7Pro-v3.0.0.zip /sdcard/Download/
# Then install via Magisk app → Modules → Install from storage
```

---

## Do Not Install

The following files in `10-QUARANTINE-invalid-downloads/` are **corrupt** and
must not be flashed:

| File | Reason |
|---|---|
| `cp2077-livewallpaper-original.apk` | HTML document, not APK |
| `cp2077-livewallpaper-vivid.apk` | HTML document, not APK |
| `cp2077-bootanimation-stock-oos.zip` | Zero bytes |
| `cp2077-bootanimation-mega.zip` | HTML document, not ZIP |

---

## Related Docs

- [VARIANTS.md](VARIANTS.md) — animation variant details and previews
- [BUILD-GUIDE.md](BUILD-GUIDE.md) — rebuild or customize the module
- [TROUBLESHOOTING.md](TROUBLESHOOTING.md) — fix common issues
- [../00-CONTROL/PRODUCTION-STATUS.md](../00-CONTROL/PRODUCTION-STATUS.md) — current device state
