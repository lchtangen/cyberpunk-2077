#!/usr/bin/env bash
# Network status widget for Waybar CP2077 HUD
iface=$(ip route get 1.1.1.1 2>/dev/null | awk '{print $5; exit}')
[ -z "$iface" ] && { echo "OFFLINE"; exit 0; }

# rx/tx delta in KB/s
rx1=$(cat /sys/class/net/${iface}/statistics/rx_bytes 2>/dev/null || echo 0)
tx1=$(cat /sys/class/net/${iface}/statistics/tx_bytes 2>/dev/null || echo 0)
sleep 1
rx2=$(cat /sys/class/net/${iface}/statistics/rx_bytes 2>/dev/null || echo 0)
tx2=$(cat /sys/class/net/${iface}/statistics/tx_bytes 2>/dev/null || echo 0)

rx_kb=$(( (rx2 - rx1) / 1024 ))
tx_kb=$(( (tx2 - tx1) / 1024 ))

ssid=""
if command -v iwgetid &>/dev/null; then
  ssid=$(iwgetid -r 2>/dev/null)
fi
[ -n "$ssid" ] && label="$ssid" || label="$iface"

echo "↓${rx_kb}K ↑${tx_kb}K  ${label}"
