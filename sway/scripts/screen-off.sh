#!/bin/sh
# sway/scripts/screen-off.sh — Manual screen-off for Sway (Noctalia or DMS shell)
#
# Sway 1.12 does not implement ext-idle-notify-v1, so Noctalia's [idle] config
# is inert here. This script locks the session (shell-dependent) and powers the
# outputs off. A swayidle watcher (timeout 1 -> no-op, resume -> power on) only
# turns the screen back on when a real input wakes it. The blanking itself is
# done explicitly below, so the watcher can never re-light the screen on its
# own; it can only react to an actual wake event.
#
# Usage:
#   screen-off.sh            -> lock via Noctalia (default)
#   screen-off.sh dms        -> lock via DMS (dms ipc call lock lock)
#   screen-off.sh "<cmd>"    -> lock via an explicit command

set -e

case "${1:-noctalia}" in
    noctalia) LOCK_CMD="noctalia msg session lock" ;;
    dms)      LOCK_CMD="dms ipc call lock lock" ;;
    *)        LOCK_CMD="$1" ;;
esac

# Stop the idle daemon so it doesn't fight us (idle.sh / a prior run).
killall swayidle 2>/dev/null || true

# Lock first so there is no unlocked black-screen window, then blank.
$LOCK_CMD
swaymsg output '*' power off

# Watcher: after a 1s idle window (no-op action) any real input triggers
# `resume`, which powers the outputs back on and exits. Because the power-off
# above is explicit and the timeout action is a no-op, this cannot re-light the
# screen by itself — only an actual wake event does.
exec swayidle -w \
    timeout 1 'true' \
    resume 'swaymsg output "*" power on; killall swayidle' \
    before-sleep 'swaymsg output "*" power on'
