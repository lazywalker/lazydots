#!/bin/bash
# fuzzel-window.sh — fuzzel-based window switcher for Sway
# Lists all visible windows across all workspaces, pipe to fuzzel dmenu, focus the selected one.
# Bound to Mod+Tab / Mod+Shift+Tab

set -u

# Get all windows with workspace number: "ws │ app_id: title<TAB>con_id"
entries=$(swaymsg -t get_tree 2>/dev/null | jq -r '
    .. | select(.type? == "workspace" and .name? != "__i3_scratch") | . as $ws |
    recurse(.nodes[]?) |
    select(.type? == "con" and .app_id? != null and .name? != null) |
    "\($ws.name) │ \(.app_id // "?"): \(.name // "untitled")\t\(.id)"
')

[[ -n "$entries" ]] || exit 0

# Show display part in fuzzel dmenu
display=$(echo "$entries" | cut -f1)
selected=$(echo "$display" | fuzzel --dmenu --prompt "  " 2>/dev/null)

# Focus selected window
if [[ -n "$selected" ]]; then
    con_id=$(echo "$entries" | grep -F "$selected"$'\t' | cut -f2 | tr -d '[:space:]')
    [[ -n "$con_id" ]] && swaymsg "[con_id=$con_id]" focus 2>/dev/null
fi
