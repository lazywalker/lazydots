#!/usr/bin/env bash
# keyhint.sh — shortcut cheatsheet shown in fuzzel (display-only, single column).
#
# Compositor-agnostic: fuzzel runs under Wayland (Hyprland/Niri/Sway) and X11,
# so the same script works everywhere. Bind a key to it in each compositor.
#
# Layout: categories as bold colored headers, then "key — description" lines.
# Pango markup is used for the headers (fuzzel renders it).
#
# Usage: keyhint.sh [fuzzel args...]

set -euo pipefail

FUZZEL_BIN="fuzzel"

# ---------------------------------------------------------------------------
# Shortcut dataset
# Format per category:  "Category Name" header, then "key<TAB>description".
# Edit this block to keep your cheatsheet in sync across compositors.
# ---------------------------------------------------------------------------
DATA="$(cat <<'EOF'
Launcher & Session
Super+Return	Terminal
Super+D	App launcher
Super+Alt+D	Run command
Super+Alt+P	Power menu
Super+L	Lock screen
Super+Slash	This cheatsheet

Windows
Super+Q	Close window
Super+F	Fullscreen
Super+Shift+F	Maximize
Super+Space	Toggle floating
Super+W	Send Ctrl+W (close tab)
Super+C	Copy (context)
Super+V	Paste (context)
Super+A	Select all

Navigation
Super+Left/Right	Focus column
Super+Up/Down	Focus window
Super+Home/End	First/last column
Super+1..9	Go to workspace
Super+Shift+1..9	Move to workspace
Super+Tab	Cycle windows

Layout
Super+H/J/K/L	Move focus (vim)
Super+Shift+H/J/K/L	Move window
Super+,	Consume into column
Super+.	Expel from column
Super+R	Reset height
Super+Ctrl+R	Cycle preset height
Super+Ctrl+F	Expand to width

Screenshots & Record
Print	Screenshot
Ctrl+Print	Screenshot screen
Alt+Print	Screenshot window
Ctrl+Alt+S	Screenshot + edit
Ctrl+Shift+[	Record screen
Ctrl+Alt+[	Record region
Ctrl+Shift+]	Stop recording
EOF
)"

# ---------------------------------------------------------------------------
# Render: build fuzzel input lines.
# fuzzel dmenu shows lines as plain text (no Pango), so we avoid markup and
# use a simple prefix + spacing for hierarchy.
# ---------------------------------------------------------------------------
out=""
tab=$'\t'
# First pass: find the longest key so descriptions can be tab-aligned.
maxkey=0
while IFS= read -r line; do
    [[ -z "$line" ]] && continue
    [[ "$line" == *"$tab"* ]] && continue
    k="${line%%$tab*}"
    ((${#k} > maxkey)) && maxkey=${#k}
done <<< "$DATA"

while IFS= read -r line; do
    [[ -z "$line" ]] && continue
    if [[ "$line" != *"$tab"* ]]; then
        # Category header: blank line above + prefixed title.
        [[ -z "$out" ]] || out+=$'\n'
        out+="▸ ${line}"
        out+=$'\n'
    else
        key="${line%%$tab*}"
        desc="${line#*$tab}"
        # Pad key to maxkey, then a tab before the description → aligned column.
        padded=$(printf '%-*s' "$maxkey" "$key")
        out+="   ${padded}${tab}${desc}"
        out+=$'\n'
    fi
done <<< "$DATA"

# Trim trailing newline.
out="${out%$'\n'}"

# ---------------------------------------------------------------------------
# Show via fuzzel (display-only; user just reads and dismisses).
# ---------------------------------------------------------------------------
printf '%s' "$out" | "$FUZZEL_BIN" --dmenu \
    --prompt="Shortcuts — Esc to close   " \
    --lines 45 --width 50 \
    "$@" >/dev/null 2>&1 || true
