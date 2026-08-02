#!/usr/bin/env bash
# keyhint.sh — shortcut cheatsheet shown in fuzzel (display-only, single column).
#
# Compositor-agnostic: fuzzel runs under Wayland (Hyprland/Niri/Sway) and X11.
#
# Data is split:
#   share/scripts/keyhint.common.txt   – keys common to all compositors
#   <comp>/scripts/keyhint.<comp>.txt  – compositor-specific keys, maintained
#                                         next to that compositor's binds.
# The script auto-detects the running compositor, concatenates common + local,
# and renders a tab-aligned list in fuzzel.
#
# Usage: keyhint.sh [--scope niri|sway|hypr] [fuzzel args...]

set -euo pipefail

FUZZEL_BIN="fuzzel"
SHARE_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/share/scripts"
SCOPE=""

# Optional --scope override.
if [[ "${1:-}" == "--scope" ]]; then
    SCOPE="${2:-}"
    shift 2 || true
fi

# ---------------------------------------------------------------------------
# Detect compositor: XDG_CURRENT_DESKTOP → fall back to process probe.
# ---------------------------------------------------------------------------
detect_comp() {
    local de="${XDG_CURRENT_DESKTOP:-}"
    de="${de,,}"
    case "$de" in
        *niri*)    echo niri; return ;;
        *sway*)    echo sway; return ;;
        *hypr*)    echo hypr; return ;;
    esac
    # Fallback: look for the compositor process.
    if command -v pgrep >/dev/null 2>&1; then
        pgrep -x niri    >/dev/null 2>&1 && { echo niri;  return; }
        pgrep -x sway    >/dev/null 2>&1 && { echo sway;  return; }
        pgrep -x Hyprland >/dev/null 2>&1 && { echo hypr; return; }
    fi
    echo ""
}

COMP="${SCOPE:-$(detect_comp)}"

# Map compositor → config dir name and local data file.
case "$COMP" in
    niri) LOCAL_DIR="niri"     ;;
    sway) LOCAL_DIR="sway"     ;;
    hypr) LOCAL_DIR="hypr"     ;;
    *)    LOCAL_DIR=""         ;;
esac

CFG_ROOT="${XDG_CONFIG_HOME:-$HOME/.config}"
COMMON_FILE="$SHARE_DIR/keyhint.common.txt"
LOCAL_FILE="$CFG_ROOT/$LOCAL_DIR/scripts/keyhint.$COMP.txt"

# ---------------------------------------------------------------------------
# Build the full dataset: common file (under "General") + local file.
# Each data file uses: "Category" header lines, then "key<TAB>desc" lines.
# ---------------------------------------------------------------------------
DATA=""
if [[ -f "$COMMON_FILE" ]]; then
    DATA+=$'General\n'
    DATA+="$(cat "$COMMON_FILE")"
    DATA+=$'\n'
fi
if [[ -n "$LOCAL_DIR" && -f "$LOCAL_FILE" ]]; then
    DATA+=$'\n'
    DATA+="$(cat "$LOCAL_FILE")"
    DATA+=$'\n'
fi

# ---------------------------------------------------------------------------
# Render: build fuzzel input lines.
# fuzzel dmenu shows lines as plain text (no Pango markup), so we avoid markup
# and use a simple prefix + spacing for hierarchy. Descriptions are tab-aligned.
# ---------------------------------------------------------------------------
tab=$'\t'
out=""

# First pass: longest key for tab alignment.
maxkey=0
while IFS= read -r line; do
    [[ -z "$line" ]] && continue
    [[ "$line" == *"$tab"* ]] || continue
    k="${line%%$tab*}"
    ((${#k} > maxkey)) && maxkey=${#k}
done <<< "$DATA"

while IFS= read -r line; do
    [[ -z "$line" ]] && continue
    if [[ "$line" != *"$tab"* ]]; then
        # Category / group header.
        [[ -z "$out" ]] || out+=$'\n'
        out+="▸ ${line}"
        out+=$'\n'
    else
        key="${line%%$tab*}"
        desc="${line#*$tab}"
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
    --lines 45 --width 70 \
    "$@" >/dev/null 2>&1 || true
