#!/usr/bin/env bash
# doubletap <id> <cmd...>
# On the first tap (within THRESHOLD ms of the previous), record a timestamp and
# do nothing. On a second tap within THRESHOLD, run <cmd...> (e.g. `wtype ...`).
# Single tap = no-op, double tap = action. Compositor-agnostic: the action is
# typically a synthesized chord (wtype) so the compositor's own bind fires.
set -u

THRESHOLD=300  # ms window for the second tap
id="$1"; shift
STAMP="${XDG_RUNTIME_DIR:-/tmp}/doubletap-${id}.stamp"

now=$(date +%s%3N)
prev=$(cat "$STAMP" 2>/dev/null || echo 0)

if [ $((now - prev)) -lt "$THRESHOLD" ]; then
  rm -f "$STAMP"
  "$@"
else
  echo "$now" > "$STAMP"
fi
