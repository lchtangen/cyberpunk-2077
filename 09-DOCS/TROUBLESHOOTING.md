# Troubleshooting

---

## Boot Animation Issues

### Animation does not play — shows stock animation

**Cause:** Wrong mount path for the ROM type.

**Fix:**
1. Open a root shell: `adb shell su`
2. Check which path your ROM uses:
   ```bash
   ls /product/media/bootanimation.zip    # AOSP / LineageOS / yaap
   ls /my_product/media/bootanimation.zip # OOS 14+
   ```
3. If neither exists, the module did not mount correctly — re-flash.
4. Force the OOS path: edit `/data/cp2077.conf` and add `oos=yes`, then reboot.

---

### Animation plays once then freezes on logo

**Cause:** Corrupted `bootanimation.zip` or mismatched resolution in `desc.txt`.

**Fix:**
1. Pull the installed file:
   ```bash
   adb pull /product/media/bootanimation.zip /tmp/
   ```
2. Inspect `desc.txt` inside the ZIP — first line must be `1440 3120 60`.
3. Re-flash from a known-good source in `06-UI-THEMES-ANIMATIONS/animations/`.

---

### Shutdown animation missing

**Cause:** Variant selected does not include a shutdown animation (e.g., Original 1080p).

**Fix:** Re-flash and select glitch, flatline, or reboot variant instead.

---

## Audio Issues

### CP2077 sounds not playing

**Cause:** Audio files not mounted to both `/product/media/audio/ui/` and `/media/audio/ui/`.

**Fix:**
```bash
adb shell su -c "ls /product/media/audio/ui/"
adb shell su -c "ls /media/audio/ui/"
```
If missing from either path, re-flash with audio enabled (`audio=yes` in config).

---

### Charging sound plays twice

**Cause:** Both `ChargingStarted.ogg` and `WirelessChargingStarted.ogg` are mounted; system plays both on wired connect on some OOS builds.

**Fix (OOS only):** Remove `WirelessChargingStarted.ogg` from `/product/media/audio/ui/` via root shell.

---

## Module Fails to Install

### "Installation failed" in Magisk

1. Check Magisk version: must be ≥ 20.4.
2. Check Android API: must be ≥ 26 (Android 8+).
3. Check device model: `adb shell getprop ro.product.model` must return `OnePlus 7 Pro`.
4. Check available storage: `/data` needs ~50 MB free.

---

### "customize.sh: syntax error"

Cause: Magisk is running a very old busybox shell.

Fix: Update Magisk to the latest stable release.

---

## ADB / Sideload Issues

### `adb push` fails — permission denied

```bash
adb shell su -c "chmod 777 /sdcard/Download"
adb push CP2077-OP7Pro-v3.0.0.zip /sdcard/Download/
```

---

### Device not detected

```bash
adb kill-server && adb start-server
adb devices
# Enable USB Debugging in Developer Options if not listed
```

---

## Config File

Location: `/data/cp2077.conf`

```
variant=glitch        # glitch | flatline | reboot | og1080p
audio=yes             # yes | no
oos=auto              # auto | yes | no
```

Delete this file and re-flash to reset to default interactive installer behavior.

---

## Known Limitations

| Limitation | Status |
|---|---|
| Live wallpaper APK | Not available — requires OP8T firmware extraction |
| Icon pack overlay | Not yet bundled |
| Fingerprint animation | OOS-based ROMs only |
| Bootloader splash | Requires manual `fastboot flash` — see `05-LINUX/` |
| Quarantined APKs | `cp2077-livewallpaper-*.apk` are HTML, not valid APKs |

---

## Log Collection

```bash
# Magisk module install log
adb logcat -d | grep -i "cp2077\|magisk\|bootanim" > cp2077-debug.log

# Module mount status
adb shell su -c "magisk --list"
adb shell su -c "ls -la /product/media/"
```

Attach `cp2077-debug.log` when reporting issues.
