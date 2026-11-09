#!/usr/bin/env bash
# Stop. Hard gate: blocks the turn from ending while any PM deliverable this
# session wrote is still marked pending a validate-docs check (marker written
# by validate-docs-guard.sh's PostToolUse pass).
#
# Scope: only markers under this session's subfolder. Files another session
# left pending, or files of a feature this session did not touch, never
# block this session.
#
# Exit 2 blocks Stop and re-surfaces stderr to Claude, which gets another
# turn to act on it. There is no platform loop-guard for Stop hooks, so this
# hook caps itself: after MAX_BLOCKS consecutive blocks in one session it
# stops blocking and only warns, so a bug here cannot hang the session
# forever. The PM still sees the warning either way.
set -uo pipefail
SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$SELF_DIR/../..}"

payload=""
if [[ ! -t 0 ]]; then payload="$(cat || true)"; fi
session_id=""
if command -v jq >/dev/null 2>&1; then
  session_id="$(printf '%s' "$payload" | jq -r '.session_id // "default"' 2>/dev/null)"
fi
[[ -z "$session_id" || "$session_id" == "null" ]] && session_id="default"

PENDING_DIR="$PROJECT_DIR/.claude/.validate-docs-pending/$session_id"
[[ -d "$PENDING_DIR" ]] || exit 0

shopt -s nullglob
markers=("$PENDING_DIR"/*)
shopt -u nullglob
[[ ${#markers[@]} -eq 0 ]] && exit 0

# Ten-Minute Stop wins over this gate: when Claude pauses to ask the PM, it
# touches .paused here. The turn ends with a warning; the flag is one-shot.
# The clock from turn-timer-start.sh also counts: past 10 minutes, never block.
pause_file="$PENDING_DIR/.paused"
timer_file="$PROJECT_DIR/.claude/.turn-timer/$session_id"
timer_start="$(cat "$timer_file" 2>/dev/null || echo "")"
if [[ "$timer_start" =~ ^[0-9]+$ ]] && (( $(date +%s) - timer_start >= 600 )); then
  touch "$pause_file"
fi
if [[ -f "$pause_file" ]]; then
  rm -f "$pause_file"
  echo "validate-docs-gate: paused for the PM (Ten-Minute Stop); docs still pending a check." >&2
  exit 0
fi

MAX_BLOCKS=3
counter_file="$PENDING_DIR/.retries"
count=0
[[ -f "$counter_file" ]] && count="$(cat "$counter_file" 2>/dev/null || echo 0)"
[[ "$count" =~ ^[0-9]+$ ]] || count=0

docs=""
for m in "${markers[@]}"; do
  docs+="  $(cat "$m" 2>/dev/null || echo "$m")"$'\n'
done

[[ -z "$docs" ]] && exit 0

if [[ "$count" -ge "$MAX_BLOCKS" ]]; then
  cat >&2 <<MSG
validate-docs-gate: WARNING (no longer blocking after $MAX_BLOCKS attempts) —
these documents written this session are still pending a validate-docs check:
$docs
Run the validate-docs agent against each one, then delete its marker under
.claude/.validate-docs-pending/$session_id/, or this will keep warning every turn.
MSG
  exit 0
fi

count=$((count + 1))
printf '%s' "$count" > "$counter_file"

# Reminder only, never a block: the PM decided (2026-10-29) that the gate
# must not force more work or keep a turn from ending.
cat >&2 <<MSG
validate-docs-gate: reminder, not reviewed yet:
$docs
Say "not reviewed yet" in the reply. Run the doc-review agent once, at the
end of the PM's request, only if the PM has not asked to stop.
MSG
exit 0
