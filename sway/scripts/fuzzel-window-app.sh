#!/bin/bash
# fuzzel-window-app.sh — fuzzel-based switcher for windows of the SAME application
# Bound to Mod+Escape / Mod+Shift+Escape

set -u

# Get focused window's app_id
app_id=$(swaymsg -t get_tree 2>/dev/null | jq -r '
    [recurse(.nodes[]?, .floating_nodes[]?) |
     select(.focused? == true and .type? == "con")] |
    first | .app_id // empty
')

[[ -n "$app_id" ]] || exit 0

# Get all windows of the same app with workspace number
entries=$(swaymsg -t get_tree 2>/dev/null | jq -r --arg app "$app_id" '
    .. | select(.type? == "workspace" and .name? != "__i3_scratch") | . as $ws |
    recurse(.nodes[]?, .floating_nodes[]?) |
    select((.type? == "con" or .type? == "floating_con") and .app_id? == $app and .name? != null) |
    "\($ws.name) │ \(if .type == "floating_con" then "F " else "" end)\(.name // "untitled")\t\(.id)"
')

[[ -n "$entries" ]] || exit 0

display=$(echo "$entries" | cut -f1)
selected=$(echo "$display" | fuzzel --dmenu --prompt "  ${app_id}" 2>/dev/null)

if [[ -n "$selected" ]]; then
    con_id=$(echo "$entries" | grep -F "$selected"$'\t' | cut -f2 | tr -d '[:space:]')
    [[ -n "$con_id" ]] && swaymsg "[con_id=$con_id]" focus 2>/dev/null
fi
