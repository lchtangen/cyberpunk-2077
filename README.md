# CYBERPUNK 2077 ALL-IN-ONE

Single workspace for Cyberpunk 2077 UI/theme development, production assets, and device management on this Arch host.  
**Last updated:** 2026-05-13 · **Size:** 5.7 GB · **Files:** 8,877 · **Repos:** 16

---

## Active Device State

| Field | Value |
|---|---|
| Device | OnePlus 7 Pro `GM1911` (guacamole) |
| Display | 1440×3120 |
| Android | API 36 |
| Magisk | 30.7 |
| Active module | `CP2077_OP7Pro_Full` v3.0.0 |
| Active variant | `CyberGlitch-2077` (glitch, 60 fps) |
| Previous module | `CP2077_OP7Pro_Ultimate` — disabled, not deleted |

---

## Directory Layout

| Dir | Purpose |
|---|---|
| `00-CONTROL` | Workspace policy, production status, operating notes |
| `01-DEVELOPMENT` | Source repositories (modules, themes, kernels) |
| `02-PRODUCTION` | Release zips and Magisk module outputs |
| `03-BUILD` | Build workspace and upstream reference modules |
| `04-ANDROID` | Device snapshot (sdcard), APKs, ARM64 archives |
| `05-LINUX` | Arch host scripts and Linux-side assets |
| `06-UI-THEMES-ANIMATIONS` | Boot/shutdown animations, themes, wallpapers |
| `07-KERNEL-PACKAGE-MODULES` | Kernel sources, patched boot images |
| `08-HACKING-RESEARCH` | NetHunter/security research repos |
| `09-DOCS` | Full documentation index |
| `10-QUARANTINE-invalid-downloads` | Files that must NOT be installed |
| `99-MANIFESTS` | Generated inventories and checksums |

---

## Repository Index

### Primary Modules (local dev)

| Module | Version | Path |
|---|---|---|
| `CP2077_OP7Pro_Full` | v3.0.0 | `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/` |
| `CP2077_OP7Pro_Ultimate` | v3.0.0 | `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro-Ultimate/` |

### Upstream Reference — Bootanimation Modules

| Repo | Author | Path |
|---|---|---|
| GlitchedCyberBoot | Magisk-Modules-Alt-Repo | `01-DEVELOPMENT/repos/cyberpunk/GlitchedCyberBoot/` |
| ONEPLUS9-OOS13-BootAnimation | sodasoba1 | `01-DEVELOPMENT/repos/cyberpunk/ONEPLUS9-OOS13-BootAnimation/` |
| CyberPunk-2077-OOS13-Modded-Boot-and-Shutdown-Animation | sodasoba1 | `03-BUILD/artifacts/cyberpunk-build/CyberPunk-2077-OOS13-…/` |
| Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO | ENEIZEM | `03-BUILD/artifacts/cyberpunk-build/Magisk-Module-…-POCO/` |

### Android UI / Icon Packs

| Repo | Author | Path |
|---|---|---|
| AndroidCyberpankIcons | privatgt | `01-DEVELOPMENT/repos/cyberpunk/AndroidCyberpankIcons/` |

### Linux Themes

| Repo | Author | Covers | Path |
|---|---|---|---|
| Cyberpunk-Neon | Roboron3042 | KDE, GTK, Sway, Waybar, Rofi, terminal, Vim, Telegram | `06-UI-THEMES-ANIMATIONS/themes/Cyberpunk-Neon/` |
| K-DE-Cyberpunk-Neon | UtkarshKunwar | KDE Plasma, Konsole, Plymouth, Neovim, Chrome | `06-UI-THEMES-ANIMATIONS/themes/K-DE-Cyberpunk-Neon/` |
| cyber-hyprland-theme | taylor85345 | Hyprland, eww widgets, Rofi, foot terminal | `06-UI-THEMES-ANIMATIONS/themes/cyber-hyprland-theme/` |
| cybrland | scherrer-txt | Full Arch dotfiles — Hyprland, Waybar, kitty, nvim, fish | `06-UI-THEMES-ANIMATIONS/themes/cybrland/` |
| cybrcolors | scherrer-txt | Cyberpunk color palette / design tokens | `06-UI-THEMES-ANIMATIONS/themes/cybrcolors/` |
| cyberpunk-technotronic-icon-theme | dreifacherspass | SVG icon theme, blue-purple gradient | `06-UI-THEMES-ANIMATIONS/themes/cyberpunk-technotronic-icon-theme/` |

### Wallpapers

