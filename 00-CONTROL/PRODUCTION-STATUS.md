# Production Status

## Installed Device State

- Device: OnePlus 7 Pro `GM1911`
- Android: API `36`
- Magisk: `30.7`
- Active module: `CP2077_OP7Pro_Full` v3.0.0
- Active variant: `CyberGlitch-2077`
- Previous Ultimate module: disabled, not deleted

## Verified Active Files (on-device)

- `/product/media/bootanimation.zip`
- `/product/media/bootanimation-dark.zip`
- `/product/media/shutdownanimation.zip`
- `/product/media/rbootanimation.zip`
- `/product/media/audio/ui/*.ogg`
- `/data/local/bootanimation.zip` (multi-path fallback)
- `/data/misc/bootanim/bootanimation.zip` (LineageOS path)

Boot and shutdown files were verified after reboot against CP2077 Full v3.0.0 checksums.

## Workspace Merge (2026-05-13)

All root-level directories consolidated into numbered structure:
- `CP2077-OP7Pro/` → `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/`
- `CP2077-OP7Pro-Ultimate/` → `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro-Ultimate/`
- `cyberpunk-build/` → `03-BUILD/artifacts/cyberpunk-build/`
- `Cyberpunk-Wallpapers/` → `06-UI-THEMES-ANIMATIONS/wallpapers/Cyberpunk-Wallpapers/`

All modules upgraded to v3.0.0.

## Module Inventory

| Module ID             | Version | Path                                     | Status  |
|-----------------------|---------|------------------------------------------|---------|
| CP2077_OP7Pro_Full    | v3.0.0  | `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro`          | active  |
| CP2077_OP7Pro_Ultimate| v3.0.0  | `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro-Ultimate` | disabled|
| CP2077_Universal      | v1.0.0  | `01-DEVELOPMENT/repos/cyberpunk/CP2077-Universal`       | dev     |
| GlitchedCyberBoot     | 1.1     | `01-DEVELOPMENT/repos/cyberpunk/GlitchedCyberBoot`      | ref     |

CP2077-Universal: all-device build, auto-detects ROM and resolution. Supports Magisk 20.4+, KernelSU, APatch. Min API 21.

## Known Bad Artifacts (quarantined)

- `cp2077-livewallpaper-original.apk`: HTML document, not APK — in `10-QUARANTINE`
- `cp2077-livewallpaper-vivid.apk`: HTML document, not APK — in `10-QUARANTINE`
- `cp2077-bootanimation-stock-oos.zip`: zero bytes — in `10-QUARANTINE`
- `cp2077-bootanimation-mega.zip`: HTML document, not real zip — in `10-QUARANTINE`

## Audit — 2026-05-13

- Workspace symlinks: all fixed (hightech-repos → repos path migration complete)
- Quarantine symlinks: relinked to `03-BUILD/artifacts/cyberpunk-build/`
- 02-PRODUCTION: symlink-based layout, all 6 symlinks resolve correctly
- Repo health: CP2077-OP7Pro has no remote (local dev only); kernel repos show large dirty counts (expected — shallow clone of full source tree)
- CP2077-Universal documented and added to manifests
