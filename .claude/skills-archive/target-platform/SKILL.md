---
name: target-platform
description: Map a legacy behavioral spec onto a target platform to produce the delta (carries over / changes / new / drop). Use after legacy-analyze, when the user says "map to target", "what changes on the new platform", or needs the migration delta. Runs the target-mapper agent and can validate with verify.
---

# Target Map

Produce the delta between the legacy behavioral spec and the target platform.
Inputs: the legacy spec (from `legacy-analyze`) and the target platform path/docs
given in $ARGUMENTS. If the legacy spec or target location is missing, ask before
starting.

## Before you start
- Confirm the **active domain** and **feature name**.
- Load `org-brain/` then `domains/<domain>/second-brain/` (domain wins on
  conflict) for terminology, constraints, precedent.

## Steps
1. **Confirm inputs.** Locate the legacy behavioral spec at
   `domains/<domain>/features/<feature-name>/legacy/behavioral-spec.md` and the
   target platform source/docs.
2. **Freshness check.** Follow `../_shared/repo-freshness-check.md` for the
   target platform repo(s) before mapping — a stale target clone can make
   already-shipped behavior look like a gap.
3. **Map.** Delegate to `target-mapper`. It classifies each BR-ID as carries
   over / changes / new / drop using `references/delta-template.md`.
4. **Carry the coverage caveat.** Ensure any not-covered legacy module is
   flagged in the delta as unaccounted-for. Do not let an incomplete legacy scan
   produce a delta that looks complete.
5. **(Optional) Verify.** For high-stakes deltas, delegate `new` and `changes`
   items to the `verify` agent to confirm the target-side sources are real.

## Output
Write the delta to:
`domains/<domain>/features/<feature-name>/legacy/delta.md`
(same `legacy/` stage folder as the behavioral spec). End with any not-covered
legacy modules restated as the final caveat.

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
