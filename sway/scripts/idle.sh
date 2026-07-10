#!/bin/sh
# sway/scripts/idle.sh — Idle management for sway
#
# Noctalia's [idle] config relies on ext-idle-notify-v1, which sway 1.12 does
# not implement. This script runs swayidle as a fallback, with timeouts
# matching noctalia/config.toml (lock 300s, screen-off 600s). Locking goes
# through Noctalia so the lock screen stays consistent across compositors.
#
# Invoked from sway/config as a single script to avoid sway's exec quoting
# issues with multi-word commands.

exec swayidle -w \
    timeout 300 'noctalia msg session lock' \
    timeout 600 'swaymsg output "*" power off' resume 'swaymsg output "*" power on' \
    before-sleep 'noctalia msg session lock'
