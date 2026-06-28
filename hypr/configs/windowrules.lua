-- =========================================================================
-- windowrules.lua — Niri window-rule{} → Hyprland hl.window_rule()
-- RE2 regex (NOT Lua patterns): . = any, \\. = literal dot, - is literal
-- =========================================================================

-- Firefox Picture-in-Picture float
hl.window_rule({
    match = { title = "Picture-in-Picture" },
    float = true,
})

-- GNOME Loupe float
hl.window_rule({
    match = { class = "org\\.gnome\\.Loupe" },
    float = true,
})

-- Kitty theme picker float + fixed size
hl.window_rule({
    match = { title = "kitty-theme-picker" },
    float = true,
    size  = { 800, 500 },
})

-- DMS Settings → float (ported from Sway)
hl.window_rule({
    match = { class = "org\\.quickshell", title = "Settings" },
    float = true,
})
