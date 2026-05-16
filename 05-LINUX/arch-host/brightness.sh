#!/usr/bin/env bash
# brightness.sh — hardware backlight (1-100%) + software gamma boost (100-200%)
# Requires: brightnessctl, wlr-randr
# Usage: brightness.sh up | down

STEP=5
SOFT_MAX=200
SOFT_STATE="/tmp/cp2077-brightness-soft"

get_output() {
    wlr-randr 2>/dev/null | awk 'NR==1{print $1}'
}

get_hw_pct() {
    local max cur
    max=$(brightnessctl max 2>/dev/null) || { echo 0; return; }
    cur=$(brightnessctl get 2>/dev/null) || { echo 0; return; }
    [ "$max" -eq 0 ] && { echo 0; return; }
    echo $((cur * 100 / max))
}

get_soft_pct() {
    cat "$SOFT_STATE" 2>/dev/null || echo 100
}

apply_soft() {
    local pct=$1
    local output
    output=$(get_output)
    [ -z "$output" ] && return
    echo "$pct" > "$SOFT_STATE"
    local fval
    fval=$(awk "BEGIN {printf \"%.2f\", $pct / 100}")
    wlr-randr --output "$output" --brightness "$fval" 2>/dev/null
}

hw_pct=$(get_hw_pct)
soft_pct=$(get_soft_pct)

case "${1:-up}" in
    up)
        if [ "$hw_pct" -lt 100 ] && [ "$hw_pct" -gt 0 ]; then
            new=$((hw_pct + STEP))
            [ "$new" -gt 100 ] && new=100
            brightnessctl set "${new}%"
            apply_soft 100
        elif [ "$hw_pct" -eq 0 ] && [ "$soft_pct" -le 100 ]; then
            # No hardware backlight — pure software mode
            new=$((soft_pct + STEP))
            [ "$new" -gt "$SOFT_MAX" ] && new=$SOFT_MAX
            apply_soft "$new"
        else
            # At hardware max — push software gamma
            new=$((soft_pct + STEP))
            [ "$new" -gt "$SOFT_MAX" ] && new=$SOFT_MAX
            apply_soft "$new"
        fi
        ;;
    down)
        if [ "$soft_pct" -gt 100 ]; then
            new=$((soft_pct - STEP))
            [ "$new" -lt 100 ] && new=100
            apply_soft "$new"
        elif [ "$hw_pct" -gt 0 ]; then
            new=$((hw_pct - STEP))
            [ "$new" -lt 1 ] && new=1
            brightnessctl set "${new}%"
            apply_soft 100
        else
            # Pure software mode going down
            new=$((soft_pct - STEP))
            [ "$new" -lt 10 ] && new=10
            apply_soft "$new"
        fi
        ;;
esac
