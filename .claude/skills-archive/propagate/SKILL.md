---
name: propagate
description: Propagate a PRD change to all downstream artifacts. Use whenever the PRD version changes (from testing, spec arbitration, or direct edit). Local docs auto-realign; Jira and Confluence require an approval gate. Runs the propagate agent.
---

# Propagate

Fan a PRD change out to everything downstream. Trigger: the PRD version changed.

## Before you start
- Confirm active domain + feature name.
- Identify the new PRD version and what changed.

## Rules (the core of the single-source-of-truth model)
- **Direction:** changes flow PRD -> downstream only. Never the reverse.
- **Local artifacts auto-propagate, no gate:** discovery, spec, deck realign to
  the new PRD version and re-stamp. These are cheap and caught before leaving
  the machine.
- **Jira + Confluence require approval:** they are external truth others act on.

## Steps
1. Delegate to the `propagate` agent. It diffs the new PRD against every
   downstream artifact and produces per-file proposed edits.
2. **Auto-write local artifacts** (discovery, spec, deck), re-stamping to the new
   PRD version.
3. **Stop at the Jira/Confluence gate.** Show the user a DIFF of proposed
   Jira/Confluence changes. Flag any Jira story that is In Progress. Write only
   on approval.
4. **Partial approval:** if the user rejects a specific story change, leave that
   story flagged "diverged from PRD vN" so it resurfaces next run — never
   silently drop it.

## Output
Updated local artifacts (re-stamped), and a record of what was pushed to
Jira/Confluence vs. left diverged, under the feature's `prd/` stage as
`prd/propagation-log.md`.

## Evidence on completion
Do not just claim done. Show the artifact: the file path written, the actual
query result / figures, the diff, or the mismatch/gap list — whatever this stage
produced. Reviewing the evidence must be faster than re-doing the check. This
catches silent failures (a stage that "ran" but produced nothing usable).
