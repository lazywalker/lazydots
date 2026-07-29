#!/usr/bin/env bash
# Noctalia theme_mode_changed hook.
set -euo pipefail
target="${XDG_CONFIG_HOME:-$HOME/.config}/kitty/kitty-color-fix.conf"

case "${NOCTALIA_THEME_MODE:-dark}" in
  light)
    # only slots Noctalia renders too pale to read on light bg (contrast < 3.0)
    cat >"$target" <<'EOF'
color5  #9d4edd
color6  #0073a8
color8  #5b5566
color13 #9d4edd
color14 #0073a8
env COLORFGBG=0;15
EOF
    ;;
  dark)
    cat >"$target" <<'EOF'
env COLORFGBG=15;0
EOF
    ;;
esac

pkill -USR1 kitty 2>/dev/null || true
