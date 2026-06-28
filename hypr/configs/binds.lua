-- =========================================================================
-- binds.lua — Niri binds{} ported to Hyprland 0.55+ Lua
-- =========================================================================

local mainMod = "SUPER"

-- =========================================================================
-- Application Launchers
-- =========================================================================

-- Terminal (Niri: Mod+Return)
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"))

-- DMS Launcher (Niri: Mod+D)
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("dms ipc call launcher toggle"))

-- File Manager (Niri: Mod+E)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"))

-- Web Browser (Niri: Mod+B)
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox"))

-- Fuzzel fallback
hl.bind("F2", hl.dsp.exec_cmd("fuzzel"))

-- Kitty theme picker (Niri: Mod+Shift+T)
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("kitty --title kitty-theme-picker kitten themes"))

-- Run Command via fuzzel dmenu (Niri: Mod+Alt+D)
hl.bind(mainMod .. " + ALT + D", hl.dsp.exec_cmd(
    [[sh -c 'compgen -c | fuzzel --dmenu --prompt="Run command: " | xargs -r -I{} sh -c "exec {}"']]
))

-- =========================================================================
-- Window Management
-- =========================================================================

-- Close window (Niri: Mod+Q)
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- Toggle overview via DMS (Niri: Mod+O)
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("dms ipc call overview toggle"))

-- Maximize in space / pseudo (Niri: Mod+F)
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

-- True fullscreen (Niri: Mod+Shift+F)
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Maximize to edges (Niri: Mod+M)
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Toggle floating (Niri: Mod+V)
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))

-- Toggle group / tabbed column (Niri: Mod+W)
hl.bind(mainMod .. " + W", hl.dsp.group.toggle())

-- Reload config (Niri: Mod+Shift+R)
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

-- Move window into/out of group (Niri: Mod+BracketLeft/Right)
hl.bind(mainMod .. " + bracketleft", hl.dsp.window.move({ into_or_create_group = "l" }))
hl.bind(mainMod .. " + bracketright", hl.dsp.window.move({ into_or_create_group = "r" }))

-- =========================================================================
-- Focus Navigation
-- =========================================================================

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }))

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

-- =========================================================================
-- Window Movement
-- =========================================================================

hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.move({ direction = "d" }))

hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.move({ direction = "d" }))

-- =========================================================================
-- Monitor Navigation
-- =========================================================================

hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.focus({ monitor = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.focus({ monitor = "r" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.focus({ monitor = "u" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.focus({ monitor = "d" }))

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.focus({ monitor = "l" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.focus({ monitor = "r" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.focus({ monitor = "u" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.focus({ monitor = "d" }))

-- Move window to monitor (Niri: Mod+Shift+Ctrl+arrows)
hl.bind(mainMod .. " + SHIFT + CTRL + left",  hl.dsp.window.move({ monitor = "l" }))
hl.bind(mainMod .. " + SHIFT + CTRL + right", hl.dsp.window.move({ monitor = "r" }))
hl.bind(mainMod .. " + SHIFT + CTRL + up",    hl.dsp.window.move({ monitor = "u" }))
hl.bind(mainMod .. " + SHIFT + CTRL + down",  hl.dsp.window.move({ monitor = "d" }))

hl.bind(mainMod .. " + SHIFT + CTRL + H", hl.dsp.window.move({ monitor = "l" }))
hl.bind(mainMod .. " + SHIFT + CTRL + L", hl.dsp.window.move({ monitor = "r" }))
hl.bind(mainMod .. " + SHIFT + CTRL + K", hl.dsp.window.move({ monitor = "u" }))
hl.bind(mainMod .. " + SHIFT + CTRL + J", hl.dsp.window.move({ monitor = "d" }))

-- =========================================================================
-- Workspace Navigation
-- =========================================================================

-- Workspace 1-9 (Niri: Mod+1..9)
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end

-- Move window to workspace 1-9 (Niri: Mod+Ctrl+1..9)
for i = 1, 9 do
    hl.bind(mainMod .. " + CTRL + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Workspace up/down (Niri: Mod+Page_Up/Down, Mod+U/I)
hl.bind(mainMod .. " + page_up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + page_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + U", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + I", hl.dsp.focus({ workspace = "e+1" }))

-- Move to workspace up/down
hl.bind(mainMod .. " + CTRL + page_up",   hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + page_down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mainMod .. " + CTRL + U", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + I", hl.dsp.window.move({ workspace = "e+1" }))

-- Previous workspace (Niri: Alt+X)
hl.bind("ALT + X", hl.dsp.focus({ workspace = "previous" }))

-- =========================================================================
-- Window Sizing
-- =========================================================================

hl.bind(mainMod .. " + minus", hl.dsp.window.resize({ x = -50, y = 0 }))
hl.bind(mainMod .. " + equal", hl.dsp.window.resize({ x = 50, y = 0 }))
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.resize({ x = 0, y = -50 }))
hl.bind(mainMod .. " + SHIFT + equal", hl.dsp.window.resize({ x = 0, y = 50 }))

-- Expand column to available width (Niri: Mod+Ctrl+F — approximate)
hl.bind(mainMod .. " + CTRL + F", hl.dsp.window.resize({ x = 500, y = 0 }))

-- =========================================================================
-- Screenshots
-- =========================================================================

hl.bind("Print", hl.dsp.exec_cmd("dms screenshot"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("dms screenshot --no-file"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("dms screenshot --window"))

-- Screenshot + open in swappy editor (ported from Sway: Ctrl+Alt+A)
hl.bind("CTRL + ALT + A", hl.dsp.exec_cmd("dms screenshot --stdout | swappy -f -"))

-- =========================================================================
-- System & Power
-- =========================================================================

-- Exit via uwsm (recommended for uwsm users)
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("uwsm stop"))
hl.bind("CTRL + ALT + Delete",      hl.dsp.exec_cmd("uwsm stop"))

-- Lock screen
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("dms ipc call lock lock"))

-- Power menu
hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd("dms ipc call powermenu toggle"))

-- Toggle status bar
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd("dms ipc call bar toggleAutoHide index 0"))

-- Bluetooth settings via Overskride
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("overskride"))

-- Next wallpaper
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("dms ipc call wallpaper next"))

-- DPMS off (with safety timer)
hl.bind(mainMod .. " + SHIFT + P", function()
    hl.timer(function()
        hl.dispatch(hl.dsp.dpms({ action = "disable" }))
    end, { timeout = 500, type = "oneshot" })
end)

-- Rename workspace via DMS
hl.bind("CTRL + SHIFT + R", hl.dsp.exec_cmd("dms ipc call workspace-rename open"))

-- Screen reader toggle
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd("pkill orca || exec orca"))

-- =========================================================================
-- Media & Volume Keys (locked + repeating)
-- =========================================================================

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 0.1+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true })

hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioStop",  hl.dsp.exec_cmd("playerctl stop"),       { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })

hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl --class=backlight set +10%"),
    { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl --class=backlight set 10%-"),
    { locked = true })

-- =========================================================================
-- Mouse Wheel — workspace switching
-- =========================================================================

-- Vertical scroll: switch workspace (Niri: Mod+WheelScroll)
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Ctrl + Vertical scroll: move window to workspace (Niri: Mod+Ctrl+WheelScroll)
hl.bind(mainMod .. " + CTRL + mouse_down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mainMod .. " + CTRL + mouse_up",   hl.dsp.window.move({ workspace = "e-1" }))

-- Horizontal scroll: focus column (Niri: Mod+WheelScrollLeft/Right)
hl.bind(mainMod .. " + mouse_left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + mouse_right", hl.dsp.focus({ direction = "r" }))

-- Ctrl + Horizontal scroll: move window (Niri: Mod+Ctrl+WheelScrollLeft/Right)
hl.bind(mainMod .. " + CTRL + mouse_left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + CTRL + mouse_right", hl.dsp.window.move({ direction = "r" }))

-- =========================================================================
-- Mouse Drag / Resize (Niri: Mod + LMB/RMB)
-- =========================================================================

-- Mod + Left Mouse Button → drag window
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

-- Mod + Right Mouse Button → resize window
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- =========================================================================
-- Miscellaneous
-- =========================================================================

-- Tilde on 68-key keyboard (Niri: Shift+Escape)
hl.bind("SHIFT + Escape", hl.dsp.exec_cmd("wtype \'~\'"))

-- Show hotkey overlay
hl.bind(mainMod .. " + SHIFT + slash", hl.dsp.exec_cmd(
    [[notify-send "Hyprland" "Binds → ~/.config/hypr/configs/binds.lua"]]
))

-- =========================================================================
-- Window Switcher (Niri: recent-windows { Mod+Tab, Mod+Escape })
-- =========================================================================

-- Super+Tab → toggle between current and last focused window (cross-workspace)
hl.bind(mainMod .. " + Tab", hl.dsp.focus({ last = true }))

-- Super+Escape → cycle next window of same class (cross-workspace)
hl.bind(mainMod .. " + Escape", function()
    -- Run shell script to compute target address → /tmp/hypr-cycle-class-target
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
end)

-- Super+Shift+Escape → cycle previous window of same class
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
end)
