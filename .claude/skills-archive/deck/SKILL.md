---
name: deck
description: Generate a feature presentation deck from the PRD. Use when the user says "make the deck", "build a presentation", or "create slides for this feature". Derives from the PRD and stamps its version.
---

# Deck

Generate the feature deck from the PRD.

## Before you start
- Confirm active domain + feature name.
- Require `prd/prd.md`; the deck derives from PRD vN and stamps it.
- Load `org-brain/` then `domains/<domain>/second-brain/` for terminology.

## What to produce
A deck covering: problem + why now, current-state baseline, what's changing
(delta), the solution, success metrics (anchored to baseline), scope, and risks.
Pull directly from the PRD — do not introduce claims the PRD doesn't support.

## Output
`domains/<domain>/features/<feature-name>/deck/` — the deck file, PRD version
stamped. (Use the pptx skill for a .pptx deliverable.)

## Folder resources (read these)
- `../../../domains/<domain>/config.json` — standing setup (domain, tool IDs,
  naming, gates). Use it instead of re-asking; only ask for what is still blank.
- `corrections/` — skill-specific corrections; apply them every run.

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
