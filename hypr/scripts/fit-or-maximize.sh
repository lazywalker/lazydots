#!/usr/bin/env bash
# =========================================================================
# fit-or-maximize.sh - Layout-aware Mod+F dispatcher
#
# In scrolling layout: niri-like "fit into view" - resize the focused window
#   to fill the usable view (zoom). Press again to return it to the default
#   column width. (Scrolling caps a lone column near 50 percent to keep
#   scroll room; with neighbour columns it fills the whole view.)
# In other layouts:    toggle maximized (pseudo-fullscreen)
# =========================================================================

set -euo pipefail
set +H

layout=$(hyprctl -j getoption general:layout 2>/dev/null | jq -r '.str')

if [[ "$layout" == "scrolling" ]]; then
    hyprctl eval '
    local DEFAULT_COL = 0.45
    local w = hl.get_active_window()
    if not w then return end
    local m = hl.get_active_monitor()
    if not m then return end
    local res = m.reserved or {}
    local rl, rr, rt, rb = res.left or 0, res.right or 0, res.top or 0, res.bottom or 0
    local usableW = m.width - rl - rr
    -- In scrolling the window height is locked to the column; resize rejects
    -- any y that differs from the current height, so keep y equal to it.
    local h = math.floor(w.size.y)
    local col = w.layout and w.layout.column
    local curW = col and col.width or DEFAULT_COL
    -- toggle: if already filled, reset to default column; else fill view.
    -- lone columns cap near 0.5; use 0.47 as the filled threshold.
    if curW >= 0.47 then
        hl.dispatch(hl.dsp.window.resize({ x = math.floor(DEFAULT_COL * usableW), y = h }))
    else
        hl.dispatch(hl.dsp.window.resize({ x = math.floor(usableW * 0.95), y = h }))
    end
    ' >/dev/null 2>&1
else
    hyprctl eval 'hl.dispatch(hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))' >/dev/null 2>&1
fi
