-- =========================================================================
-- binds.lua — Niri binds{} ported to Hyprland 0.55+ Lua
-- =========================================================================

local mainMod = "SUPER"

-- =========================================================================
-- Application Launchers
-- =========================================================================

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"),
    { description = "Open terminal (Kitty)" })

hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("dms ipc call launcher toggle"),
    { description = "DMS application launcher" })

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"),
    { description = "Open file manager (Thunar)" })

hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox"),
    { description = "Open web browser (Firefox)" })

hl.bind("F2", hl.dsp.exec_cmd("fuzzel"),
    { description = "Fuzzel app launcher (fallback)" })

hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("kitty --title kitty-theme-picker kitten themes"),
    { description = "Kitty theme picker" })

hl.bind(mainMod .. " + ALT + D", hl.dsp.exec_cmd(
    [[sh -c 'compgen -c | fuzzel --dmenu --prompt="Run command: " | xargs -r -I{} sh -c "exec {}"']]),
    { description = "Run command (fuzzel dmenu)" })

-- =========================================================================
-- Window Management
-- =========================================================================

hl.bind(mainMod .. " + Q", hl.dsp.window.close(),
    { description = "Close focused window" })

hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("dms ipc call overview toggle"),
    { description = "Toggle DMS overview" })

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }),
    { description = "Toggle maximized (pseudo-fullscreen)" })

hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
    { description = "Toggle fullscreen" })

hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
    { description = "Toggle maximize to edges" })

hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }),
    { description = "Toggle floating" })

hl.bind(mainMod .. " + W", hl.dsp.group.toggle(),
    { description = "Toggle group (tabbed column)" })

hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(
    "hyprctl reload && notify-send -e -u low -i preferences-system 'Hyprland' 'Config reloaded'"),
    { description = "Reload Hyprland config" })

hl.bind(mainMod .. " + bracketleft", hl.dsp.window.move({ into_or_create_group = "l" }),
    { description = "Move window into/out of group left" })

hl.bind(mainMod .. " + bracketright", hl.dsp.window.move({ into_or_create_group = "r" }),
    { description = "Move window into/out of group right" })

-- =========================================================================
-- Focus Navigation
-- =========================================================================

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }),
    { description = "Focus window left" })
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }),
    { description = "Focus window right" })
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }),
    { description = "Focus window up" })
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }),
    { description = "Focus window down" })

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }),
    { description = "Focus window left (vim)" })
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }),
    { description = "Focus window right (vim)" })
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }),
    { description = "Focus window up (vim)" })
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }),
    { description = "Focus window down (vim)" })

-- =========================================================================
-- Window Movement
-- =========================================================================

hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.move({ direction = "l" }),
    { description = "Move window left" })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ direction = "r" }),
    { description = "Move window right" })
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.move({ direction = "u" }),
    { description = "Move window up" })
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.move({ direction = "d" }),
    { description = "Move window down" })

hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.move({ direction = "l" }),
    { description = "Move window left (vim)" })
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.move({ direction = "r" }),
    { description = "Move window right (vim)" })
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.move({ direction = "u" }),
    { description = "Move window up (vim)" })
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.move({ direction = "d" }),
    { description = "Move window down (vim)" })

-- =========================================================================
-- Monitor Navigation
-- =========================================================================

hl.bind(mainMod .. " + SHIFT + left", hl.dsp.focus({ monitor = "l" }),
    { description = "Focus monitor left" })
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.focus({ monitor = "r" }),
    { description = "Focus monitor right" })
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.focus({ monitor = "u" }),
    { description = "Focus monitor up" })
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.focus({ monitor = "d" }),
    { description = "Focus monitor down" })

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.focus({ monitor = "l" }),
    { description = "Focus monitor left (vim)" })
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.focus({ monitor = "r" }),
    { description = "Focus monitor right (vim)" })
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.focus({ monitor = "u" }),
    { description = "Focus monitor up (vim)" })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.focus({ monitor = "d" }),
    { description = "Focus monitor down (vim)" })

hl.bind(mainMod .. " + SHIFT + CTRL + left", hl.dsp.window.move({ monitor = "l" }),
    { description = "Move window to monitor left" })
hl.bind(mainMod .. " + SHIFT + CTRL + right", hl.dsp.window.move({ monitor = "r" }),
    { description = "Move window to monitor right" })
hl.bind(mainMod .. " + SHIFT + CTRL + up", hl.dsp.window.move({ monitor = "u" }),
    { description = "Move window to monitor up" })
hl.bind(mainMod .. " + SHIFT + CTRL + down", hl.dsp.window.move({ monitor = "d" }),
    { description = "Move window to monitor down" })

