-- =========================================================================
-- hyprland.lua — Main entry for Hyprland 0.55+
-- =========================================================================

-- === Input (hardware-specific) ===
hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = -0.5,
        touchpad = {
            natural_scroll = true,
            tap_to_click = true,
        },
    },
})

-- === Load modular configs ===
local home = os.getenv("HOME")
local base = home .. "/.config/hypr"

dofile(base .. "/configs/styles.lua")
dofile(base .. "/configs/exec.lua")
dofile(base .. "/configs/binds.lua")
dofile(base .. "/configs/layouts.lua")
dofile(base .. "/configs/windowrules.lua")

-- === User overrides (loaded last) ===
dofile(base .. "/UserConfigs/binds.lua")

-- =========================================================================
-- Animations (lightweight for old Mac mini)
-- =========================================================================

hl.curve("myBezier", {
    type   = "bezier",
    points = { { 0.05, 0.9 }, { 0.1, 1.05 } },
})

hl.animation({ leaf = "windows",      enabled = true, speed = 5,   bezier = "myBezier", style = "popin 87%" })
hl.animation({ leaf = "windowsIn",    enabled = true, speed = 5,   bezier = "myBezier", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",   enabled = true, speed = 5,   bezier = "myBezier", style = "popin 87%" })
hl.animation({ leaf = "workspaces",   enabled = true, speed = 4,   bezier = "default",  style = "slidevert" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 4,  bezier = "default",  style = "slidevert" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 4,  bezier = "default",  style = "slidevert" })
hl.animation({ leaf = "fade",         enabled = true, speed = 3,   bezier = "default" })
hl.animation({ leaf = "fadeIn",       enabled = true, speed = 3,   bezier = "default" })
hl.animation({ leaf = "fadeOut",      enabled = true, speed = 3,   bezier = "default" })
hl.animation({ leaf = "border",       enabled = true, speed = 5,   bezier = "myBezier" })
