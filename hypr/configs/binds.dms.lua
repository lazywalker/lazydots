-- =========================================================================
-- binds.dms.lua — DMS-specific keybindings for Hyprland
-- Source from hyprland.lua when using DMS desktop shell
-- =========================================================================

-- Launcher
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("dms ipc call launcher toggle"),
    { description = "DMS application launcher" })

-- Overview
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("dms ipc call overview toggle"),
    { description = "Toggle DMS overview" })

-- Lock screen
hl.bind(mainMod .. " + CTRL + ALT + L", hl.dsp.exec_cmd("dms ipc call lock lock"),
    { description = "Lock screen" })

-- Power menu
hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd("dms ipc call powermenu toggle"),
    { description = "Power menu" })

-- Toggle status bar auto-hide
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd("dms ipc call bar toggleAutoHide index 0"),
    { description = "Toggle status bar auto-hide" })

-- Next wallpaper
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("dms ipc call wallpaper next"),
    { description = "Next wallpaper" })

-- Rename workspace
hl.bind("CTRL + SHIFT + R", hl.dsp.exec_cmd("dms ipc call workspace-rename open"),
    { description = "Rename workspace" })

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd("dms screenshot"),
    { description = "Take screenshot (select area)" })
hl.bind("CTRL + Print", hl.dsp.exec_cmd("dms screenshot --no-file"),
    { description = "Take screenshot to clipboard" })
hl.bind("ALT + Print", hl.dsp.exec_cmd("dms screenshot --window"),
    { description = "Take screenshot of active window" })
hl.bind("CTRL + ALT + S", hl.dsp.exec_cmd("dms screenshot --stdout | swappy -f -"),
    { description = "Screenshot + open in swappy editor" })
