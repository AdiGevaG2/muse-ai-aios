#!/usr/bin/env bash
# PermissionRequest + PostToolUse. Time the PM spends on an approval prompt
# does not count toward the Ten-Minute Stop: PermissionRequest records when
# the prompt opened; PostToolUse moves the clock's start forward by the wait.
set -uo pipefail
SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$SELF_DIR/../..}"

payload=""
if [[ ! -t 0 ]]; then payload="$(cat || true)"; fi
session_id=""
event=""
if command -v jq >/dev/null 2>&1; then
  session_id="$(printf '%s' "$payload" | jq -r '.session_id // "default"' 2>/dev/null)"
  event="$(printf '%s' "$payload" | jq -r '.hook_event_name // ""' 2>/dev/null)"
fi
[[ -z "$session_id" || "$session_id" == "null" ]] && session_id="default"

timer_file="$PROJECT_DIR/.claude/.turn-timer/$session_id"
wait_file="$timer_file.wait"

if [[ "$event" == "PermissionRequest" ]]; then
  mkdir -p "$(dirname "$timer_file")"
  date +%s > "$wait_file"
  exit 0
fi

[[ -f "$wait_file" ]] || exit 0
wait_start="$(cat "$wait_file" 2>/dev/null || echo "")"
rm -f "$wait_file"
start="$(cat "$timer_file" 2>/dev/null || echo "")"
[[ "$wait_start" =~ ^[0-9]+$ && "$start" =~ ^[0-9]+$ ]] || exit 0
echo $(( start + $(date +%s) - wait_start )) > "$timer_file"
exit 0