hl.bind(mainMod .. " + SHIFT + CTRL + H", hl.dsp.window.move({ monitor = "l" }),
    { description = "Move window to monitor left (vim)" })
hl.bind(mainMod .. " + SHIFT + CTRL + L", hl.dsp.window.move({ monitor = "r" }),
    { description = "Move window to monitor right (vim)" })
hl.bind(mainMod .. " + SHIFT + CTRL + K", hl.dsp.window.move({ monitor = "u" }),
    { description = "Move window to monitor up (vim)" })
hl.bind(mainMod .. " + SHIFT + CTRL + J", hl.dsp.window.move({ monitor = "d" }),
    { description = "Move window to monitor down (vim)" })

-- =========================================================================
-- Workspace Navigation
-- =========================================================================

for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }),
        { description = "Switch to workspace " .. i })
end

for i = 1, 9 do
    hl.bind(mainMod .. " + CTRL + " .. i, hl.dsp.window.move({ workspace = i }),
        { description = "Move window to workspace " .. i })
end

hl.bind(mainMod .. " + page_up", hl.dsp.focus({ workspace = "e-1" }),
    { description = "Previous workspace" })
hl.bind(mainMod .. " + page_down", hl.dsp.focus({ workspace = "e+1" }),
    { description = "Next workspace" })
hl.bind(mainMod .. " + U", hl.dsp.focus({ workspace = "e-1" }),
    { description = "Previous workspace" })
hl.bind(mainMod .. " + I", hl.dsp.focus({ workspace = "e+1" }),
    { description = "Next workspace" })

hl.bind(mainMod .. " + CTRL + page_up", hl.dsp.window.move({ workspace = "e-1" }),
    { description = "Move window to previous workspace" })
hl.bind(mainMod .. " + CTRL + page_down", hl.dsp.window.move({ workspace = "e+1" }),
    { description = "Move window to next workspace" })
hl.bind(mainMod .. " + CTRL + U", hl.dsp.window.move({ workspace = "e-1" }),
    { description = "Move window to previous workspace" })
hl.bind(mainMod .. " + CTRL + I", hl.dsp.window.move({ workspace = "e+1" }),
    { description = "Move window to next workspace" })

hl.bind("ALT + X", hl.dsp.focus({ workspace = "previous" }),
    { description = "Switch to previous workspace" })

-- =========================================================================
-- Window Sizing
-- =========================================================================

hl.bind(mainMod .. " + minus", hl.dsp.window.resize({ x = -50, y = 0 }),
    { description = "Decrease window width" })
hl.bind(mainMod .. " + equal", hl.dsp.window.resize({ x = 50, y = 0 }),
    { description = "Increase window width" })
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.resize({ x = 0, y = -50 }),
    { description = "Decrease window height" })
hl.bind(mainMod .. " + SHIFT + equal", hl.dsp.window.resize({ x = 0, y = 50 }),
    { description = "Increase window height" })
hl.bind(mainMod .. " + CTRL + F", hl.dsp.window.resize({ x = 500, y = 0 }),
    { description = "Expand column width" })

-- =========================================================================
-- Screenshots
-- =========================================================================

hl.bind("Print", hl.dsp.exec_cmd("dms screenshot"),
    { description = "Take screenshot (select area)" })
hl.bind("CTRL + Print", hl.dsp.exec_cmd("dms screenshot --no-file"),
    { description = "Take screenshot to clipboard" })
hl.bind("ALT + Print", hl.dsp.exec_cmd("dms screenshot --window"),
    { description = "Take screenshot of active window" })
hl.bind("CTRL + ALT + A", hl.dsp.exec_cmd("dms screenshot --stdout | swappy -f -"),
    { description = "Screenshot + open in swappy editor" })

-- =========================================================================
-- System & Power
-- =========================================================================

hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("uwsm stop"),
    { description = "Exit Hyprland (via uwsm)" })
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("uwsm stop"),
    { description = "Exit Hyprland (Ctrl+Alt+Del)" })

hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("dms ipc call lock lock"),
    { description = "Lock screen" })

hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd("dms ipc call powermenu toggle"),
    { description = "Power menu" })

hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd("dms ipc call bar toggleAutoHide index 0"),
    { description = "Toggle status bar auto-hide" })

hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("overskride"),
    { description = "Bluetooth settings (Overskride)" })

hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("dms ipc call wallpaper next"),
    { description = "Next wallpaper" })

