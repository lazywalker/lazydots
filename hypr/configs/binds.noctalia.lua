-- =========================================================================
-- binds.noctalia.lua — Noctalia-specific keybindings for Hyprland
-- Source from hyprland.lua when using Noctalia desktop shell
-- =========================================================================

local ncl = "noctalia msg"

-- Launcher
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(ncl .. " panel-toggle launcher"),
    { description = "Noctalia launcher" })

-- Control center
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(ncl .. " panel-toggle control-center"),
    { description = "Noctalia control center" })

-- Overview
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("qs -c overview"),
    { description = "Toggle overview (Quickshell)" })

-- Lock screen
hl.bind(mainMod .. " + CTRL + ALT + L", hl.dsp.exec_cmd(ncl .. " session lock"),
    { description = "Lock screen" })

-- Power menu (fuzzel + Noctalia session actions)
hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd(
    [[sh -c 'printf "Lock\nLogout\nSuspend\nReboot\nShutdown" | fuzzel --dmenu --prompt="Power: " | xargs -r -I{} sh -c 'case "{}" in Lock) noctalia msg session lock;; Logout) noctalia msg session logout;; Suspend) noctalia msg session suspend;; Reboot) noctalia msg session reboot;; Shutdown) noctalia msg session shutdown;; esac'']]),
    { description = "Power menu" })

-- Toggle status bar auto-hide (Noctalia bar toggle placeholder)
-- hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd("..."),
--     { description = "Toggle status bar auto-hide" })

-- Next wallpaper
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(ncl .. " wallpaper-random"),
    { description = "Next wallpaper (Noctalia)" })

-- Rename workspace (fuzzel fallback)
hl.bind("CTRL + SHIFT + R", hl.dsp.exec_cmd(
    [[sh -c 'fuzzel --dmenu --prompt="Rename workspace: " | xargs -r -I{} hyprctl renameworkspace "{}"']]),
    { description = "Rename workspace" })

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd(ncl .. " screenshot-region"),
    { description = "Take screenshot (region)" })
hl.bind("CTRL + Print", hl.dsp.exec_cmd(ncl .. " screenshot-fullscreen"),
    { description = "Take screenshot (fullscreen)" })
hl.bind("ALT + Print", hl.dsp.exec_cmd(ncl .. " screenshot-fullscreen pick"),
    { description = "Take screenshot (pick monitor)" })
hl.bind("CTRL + ALT + S", hl.dsp.exec_cmd(
    "slurp | grim -g - - | swappy -f -"),
    { description = "Screenshot region + edit in swappy" })

-- Window switcher
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd(ncl .. " window-switcher"),
    { description = "Window switcher" })
