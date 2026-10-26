#!/usr/bin/env bash
# PreToolUse on AskUserQuestion.
#
# CLAUDE.md ("Default Behavior: Ask on Product, Act on Everything Else") now
# always asks on product decisions (scope, naming, framing, metric choice,
# persona, business rationale) and only auto-decides a narrow set of routine
# mechanical calls that were previously listed as "you decide": run mode,
# which evidence to read, and whether to pull latest / stale-repo handling.
#
# So this gate flips from allowlist to blocklist: block only questions that
# are purely about one of those routine mechanical calls, and let everything
# else through, including all product questions and all technical/tooling
# questions (MCP, Bash, credentials, config, etc.) which were never assumed.
set -uo pipefail
SELF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=_payload.sh
source "$SELF_DIR/_payload.sh"

hook_have_jq || exit 0
hook_read_payload
[[ "$HOOK_PAYLOAD_OK" -eq 1 ]] || exit 0

# All question text plus headers, lowercased, as one blob to match against.
questions="$(printf '%s' "$HOOK_PAYLOAD" | jq -r '
  [ (.tool_input.questions[]?.question?),
    (.tool_input.questions[]?.header?)
  ] | map(select(. != null)) | join(" ")' 2>/dev/null | tr '[:upper:]' '[:lower:]')"

# Nothing to inspect — do not block on a payload shape we do not recognize.
[[ -z "$questions" ]] && exit 0

# /learn-feature is a teaching conversation, so asking IS the deliverable.
# Opt in explicitly by tagging the question text with [learn-feature].
if printf '%s' "$questions" | grep -qF '[learn-feature]'; then
  exit 0
fi

# Blocked: purely routine mechanical calls CLAUDE.md still auto-decides.
# Only fires when the question is ABOUT one of these specific mechanics —
# any product or technical wording elsewhere in the question overrides this
# below via the allow check.
block_re='run mode\?|quick or thorough'
block_re+='|pull (the )?latest\?|repo (is |looks )?stale'
block_re+='|which evidence (should i|to) read'

# Never block if the question carries product or technical substance —
# those are asked regardless of also mentioning a routine mechanic in passing.
allow_re='scope|framing|persona|metric|business rationale|naming|feature name'
allow_re+='|confluence|jira|slack|email|publish|push to|create the ticket'
allow_re+='|overwrite|delete|discard|replace the existing|destroy'
allow_re+='|mcp|api key|client id|client secret|credential|access token'
allow_re+='|base url|server url|looker|connection string'
allow_re+='|bash|shell|terminal|command|script|\bcli\b'
allow_re+='|config|setting|permission|allowlist|env var|environment variable'
allow_re+='|install|package|dependency|version|upgrade|downgrade'
allow_re+='|server|deploy|repo|repository|branch|hook|agent|subagent|workflow'
allow_re+='|tool\b|skill\b|integration|token|auth|oauth|api\b'

if printf '%s' "$questions" | grep -Eq "$allow_re"; then
  exit 0
fi

if ! printf '%s' "$questions" | grep -Eq "$block_re"; then
  exit 0
fi

cat >&2 <<'MSG'
BLOCKED: AskUserQuestion is gated by the PM workflow contract.

CLAUDE.md -> "Ask on Product, Act on Everything Else". This question reads as
one of the routine mechanical calls still auto-decided:
  - Run mode          -> default Quick (_shared/run-mode.md)
  - Stale/dirty repo  -> caveat in the artifact, never ask to pull
  - Which evidence to read -> the skill's hard stopping rule decides

Take the most reasonable reading, write it into the artifact marked `ASSUMED:`,
and continue.

If this is actually a product decision (scope, naming, framing, metric
choice) or a technical/tooling question, say so explicitly in the question
text and re-issue it — those are always asked.
MSG
exit 2
