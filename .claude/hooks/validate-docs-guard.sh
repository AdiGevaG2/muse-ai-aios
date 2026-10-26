#!/usr/bin/env bash
# PostToolUse. A PM deliverable was written or edited. Record it as pending a
# validate-docs check — the Stop hook (validate-docs-gate.sh) blocks turn
# completion until every pending marker is cleared.
#
# This hook cannot run the check itself — a validate-docs pass needs the
# validate-docs agent (reads CLAUDE.md, memory feedback entries, and the
# doc, then fixes mechanical violations). This hook only records that the
# check is owed; the Stop hook is what actually enforces it.
#
# Scope: any .md under outputs/<feature>/, any stage or subfolder. Not
# README, INDEX, schema files, or anything under an ingestion/ subfolder
# (ingestion logs are history, not a deliverable).
set -uo pipefail
SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=_payload.sh
source "$SELF_DIR/_payload.sh"

PENDING_DIR="${CLAUDE_PROJECT_DIR:-$SELF_DIR/../..}/.claude/.validate-docs-pending"

hook_have_jq || exit 0
hook_read_payload
[[ "$HOOK_PAYLOAD_OK" -eq 1 ]] || exit 0

flagged=""

while IFS= read -r target; do
  [[ -z "$target" ]] && continue
  case "$target" in
    *outputs/*/ingestion/*) continue ;;
  esac
  case "$target" in
    *outputs/*.md)
      case "$(basename "$target")" in
        README.md|INDEX.md|_SCHEMA.md) continue ;;
      esac
      mkdir -p "$PENDING_DIR"
      marker="$PENDING_DIR/$(printf '%s' "$target" | cksum | awk '{print $1}')"
      printf '%s' "$target" > "$marker"
      flagged+="  $target"$'\n'
      ;;
  esac
done < <(hook_file_paths)

[[ -z "$flagged" ]] && exit 0

cat <<MSG
validate-docs-guard: marked as pending a validate-docs check — the
session cannot end this turn until it is cleared:
$flagged
Run the validate-docs agent against each pending document before finishing.
It checks the document against CLAUDE.md and the standing feedback memories
(no em dash, no "buys" language, no decorative adjectives, no parenthetical
definitions, naming/terminology/scope drift, etc.), fixes mechanical
violations, and flags judgment calls instead of fixing them. It clears the
pending marker itself when done.
MSG
exit 0
