<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════════╗
║  ░▒▓  CP2077 LINUX HUD — ARCH/WAYLAND DESKTOP THEME SUITE  ▓▒░             ║
║  ────────────────────────────────────────────────────────────────────────── ║
║  Waybar · eww · hyprlock · swaylock · Hyprland · Sway                      ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

[![Waybar](https://img.shields.io/badge/Waybar-Status_Bar-FCEE0C?style=for-the-badge&labelColor=0a0a0a)](./)
[![eww](https://img.shields.io/badge/eww-Overlay_HUD-00FFFF?style=for-the-badge&labelColor=0a0a0a)](./)
[![hyprlock](https://img.shields.io/badge/hyprlock-Lock_Screen-FF003C?style=for-the-badge&labelColor=0a0a0a)](./)
[![swaylock](https://img.shields.io/badge/swaylock-Lock_Screen-00FF9F?style=for-the-badge&labelColor=0a0a0a)](./)

</div>

---

## 🎨 CP2077 Color Palette

```
╔══════════════════════════════════════════════════════════════════════════════╗
║  DESIGN TOKENS — ALL COMPONENTS USE THESE CONSISTENTLY                     ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

<div align="center">

| 🎨 Token | 🔑 Hex | 💡 Usage |
|:--------|:------|:--------|
| 🟡 **Neon Yellow** | `#FCEE0C` | Primary accent · active state · corp-ID gold |
| 🔵 **Netrunner Cyan** | `#00FFFF` | Data readouts · clock · secondary accent |
| 🔴 **Flatline Red** | `#FF003C` | Errors · wrong password · critical state |
| 🟢 **Signal Green** | `#00FF9F` | OK states · verified · success |
| 🟠 **Warning Orange** | `#FF6B35` | Warnings · caps lock · caution |
| ⬛ **Carbon Black** | `#0A0A0A` | Panel background · deep dark |
| 🔲 **Grid Border** | `#2A2A2A` | Dividers · frame borders · low-emphasis |

</div>

**Font:** `JetBrains Mono` across all components.

```bash
pacman -S ttf-jetbrains-mono
```

---

## ⚡ Component Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    CP2077 LINUX HUD — COMPONENT MAP                         │
│                                                                             │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │  WAYBAR  [workspaces | window-title] [⏰ clock] [net|cpu|ram|bat|vol] │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
│                          ┌─────────────┐                                   │
│                          │  eww HUD    │  ← top-right overlay              │
│                          │  PROCESSOR  │                                   │
│                          │  RAM BUFFER │                                   │
│                          │  STORAGE    │                                   │
│                          │  NETRUNNER  │                                   │
│                          │  POWER CELL │                                   │
│                          └─────────────┘                                   │
│                                                                             │
│  ┌───────────────────────────────────────────────────────────────────────┐  │
│  │  HYPRLOCK / SWAYLOCK  — full-screen lock overlay with CP2077 identity │  │
│  └───────────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────────┘
```


---

## 1. 📊 Waybar — Status Bar

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

### Hyprland Autostart

```
# ~/.config/hypr/hyprland.conf
exec-once = waybar
```

### Bar Layout

```
┌──────────────────────────────────────────────────────────────────────────┐
│  [1][2][3] │ window-title │  ◈  HH:MM:SS  //  YYYY-MM-DD  ◈  │ NET CPU RAM BAT VOL │
└──────────────────────────────────────────────────────────────────────────┘
  workspaces     active window         cyberpunk clock             right modules
```

### Custom Modules

<div align="center">

| 📡 Module | 🔧 Script | ⏱ Interval | ⚠️ Warning | 🔴 Critical |
|:---------|:---------|:----------|:---------|:---------|
| Network | `scripts/cp2077-net.sh` | 3 s | — | — |
| CPU | Built-in Waybar | 2 s | > 70% | > 90% |
| Memory | Built-in Waybar | 5 s | > 80% | > 95% |
| Battery | Built-in Waybar | 30 s | < 30% | < 15% |

</div>

### Launch

```bash
waybar &
```


---

## 2. 🖥 eww — Overlay HUD Widget

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

## 3. 🔐 hyprlock — Hyprland Lock Screen

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
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  ← #FCEE0C accent bar
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

## 4. 🔒 swaylock — Sway / Generic Wayland Lock Screen

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

### Color State Map

<div align="center">

| 🔐 State | 💎 Ring Color | 📝 Label |
|:--------|:------------|:-------|
| Idle | `#2A2A2A` | dim grey ring |
| Verifying | `#FFFFFF` | `VERIFYING…` |
| Wrong password | `#FF003C` | `ACCESS DENIED` |
| Cleared / unlocked | `#FCEE0C` | *(empty)* |
| Caps lock active | `#FF6B35` | indicator shown |

</div>

---

## 🚀 Quick-Install All Components

```bash
#!/usr/bin/env bash
# Run from the cp2077-linux-hud/ directory

THEME_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "⚡ Installing CP2077 Linux HUD..."

# Waybar
mkdir -p ~/.config/waybar/scripts
cp "$THEME_DIR/waybar/config.jsonc"           ~/.config/waybar/config
cp "$THEME_DIR/waybar/style.css"              ~/.config/waybar/style.css
cp "$THEME_DIR/waybar/scripts/cp2077-net.sh"  ~/.config/waybar/scripts/cp2077-net.sh
chmod +x ~/.config/waybar/scripts/cp2077-net.sh
echo "  ✅ Waybar installed"

# eww
mkdir -p ~/.config/eww/scripts
cp "$THEME_DIR/eww/eww.yuck"  ~/.config/eww/eww.yuck
cp "$THEME_DIR/eww/eww.scss"  ~/.config/eww/eww.scss
cp "$THEME_DIR/waybar/scripts/cp2077-net.sh"  ~/.config/eww/scripts/net.sh
chmod +x ~/.config/eww/scripts/net.sh
echo "  ✅ eww installed"

# hyprlock
mkdir -p ~/.config/hypr
cp "$THEME_DIR/hyprlock/hyprlock.conf" ~/.config/hypr/hyprlock.conf
echo "  ✅ hyprlock installed"

# swaylock
mkdir -p ~/.config/swaylock
cp "$THEME_DIR/swaylock/swaylock.conf" ~/.config/swaylock/config
echo "  ✅ swaylock installed"

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║  CP2077 Linux HUD — JACK IN COMPLETE  ⚡ ║"
echo "╚══════════════════════════════════════════╝"
echo "  Waybar:   waybar &"
echo "  eww HUD:  eww daemon && eww open cp2077-hud"
echo "  Lock:     hyprlock  (or  swaylock)"
```

---

## 🐛 Troubleshooting

<div align="center">

| ❌ Problem | 🔧 Fix |
|:---------|:------|
| Waybar shows no icons | Install a Nerd Font or replace Unicode symbols in `config.jsonc` with text labels |
| eww fails to start | Ensure `eww-wayland` is installed (not the X11 build). Run `eww logs` for details |
| hyprlock shape blocks not rendering | Update hyprlock to ≥ 0.3.0. On older versions, remove the two `shape {}` blocks from `hyprlock.conf` |
| swaylock no blur | Install `swaylock-effects` (AUR) instead of the standard `swaylock`. Comment out `effect-blur` and `effect-vignette` |
| Font missing / glyph misalign | `pacman -S ttf-jetbrains-mono`. eww/Waybar fall back to the system monospace font if missing, but glyph alignment may break |
| eww HUD not toggling | Ensure `eww daemon` is running before calling `eww open cp2077-hud` |
| Waybar modules not updating | Check `interval` in `config.jsonc` — must be an integer (not `"3s"`) |

</div>

---

<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════════╗
║  ⚡  WAKE THE F**K UP, SAMURAI. YOUR DESKTOP IS WAITING.  ⚡                ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

[![Android Theme](https://img.shields.io/badge/Android_Theme-CP2077_OP7Pro-FF003C?style=flat-square&labelColor=0a0a0a)](../../../01-DEVELOPMENT/repos/cyberpunk/CP2077-OP7Pro/)
[![Docs](https://img.shields.io/badge/Docs-09--DOCS-FCEE0C?style=flat-square&labelColor=0a0a0a)](../../../09-DOCS/INDEX.md)

</div>
