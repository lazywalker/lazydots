#!/usr/bin/env bash
# niri Mod+C/Mod+V dispatcher: Firefox gets Ctrl+C/V (ignores wtype Shift+Insert),
# other apps get Ctrl+Insert / Shift+Insert so terminals aren't SIGINTed by Ctrl+C.
set -euo pipefail

action="${1:-paste}"

app_id="$(niri msg focused-window 2>/dev/null | awk -F'"' '/App ID:/ {print $2}')"

if [[ "${app_id,,}" == *firefox* ]]; then
    case "$action" in
        copy)  wtype -M ctrl -k c -m ctrl ;;
        paste) wtype -M ctrl -k v -m ctrl ;;
    esac
else
    case "$action" in
        copy)  wtype -M ctrl -k insert -m ctrl ;;
        paste) wtype -M shift -k insert -m shift ;;
    esac
fi
