#!/usr/bin/env bash
# =========================================================================
# resize-cycle.sh — Cycle active window width through 30% → 40% → 50% → 60%
# Uses relative resize (delta) to set window to target width.
# =========================================================================

set -euo pipefail

RATIOS=(0.3 0.4 0.5 0.6)

layout=$(hyprctl -j getoption general:layout 2>/dev/null | jq -r '.str')
if [[ "$layout" == "monocle" ]]; then
    notify-send -e -u low -i dialog-information "Resize Cycle" "Not available in monocle layout"
    exit 0
fi

addr=$(hyprctl activewindow -j 2>/dev/null | jq -r '.address // empty')
if [[ -z "$addr" ]]; then
    exit 0
fi

win_w=$(hyprctl clients -j 2>/dev/null | jq -r --arg a "$addr" '.[] | select(.address == $a) | .size[0]')
mon_w=$(hyprctl monitors -j 2>/dev/null | jq -r '.[] | select(.focused == true) | .width')
if [[ -z "$win_w" || -z "$mon_w" || "$mon_w" == "0" ]]; then
    exit 0
fi

# Compute current ratio
current_ratio=$(bc <<< "scale=3; $win_w / $mon_w")

# Find the next ratio strictly larger than current
next=""
for r in "${RATIOS[@]}"; do
    if (( $(bc <<< "$current_ratio < $r") )); then
        next="$r"
        break
    fi
done
[[ -z "$next" ]] && next="${RATIOS[0]}"

# Compute target width and delta
target_w=$(bc <<< "scale=0; $mon_w * $next / 1")
delta_x=$(bc <<< "$target_w - $win_w")

# Resize by delta (relative)
hyprctl eval "hl.dispatch(hl.dsp.window.resize({ x = ${delta_x}, y = 0, relative = true, window = \"address:${addr}\" }))" >/dev/null 2>&1

#notify-send -e -u low -i preferences-system "Window Width: ${next}" "$(bc <<< "scale=0; $next * 100 / 1")% of screen"