hl.bind(mainMod .. " + SHIFT + P", function()
    hl.timer(function()
        hl.dispatch(hl.dsp.dpms({ action = "disable" }))
    end, { timeout = 500, type = "oneshot" })
end, { description = "Power off monitors (DPMS)" })

hl.bind("CTRL + SHIFT + R", hl.dsp.exec_cmd("dms ipc call workspace-rename open"),
    { description = "Rename workspace" })

hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd("pkill orca || exec orca"),
    { description = "Toggle screen reader (Orca)" })

-- =========================================================================
-- Media & Volume Keys
-- =========================================================================

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 0.1+"),
    { description = "Raise volume", locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"),
    { description = "Lower volume", locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { description = "Mute audio", locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { description = "Mute microphone", locked = true })

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"),
    { description = "Play/Pause media", locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"),
    { description = "Stop media", locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"),
    { description = "Previous track", locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),
    { description = "Next track", locked = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl --class=backlight set +10%"),
    { description = "Increase brightness", locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl --class=backlight set 10%-"),
    { description = "Decrease brightness", locked = true })

-- =========================================================================
-- Mouse Wheel — workspace switching
-- =========================================================================

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }),
    { description = "Next workspace (scroll)" })
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }),
    { description = "Previous workspace (scroll)" })

hl.bind(mainMod .. " + CTRL + mouse_down", hl.dsp.window.move({ workspace = "e+1" }),
    { description = "Move window to next workspace (scroll)" })
hl.bind(mainMod .. " + CTRL + mouse_up", hl.dsp.window.move({ workspace = "e-1" }),
    { description = "Move window to previous workspace (scroll)" })

hl.bind(mainMod .. " + mouse_left", hl.dsp.focus({ direction = "l" }),
    { description = "Focus window left (scroll)" })
hl.bind(mainMod .. " + mouse_right", hl.dsp.focus({ direction = "r" }),
    { description = "Focus window right (scroll)" })

hl.bind(mainMod .. " + CTRL + mouse_left", hl.dsp.window.move({ direction = "l" }),
    { description = "Move window left (scroll)" })
hl.bind(mainMod .. " + CTRL + mouse_right", hl.dsp.window.move({ direction = "r" }),
    { description = "Move window right (scroll)" })

-- =========================================================================
-- Mouse Drag / Resize
-- =========================================================================

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),
    { description = "Drag window (Super + LMB)", mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(),
    { description = "Resize window (Super + RMB)", mouse = true })

-- =========================================================================
-- Miscellaneous
-- =========================================================================

hl.bind("SHIFT + Escape", hl.dsp.exec_cmd("wtype '~'"),
    { description = "Type tilde (68-key keyboard)" })

hl.bind(mainMod .. " + SHIFT + slash", hl.dsp.exec_cmd(
    [[sh -c 'hyprctl binds -j | jq -r ".[] | (if .modmask == 0 then \"\" elif .modmask == 64 then \"SUPER\" elif .modmask == 65 then \"SUPER+SHIFT\" elif .modmask == 8 then \"ALT\" elif .modmask == 72 then \"SUPER+ALT\" else \"MOD(\(.modmask))\" end) as \$mod | \"\(\$mod) + \(.key)\t ➔ \t \(.description // .arg)\"" | fuzzel --dmenu --width=90 --prompt="🔍 Search Keybinds: "']]),
    { description = "Search keybinds (fuzzel)" })

-- =========================================================================
-- Window Switcher
-- =========================================================================

hl.bind(mainMod .. " + Tab", hl.dsp.focus({ last = true }),
    { description = "Toggle between current and last window" })

hl.bind(mainMod .. " + Escape", function()
    hl.exec_cmd("~/.config/hypr/scripts/cycle-class.sh")
    hl.timer(function()
        local f = io.open("/tmp/hypr-cycle-class-target", "r")
        if f then
            local addr = f:read("*l")
            f:close()
            if addr and addr ~= "" then
                hl.dispatch(hl.dsp.focus({ window = "address:" .. addr }))
            end
        end
    end, { timeout = 100, type = "oneshot" })
end, { description = "Cycle next window of same class" })

hl.bind(mainMod .. " + SHIFT + Escape", function()
    hl.exec_cmd("~/.config/hypr/scripts/cycle-class.sh prev")
    hl.timer(function()
        local f = io.open("/tmp/hypr-cycle-class-target", "r")
        if f then
            local addr = f:read("*l")
            f:close()
            if addr and addr ~= "" then
                hl.dispatch(hl.dsp.focus({ window = "address:" .. addr }))
            end
        end
    end, { timeout = 100, type = "oneshot" })
end, { description = "Cycle previous window of same class" })
