#!/usr/bin/env bash
# =========================================================================
# starship-clean-filter.sh — git clean filter for ~/.config/starship.toml
#
# Strips Noctalia-managed content so git stores only the hand-written
# prompt styles:
#   - the leading `palette = "noctalia"` line
#   - the `>>> NOCTALIA STARSHIP PALETTE >>>` ... `<<<` block
#
# Both are regenerated at runtime by Noctalia's starship apply.sh, so
# tracking them only produces noise diffs on every wallpaper refresh.
# This is the starship equivalent of kitty's `include current-theme.conf`:
# starship has no native include, so Noctalia uses in-file marker blocks,
# and this filter hides those blocks from git.
#
# Smudge is a no-op (the working copy already holds the full file).
#
# Wiring (.gitattributes):
#   /starship.toml filter=noctalia-starship
# =========================================================================
set -euo pipefail

awk '
    # Drop the runtime-injected palette selector line
    /^palette[[:space:]]*=[[:space:]]*"noctalia"[[:space:]]*$/ { next }

    # Skip everything between the Noctalia palette markers (inclusive)
    /^# >>> NOCTALIA STARSHIP PALETTE >>>$/ { in_block = 1; next }
    in_block && /^# <<< NOCTALIA STARSHIP PALETTE <<</ { in_block = 0; next }
    in_block { next }

    { print }
'
