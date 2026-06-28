-- =========================================================================
-- layouts.lua — Layout cycling via Super+F2 with DMS notify feedback
-- =========================================================================

-- Super+Shift+L → cycle through master → dwindle → scrolling → monocle
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd(
    "~/.config/hypr/scripts/layout-cycle.sh"
), { description = "Cycle layout (master → dwindle → scrolling → monocle)" })
