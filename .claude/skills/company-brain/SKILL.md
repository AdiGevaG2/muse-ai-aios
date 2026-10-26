---
name: company-brain
description: 'Route a question to the right repo, Confluence space, or Jira project across the evercompliant org, and trace why a line of code exists. Use when asked "which repo does X live in", "who owns X", "where is X implemented", "where is X documented", "why is this code like this", "what ticket caused this", "who wrote this and why", or when a question spans repos that are not checked out locally.'
---

# Company Brain

Two workflows over `router.toon.md`, in this same directory. The router holds **pointers only** —
which repo, which Confluence space, which Jira project. It never holds prose. Content is always
fetched live, as the calling user, so per-user permissions hold.

The org has ~430 repos and only ~65 are cloned locally. **Grep cannot see the other 365.** That gap
is the reason this skill exists.

## Workflow A — where does X live / who owns it

1. Read `router.toon.md` in this same directory. It is ~10k tokens; read it
   whole, or grep it for keywords.
2. Match the question's nouns against the `capability` and `keywords` columns across all three
   sections: `[repos]`, `[spaces]`, `[projects]`.
3. **Return the top 3 candidates, never a single answer.** For each: name, owners, `pushed` date,
   and the keyword that matched.
4. Then go get the real answer:
   - repo → `gh api repos/evercompliant/<repo>/...`, or clone it if the work needs a working tree
   - Confluence space → `searchConfluenceUsingCql` with `space = <KEY>` in the query
   - Jira project → `searchJiraIssuesUsingJql` with `project = <KEY>`

**Never answer a "where is X" question from the router alone.** The router narrows the search; it
does not answer it. Say which candidate you verified and how.

## Workflow B — why is it like this

```
git blame -L <line>,<line> -- <path>                       → SHA
  # repo not cloned locally:
  gh api "repos/evercompliant/<repo>/commits?path=<path>&per_page=1"

gh api repos/evercompliant/<repo>/commits/<SHA>/pulls      → PR number, title, body, branch

# find the ticket — search branch name FIRST, then PR title, body, commit subject
grep -oEi '[a-z][a-z0-9]{1,9}-[0-9]+'                      → uppercase it

getTeamworkGraphContext(JiraWorkItem, <KEY>)               → linked PRs, commits, builds
  # verified working: RT-1343 returns 18 PRs / 141 commits / 912 builds,
  # spanning several repos (mlrc-merchant, mlrc-account, dyn-env pipelines)
  # targets come back as opaque graph ARIs — call getTeamworkGraphObject(<ari>)
  # for the real title/URL, or detailLevel:'full' with relationshipTypes to filter
```

**Run this direction too.** Given a ticket key, `getTeamworkGraphContext` answers "what code
implemented this" across every repo at once — which the router cannot do and grep certainly cannot.
It is often faster than starting from `git blame`. A ticket with no linked dev work (e.g. a PRD or
epic) returns only `atlassian_user_*` relationships; that means no code was linked, not that the
graph is broken.

Three rules the data forces — each was measured, not guessed:

- **Ticket keys live in branch names, not commit subjects.** Subject-line density is wildly uneven
  across the org (`marketview-portal` 193/400 commits, `ai-utils` **0/400**). Branch names like
  `th-1038/fix-thing` are lowercase — uppercase before any Jira lookup.
- **~70% of PRs have no ticket at all.** When the regex finds nothing, the PR body and its review
  comments *are* the provenance. Report them and **stop**. Never infer which ticket a PR probably
  belonged to — a confidently wrong ticket is worse than "no ticket linked."
- **Teamwork Graph relationships expire after 90 days** for several types. For anything older, git
  and the GitHub API are the durable record; say so rather than reporting an empty graph as "no
  context exists."

## Trust rules

- **Staleness.** Every row carries `pushed`; the file header carries `generated_at`. If
  `pushed > generated_at`, the `capability` text is a **hint, not an answer** — grep the repo to
  confirm before relying on it.
- **`pushed=2026-02-23` is not real activity.** 240 of 412 repos share that exact date — a bulk
  org-wide event (migration or mass force-push), not human commits. Treat that date as "unknown,
  probably dormant", never as "recently maintained". Roughly 172 repos have genuine recent pushes.
- **Top 3, never top 1.** A wrong first guess then costs one extra tool call instead of a wrong
  answer.
- **The router never asserts *why*, or *where in a file*.** Only which source to look in.
- **Blank `capability` means nobody has described that repo yet** — not that the repo is empty.
  Fall back to its `toplevel` listing and README.

## Fixing a wrong row

Do not edit `router.toon.md` — it is regenerated weekly and your edit will be overwritten. Add a
line to that repo's own `AGENTS.md` instead; the generator prefers it over the generated text and it
survives every regeneration:

```
capability: short phrase describing what this repo does
```

## Regenerating

The generator lives here (`scripts/gen-router.sh`) and writes `router.toon.md` in this same
directory:

```
cd .claude/skills/company-brain && scripts/gen-router.sh --days 365
```

Rewrites the `[repos]` section only; `[spaces]` and `[projects]` are preserved because they come
from the Atlassian MCP, which the script cannot call. Fill blank `capability` cells from
`.cache/raw-inputs.json` (README head + top-level file listing per repo).

A weekly CI job (`.github/workflows/refresh-router.yml`, in this repo) runs this same script,
sparse-checking out this directory, then `scripts/refresh-prompt.md` (a Copilot CLI prompt that
fills blank `capability` cells and refreshes `[spaces]`/`[projects]` via the Atlassian MCP), then
commits `router.toon.md` directly (via a GitHub App token — main is ruleset-protected). Needs
`ROUTER_GH_TOKEN`, `ATLASSIAN_EMAIL`, `ATLASSIAN_API_TOKEN`, `COPILOT_PAT`, `APP_ID` and
`APP_PRIVATE_KEY` configured as secrets on this repo (the last two are already used by other
workflows here).
