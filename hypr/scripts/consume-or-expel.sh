#!/usr/bin/env bash
# =========================================================================
# consume-or-expel.sh — Layout-aware Mod+[ / Mod+] dispatcher
#
# In scrolling layout: consume_or_expel prev/next (matches niri semantics)
# In other layouts:    move window into/out of group left/right (original behavior)
#
# Usage: consume-or-expel.sh {left|right}
# =========================================================================

set -euo pipefail

dir="${1:?missing direction (left|right)}"

layout=$(hyprctl -j getoption general:layout 2>/dev/null | jq -r '.str')

if [[ "$layout" == "scrolling" ]]; then
    case "$dir" in
        left)  hyprctl eval 'hl.dispatch(hl.dsp.layout("consume_or_expel prev"))' >/dev/null 2>&1 ;;
        right) hyprctl eval 'hl.dispatch(hl.dsp.layout("consume_or_expel next"))' >/dev/null 2>&1 ;;
        *) echo "invalid direction: $dir" >&2; exit 1 ;;
    esac
else
    case "$dir" in
        left)  hyprctl eval 'hl.dispatch(hl.dsp.window.move({ into_or_create_group = "l" }))' >/dev/null 2>&1 ;;
        right) hyprctl eval 'hl.dispatch(hl.dsp.window.move({ into_or_create_group = "r" }))' >/dev/null 2>&1 ;;
        *) echo "invalid direction: $dir" >&2; exit 1 ;;
    esac
fi
