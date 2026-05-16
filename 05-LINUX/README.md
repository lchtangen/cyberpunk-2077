# 05-LINUX — Linux Host Environment & Device Control

Configuration and scripts for the Arch Linux development host and OnePlus 7 Pro device control via ADB.

## Structure

- **`scripts/`** — Standalone utility scripts
  - `brightness.sh` — Display brightness control
  - `grub-probe-fast.sh` — Fast GRUB disk probe
  - `install-cp2077-desktop.sh` — Desktop environment setup
  - `cp2077-wallpaper-daemon.sh` — Dynamic wallpaper daemon

- **`configs/`** — Application and daemon configuration files
  - `cp2077-hyprland.conf` — Hyprland window manager config (Cyberpunk theme)
  - `mako/` — Mako notification daemon config
  - `rofi/` — Rofi app launcher theme
  - `terminal-themes/` — Terminal emulator themes (Alacritty, Kitty, WezTerm, Vim)

- **`device-arch-scripts/`** — ADB-based device operations
  - `cp2077-adb-control.sh` — Main device control interface (variant switching, flashing, logs)
  - `install-kde-wayland-minimal.sh` — KDE Wayland minimal install
  - `setup-sway-desktop.sh` — Sway desktop setup
  - `setup-sway-fixed.sh` — Sway with fixes applied
  - `setup-minimal-copy-terminal.sh` — Minimal terminal setup

## Usage

### Device Control
```bash
cd device-arch-scripts
./cp2077-adb-control.sh status          # Check device state
./cp2077-adb-control.sh switch glitch   # Switch bootanimation variant
./cp2077-adb-control.sh flash           # Flash module to device
./cp2077-adb-control.sh logs            # Pull device logs
```

### Environment Setup
```bash
# Apply Cyberpunk theme and configs
bash scripts/install-cp2077-desktop.sh
```

## Design

- Configs are centralized and organized by application
- Device scripts are production-grade with ADB error handling
- Utility scripts are self-contained and portable
