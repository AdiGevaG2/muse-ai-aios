#!/usr/bin/env bash
# PreToolUse, every tool. Enforces the Ten-Minute Stop: once 10 minutes have
# passed since the PM's last message, every tool call is blocked so Claude
# must stop and send the stop report. AskUserQuestion stays allowed, since
# asking the PM is the required next step. The PM's next message resets the
# clock (turn-timer-start.sh).
set -uo pipefail
SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$SELF_DIR/../..}"
LIMIT_SECONDS=600
WARN_SECONDS=420

payload=""
if [[ ! -t 0 ]]; then payload="$(cat || true)"; fi
session_id=""
tool_name=""
if command -v jq >/dev/null 2>&1; then
  session_id="$(printf '%s' "$payload" | jq -r '.session_id // "default"' 2>/dev/null)"
  tool_name="$(printf '%s' "$payload" | jq -r '.tool_name // ""' 2>/dev/null)"
fi
[[ -z "$session_id" || "$session_id" == "null" ]] && session_id="default"

[[ "$tool_name" == "AskUserQuestion" ]] && exit 0

timer_file="$PROJECT_DIR/.claude/.turn-timer/$session_id"
# No clock means the turn started without UserPromptSubmit (the Stop hook
# cleared the last one): start it now.
if [[ ! -f "$timer_file" ]]; then
  mkdir -p "$(dirname "$timer_file")"
  date +%s > "$timer_file"
  exit 0
fi
start="$(cat "$timer_file" 2>/dev/null || echo "")"
[[ "$start" =~ ^[0-9]+$ ]] || exit 0

elapsed=$(( $(date +%s) - start ))
# From 7 minutes on, warn so the current batch is the last one before the stop.
if [[ "$elapsed" -ge "$WARN_SECONDS" && "$elapsed" -lt "$LIMIT_SECONDS" ]]; then
  printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","additionalContext":"turn-timer-guard: WARNING. %d minutes since the PM'"'"'s last message. Finish the edits the PM asked for in this one batch, skip any check the PM did not ask for, then send the report."}}\n' "$((elapsed / 60))"
  exit 0
fi
[[ "$elapsed" -lt "$LIMIT_SECONDS" ]] && exit 0

cat >&2 <<MSG
turn-timer-guard: BLOCKED. $((elapsed / 60)) minutes have passed since the PM's
last message (Ten-Minute Stop, CLAUDE.md). Make no more tool calls. Send the
stop report now: what is done, why it is slow (looping, hunting, blocked, or
scope), the recommended next step, and the alternatives. Then end the turn.
The PM's next message resets the clock.
MSG
exit 2
