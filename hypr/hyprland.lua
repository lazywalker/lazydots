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
dofile(base .. "/configs/windowrules.lua")

-- === Desktop shell integration ===
-- Choose one: dofile for DMS (default) or Noctalia
local noctalia_ok, noctalia = pcall(dofile, base .. "/noctalia.lua")
if noctalia_ok then
    -- Noctalia is installed: apply dynamic theme via hyprctl eval (avoids hl.config() resetting general.*)
    local p = noctalia.colors.primary
    local s = noctalia.colors.surface
    local e = noctalia.colors.error
    hl.exec_cmd("hyprctl eval 'hl.config({ general = { col = { active_border = " .. p .. ", inactive_border = " .. s .. " } } })'")
    hl.exec_cmd("hyprctl eval 'hl.config({ group = { col = { border_active = " .. p .. ", border_inactive = " .. s .. ", border_locked_active = " .. e .. ", border_locked_inactive = " .. s .. " } } })'")
    hl.exec_cmd("hyprctl eval 'hl.config({ group = { groupbar = { col = { active = " .. p .. ", inactive = " .. s .. ", locked_active = " .. e .. ", locked_inactive = " .. s .. " } } } })'")
    dofile(base .. "/configs/binds.noctalia.lua")
else
    -- Fallback: DMS binds (DankMaterialShell)
    dofile(base .. "/configs/binds.dms.lua")
end

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

-- Noctalia Color templates: apply colors via hyprctl eval (not hl.config)
-- to avoid resetting general.* fields like layout.
local ok, ncl = pcall(dofile, base .. "/noctalia.lua")
if ok and ncl and ncl.colors then
    local c = ncl.colors
    hl.exec_cmd("hyprctl eval 'hl.config({ general = { col = { active_border = " .. c.primary .. ", inactive_border = " .. c.surface .. " } } })'")
    hl.exec_cmd("hyprctl eval 'hl.config({ group = { col = { border_active = " .. c.secondary .. ", border_inactive = " .. c.surface .. ", border_locked_active = " .. c.error .. ", border_locked_inactive = " .. c.surface .. " } } })'")
    hl.exec_cmd("hyprctl eval 'hl.config({ group = { groupbar = { col = { active = " .. c.secondary .. ", inactive = " .. c.surface .. ", locked_active = " .. c.error .. ", locked_inactive = " .. c.surface .. " } } } })'")
end

-- For Noctalia Color templates (kept for apply.sh compatibility)
require("noctalia").apply_theme()

-- Restore layout after Noctalia apply_theme() resets general.* on reload.
-- Read the layout saved by layout-cycle.sh or the last user selection.
local f = io.open(base .. "/.layout", "r")
if f then
    local layout = f:read("*l")
    f:close()
    if layout and layout ~= "" and layout ~= "dwindle" then
        hl.config({ general = { layout = layout } })
        -- Scrolling layout needs extra settings
        if layout == "scrolling" then
            hl.config({ scrolling = { column_width = 0.4 } })
            hl.config({ general = { gaps_out = { top = 6, right = 6, bottom = 6, left = 30 } } })
        end
    end
end
