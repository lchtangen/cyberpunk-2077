#!/bin/bash
#
# Clone 10+ ADDITIONAL GitHub repositories for CP2077 OP7 Pro development
# Focus: Alternative ROMs, system utilities, boot customization, icon packs, build tools
#
# Usage: bash clone-repos-extended.sh [--dry-run]
#

set -euo pipefail

WORKSPACE_ROOT="/home/arch/dev/projects/cyberpunk-2077"
DRY_RUN="${1:-}"
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_BLUE='\033[0;34m'
COLOR_RED='\033[0;31m'
COLOR_NC='\033[0m'

echo -e "${COLOR_BLUE}=== CP2077 Extended Repository Cloning (10+ Additional Repos) ===${COLOR_NC}"
echo "Workspace: $WORKSPACE_ROOT"
echo "Focus: ROM alternatives, build tools, icon packs, utilities"
echo ""

clone_repo() {
    local repo_url="$1"
    local target_dir="$2"
    local description="${3:-}"
    local depth="${4:---depth 1}"

    mkdir -p "$(dirname "$target_dir")"

    if [ -d "$target_dir/.git" ]; then
        echo -e "${COLOR_YELLOW}SKIP${COLOR_NC} $(basename "$target_dir") — already cloned"
        return 0
    fi

    if [ -L "$target_dir" ]; then
        echo -e "${COLOR_YELLOW}SKIP${COLOR_NC} $(basename "$target_dir") — symlink exists"
        return 0
    fi

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
# PART 1: ALTERNATIVE ROM DEVICE TREES (OP7 Pro alternatives to LineageOS)
# ============================================================================
echo -e "${COLOR_BLUE}[1/4] Alternative ROM Device Trees (OP7 Pro Variants)${COLOR_NC}"
echo ""

clone_repo \
    "https://github.com/crDroid-org/android_device_oneplus_guacamole" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/oneplus-7-pro/device-crdroid-guacamole" \
    "crDroid device tree for OP7 Pro — alternative ROM base"

clone_repo \
    "https://github.com/Evolution-X-Devices/android_device_oneplus_guacamole" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/oneplus-7-pro/device-evolution-x-guacamole" \
    "Evolution-X device tree for OP7 Pro — performance-focused ROM"

clone_repo \
    "https://github.com/PixelExperience-Devices/android_device_oneplus_guacamole" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/oneplus-7-pro/device-pixel-experience-guacamole" \
    "Pixel Experience device tree for OP7 Pro — clean AOSP experience"

clone_repo \
    "https://github.com/DerpFest-Devices/android_device_oneplus_guacamole" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/oneplus-7-pro/device-derpfest-guacamole" \
    "DerpFest device tree for OP7 Pro — Derp ROM variant"

# ============================================================================
# PART 2: COMMON DEVICE CODE & SM8150 (Snapdragon 855 Base)
# ============================================================================
echo -e "${COLOR_BLUE}[2/4] SM8150 Common Device Code & Supporting Trees${COLOR_NC}"
echo ""

clone_repo \
    "https://github.com/LineageOS/android_device_oneplus_sm8150-common" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/oneplus-7-pro/device-lineage-sm8150-common" \
    "LineageOS SM8150 common device tree (shared across OP7/T/8/Pro)"

clone_repo \
    "https://github.com/crDroid-org/android_device_oneplus_sm8150-common" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/oneplus-7-pro/device-crdroid-sm8150-common" \
    "crDroid SM8150 common tree (optimization + features)"

# ============================================================================
# PART 3: BUILD SYSTEM, UTILITIES & DEVELOPMENT TOOLS
# ============================================================================
echo -e "${COLOR_BLUE}[3/4] Build System, ROM Utilities & Development Tools${COLOR_NC}"
echo ""

clone_repo \
    "https://github.com/LineageOS/android_manifest" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/lineageos-manifest" \
    "LineageOS official manifest — for building LineageOS from source"

clone_repo \
    "https://github.com/Magisk-Modules-Repo/submission" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/magisk-modules-repo-submission" \
    "Magisk Modules Repository submission guide + utilities"

clone_repo \
    "https://github.com/topjohnwu/Magisk" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/magisk-ecosystem/magisk-official" \
    "Official Magisk source code (reference for latest features)"

# ============================================================================
# PART 4: ICON PACKS, THEMING & BOOT CUSTOMIZATION
# ============================================================================
echo -e "${COLOR_BLUE}[4/4] Icon Packs, Theming & Boot Customization${COLOR_NC}"
echo ""

clone_repo \
    "https://github.com/Papirus-Team/papirus-icon-theme" \
    "$WORKSPACE_ROOT/06-UI-THEMES-ANIMATIONS/repos/papirus-icon-theme" \
    "Papirus icon pack — highly customizable, cyberpunk-friendly"

clone_repo \
    "https://github.com/vinceliuice/Tela-icon-theme" \
    "$WORKSPACE_ROOT/06-UI-THEMES-ANIMATIONS/repos/tela-icon-theme" \
    "Tela icon pack — modern, works well with Cyberpunk colors"

clone_repo \
    "https://github.com/Frost-Team/Frost-Neon-Icon-Theme" \
    "$WORKSPACE_ROOT/06-UI-THEMES-ANIMATIONS/repos/frost-neon-icon-theme" \
    "Frost Neon icon theme — neon aesthetic + cyberpunk colors"

# ============================================================================
# BONUS REPOS (if you want even more)
# ============================================================================
# Uncomment below for additional repos

# clone_repo \
#     "https://github.com/polybar/polybar" \
#     "$WORKSPACE_ROOT/06-UI-THEMES-ANIMATIONS/repos/polybar" \
#     "Polybar — advanced status bar (Waybar alternative)"

# clone_repo \
#     "https://github.com/offensive-security/kali-nethunter" \
#     "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/kali-nethunter" \
#     "Kali NetHunter — penetration testing framework for Android"

# clone_repo \
#     "https://github.com/kdrag0n/fwupd-android" \
#     "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/fwupd-android" \
#     "Firmware update daemon for Android (advanced OTA management)"

# ============================================================================
# SUMMARY
# ============================================================================
echo ""
echo -e "${COLOR_BLUE}=== Clone Summary ===${COLOR_NC}"
echo ""
echo "Cloned repositories organized by category:"
echo ""
echo "Alternative ROM Device Trees (OP7 Pro):"
echo "  • crDroid device tree"
echo "  • Evolution-X device tree"
echo "  • Pixel Experience device tree"
echo "  • DerpFest device tree"
echo ""
echo "SM8150 Common Code:"
echo "  • LineageOS SM8150 common"
echo "  • crDroid SM8150 common"
echo ""
echo "Build System & Utilities:"
echo "  • LineageOS manifest (for building ROMs)"
echo "  • Magisk Modules Repository utilities"
echo "  • Official Magisk source code"
echo ""
echo "Icon Packs & Theming:"
echo "  • Papirus icon pack"
echo "  • Tela icon pack"
echo "  • Frost Neon icon theme"
echo ""

# ============================================================================
# NEXT STEPS
# ============================================================================
echo ""
echo -e "${COLOR_YELLOW}Next Steps:${COLOR_NC}"
echo ""
echo "1. Verify clones:"
echo "   find . -name '.git' -type d | wc -l"
echo ""
echo "2. Update manifests:"
echo "   bash 99-MANIFESTS/generate-manifests.sh"
echo ""
echo "3. Integration tasks:"
echo "   cat 09-DOCS/REPO-INTEGRATION-TASKS.md"
echo ""
echo "4. Reference guide for new repos:"
echo "   cat 09-DOCS/EXTENDED-REPOS-REFERENCE.md (coming next)"
echo ""
echo -e "${COLOR_GREEN}Extended repositories ready for development!${COLOR_NC}"
echo ""
echo -e "${COLOR_BLUE}Total available for Magisk module development:${COLOR_NC}"
echo "  • 4 ROM device trees to test compatibility against"
echo "  • 2 SM8150 common bases for understanding partition layout"
echo "  • LineageOS manifest for custom ROM builds"
echo "  • 3 icon packs for UI integration testing"
echo ""
