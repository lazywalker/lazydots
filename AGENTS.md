# AGENTS.md — KoolDots dotfiles

In-place git repo at `~/.config` (the directory IS the repo). Arch Linux +
Wayland. No symlink manager. Main branch is `main`; work happens on `master`.

## Compositor / shell layout

Three Wayland compositors + one X11, each with parallel Noctalia and DMS
(DankMaterialShell) keybind sets:

| Compositor | Entry | Shell auto-detection |
|------------|-------|----------------------|
| Hyprland (primary) | `hypr/hyprland.lua` (Hyprland 0.55+ Lua API: `hl.config`/`hl.bind`/`hl.dsp.*`) | `hypr/configs/exec.lua` pchecks `hypr/noctalia.lua` existence → starts `noctalia` else `dms run` |
| Niri | `niri/configs/*.kdl` | `binds.noctalia.kdl` / `binds.dms.kdl` |
| Sway | `sway/config` → includes `sway/configs/binds` + `sway/noctalia` | `sway/noctalia` (generated) / `sway/binds.noctalia` (tracked) |
| FVWM3 (X11, submodule) | `fvwm/` | tint2 panel |

Keybind files: `binds.noctalia.*` (Noctalia shell) and `binds.dms.*` (fallback).
When adding a binding that should work under both shells, put it in the base
`binds.lua`/`binds`/`binds.kdl`; only Noctalia/DMS-specific commands go in the
`.noctalia`/`.dms` variants.

## Submodules

`nvim/` → github.com/lazywalker/minivim · `fvwm/` → github.com/lazywalker/fvwm

Changes inside a submodule must be committed and pushed **in the submodule**
first, then the parent repo records the new pointer (often via `--amend` into
the current HEAD in this repo's workflow).

## Noctalia config layering (v5)

Two layers, do NOT merge them:
- `~/.config/noctalia/config.toml` — **base layer**, hand-written, tracked here.
  File name MUST be `config.toml`, not `settings.toml` (the name `settings.toml`
  inside the config dir gets treated as the state/override layer and wins).
- `~/.local/state/noctalia/settings.toml` — **GUI override layer**, owned by
  Noctalia, untracked. When a GUI value equals the base layer, Noctalia removes
  the redundant key automatically.

`noctalia/config.toml` intentionally omits volatile `[wallpaper.default/last/
monitors]` paths — Noctalia writes those at runtime into the state layer.

`noctalia config validate` / `noctalia config export merged` are the source of
truth for the effective config.

## .gitignore strategy

`/*` ignores everything by default; directories/files are re-whitelisted
individually. Noctalia-generated files are explicitly un-tracked even inside
whitelisted dirs: `hypr/noctalia.lua`, `kitty/current-theme.conf`,
`niri/noctalia.kdl`, `sway/noctalia`, `fuzzel/themes/noctalia`. Runtime state
`hypr/.layout` (written by `hypr/scripts/layout-cycle.sh`) is also ignored.

## nvim (submodule) specifics

- Neovim 0.11+ (uses `vim.lsp.config`/`vim.lsp.enable`); `nvim-lspconfig` must
  have a trigger (`event`) or `vim.lsp.enable` never runs (past bug).
- Theming: catppuccin (`transparent_background = true`) as cross-platform
  fallback; base16/matugen (`lua/matugen.lua`, gitignored, Noctalia-generated)
  layers on top on Linux via SIGUSR1 hot-reload. Both `lua/matugen.lua` and
  `lua/plugins/base16.lua` are Noctalia-generated and gitignored.
- Plugins: blink.cmp (v1, `version="1.*"`), gitsigns, mini.* ecosystem
  (bufremove/cursorword/starter/statusline/indentscope/icons/pairs/comment),
  nvim-tree, bufferline, telescope, which-key, render-markdown, treesitter
  (main branch: highlight via `vim.treesitter.start()`, not the old
  `configs.setup`).
- `options.lua`: OSC52 clipboard fallback when `$SSH_CONNECTION` is set.
- Editing nvim files = editing inside the `nvim/` submodule; commit there.

## Idle behavior differs per compositor

- **Hyprland**: Noctalia's `[idle]` works (Hyprland implements
  `ext-idle-notify-v1`).
- **Sway 1.12**: does NOT implement `ext-idle-notify-v1` ("idle notify protocol
  unavailable; idle behaviors not registered"). Fall back to
  `sway/scripts/idle.sh` (swayidle wrapper). Multi-word swayidle commands must
  be quoted; the wrapper script exists because sway's `exec` mangles inline
  quotes.

## Useful commands

```
hyprctl reload                       # Hyprland reload
niri msg action do-screen-transition # Niri reload
swaymsg reload                       # Sway reload (binds notify)
noctalia config validate             # check Noctalia config
noctalia config export merged        # effective merged config
noctalia msg panel-toggle <name>     # toggle launcher/control-center/session
git submodule update --init --recursive
git -C nvim push origin master       # then amend pointer in parent repo
```

## Conventions

- Commit messages: short subject (`type: summary`); prefer single-line unless
  the change genuinely needs a body.
- In this repo, submodule pointer bumps are commonly `--amend`-ed into the
  current HEAD rather than separate commits.
- Hyprland Lua API dispatchers use `hl.dsp.*`, e.g. `hl.dsp.window.cycle_next`,
  `hl.dsp.window.close()`, `hl.dsp.focus({last=true})`. Window cycle is
  `hl.dsp.window.cycle_next({tiled=true, floating=true})`.
- There is no remote for the parent dotfiles repo.
