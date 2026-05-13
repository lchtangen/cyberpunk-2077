# Build Guide — CP2077 OP7 Pro Module

How to rebuild, modify, or re-package the Magisk module from source.

---

## Source Tree

```
01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/
├── audio/ui/           — CP2077 .ogg sound files
├── bootanimation/      — variant ZIPs (flatline, glitch, og1080p, reboot)
├── shutdownanimation/  — variant ZIPs (flatline, glitch, reboot)
├── splash/             — boot splash and about-phone PNGs
├── META-INF/           — Magisk installer scripts
├── customize.sh        — interactive variant installer
├── post-fs-data.sh     — config-driven boot hook
├── service.sh          — late-start service hook
├── uninstall.sh        — cleanup script
├── module.prop         — module metadata
├── build.py            — build script
└── release/            — output ZIPs
```

---

## Prerequisites

```bash
# Arch Linux host
sudo pacman -S python zip unzip android-tools
```

---

## Build the Module ZIP

```bash
cd 01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro
python build.py
```

Output lands in `release/CP2077-OP7Pro-v<version>.zip`.

The build script:
1. Validates all animation and audio assets exist
2. Assembles the Magisk module directory structure
3. Packages into a flashable ZIP with `zip -r`
4. Prints SHA-256 of the output

---

## Build Variants

```bash
python build.py --variant glitch      # single variant, smaller ZIP
python build.py --all                 # all variants (megapack)
python build.py --no-audio            # skip audio pack
```

---

## Adding a New Animation Variant

1. Place assets:
   ```
   bootanimation/<name>/bootanimation.zip
   shutdownanimation/<name>/shutdownanimation.zip   # optional
   ```
2. Register the variant in `customize.sh` (add to the selection menu and
   `install_bootanimation` / `install_shutdownanimation` calls).
3. Rebuild: `python build.py`.

Animation ZIP format (standard Android):
```
bootanimation.zip
└── desc.txt          — "1440 3120 60" (width height fps)
└── part0/            — frame PNGs (frame001.png …)
└── part1/            — optional loop section
```

---

## Updating module.prop

```
id=CP2077_OP7Pro_Full
name=Cyberpunk 2077 Full Edition — OnePlus 7 Pro
version=v3.0.0
versionCode=300000
author=lchtangen
minMagisk=20400
androidApi=26
```

Bump `version` and `versionCode` before every release. `versionCode` format: `MAJOR*100000 + MINOR*1000 + PATCH`.

---

## Regenerate Manifests

After any build or asset change, update the workspace manifests:

```bash
cd /home/arch/cyberpunk-2077

# SHA-256 of production artifacts
sha256sum 02-PRODUCTION/magisk-modules/**/*.zip > 99-MANIFESTS/production-artifact-sha256.txt

# Full artifact inventory
find . -type f -not -path '*/.git/*' \
  | sort \
  | awk '{print NR"\t"$0}' \
  > 99-MANIFESTS/artifact-inventory.tsv

# Directory map
find . -type d -not -path '*/.git/*' | sort > 99-MANIFESTS/directory-map.txt

# Workspace size
du -sh . > 99-MANIFESTS/workspace-size.txt
```

---

## Third-Party Source Modules

Two upstream Magisk modules are preserved in `03-BUILD/artifacts/cyberpunk-build/`
as reference source material. Do not flash these directly to OP7 Pro — they
target different devices.

| Module | Target | Author |
|---|---|---|
| `CyberPunk-2077-OOS13-Modded-Boot-and-Shutdown-Animation` | OOS 13 generic | sodasoba1 |
| `Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO` | POCO devices | ENEIZEM |

---

## Release Checklist

- [ ] Bump `version` and `versionCode` in `module.prop`
- [ ] Update `CHANGELOG.md` with changes
- [ ] Run `python build.py --all` and verify output ZIP
- [ ] SHA-256 hash the release ZIP and record in `99-MANIFESTS/`
- [ ] Push to device via ADB, test all variants
- [ ] Update `00-CONTROL/PRODUCTION-STATUS.md` with verified state
- [ ] Tag commit: `git tag v3.0.0`
