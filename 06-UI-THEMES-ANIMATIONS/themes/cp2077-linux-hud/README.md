# CP2077 Linux HUD — Installation Guide

Cyberpunk 2077 UI theme suite for Arch/Wayland desktops.
Covers: Waybar status bar, eww overlay widget, hyprlock lock screen, swaylock lock screen.

---

## Color Palette

| Role    | Hex       | Usage                        |
|---------|-----------|------------------------------|
| Yellow  | `#FCEE0C` | Primary accent, active state |
| Cyan    | `#00FFFF` | Data readouts, clock         |
| Red     | `#FF003C` | Errors, wrong password       |
| Green   | `#00FF9F` | OK states, verified          |
| Orange  | `#FF6B35` | Warnings, caps lock          |
| BG      | `#0A0A0A` | Panel background             |

Font: **JetBrains Mono** (all components). Install via `pacman -S ttf-jetbrains-mono`.

---

## 1. Waybar

### Dependencies

```bash
pacman -S waybar
```

### Install

```bash
mkdir -p ~/.config/waybar/scripts

# Config and stylesheet
cp waybar/config.jsonc  ~/.config/waybar/config
cp waybar/style.css     ~/.config/waybar/style.css

# Network script
cp waybar/scripts/cp2077-net.sh ~/.config/waybar/scripts/
chmod +x ~/.config/waybar/scripts/cp2077-net.sh
```

### Launch

```bash
waybar &
```

Add to your Hyprland config:

```
exec-once = waybar
```

### Layout

```
[workspaces | window-title]   [◈  HH:MM:SS  //  YYYY-MM-DD  ◈]   [NET | CPU | RAM | BAT | VOL | tray | ⏻]
```

### Custom Modules

| Module  | Script                        | Interval |
|---------|-------------------------------|----------|
| network | `scripts/cp2077-net.sh`       | 3 s      |
| cpu     | Built-in Waybar               | 2 s      |
| memory  | Built-in Waybar               | 5 s      |
| battery | Built-in Waybar               | 30 s     |

Warning thresholds: CPU >70%, RAM >80%, Battery <30%. Critical: CPU >90%, Battery <15%.

---

## 2. eww (Elkowar's Wacky Widgets)

### Dependencies

```bash
# eww is AUR — install via your AUR helper
yay -S eww-wayland
```

### Install

```bash
mkdir -p ~/.config/eww/scripts

cp eww/eww.yuck  ~/.config/eww/eww.yuck
cp eww/eww.scss  ~/.config/eww/eww.scss

# Network script (shared with Waybar)
cp waybar/scripts/cp2077-net.sh ~/.config/eww/scripts/net.sh
chmod +x ~/.config/eww/scripts/net.sh
```

### Launch

```bash
eww daemon
eww open cp2077-hud
```

To close:

```bash
eww close cp2077-hud
```

Toggle via keybind in Hyprland:

```
bind = $mod, F12, exec, eww open-many --toggle cp2077-hud
```

### Widget Layout

Top-right overlay (220×auto), 12px from edge, 48px from top:

```
┌─ ░▒▓ CP2077 HUD ▓▒░ ─────────────────────┐
│  HH:MM:SS                                  │
│  YYYY-MM-DD                                │
├─ ◈  PROCESSOR / ICE  ◈ ───────────────────┤
│  LOAD          XX%                         │
│  ████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
├─ ◈  NEURAL BUFFER / RAM  ◈ ───────────────┤
│  USAGE         X.XG / X.XG                │
│  ████████████░░░░░░░░░░░░░░░░░░░░░░░░░░░  │
├─ ◈  CYBERWARE STORAGE  ◈ ─────────────────┤
│  ROOT          XX%                         │
│  ███████████████████████░░░░░░░░░░░░░░░░  │
├─ ◈  NETRUNNER / UPLINK  ◈ ────────────────┤
│  STATUS        ↑X.X ↓X.X KB/s wlan0       │
├─ ◈  POWER CELL  ◈ ────────────────────────┤
│  CHARGE        XX%                         │
│  STATUS        Discharging                 │
│  ████████████████████████████░░░░░░░░░░░  │
└────────────────────────────────────────────┘
```

---

## 3. hyprlock (Hyprland lock screen)

### Dependencies

```bash
pacman -S hyprlock
```

Requires Hyprland. hyprlock ≥ 0.3.0 recommended for `shape {}` block support.

### Install

```bash
mkdir -p ~/.config/hypr

cp hyprlock/hyprlock.conf ~/.config/hypr/hyprlock.conf
```

Optional — set a user avatar (square image, shown as corp ID):

```bash
cp your-photo.jpg ~/.face
```

