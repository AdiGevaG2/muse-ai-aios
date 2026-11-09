#!/usr/bin/env bash
# Stop. Clears the Ten-Minute Stop clock when a turn ends, so the next turn
# never inherits an old start time. A PM message that arrives without
# UserPromptSubmit firing then starts its clock at the first tool call
# (turn-timer-guard.sh).
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

rm -f "$PROJECT_DIR/.claude/.turn-timer/$session_id"
exit 0
