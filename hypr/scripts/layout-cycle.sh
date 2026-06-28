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

# Scrolling layout: set column width to 40%, left margin 30px
if [[ "$target" == "scrolling" ]]; then
    hyprctl eval "hl.config({ scrolling = { column_width = 0.4 } })" >/dev/null 2>&1
    hyprctl eval "hl.config({ general = { gaps_out = { top = 14, right = 6, bottom = 6, left = 30 } } })" >/dev/null 2>&1
else
    # Restore normal gaps for non-scrolling layouts
    hyprctl eval "hl.config({ general = { gaps_out = { top = 14, right = 6, bottom = 6, left = 6 } } })" >/dev/null 2>&1
fi

# Verify and notify
actual=$(get_layout)
if [[ "$actual" == "$target" ]]; then
    notify-send -e -u low -i preferences-system "${target^} Layout" "Switched to ${target} layout"
else
    notify-send -e -u critical -i dialog-error "Layout Switch Failed" "Expected ${target}, got ${actual}"
fi
