# Changelog

## v3.0.0 (2026-05-13)
### Workspace Merge & Upgrade
- **Unified workspace**: all sources consolidated under numbered directory structure
- **customize.sh**: merged Full+Ultimate logic — config-file support, OOS my_product path, modular functions
- **post-fs-data.sh**: upgraded to multi-path mount engine (covers AOSP, LineageOS, OOS, yaap)
- **service.sh**: replaced fixed-path checks with size-threshold remount helper
- **uninstall.sh**: now cleans /data/local and /data/misc/bootanim paths too
- **META-INF/update-binary**: fixed undefined variable bugs, standard Magisk trampoline
- **module.prop**: broadened androidApi=26 (was 36), version bumped to v3.0.0
- **build.py**: upgraded with parallel variant builds and proper metadata embedding
- **update.json**: bumped to v3.0.0

## v2.0.0-beta (2026-05-13)
### Initial Public Beta Release
- Boot animation: 3 variants + original at 1440×3120 (OP7 Pro native)
  - CyberGlitch-2077 (glitch logo, 60fps)
  - Cyberpunk-Flatline-2077 (flatline style, 60fps)
  - Re-Boot Animation (OP logo + glitch, 60fps)
  - Original 1080p (8T SE port, 30fps)
- Shutdown animation: color-matched for all 3 main variants
- Audio: CP2077-themed lock/unlock, charging, camera, and UI sounds
- Installer: interactive variant selection via customize.sh
- Compatibility: Android 16 (API 36) — OnePlus 7 Pro (guacamole)
- Paths: automatic detection for AOSP (/product/media) and OOS (/my_product/media)

Previous releases: N/A (initial)
