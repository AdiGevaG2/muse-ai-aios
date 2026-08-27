---
name: publish
description: Publish the PRD to Confluence and create Jira work items (Initiative/Milestone/Epic/Story/Bug/Subtask hierarchy). Use when the user says "publish to Confluence", "create the Jira tickets", or "push to Jira". Always behind an approval gate — shows a diff and writes only on approval.
---

# Publish (Confluence + Jira)

Push the PRD out to Confluence and Jira. This is the trust boundary — external
state others act on — so it is always gated.

## Confluence and Jira are asked and approved SEPARATELY
Never bundle these into one "yes to publish everything" confirmation. Ask "do
you want to publish to Confluence?" and get an explicit answer BEFORE showing
the Confluence diff; separately ask "do you want to create/update the Jira
items?" and get an explicit answer before showing the Jira diff. A yes to one
is never treated as a yes to the other — the user may want the PRD on
Confluence without touching Jira yet, or vice versa. Run whichever ones the
user actually asked for; skip the other cleanly (not "not yet" — genuinely
skipped unless asked again).

## Before you start
- Confirm active domain + feature name.
- Require a current `prd/prd.md`; note its version.
- Load `org-brain/` (systems, policy) for Confluence/Jira conventions.
- Ask which of Confluence, Jira, or both the PM wants this run — do not assume
  "publish" means both.

## Steps
1. **Confluence** (only if requested): prepare the PRD for upload. Show the
   user what will be published/updated. On approval, upload via MCP.
2. **Jira** (only if requested) **— hierarchy.** Default hierarchy (from `config.json` →
   `jira.issue_hierarchy`): **Initiative** (only for multi-quarter strategic
   work) → **Milestone** (required for each roadmap item) → **Epic**
   (new-functionality or bucket) → **Story/Bug** → optional **Subtask**. Derive
   from the PRD's goals/user-story sections using the matching template:
   - `references/initiative-template.md` — only when the feature is genuinely
     multi-quarter strategic work, not every feature needs one.
   - `references/milestone-template.md` — for the roadmap item this PRD
     delivers.
   - `references/epic-template.md` — new-functionality epic (MVP/phased
     delivery) or bucket epic (tech debt/small enhancements).
   - `references/story-template.md` — sprint-sized units under the epic; use
     the Bug variant when the work fixes broken/regressed behavior.
   Before creating: **ask whether Initiative, Milestone, and Epic should link
   to an existing Jira item or be created new**, and **confirm whether sprint
   work should be Story, Bug, or a mix**. Keep subtasks optional, granular, and
   low-hour — only create them when explicitly requested.
3. **Show a DIFF** of what will be created/changed at every level before
   writing. Flag any existing story that is In Progress — changing those
   mid-sprint is high-stakes; make the user approve them deliberately.
4. **Partial approval:** create only approved items; leave rejected ones flagged
   "diverged from PRD vN" for next run.

## Hard rules
- Never write to Jira/Confluence without explicit approval on the shown diff.
- **Never treat approval of one as approval of the other** — Confluence and
  Jira are independent asks, independent diffs, independent approvals.
- Inherit the authenticated user's permissions; don't broaden scope.
- Record what was pushed vs. left diverged.

## Output
`domains/<domain>/features/<feature-name>/prd/publish-log.md` — what went to
Confluence/Jira, with links/IDs, and anything left diverged.

## Folder resources (read these)
- `../../../domains/<domain>/config.json` — standing setup (domain, tool IDs,
  naming, gates). Use it instead of re-asking; only ask for what is still blank.
- `corrections/` — skill-specific corrections; apply them every run.
- `references/jira-confluence.md` — how to call Jira/Confluence.
- `references/initiative-template.md`, `milestone-template.md`,
  `epic-template.md`, `story-template.md` — Jira Description-field templates
  for each hierarchy level (see Step 2).

## Run mode (standalone)
If invoked directly (not via /feature-flow), first ask the PM: **Quick one-off**
(assume low-stakes gaps, flag each inline) or **Strict** (ask on every gap)?
Follow `../_shared/run-mode.md`. Either way, high-stakes gaps (compliance,
requirement/behavior decisions, invented components, unanchored metrics, or any
write to PRD/Jira/Confluence/brain) are ALWAYS asked, never assumed.

## Evidence on completion
Do not just claim done. Show the artifact: the file path written, the actual
query result / figures, the diff, or the mismatch/gap list — whatever this stage
produced. Reviewing the evidence must be faster than re-doing the check. This
catches silent failures (a stage that "ran" but produced nothing usable).
