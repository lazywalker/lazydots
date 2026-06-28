-- =========================================================================
-- styles.lua — Niri layout{} ported to Hyprland 0.55+ Lua
-- =========================================================================

hl.config({
    general = {
        -- Niri: gaps 12 → Hyprland (CSS order: top, right, bottom, left)
        gaps_in  = 4,
        gaps_out = { top = 14, right = 6, bottom = 6, left = 6 },

        -- Niri: focus-ring { width 4 }
        border_size = 4,

        -- Niri: focus-ring { active-color "#7fc8ff", inactive-color "#505050" }
        col = {
            active_border   = "rgba(7fc8ffee)",
            inactive_border = "rgba(505050ee)",
        },

        layout = "dwindle",
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        mfact = 0.45,
    },

    decoration = {
        rounding = 4,

        blur = {
            enabled = true,
            size   = 3,
            passes = 1,
        },

        -- Niri shadow (disabled for Mac mini 2014 performance)
        -- shadow = {
        --     enabled      = true,
        --     range        = 30,
        --     render_power = 3,
        --     offset       = { 0, 5 },
        --     color        = 0xee1a1a1a,
        -- },
    },

    group = {
        groupbar = {
            enabled       = true,
            font_size     = 11,
            gradients     = false,
            render_titles = true,
        },
    },

    misc = {
        disable_hyprland_logo   = true,
        disable_splash_rendering = true,
        vrr = 0,
    },

    -- Prevent apps (sdl-freerdp3, VMs, etc.) from capturing global keybinds
    binds = {
        disable_keybind_grabbing = true,
    },
})
