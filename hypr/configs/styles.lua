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
        mfact = 0.6,
        new_status = "slave",
        new_on_top = false,
    },

    decoration = {
        rounding = 0,

        blur = {
            enabled = true,
            size   = 3,
            passes = 1,
        },

        -- Niri shadow (disabled for Mac mini 2014 performance)
        shadow = {
            enabled      = false,
            range        = 10,
            render_power = 3,
            offset       = { 0, 5 },
            color        = 0xee1a1a1a,
        },
    },

    group = {
        groupbar = {
            enabled       = true,
            height        = 18,
            font_size     = 12,
            gradients     = true,
            render_titles = true,
            stacked       = false,
            text_color          = 0xffffffff,
            text_color_inactive = 0xaacccccc,
            -- col = {
            --     active   = 0xff555555,
            --     inactive = 0xff333333,
            -- },
        },
    },

    scrolling = {
        fullscreen_on_one_column = false,
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
