# Workspace Policy

## Rules

- Use this folder as the single entry point for Cyberpunk UI/theme/kernel/module work.
- Keep large repositories linked so their git history remains intact.
- Keep generated production artifacts under `02-PRODUCTION` or `03-BUILD`.
- Keep Android device pulls under `04-ANDROID/device`.
- Keep suspicious or malformed downloads under `10-QUARANTINE-invalid-downloads`.
- Do not install quarantined APK/ZIP files.

## Development Flow

1. Edit source through `01-DEVELOPMENT/repos/...`.
2. Build into the source repo's release/build folder.
3. Link or place production outputs under `02-PRODUCTION`.
4. Regenerate manifests in `99-MANIFESTS`.
5. Install only verified OnePlus 7 Pro artifacts.
