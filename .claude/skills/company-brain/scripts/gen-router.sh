#!/usr/bin/env bash
# Regenerates the [repos] section of router.toon.md (this directory) from the
# GitHub org. Sections other than [repos] are preserved verbatim — [spaces]
# and [projects] come from the Atlassian MCP, which this script cannot call.
#
# Usage:  scripts/gen-router.sh [--org NAME] [--days N] [--jobs N]
#
# Writes:
#   router.toon.md        committed; capability/keywords blank unless the repo
#                         supplies its own `capability:` line in AGENTS.md
#   .cache/raw-inputs.json  gitignored; input for the LLM summarization pass

set -euo pipefail

ORG=evercompliant
CUTOFF_DAYS=365
JOBS=8
MERGE_TSV=""
SKIP_FETCH=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --org)   ORG=$2; shift 2 ;;
    --days)  CUTOFF_DAYS=$2; shift 2 ;;
    --jobs)  JOBS=$2; shift 2 ;;
    --merge) MERGE_TSV=$2; shift 2 ;;   # repo<TAB>capability<TAB>keywords
    --cached) SKIP_FETCH=1; shift ;;    # reuse .cache, re-emit only
    *) echo "unknown arg: $1" >&2; exit 2 ;;
  esac
done

cd "$(dirname "$0")/.."
OUT=router.toon.md
CACHE=.cache/raw-inputs.json
mkdir -p .cache

command -v gh >/dev/null || { echo "gh not found" >&2; exit 1; }
command -v jq >/dev/null || { echo "jq not found" >&2; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "gh not authenticated" >&2; exit 1; }

if [[ $SKIP_FETCH -eq 1 ]]; then
  [[ -f "$CACHE" ]] || { echo "--cached needs an existing $CACHE" >&2; exit 1; }
  COUNT=$(jq length "$CACHE")
  echo "reusing $CACHE ($COUNT repos)" >&2
else

# --- 1. one call for the whole org -------------------------------------------
echo "listing repos in $ORG ..." >&2
gh repo list "$ORG" --limit 1000 --no-archived \
  --json name,primaryLanguage,pushedAt,description,repositoryTopics \
  > .cache/repos-raw.json

CUTOFF=$(date -u -v-"${CUTOFF_DAYS}"d +%Y-%m-%dT%H:%M:%SZ 2>/dev/null \
      || date -u -d "${CUTOFF_DAYS} days ago" +%Y-%m-%dT%H:%M:%SZ)

