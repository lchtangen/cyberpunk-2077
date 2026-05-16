#!/bin/bash
#
# Clone GitHub repositories useful for CP2077 OP7 Pro + LineageOS 23.2 + Android 16
# Organization: Follows workspace directory structure from CLAUDE.md
#
# Usage: bash clone-repos.sh [--dry-run]
#

set -euo pipefail

WORKSPACE_ROOT="/home/arch/dev/projects/cyberpunk-2077"
DRY_RUN="${1:-}"
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_BLUE='\033[0;34m'
COLOR_NC='\033[0m' # No Color

echo -e "${COLOR_BLUE}=== CP2077 Repository Cloning Script ===${COLOR_NC}"
echo "Workspace: $WORKSPACE_ROOT"
echo "Dry-run: ${DRY_RUN:-false}"
echo ""

# Helper function
clone_repo() {
    local repo_url="$1"
    local target_dir="$2"
    local description="${3:-}"
    local depth="${4:---depth 1}"

    mkdir -p "$(dirname "$target_dir")"

    # Skip if already a valid git repo
    if [ -d "$target_dir/.git" ]; then
        echo -e "${COLOR_YELLOW}SKIP${COLOR_NC} $(basename "$target_dir") — already cloned"
        return 0
    fi

    # Skip if symlink exists (assume it's pointing to existing repo)
    if [ -L "$target_dir" ]; then
        echo -e "${COLOR_YELLOW}SKIP${COLOR_NC} $(basename "$target_dir") — symlink exists (already referenced)"
        return 0
    fi

    # Skip if directory exists but isn't a git repo
    if [ -d "$target_dir" ] && [ ! -d "$target_dir/.git" ]; then
        echo -e "${COLOR_YELLOW}SKIP${COLOR_NC} $(basename "$target_dir") — directory exists (non-git)"
        return 0
    fi

    echo -e "${COLOR_GREEN}CLONE${COLOR_NC} $(basename "$target_dir")"
    [ -n "$description" ] && echo "  └─ $description"

    if [ -n "$DRY_RUN" ]; then
        echo "  [DRY-RUN] git clone $depth '$repo_url' '$target_dir'"
    else
        git clone $depth "$repo_url" "$target_dir"
    fi
    echo ""
}

# ============================================================================
# 1. DEVICE TREE & ROM ECOSYSTEM
# ============================================================================
echo -e "${COLOR_BLUE}[1/6] Device Trees & ROM Ecosystem${COLOR_NC}"
echo ""

clone_repo \
    "https://github.com/LineageOS/android_device_oneplus_guacamole" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/oneplus-7-pro/lineage-device-guacamole" \
    "Official LineageOS device tree for OP7 Pro (GM1911/guacamole)"

clone_repo \
    "https://github.com/OrangeFoxRecovery/device_oneplus_guacamole" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/oneplus-7-pro/orangefox-device-guacamole" \
    "OrangeFox recovery device tree for OP7 Pro"

# ============================================================================
# 2. KERNELS (SM8150 — Snapdragon 855, supports A16/LineageOS 23.2)
# ============================================================================
echo -e "${COLOR_BLUE}[2/6] Kernel Sources (SM8150 Snapdragon 855)${COLOR_NC}"
echo ""

clone_repo \
    "https://github.com/OnePlusOSS/android_kernel_oneplus_sm8150" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/oneplus-7-pro/kernel-oneplus-oss" \
    "Official OnePlus kernel source (upstream reference)" \
    "--depth 1"

clone_repo \
    "https://github.com/engstk/op7" \
    "$WORKSPACE_ROOT/07-KERNEL-PACKAGE-MODULES/kernel-engstk-op7" \
    "blu_spark kernel for OP7 series (performance + stability)" \
    "--depth 1"

clone_repo \
    "https://github.com/WildKernels/OnePlus_KernelSU_SUSFS" \
    "$WORKSPACE_ROOT/07-KERNEL-PACKAGE-MODULES/kernel-kernelsu-susfs" \
    "OnePlus kernels with KernelSU + SUSFS pre-integrated" \
    "--depth 1"

clone_repo \
    "https://github.com/kimocoder/android_kernel_oneplus_sm8150_draco" \
    "$WORKSPACE_ROOT/07-KERNEL-PACKAGE-MODULES/kernel-nethunter-draco" \
    "NetHunter kernel variant (security-focused) — optional" \
    "--depth 1"

# ============================================================================
# 3. BOOT ANIMATION TOOLS (Your core functionality)
# ============================================================================
echo -e "${COLOR_BLUE}[3/6] Boot Animation Tools${COLOR_NC}"
echo ""

clone_repo \
    "https://github.com/rhythmcache/Video-to-BootAnimation-Creator-Script" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/boot-animation-tools/video-to-bootanim" \
    "FFmpeg-based video → bootanimation.zip converter (reference for build.py patterns)"

clone_repo \
    "https://github.com/ENEIZEM/Magisk-Module-Cyberpunk-2077-Bootanimation-SplashScreen-POCO" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/cyberpunk/reference-cp2077-poco-module" \
    "Reference CP2077 Magisk module (POCO variant) — study customize.sh patterns"

# ============================================================================
# 4. MAGISK ECOSYSTEM (Module dev + root frameworks)
# ============================================================================
echo -e "${COLOR_BLUE}[4/6] Magisk Ecosystem & Root Frameworks${COLOR_NC}"
echo ""

