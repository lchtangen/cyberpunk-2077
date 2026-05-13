# Animation Variants

All variants are pre-scaled to **1440×3120** (OnePlus 7 Pro native resolution).

---

## Boot Animation Variants

### 1. CyberGlitch-2077 ⚡ *(Active / Recommended)*
- **Style:** Glitch-effect logo with neon cyan/yellow color palette
- **FPS:** 60
- **Resolution:** 1440×3120
- **Source:** sodasoba1 — OOS 13 modded
- **Shutdown match:** Yes (`glitch/shutdownanimation.zip`)
- **Notes:** Best visual match to the OP8T Cyberpunk Edition hardware theme

### 2. Cyberpunk-Flatline-2077
- **Style:** Flatline ECG motif with CP2077 color grade
- **FPS:** 60
- **Resolution:** 1440×3120
- **Shutdown match:** Yes (`flatline/shutdownanimation.zip`)
- **Notes:** Subtle, cinematic feel

### 3. Re-Boot Animation
- **Style:** OnePlus logo with glitch transition overlay
- **FPS:** 60
- **Resolution:** 1440×3120
- **Shutdown match:** Yes (`reboot/shutdownanimation.zip`)
- **Notes:** Closest to stock OP boot feel with CP2077 flair

### 4. Original 1080p (8T SE Port)
- **Style:** Original OnePlus 8T Cyberpunk Special Edition animation
- **FPS:** 30
- **Resolution:** 1080p (upscaled)
- **Shutdown match:** No (none included)
- **Notes:** Authentic source material; lower fps/res than native variants

### 5. OG 4K *(development asset)*
- **Style:** 4K source variant
- **FPS:** 60
- **Resolution:** 4K (downscaled at install time)
- **Location:** `06-UI-THEMES-ANIMATIONS/animations/CP2077-OP7Pro-bootanimations/og4k/`
- **Notes:** Not included in module ZIP by default; requires manual build step

---

## Shutdown Animation Variants

| Variant | File | Reboot Animation |
|---|---|---|
| glitch | `glitch/shutdownanimation.zip` | Same file → `rbootanimation.zip` |
| flatline | `flatline/shutdownanimation.zip` | Same file → `rbootanimation.zip` |
| reboot | `reboot/shutdownanimation.zip` | Same file → `rbootanimation.zip` |

---

## Audio Pack — CP2077 UI Sounds

Installed to `/product/media/audio/ui/` and `/media/audio/ui/`:

| File | Replaces |
|---|---|
| `Lock.ogg` | Screen lock sound |
| `Unlock.ogg` | Screen unlock sound |
| `ChargingStarted.ogg` | Wired charging connect |
| `WirelessChargingStarted.ogg` | Wireless charging connect |
| `camera_click.ogg` | Camera shutter |
| `camera_focus.ogg` | Camera autofocus |
| `Effect_Tick.ogg` | UI tick / selection |

---

## Switching Variants After Install

Re-flash the module ZIP and select a new variant at the installer prompt.
The previous selection is loaded from `/data/cp2077.conf` as a default.

Or manually edit `/data/cp2077.conf`:
```
variant=glitch   # glitch | flatline | reboot | og1080p
audio=yes        # yes | no
```
Then reboot — the `post-fs-data.sh` hook re-applies the selected variant on boot.

---

## Asset Locations in This Workspace

```
06-UI-THEMES-ANIMATIONS/
├── animations/
│   ├── CP2077-OP7Pro-bootanimations/
│   │   ├── flatline/bootanimation.zip
│   │   ├── glitch/bootanimation.zip
│   │   ├── og1080p/bootanimation.zip
│   │   ├── og4k/bootanimation.zip
│   │   └── reboot/bootanimation.zip
│   └── CP2077-OP7Pro-shutdownanimations/
│       ├── flatline/shutdownanimation.zip
│       ├── glitch/shutdownanimation.zip
│       └── reboot/shutdownanimation.zip
├── themes/
│   ├── CP2077-splash-assets/                   — boot splash PNGs
│   ├── CP2077-system-audio/ui/                 — .ogg audio files
│   ├── Cyberpunk-Neon/                         — KDE/GTK/Sway/terminal
│   ├── K-DE-Cyberpunk-Neon/                    — KDE + Plymouth
│   ├── cyber-hyprland-theme/                   — Hyprland + eww + Rofi
│   ├── cybrland/                               — Full Arch dotfiles
│   ├── cybrcolors/                             — Color palette tokens
│   └── cyberpunk-technotronic-icon-theme/      — Icon theme (SVG)
└── wallpapers/
    ├── Cyberpunk-Wallpapers/                   — AI-gen + curated (JPEG/PNG/WebP)
    └── cybrpapers/                             — Hand-crafted CC0 collection
```

---

## Upstream Source Repos (Animation Reference)

| Repo | Location | What It Contributes |
|---|---|---|
| `sodasoba1/CyberPunk-2077-OOS13-Modded-Boot-and-Shutdown-Animation` | `03-BUILD/artifacts/cyberpunk-build/CyberPunk-2077-OOS13-…/` | Source of glitch + flatline animation frames used in OP7 Pro port |
| `Magisk-Modules-Alt-Repo/GlitchedCyberBoot` | `01-DEVELOPMENT/repos/cyberpunk/GlitchedCyberBoot/` | Alternative glitch variant; OOS `my_product/media` path format |
| `sodasoba1/ONEPLUS9-OOS13-BootAnimation` | `01-DEVELOPMENT/repos/cyberpunk/ONEPLUS9-OOS13-BootAnimation/` | Higher-resolution source frames from OP9 OOS13 |
| `ENEIZEM/Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO` | `03-BUILD/artifacts/cyberpunk-build/Magisk-Module-…-POCO/` | POCO-targeted module; splash screen reference |
