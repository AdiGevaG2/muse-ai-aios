#!/usr/bin/env bash
# Stop. Hard gate: blocks the turn from ending while any PM deliverable is
# still marked pending a validate-docs check (marker written by
# validate-docs-guard.sh's PostToolUse pass).
#
# Exit 2 blocks Stop and re-surfaces stderr to Claude, which gets another
# turn to act on it. There is no platform loop-guard for Stop hooks, so this
# hook caps itself: after MAX_BLOCKS consecutive blocks in one session it
# stops blocking and only warns, so a bug here cannot hang the session
# forever. The PM still sees the warning either way.
set -uo pipefail
SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$SELF_DIR/../..}"
PENDING_DIR="$PROJECT_DIR/.claude/.validate-docs-pending"

[[ -d "$PENDING_DIR" ]] || exit 0

shopt -s nullglob
markers=("$PENDING_DIR"/*)
shopt -u nullglob
[[ ${#markers[@]} -eq 0 ]] && exit 0

# Session-scoped retry counter, keyed by session_id if we can read one off
# stdin, else a single shared counter — either way it resets per session.
MAX_BLOCKS=3
payload=""
if [[ ! -t 0 ]]; then payload="$(cat || true)"; fi
session_id="$(printf '%s' "$payload" | command -v jq >/dev/null 2>&1 && printf '%s' "$payload" | jq -r '.session_id // "default"' 2>/dev/null)"
[[ -z "$session_id" ]] && session_id="default"
counter_file="$PENDING_DIR/.retries-$session_id"
count=0
[[ -f "$counter_file" ]] && count="$(cat "$counter_file" 2>/dev/null || echo 0)"
[[ "$count" =~ ^[0-9]+$ ]] || count=0

docs=""
for m in "${markers[@]}"; do
  case "$(basename "$m")" in
    .retries-*) continue ;;
  esac
  docs+="  $(cat "$m" 2>/dev/null || echo "$m")"$'\n'
done

[[ -z "$docs" ]] && exit 0

if [[ "$count" -ge "$MAX_BLOCKS" ]]; then
  cat >&2 <<MSG
validate-docs-gate: WARNING (no longer blocking after $MAX_BLOCKS attempts) —
these documents are still marked pending a validate-docs check:
$docs
Run the validate-docs agent against each one, then delete its marker under
.claude/.validate-docs-pending/, or this will keep warning every turn.
MSG
  exit 0
fi

count=$((count + 1))
printf '%s' "$count" > "$counter_file"

cat >&2 <<MSG
validate-docs-gate: BLOCKED — documents written this session have not been
checked against workspace rules yet:
$docs
Run the validate-docs agent (Agent tool, subagent_type: validate-docs)
against each document listed above before ending this turn. The agent clears
its own marker under .claude/.validate-docs-pending/ when it finishes a
document. Once every marker is cleared, the turn can end.

Also required for each document (CLAUDE.md, Definition of Done): run the
doc-critic agent and a conflict/accuracy check against source evidence and
existing Confluence/Jira, and report all three results to the PM.
MSG
exit 2
