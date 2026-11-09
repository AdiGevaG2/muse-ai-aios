#!/usr/bin/env bash
# UserPromptSubmit. Starts the Ten-Minute Stop clock: records when the PM sent
# this message. turn-timer-guard.sh and validate-docs-gate.sh read it.
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

TIMER_DIR="$PROJECT_DIR/.claude/.turn-timer"
mkdir -p "$TIMER_DIR"
date +%s > "$TIMER_DIR/$session_id"
exit 0
