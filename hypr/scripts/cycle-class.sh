#!/usr/bin/env bash
# cycle-class.lua helper — called from Hyprland binds to cycle windows of same class
# Usage: cycle-class.sh [prev]

set -euo pipefail
direction="${1:-next}"

class=$(hyprctl activewindow -j 2>/dev/null | jq -r '.class // empty')
if [ -z "$class" ]; then exit 0; fi

current_addr=$(hyprctl activewindow -j 2>/dev/null | jq -r '.address // empty')
if [ -z "$current_addr" ]; then exit 0; fi

# Get all addresses of same class, sorted by focusHistoryID
mapfile -t addrs < <(
    hyprctl clients -j 2>/dev/null | jq -r --arg class "$class" '
        [.[] | select(.class == $class)] | sort_by(.focusHistoryID) | .[].address'
)

if [ ${#addrs[@]} -le 1 ]; then exit 0; fi

# Find current position
pos=-1
for i in "${!addrs[@]}"; do
    if [ "${addrs[$i]}" = "$current_addr" ]; then
        pos=$i
        break
    fi
done

if [ $pos -lt 0 ]; then exit 0; fi

# Determine next
if [ "$direction" = "prev" ]; then
    next=$(( (pos - 1 + ${#addrs[@]}) % ${#addrs[@]} ))
else
    next=$(( (pos + 1) % ${#addrs[@]} ))
fi

# Write target address to tmp file for Lua to read
echo "${addrs[$next]}" > /tmp/hypr-cycle-class-target