### Launch

```bash
hyprlock
```

Bind in Hyprland config:

```
bind = $mod, L, exec, hyprlock
```

Auto-lock with `hypridle`:

```bash
pacman -S hypridle
```

`~/.config/hypr/hypridle.conf`:

```
listener {
    timeout  = 300
    on-timeout = hyprlock
}
listener {
    timeout  = 600
    on-timeout = systemctl suspend
}
```

### Screen layout

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ← yellow accent bar
          ░▒▓  CYBERPUNK 2077  ▓▒░
          NIGHT CITY NEVER SLEEPS
               HH:MM:SS
            DDD, DD MMM YYYY
               [avatar]
               USERNAME
         [ENTER ACCESS CODE    ]
       Wake the f**k up, Samurai.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ← dim bottom bar
```

Background: blurred screenshot of current desktop (brightness 0.3).

---

## 4. swaylock (Sway / generic Wayland)

### Dependencies

```bash
# swaylock-effects for blur support (AUR)
yay -S swaylock-effects
```

Standard `swaylock` (no blur): `pacman -S swaylock`

### Install

```bash
mkdir -p ~/.config/swaylock
mkdir -p ~/.config/wallpapers

cp swaylock/swaylock.conf ~/.config/swaylock/config

# Place a CP2077 wallpaper (1920×1080 or higher)
cp your-wallpaper.jpg ~/.config/wallpapers/cp2077-nightcity.jpg
```

### Launch

```bash
swaylock
```

Bind in Sway config (`~/.config/sway/config`):

```
bindsym $mod+l exec swaylock
```

Auto-lock with `swayidle`:

```bash
pacman -S swayidle
```

Add to Sway config:

```
exec swayidle -w \
    timeout 300  'swaylock -f' \
    timeout 600  'systemctl suspend' \
    before-sleep 'swaylock -f'
```

### Color states

| State         | Ring color             | Text                |
|---------------|------------------------|---------------------|
| Idle          | `#2A2A2A`              | dim grey            |
| Verifying     | `#FFFFFF`              | VERIFYING…          |
| Wrong         | `#FF003C`              | ACCESS DENIED       |
| Cleared       | `#FCEE0C`              | *(empty)*           |
| Caps lock     | `#FF6B35`              | indicator shown     |

---

## Quick-install all components

```bash
#!/usr/bin/env bash
# Run from the cp2077-linux-hud/ directory

THEME_DIR="$(cd "$(dirname "$0")" && pwd)"

# Waybar
mkdir -p ~/.config/waybar/scripts
cp "$THEME_DIR/waybar/config.jsonc"           ~/.config/waybar/config
cp "$THEME_DIR/waybar/style.css"              ~/.config/waybar/style.css
cp "$THEME_DIR/waybar/scripts/cp2077-net.sh"  ~/.config/waybar/scripts/cp2077-net.sh
chmod +x ~/.config/waybar/scripts/cp2077-net.sh

# eww
mkdir -p ~/.config/eww/scripts
cp "$THEME_DIR/eww/eww.yuck"  ~/.config/eww/eww.yuck
cp "$THEME_DIR/eww/eww.scss"  ~/.config/eww/eww.scss
cp "$THEME_DIR/waybar/scripts/cp2077-net.sh"  ~/.config/eww/scripts/net.sh
chmod +x ~/.config/eww/scripts/net.sh

# hyprlock
mkdir -p ~/.config/hypr
cp "$THEME_DIR/hyprlock/hyprlock.conf" ~/.config/hypr/hyprlock.conf

# swaylock
mkdir -p ~/.config/swaylock
cp "$THEME_DIR/swaylock/swaylock.conf" ~/.config/swaylock/config

echo "CP2077 Linux HUD installed."
echo "Restart Waybar: pkill waybar && waybar &"
echo "Open eww HUD:   eww daemon && eww open cp2077-hud"
```

---

## Troubleshooting

**Waybar shows no icons** — Install a Nerd Font or replace Unicode symbols in `config.jsonc` with text labels.

**eww fails to start** — Ensure `eww-wayland` is installed (not the X11 build). Run `eww logs` to inspect errors.

**hyprlock shape blocks not rendering** — Update hyprlock to ≥ 0.3.0. On older versions, remove the two `shape {}` blocks from `hyprlock.conf`.

**swaylock no blur** — Install `swaylock-effects` (AUR) instead of the standard `swaylock`. Without it, comment out the `effect-blur` and `effect-vignette` lines.

**Font missing** — `pacman -S ttf-jetbrains-mono`. eww/Waybar will fall back to the system monospace font if missing, but glyph alignment may break.
