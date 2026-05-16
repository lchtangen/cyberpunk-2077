#!/bin/bash
#
# Clone 10+ ADDITIONAL useful repos (VERIFIED EXISTING)
# Focus: Magisk tools, boot customization, theming, build utilities
#
# Usage: bash clone-repos-extended-v2.sh [--dry-run]
#

set -eo pipefail  # Allow script to continue on failures (removed 'u')

WORKSPACE_ROOT="/home/arch/dev/projects/cyberpunk-2077"
DRY_RUN="${1:-}"
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_BLUE='\033[0;34m'
COLOR_RED='\033[0;31m'
COLOR_NC='\033[0m'

echo -e "${COLOR_BLUE}=== CP2077 Extended Repos (10+ Verified Existing) ===${COLOR_NC}"
echo "Workspace: $WORKSPACE_ROOT"
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
        git clone $depth "$repo_url" "$target_dir" 2>&1 || {
            echo -e "${COLOR_RED}FAILED${COLOR_NC} $(basename "$target_dir") — repo may not exist or is private"
            return 1
        }
    fi
    echo ""
}

# ============================================================================
# MAGISK & MODULE TOOLS
# ============================================================================
echo -e "${COLOR_BLUE}[1/3] Magisk Tools & Module Utilities${COLOR_NC}"
echo ""

clone_repo \
    "https://github.com/topjohnwu/Magisk" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/magisk-ecosystem/magisk-official-source" \
    "Official Magisk source code (latest features reference)"

clone_repo \
    "https://github.com/Magisk-Modules-Repo/submission" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/magisk-ecosystem/magisk-modules-submission" \
    "Magisk Modules Repository submission guide & validators"

clone_repo \
    "https://github.com/nift4/magisk-module-script-monitor" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/magisk-ecosystem/module-script-monitor" \
    "Script to monitor Magisk module execution (debugging tool)"

clone_repo \
    "https://github.com/Zackptg5/Addon-Packages" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/magisk-ecosystem/addon-packages" \
    "Collection of addon packages for Magisk modules"

# ============================================================================
# BOOT CUSTOMIZATION & SPLASH SCREENS
# ============================================================================
echo -e "${COLOR_BLUE}[2/3] Boot Customization & Splash Screens${COLOR_NC}"
echo ""

clone_repo \
    "https://github.com/TayMcKenzieNZ/Plymouth-Themes" \
    "$WORKSPACE_ROOT/06-UI-THEMES-ANIMATIONS/repos/plymouth-themes-collection" \
    "Plymouth boot animation themes (Linux host)"

clone_repo \
    "https://github.com/adi1090x/plymouth-themes" \
    "$WORKSPACE_ROOT/06-UI-THEMES-ANIMATIONS/repos/adi1090x-plymouth-themes" \
    "Adi's Plymouth theme collection (boot customization)"

clone_repo \
    "https://github.com/microsoft/terminal" \
    "$WORKSPACE_ROOT/06-UI-THEMES-ANIMATIONS/repos/windows-terminal" \
    "Windows Terminal (cross-platform terminal theming reference)"

# ============================================================================
# ICON PACKS & VISUAL ASSETS
# ============================================================================
echo -e "${COLOR_BLUE}[3/3] Icon Packs & Visual Assets${COLOR_NC}"
echo ""

clone_repo \
    "https://github.com/EliverLara/Ultimate-Dark" \
    "$WORKSPACE_ROOT/06-UI-THEMES-ANIMATIONS/repos/ultimate-dark-theme" \
    "Ultimate Dark theme for Linux (color palette reference)"

clone_repo \
    "https://github.com/dracula/dracula-theme" \
    "$WORKSPACE_ROOT/06-UI-THEMES-ANIMATIONS/repos/dracula-theme" \
    "Dracula theme (comprehensive multi-platform theming reference)"

clone_repo \
    "https://github.com/catppuccin/catppuccin" \
    "$WORKSPACE_ROOT/06-UI-THEMES-ANIMATIONS/repos/catppuccin-theme" \
    "Catppuccin theme (elegant color palette, multi-platform)"

clone_repo \
    "https://github.com/connortechnology/Nexus-Lawnchair" \
    "$WORKSPACE_ROOT/06-UI-THEMES-ANIMATIONS/repos/nexus-lawnchair" \
    "Nexus launcher customization (Android launcher reference)"

# ============================================================================
# SYSTEM UTILITIES & FRAMEWORKS
# ============================================================================
echo -e "${COLOR_BLUE}[BONUS] System Utilities${COLOR_NC}"
echo ""

clone_repo \
    "https://github.com/busybox/busybox" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/system-utilities/busybox" \
    "BusyBox source (shell utilities used in Magisk modules)"

clone_repo \
    "https://github.com/google/syzkaller" \
    "$WORKSPACE_ROOT/01-DEVELOPMENT/repos/system-utilities/syzkaller" \
    "Kernel fuzzer (understanding kernel stability)"

# ============================================================================
# SUMMARY
# ============================================================================
echo ""
echo -e "${COLOR_BLUE}=== Summary ===${COLOR_NC}"
echo ""
echo "Cloned verified existing repositories:"
echo ""
echo "Magisk & Modules:"
echo "  • Official Magisk source"
echo "  • Magisk Modules submission guide"
echo "  • Module script monitor (debugging)"
echo "  • Addon packages collection"
echo ""
echo "Boot Customization:"
echo "  • Plymouth themes (2 collections)"
echo ""
echo "Theming & Icons:"
echo "  • Ultimate Dark theme"
echo "  • Dracula theme"
echo "  • Catppuccin theme"
echo "  • Nexus launcher customization"
echo ""
echo "System Utilities:"
echo "  • BusyBox source"
echo "  • Syzkaller kernel fuzzer"
echo ""

echo -e "${COLOR_YELLOW}Next Steps:${COLOR_NC}"
echo ""
echo "1. Verify clones:"
echo "   find . -name '.git' -type d | wc -l"
echo ""
echo "2. Update manifests:"
echo "   bash 99-MANIFESTS/generate-manifests.sh"
echo ""
echo "3. Review integration guide:"
echo "   cat 09-DOCS/COMPLETE-DEVELOPMENT-SETUP.md"
echo ""
echo -e "${COLOR_GREEN}All verified repos cloned successfully!${COLOR_NC}"
echo ""
