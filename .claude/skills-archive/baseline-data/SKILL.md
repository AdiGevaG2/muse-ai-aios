---
name: baseline-data
description: Establish a data baseline for a feature from Mixpanel and Coralogix via MCP. Use when the user says "get the baseline", "pull current metrics", or before writing a PRD that needs success metrics anchored to real numbers. Produces the current-state figures the PRD must set targets against.
---

# Baseline

Establish the current-state data baseline for a feature. Feature/metrics area:
$ARGUMENTS (ask if unclear).

## Before you start
- Confirm active domain + feature name.
- Load `org-brain/` (systems, policies) then `domains/<domain>/second-brain/`.
  Respect data/PII policy — query only what policy allows.

## Steps
1. **Identify the metrics that matter** for this feature (funnel steps, error
   rates, latency, drop-off) — grounded in the discovery/requirement, not
   generic.
2. **Query Mixpanel** (MCP) for product/funnel metrics. State the exact date
   window used.
3. **Query Coralogix** (MCP) for error/performance signals. Note the archive-vs-
   frequent-search constraint if relevant.
4. **Record the numbers as the baseline** — these are the figures the PRD's
   success metrics must reference (e.g. "current KYC drop-off = X%").

## Rules
- Numbers only, each with its source (query + date window) so they're verifiable.
- If a metric can't be pulled, say so — do not estimate.
- The baseline is both the starting line and the later measuring stick; state it
  so post-launch re-measurement is a straight re-run.

## Output
Write to `domains/<domain>/features/<feature-name>/baseline/baseline.md`.
End by listing the specific current-state figures the PRD is obligated to set
targets against.

## Folder resources (read these)
- `../../../domains/<domain>/config.json` — standing setup (domain, tool IDs,
  naming, gates). Use it instead of re-asking; only ask for what is still blank.
- `corrections/` — skill-specific corrections; apply them every run.
- `references/mcp-queries.md` — how to call Mixpanel/Coralogix.

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
