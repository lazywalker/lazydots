#!/usr/bin/env bash
# =========================================================================
# layout-cycle.sh — Cycle Hyprland layouts and push notify via DMS IPC
#
# Layouts: master → dwindle → scrolling → monocle → master
# =========================================================================

set -euo pipefail

LAYOUTS=(master dwindle scrolling monocle)

get_layout() {
    hyprctl -j getoption general:layout 2>/dev/null | jq -r '.str'
}

next_layout() {
    local current="$1"
    for i in "${!LAYOUTS[@]}"; do
        if [[ "${LAYOUTS[$i]}" == "$current" ]]; then
            echo "${LAYOUTS[$(( (i + 1) % ${#LAYOUTS[@]} ))]}"
            return
        fi
    done
    echo "${LAYOUTS[0]}"
}

current=$(get_layout)
target=$(next_layout "$current")

# Switch layout
hyprctl eval "hl.config({ general = { layout = \"${target}\" } })" >/dev/null 2>&1

# Save layout for recovery after Noctalia auto-reload
echo "$target" > /tmp/hypr_layout

# Scrolling layout: set column width to 40%, left margin 30px
if [[ "$target" == "scrolling" ]]; then
    hyprctl eval "hl.config({ scrolling = { column_width = 0.4 } })" >/dev/null 2>&1
    hyprctl eval "hl.config({ general = { gaps_out = { top = 6, right = 6, bottom = 6, left = 30 } } })" >/dev/null 2>&1
else
    # Restore normal gaps for non-scrolling layouts
    hyprctl eval "hl.config({ general = { gaps_out = { top = 6, right = 6, bottom = 6, left = 6 } } })" >/dev/null 2>&1
fi

# Monocle layout: move each window to its own workspace, auto-spawn to new workspace
if [[ "$target" == "monocle" ]]; then
    # Install window rule: new windows go to the next empty workspace
    hyprctl eval 'hl.window_rule({ name = "monocle-auto-ws", match = { class = ".*" }, workspace = "emptym" })' >/dev/null 2>&1

    # Move each existing window to its own workspace
    ws=1
    hyprctl clients -j 2>/dev/null | jq -r '
        [.[] | select(.floating == false)] | sort_by(.at[0]) | .[].address' | while read -r addr; do
        hyprctl eval "hl.dispatch(hl.dsp.window.move({ workspace = ${ws}, window = \"address:${addr}\" }))" >/dev/null 2>&1
        ws=$((ws + 1))
        sleep 0.05
    done
elif [[ "$current" == "monocle" ]]; then
    # Leaving monocle: remove the auto-workspace rule
    hyprctl eval 'hl.window_rule({ name = "monocle-auto-ws", match = { class = ".*" }, workspace = "unset" })' >/dev/null 2>&1

    # Collect all non-floating windows from all workspaces, group max 3 per workspace
    all_windows=$(hyprctl clients -j 2>/dev/null | jq -r '
        [.[] | select(.floating == false)] | sort_by(.at[0]) | .[].address')
    ws=1
    count=0
    for addr in $all_windows; do
        hyprctl eval "hl.dispatch(hl.dsp.window.move({ workspace = ${ws}, window = \"address:${addr}\" }))" >/dev/null 2>&1
        count=$((count + 1))
        if [[ $count -ge 3 ]]; then
            count=0
            ws=$((ws + 1))
        fi
        sleep 0.05
    done
else
    # Not monocle transition: just remove the rule if switching between non-monocle layouts
    hyprctl eval 'hl.window_rule({ name = "monocle-auto-ws", match = { class = ".*" }, workspace = "unset" })' >/dev/null 2>&1
fi
actual=$(get_layout)
if [[ "$actual" == "$target" ]]; then
    notify-send -e -u low -i preferences-system "${target^} Layout" "Switched to ${target} layout"
else
    notify-send -e -u critical -i dialog-error "Layout Switch Failed" "Expected ${target}, got ${actual}"
fi
