#!/bin/bash
# rofi-window-app.sh — rofi-based switcher for windows of the same application
# Bound to Mod+Escape / Mod+Shift+Escape

set -u

# Get focused window's app_id
app_id=$(swaymsg -t get_tree 2>/dev/null | jq -r '
    [recurse(.nodes[]?, .floating_nodes[]?) |
     select(.focused? == true and .type? == "con")] |
    first | .app_id // empty
')

[[ -n "$app_id" ]] || exit 0

# Build tab-separated list: index | name | con_id
entries=$(swaymsg -t get_tree 2>/dev/null | jq -r --arg app "$app_id" '
    [.. | select(.type? == "con" and .app_id? == $app and .name? != null)] |
    to_entries | .[] | "\(.key)\t\(.value.name)\t\(.value.id)"
')

[[ -n "$entries" ]] || exit 0

# Show names in rofi, return 0-based index
names=$(echo "$entries" | cut -f2)
selected=$(echo "$names" | rofi -dmenu -i -p "  $app_id" -no-custom -format i 2>/dev/null)

if [[ -n "$selected" ]] && [[ "$selected" =~ ^[0-9]+$ ]]; then
    con_id=$(echo "$entries" | sed -n "$((selected + 1))p" | cut -f3)
    [[ -n "$con_id" ]] && swaymsg "[con_id=$con_id]" focus
fi