jq --arg cutoff "$CUTOFF" '
  [ .[]
    | select(.pushedAt >= $cutoff)
    | { repo: .name,
        lang: (.primaryLanguage.name // "-" | ascii_downcase),
        pushed: (.pushedAt | split("T")[0]),
        desc: (.description // ""),
        topics: [ .repositoryTopics[]?.name ] }
  ] | sort_by(.repo)' .cache/repos-raw.json > .cache/repos.json

COUNT=$(jq length .cache/repos.json)
echo "$COUNT repos pushed within ${CUTOFF_DAYS}d" >&2

# --- 2. per-repo enrichment (parallel) ---------------------------------------
# Each worker prints one JSON object. Failures degrade to empty fields rather
# than aborting the run — a missing README must not cost us the other 264 rows.
enrich() {
  local org=$1 repo=$2
  local raw='Accept: application/vnd.github.raw'
  local owners capability readme toplevel

  # owners: CODEOWNERS (either location) -> top 3 contributors
  owners=$(
    { gh api "repos/$org/$repo/contents/.github/CODEOWNERS" -H "$raw" 2>/dev/null \
   || gh api "repos/$org/$repo/contents/CODEOWNERS"         -H "$raw" 2>/dev/null; } \
      | grep -oE '@[A-Za-z0-9_/-]+' | sort -u | head -3 | paste -sd, - || true
  )
  if [[ -z "$owners" ]]; then
    owners=$(gh api "repos/$org/$repo/contributors?per_page=3" \
               --jq '[.[].login] | join(",")' 2>/dev/null || echo "")
  fi

  # a repo may state its own capability line; it wins over the LLM guess
  if capability=$(gh api "repos/$org/$repo/contents/AGENTS.md" -H "$raw" 2>/dev/null); then
    capability=$(grep -m1 -i '^capability:' <<<"$capability" \
                   | sed 's/^[Cc]apability:[[:space:]]*//' || true)
  else
    capability=""
  fi

  # gh api writes the HTTP error body to stdout, so a 404 would otherwise be
  # cached as if it were README text. Gate on the exit code, not the output.
  if readme=$(gh api "repos/$org/$repo/readme" -H "$raw" 2>/dev/null); then
    readme=$(head -c 2000 <<<"$readme")
  else
    readme=""
  fi
  toplevel=$(gh api "repos/$org/$repo/contents" --jq '[.[].name] | join(" ")' 2>/dev/null || echo "")

  jq -nc --arg repo "$repo" --arg owners "$owners" --arg capability "$capability" \
         --arg readme "$readme" --arg toplevel "$toplevel" \
    '{repo:$repo, owners:$owners, capability:$capability, readme:$readme, toplevel:$toplevel}'
}
export -f enrich

echo "enriching $COUNT repos (${JOBS} parallel) ..." >&2
jq -r '.[].repo' .cache/repos.json \
  | xargs -P "$JOBS" -I{} bash -c 'enrich "$0" "$1"' "$ORG" {} \
  | jq -s '.' > .cache/enrich.json

jq -s '.[0] as $base | .[1] as $enr
  | [ $base[] as $b
      | ($enr[] | select(.repo == $b.repo)) as $e
      | $b + {owners: $e.owners, capability: $e.capability,
              readme: $e.readme, toplevel: $e.toplevel} ]' \
  .cache/repos.json .cache/enrich.json > "$CACHE"

fi  # SKIP_FETCH

# --- 3. emit the [repos] section, preserve the rest --------------------------
# Precedence for capability/keywords, highest first:
#   1. `capability:` in the repo's own AGENTS.md   (survives every regeneration)
#   2. --merge TSV from the LLM summarization pass
#   3. the value already in router.toon.md          (carry-forward between runs)
#   4. blank
PREV_JSON='{}'
if [[ -f "$OUT" ]]; then
  PREV_JSON=$(awk -F'|' '/^\[repos\]/{f=1;next} /^\[/{f=0} f && NF>=6 && $1!~/^#/ {print}' "$OUT" \
    | jq -Rn '[inputs | split("|") | {key: .[0], value: {capability: .[4], keywords: .[5]}}] | from_entries')
fi

MERGE_JSON='{}'
if [[ -n "$MERGE_TSV" ]]; then
  [[ -f "$MERGE_TSV" ]] || { echo "no such file: $MERGE_TSV" >&2; exit 1; }
  MERGE_JSON=$(jq -Rn --rawfile tsv "$MERGE_TSV" '
    $tsv | split("\n") | map(select(length > 0) | split("\t"))
         | map(select(length >= 3))
         | map({key: .[0], value: {capability: .[1], keywords: .[2]}})
         | from_entries')
fi

NEW_REPOS=$(jq -r --argjson m "$MERGE_JSON" --argjson p "$PREV_JSON" '
  .[] | . as $r
      | ($m[$r.repo] // {}) as $t
      | ($p[$r.repo] // {}) as $o
      | [ $r.repo, $r.lang, $r.pushed, ($r.owners // ""),
          (if ($r.capability // "") != "" then $r.capability
           elif ($t.capability // "") != "" then $t.capability
           else ($o.capability // "") end),
          (if ($t.keywords // "") != "" then $t.keywords else ($o.keywords // "") end) ]
      | map(gsub("\\|"; "/"))
      | join("|")' "$CACHE")

TAIL=""
if [[ -f "$OUT" ]] && grep -q '^\[spaces\]' "$OUT"; then
  TAIL=$(sed -n '/^\[spaces\]/,$p' "$OUT")
else
  TAIL=$'[spaces]     key|title|keywords\n\n[projects]   key|name|keywords'
fi

{
  echo "# RIG v2 - $ORG company brain router"
  echo "generated_at=$(date -u +%Y-%m-%d)"
  echo "scope=repos: pushed<${CUTOFF_DAYS}d && !archived (n=$COUNT); spaces+projects via Atlassian MCP"
  echo "trust=capability is a HINT when pushed > generated_at. Return top 3, never top 1."
  echo
  echo "[repos]      repo|lang|pushed|owners|capability|keywords"
  echo "$NEW_REPOS"
  echo
  echo "$TAIL"
} > "$OUT"

# count what actually landed in the file, not what was in the cache
BLANK=$(awk -F'|' 'BEGIN{n=0} /^\[repos\]/{f=1;next} /^\[/{f=0} f && NF>=5 && $5=="" {n++} END{print n}' "$OUT")
echo "wrote $OUT ($COUNT repos, $BLANK still need a capability line)" >&2
[[ $BLANK -gt 0 ]] && echo "next: summarize from $CACHE, then re-run with --cached --merge <tsv>" >&2
exit 0
