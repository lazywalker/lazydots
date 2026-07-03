-- =========================================================================
-- exec.lua — Environment + Monitor + Startup commands
-- =========================================================================

-- === Environment Variables ===
hl.env("XCURSOR_SIZE", "24")
hl.env("GTK_THEME", "Adwaita:dark")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- === Monitor ===
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

-- === Startup Applications ===
hl.on("hyprland.start", function()
    hl.exec_cmd("uwsm finalize")
    -- Desktop shell: Noctalia if installed, otherwise DMS
    local f = io.open(os.getenv("HOME") .. "/.config/hypr/noctalia.lua", "r")
    if f then
        f:close()
        hl.exec_cmd("noctalia")
    else
        hl.exec_cmd("dms run")
    end
    hl.exec_cmd("fcitx5 -d --replace")
    hl.exec_cmd("nm-applet --indicator")
end)