| Repo | Author | License | Path |
|---|---|---|---|
| cybrpapers | scherrer-txt | CC0 | `06-UI-THEMES-ANIMATIONS/wallpapers/cybrpapers/` |
| Cyberpunk-Wallpapers | local | — | `06-UI-THEMES-ANIMATIONS/wallpapers/Cyberpunk-Wallpapers/` |

### Kernels — OnePlus 7 Pro / SM8150

| Repo | Author | Notes | Path |
|---|---|---|---|
| blu-spark-kernel-op7 | engstk | CAF 4.14, OP7/T/Pro, --depth 1 | `07-KERNEL-PACKAGE-MODULES/kernel/blu-spark-kernel-op7/` |
| neptune-kernel-sm8150 | 0wnerDied | CAF/CLO QSSI14.0, --depth 1 | `07-KERNEL-PACKAGE-MODULES/kernel/neptune-kernel-sm8150/` |
| kernelsu-lineageos-guacamole | surfaceocean | KernelSU pre-built for OP7 Pro + LineageOS | `07-KERNEL-PACKAGE-MODULES/kernel/kernelsu-lineageos-guacamole/` |
| oneplus-7-pro-lineage-kernel-sm8150 | LineageOS | Official LineageOS SM8150 kernel | `07-KERNEL-PACKAGE-MODULES/kernel/oneplus-7-pro-lineage-kernel-sm8150/` |

---

## Key Paths

| What | Path |
|---|---|
| Full Edition source | `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/` |
| Ultimate source | `01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro-Ultimate/` |
| Production releases | `02-PRODUCTION/magisk-modules/` |
| Upstream reference modules | `03-BUILD/artifacts/cyberpunk-build/` |
| Boot animations (sorted) | `06-UI-THEMES-ANIMATIONS/animations/` |
| All themes | `06-UI-THEMES-ANIMATIONS/themes/` |
| Wallpapers | `06-UI-THEMES-ANIMATIONS/wallpapers/` |
| Kernel sources | `07-KERNEL-PACKAGE-MODULES/kernel/` |
| Device sdcard snapshot | `04-ANDROID/device/sdcard-Download/Download/` |

---

## Building

```bash
# Full Edition
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro
python3 build.py

# Ultimate All-In-One
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro-Ultimate
python3 build-ultimate.py
```

## Switching Variants on Device

```bash
# Edit config and reflash
su -c 'echo "variant=flatline" > /data/cp2077.conf'
# then reflash the module zip via Magisk Manager

# Or use the Ultimate config tool
su -c /data/adb/modules/CP2077_OP7Pro_Ultimate/cp2077-config.sh
```

## Update All Repos

```bash
for r in $(find . -name '.git' -not -path '*/.git/.git' | sed 's|/.git||'); do
  echo "→ $r"
  git -C "$r" pull --ff-only 2>&1 | grep -v '^Already'
done
```

---

## Do NOT Install (Quarantined)

| File | Reason |
|---|---|
| `cp2077-livewallpaper-original.apk` | HTML document, not APK |
| `cp2077-livewallpaper-vivid.apk` | HTML document, not APK |
| `cp2077-bootanimation-stock-oos.zip` | Zero bytes |
| `cp2077-bootanimation-mega.zip` | HTML document, not ZIP |

All quarantined files are in `10-QUARANTINE-invalid-downloads/` for audit visibility only.

---

## Documentation

- [`09-DOCS/INDEX.md`](09-DOCS/INDEX.md) — Full docs index
- [`09-DOCS/REPOS.md`](09-DOCS/REPOS.md) — Detailed repo catalogue
- [`09-DOCS/INSTALLATION-GUIDE.md`](09-DOCS/INSTALLATION-GUIDE.md) — Flash guide
- [`09-DOCS/VARIANTS.md`](09-DOCS/VARIANTS.md) — Animation variants
- [`09-DOCS/BUILD-GUIDE.md`](09-DOCS/BUILD-GUIDE.md) — Build instructions
- [`09-DOCS/DEVICE-SPECS.md`](09-DOCS/DEVICE-SPECS.md) — Hardware / ROM compat
- [`09-DOCS/TROUBLESHOOTING.md`](09-DOCS/TROUBLESHOOTING.md) — Common fixes
- [`99-MANIFESTS/git-repositories.txt`](99-MANIFESTS/git-repositories.txt) — All repos with remotes
- [`00-CONTROL/PRODUCTION-STATUS.md`](00-CONTROL/PRODUCTION-STATUS.md) — Current device state
