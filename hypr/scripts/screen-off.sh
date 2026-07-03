##
## pacman -S hypridle
##

# =========================================================================
# screen-off.sh — Power off monitors via hyprctl dpms + hypridle wake
#
# Usage:  $mod+Shift+P  (bound in hypr/configs/binds.lua)
# Effect: turns off monitors, wakes on any input (mouse/keyboard)
# =========================================================================

CONFIG=/tmp/hypridle-screen-off.conf

cat > "$CONFIG" << 'CONF'
general {
    lock_cmd = hyprctl dispatch dpms on
    unlock_cmd = hyprctl dispatch dpms on
    before_sleep_cmd = hyprctl dispatch dpms on
}

listener {
    timeout = 1
    on-timeout = hyprctl eval 'hl.dispatch(hl.dsp.dpms({ action = "off" }))'
    on-resume = hyprctl eval 'hl.dispatch(hl.dsp.dpms({ action = "on" }))' && pkill hypridle
}
CONF

killall hypridle 2>/dev/null
hypridle -c "$CONFIG"
rm -f "$CONFIG"