clone_repo \
    "https://github.com/Zackptg5/MMT-Extended" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/magisk-ecosystem/mmt-extended" \
    "Advanced Magisk Module Template — utilities + hook system"

clone_repo \
    "https://github.com/Dr-TSNG/ZygiskNext" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/magisk-ecosystem/zygisknext" \
    "Open-source Zygisk implementation (Magisk/KernelSU/APatch compatible) — future integration"

clone_repo \
    "https://github.com/snake-4/Zygisk-Assistant" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/magisk-ecosystem/zygisk-assistant" \
    "Root framework abstraction layer (optional, for multi-framework support)"

# ============================================================================
# 5. DESIGN & THEMING (Color palette + desktop themes)
# ============================================================================
echo -e "${COLOR_BLUE}[5/6] Design Tokens & Theming${COLOR_NC}"
echo ""

clone_repo \
    "https://github.com/Roboron3042/Cyberpunk-Neon" \
    "$WORKSPACE_ROOT/06-UI-THEMES-ANIMATIONS/repos/cyberpunk-neon-canonical" \
    "Canonical Cyberpunk-Neon palette (validate your colors against this)"

clone_repo \
    "https://github.com/prasanthrangan/hyprdots" \
    "$WORKSPACE_ROOT/06-UI-THEMES-ANIMATIONS/repos/hyprdots" \
    "Complete Hyprland dotfiles (Waybar, rofi, dunst reference)"

clone_repo \
    "https://github.com/scherrer-txt/cybrland" \
    "$WORKSPACE_ROOT/06-UI-THEMES-ANIMATIONS/repos/cybrland" \
    "Cyberpunk-themed Hyprland setup (eww, Waybar integration)"

clone_repo \
    "https://github.com/aranel616/neon-nexus" \
    "$WORKSPACE_ROOT/06-UI-THEMES-ANIMATIONS/repos/neon-nexus" \
    "Multi-tool neon theming (Hyprland, Waybar, rofi, Kitty) — optional"

# ============================================================================
# 6. LAUNCHER & ICON CUSTOMIZATION (Optional but useful)
# ============================================================================
echo -e "${COLOR_BLUE}[6/6] Launcher & Icon Themes (Optional)${COLOR_NC}"
echo ""

clone_repo \
    "https://github.com/LawnchairLauncher/lawnchair" \
    "$WORKSPACE_ROOT/06-UI-THEMES-ANIMATIONS/repos/lawnchair" \
    "Open-source Pixel Launcher (Material 3 theming reference)" \
    "--depth 1"

clone_repo \
    "https://github.com/LawnchairLauncher/lawnicons" \
    "$WORKSPACE_ROOT/06-UI-THEMES-ANIMATIONS/repos/lawnicons" \
    "Monochrome icon pack (theming reference)"

# ============================================================================
# SUMMARY
# ============================================================================
echo ""
echo -e "${COLOR_BLUE}=== Clone Summary ===${COLOR_NC}"
echo ""
echo "Cloned repositories organized by category:"
echo ""
echo "Device Tree & Recovery:"
echo "  • LineageOS device tree (guacamole)"
echo "  • OrangeFox recovery tree"
echo ""
echo "Kernels (SM8150 — supports A16/LineageOS 23.2):"
echo "  • OnePlus OSS kernel (upstream)"
echo "  • engstk blu_spark kernel"
echo "  • KernelSU + SUSFS variant"
echo "  • NetHunter variant (optional)"
echo ""
echo "Boot Animation Tools:"
echo "  • FFmpeg video converter"
echo "  • ENEIZEM CP2077 reference module"
echo ""
echo "Magisk Ecosystem:"
echo "  • MMT-Extended framework"
echo "  • ZygiskNext (future integration)"
echo "  • Zygisk-Assistant (optional)"
echo ""
echo "Theming & Design:"
echo "  • Cyberpunk-Neon canonical palette"
echo "  • hyprdots (Hyprland reference)"
echo "  • cybrland (Cyberpunk Hyprland)"
echo "  • neon-nexus (multi-tool)"
echo ""
echo "Launcher & Icons:"
echo "  • Lawnchair launcher"
echo "  • Lawnicons icon pack"
echo ""

# ============================================================================
# NEXT STEPS
# ============================================================================
echo ""
echo -e "${COLOR_YELLOW}Next Steps:${COLOR_NC}"
echo ""
echo "1. Review integration tasks:"
echo "   cat 09-DOCS/REPO-INTEGRATION-TASKS.md"
echo ""
echo "2. Start with these comparisons (Week 1):"
echo "   • FFmpeg LANCZOS patterns (video-to-bootanim)"
echo "   • ENEIZEM customize.sh structure (reference module)"
echo "   • Design token validation (cyberpunk-neon-canonical)"
echo ""
echo "3. Study Waybar/eww configs (Week 2):"
echo "   • hyprdots: ~/.config/waybar/"
echo "   • cybrland: ~/.config/eww/"
echo ""
echo "4. Cross-reference GitHub Actions:"
echo "   cat .github/workflows/release.yml"
echo ""
echo -e "${COLOR_GREEN}All repositories cloned successfully!${COLOR_NC}"
echo ""
