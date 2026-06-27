#!/bin/bash
# dwindle-auto.sh — Auto-alternating split direction for Sway (Hyprland Dwindle-like)
#
# On each new window, reads the parent container layout from the sway tree
# and toggles it (splith ↔ splitv) for the next sibling.
# Default first split: splith (horizontal).

set -u
PIDFILE="${XDG_RUNTIME_DIR:-/tmp}/dwindle-auto.pid"
DEBUG="${DWM_DEBUG:-0}"
log() { [[ "$DEBUG" == 1 ]] && echo "[$(date '+%H:%M:%S')] $*" >> /tmp/dwindle.log; }

# Singleton: kill stale instance, then register
if [[ -f "$PIDFILE" ]]; then
    old_pid=$(cat "$PIDFILE" 2>/dev/null)
    if [[ -n "$old_pid" ]] && kill -0 "$old_pid" 2>/dev/null; then
        kill "$old_pid" 2>/dev/null
        sleep 0.2
    fi
fi
echo $$ > "$PIDFILE"
trap 'rm -f "$PIDFILE"' EXIT

# Wait for sway socket
for _ in $(seq 1 30); do
    swaymsg -t get_version &>/dev/null && break
    sleep 0.5
done

swaymsg -r -t subscribe -m '[ "window" ]' 2>/dev/null | while read -r event; do
    change=$(echo "$event" | jq -r '.change // empty' 2>/dev/null)
    [[ "$change" == "new" ]] || continue

    con_id=$(echo "$event" | jq -r '.container.id // empty' 2>/dev/null)
    [[ -n "$con_id" ]] || continue

    sleep 0.05

    tree=$(swaymsg -r -t get_tree 2>/dev/null)
    parent_layout=$(echo "$tree" | jq -r --argjson cid "$con_id" '
        [recurse(.nodes[]?, .floating_nodes[]?) |
         select(.nodes != null and (.nodes | map(.id) | index($cid) != null))]
        | first | .layout // empty
    ' 2>/dev/null)

    if [[ "$parent_layout" == "splith" ]]; then
        swaymsg splitv 2>/dev/null || true
    elif [[ "$parent_layout" == "splitv" ]]; then
        swaymsg splith 2>/dev/null || true
    else
        swaymsg splitv 2>/dev/null || true
    fi

    log "con=$con_id parent=$parent_layout → $( [[ "$parent_layout" == splith ]] && echo splitv || echo splith )"
done
