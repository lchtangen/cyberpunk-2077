# 06-UI-THEMES-ANIMATIONS — User Interface Assets & Themes

Boot animations, shutdown animations, Linux desktop themes, wallpapers, and audio for the Cyberpunk 2077 Android module and Arch Linux host.

## Structure

- **`bootanimations/`** — Boot and shutdown animation ZIPs by module
  - `CP2077-OP7Pro-bootanimations/` → Symlink to source module
  - `CP2077-OP7Pro-shutdownanimations/` → Symlink to source module
  - `CP2077-Universal-bootanimations/` → Symlink to source module

- **`linux-boot/`** — Linux boot themes
  - `cp2077-linux-boot/` — Plymouth and GRUB theme (Cyberpunk animated boot screen)

- **`themes/`** — Desktop environment themes
  - `Cyberpunk-Neon` — KDE Plasma theme (submodule)
  - `K-DE-Cyberpunk-Neon` — Alternative KDE theme (submodule)
  - `cyberpunk-technotronic-icon-theme` — Icon theme (submodule)
  - `cp2077-linux-hud` — Custom HUD for Waybar, Eww, Hyprlock, Swaylock
  - `cyber-hyprland-theme` — Hyprland-specific theme
  - `cybrcolors`, `cybrland` — Color schemes and utilities

- **`wallpapers/`** — Background images
  - `Cyberpunk-Wallpapers/` — 35+ high-quality Cyberpunk-themed wallpapers

## Animation Variants

Each module supports multiple boot animation variants (stored in `01-DEVELOPMENT/repos/cyberpunk/`):

| Variant | FPS | Resolution | Style |
|---------|-----|-----------|-------|
| `glitch` | 60 | 1440×3120 | CP2077 logo glitch (recommended) |
| `flatline` | 60 | 1440×3120 | ECG flatline motif |
| `reboot` | 60 | 1440×3120 | OnePlus + glitch |
| `og1080p` | 30 | 1080×2340 | Authentic OP8T Cyberpunk SE |
| `og4k` | 30 | 2160×4800 | Upscaled version |

## Related Paths

- Source animations: `01-DEVELOPMENT/repos/cyberpunk/{CP2077-OP7Pro,CP2077-Universal}/bootanimation/`
- Release artifacts: `02-PRODUCTION/magisk-modules/`
- Audio (UI sounds): See `01-DEVELOPMENT/repos/cyberpunk/*/audio/ui/`

## Design Notes

- Animations use `ZIP_STORED` (no compression) for performance
- Themes are modular — each can be used independently
- Wallpapers support 16:9 and mobile aspect ratios
