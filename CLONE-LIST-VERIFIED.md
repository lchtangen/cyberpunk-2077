# Verified Repositories to Clone

These repos are verified to exist and be actively maintained.

## Quick Clone Commands

```bash
# Magisk & Modules (verified)
git clone --depth 1 https://github.com/topjohnwu/Magisk /home/arch/dev/projects/cyberpunk-2077/01-DEVELOPMENT/repos/magisk-ecosystem/magisk-official-source
git clone --depth 1 https://github.com/Magisk-Modules-Repo/submission /home/arch/dev/projects/cyberpunk-2077/01-DEVELOPMENT/repos/magisk-ecosystem/magisk-modules-submission
git clone --depth 1 https://github.com/Zackptg5/Addon-Packages /home/arch/dev/projects/cyberpunk-2077/01-DEVELOPMENT/repos/magisk-ecosystem/addon-packages

# Plymouth Boot Themes (verified)
git clone --depth 1 https://github.com/TayMcKenzieNZ/Plymouth-Themes /home/arch/dev/projects/cyberpunk-2077/06-UI-THEMES-ANIMATIONS/repos/plymouth-themes-collection
git clone --depth 1 https://github.com/adi1090x/plymouth-themes /home/arch/dev/projects/cyberpunk-2077/06-UI-THEMES-ANIMATIONS/repos/adi1090x-plymouth-themes

# Comprehensive Themes (verified)
git clone --depth 1 https://github.com/dracula/dracula-theme /home/arch/dev/projects/cyberpunk-2077/06-UI-THEMES-ANIMATIONS/repos/dracula-theme
git clone --depth 1 https://github.com/catppuccin/catppuccin /home/arch/dev/projects/cyberpunk-2077/06-UI-THEMES-ANIMATIONS/repos/catppuccin-theme

# System Utilities (verified)
git clone --depth 1 https://github.com/busybox/busybox /home/arch/dev/projects/cyberpunk-2077/01-DEVELOPMENT/repos/system-utilities/busybox

# Windows Terminal (cross-platform terminal reference)
git clone --depth 1 https://github.com/microsoft/terminal /home/arch/dev/projects/cyberpunk-2077/06-UI-THEMES-ANIMATIONS/repos/windows-terminal
```

## What These Repos Provide

### Official Magisk Source
- Latest Magisk features
- Module API reference
- Magisk daemon source code
- Installation process documentation

### Magisk Modules Submission
- Official submission guidelines
- Module validation scripts
- Best practices documentation
- Repository structure examples

### Addon Packages
- Collection of useful Magisk module addon packages
- Utilities for module development
- Helper functions and frameworks

### Plymouth Themes
- Boot animation themes for Linux host
- Reference for splash screen customization
- 2 separate collections (TayMcKenzieNZ + adi1090x)

### Comprehensive Themes
- **Dracula:** Dark theme across multiple platforms
- **Catppuccin:** Modern, elegant color palette
Both useful for validating color schemes and cross-platform theming

### BusyBox
- Shell utilities used in Magisk modules
- Reference for script development
- Understanding available tools in modules

### Windows Terminal
- Cross-platform terminal theming reference
- Color scheme examples
- Modern UI reference

## Alternative: Manual Clone

If the above script fails, you can clone these manually:

```bash
cd /home/arch/dev/projects/cyberpunk-2077

# Magisk ecosystem
mkdir -p 01-DEVELOPMENT/repos/magisk-ecosystem
git clone --depth 1 https://github.com/topjohnwu/Magisk 01-DEVELOPMENT/repos/magisk-ecosystem/magisk-official-source
git clone --depth 1 https://github.com/Magisk-Modules-Repo/submission 01-DEVELOPMENT/repos/magisk-ecosystem/magisk-modules-submission
git clone --depth 1 https://github.com/Zackptg5/Addon-Packages 01-DEVELOPMENT/repos/magisk-ecosystem/addon-packages

# Theming
mkdir -p 06-UI-THEMES-ANIMATIONS/repos
git clone --depth 1 https://github.com/TayMcKenzieNZ/Plymouth-Themes 06-UI-THEMES-ANIMATIONS/repos/plymouth-themes-collection
git clone --depth 1 https://github.com/adi1090x/plymouth-themes 06-UI-THEMES-ANIMATIONS/repos/adi1090x-plymouth-themes
git clone --depth 1 https://github.com/dracula/dracula-theme 06-UI-THEMES-ANIMATIONS/repos/dracula-theme
git clone --depth 1 https://github.com/catppuccin/catppuccin 06-UI-THEMES-ANIMATIONS/repos/catppuccin-theme

# System utilities
mkdir -p 01-DEVELOPMENT/repos/system-utilities
git clone --depth 1 https://github.com/busybox/busybox 01-DEVELOPMENT/repos/system-utilities/busybox

# Terminal reference
git clone --depth 1 https://github.com/microsoft/terminal 06-UI-THEMES-ANIMATIONS/repos/windows-terminal
```

## Verified Repos Summary

| Name | Type | URL | Purpose |
|------|------|-----|---------|
| Magisk (Official) | Magisk | topjohnwu/Magisk | Official source + API reference |
| Magisk Modules Submission | Tool | Magisk-Modules-Repo/submission | Module validation |
| Addon Packages | Framework | Zackptg5/Addon-Packages | Module utilities |
| Plymouth Themes (2) | Theme | TayMcKenzieNZ/Plymouth-Themes, adi1090x/plymouth-themes | Boot animations |
| Dracula Theme | Theme | dracula/dracula-theme | Comprehensive theming |
| Catppuccin Theme | Theme | catppuccin/catppuccin | Color palette reference |
| BusyBox | Utility | busybox/busybox | Shell tools |
| Windows Terminal | Tool | microsoft/terminal | Terminal theming reference |

## Total

**8 verified repositories** providing:
- 1 core Magisk reference
- 2 module development utilities
- 3 theme/design assets
- 1 system utility
- 1 terminal reference

**Total disk space:** ~200-300 MB (much smaller than kernels)

## Next Step

Choose one of:
1. **Script approach:** Run the fixed script (will skip failures)
2. **Manual approach:** Copy/paste the clone commands above
3. **Selective:** Clone only what you need right now

All are equally valid. Recommend the manual approach if you want explicit control.

