---
name: baseline-data
description: Pull current-state numbers from Mixpanel, Coralogix, or Looker via MCP. Use for "get the baseline", "pull current metrics", "what does the data say", "query Mixpanel", "check the error rate", or before a PRD needing metrics anchored to real figures.
---

# Baseline Data

Pull the current-state figures for $ARGUMENTS (a feature or metrics area). Ask
if unclear.

These numbers become the baseline the PRD sets targets against, and the
measuring stick post-launch. Record them so re-measurement is a straight re-run.

## Before you start
- Confirm active domain and feature name.
- Read the feature `README.md` if it exists; follow `../../../outputs/README.md`
  for a new feature workspace.
- Read `config.json` → `tools` for project IDs, endpoints, and the customer-only
  default. Do not re-ask for what is already there.
- Check `org-brain/context/policies.md` only for a specific unresolved question
  about what may be queried or exported — not wholesale.

## Sources

| Source | Use for | Readiness |
|---|---|---|
| **Mixpanel** | Product and funnel metrics: usage, coverage, conversion, drop-off, segmentation | see `config.json` |
| **Coralogix** | Error and performance signals: error rate by service, latency, failure counts | see `config.json` |
| **Looker** | Business and warehouse metrics not in Mixpanel | **Not connected** — see below |

`config.json` marks each integration `UNVERIFIED` until a real query succeeds.
Configuration metadata is not a working connection: if a call fails, report the
failure and the readiness state rather than substituting an estimate.

**Looker is not currently connected.** If a question needs it, say so and stop
for that figure — do not approximate it from Mixpanel. Setup is a one-time
browser OAuth the user must run themselves: point them at
`references/connect-looker.md`. An agent cannot complete it.

## Steps
1. **Identify the metrics that matter** for this feature — funnel steps, error
   rates, coverage, drop-off — grounded in the discovery or requirement, never
   a generic dashboard sweep.
2. **Pick the right source per metric.** Product behavior → Mixpanel. System
   health → Coralogix. Business/warehouse → Looker. Do not pull a number from a
   source that only approximates it.
3. **Query**, following `references/mcp-queries.md` for per-source mechanics and
   query discipline.
4. **Record each figure with its query and window** so it is reproducible.

## Rules
- Numbers only, each with its source, query, and explicit date window.
- **If a metric cannot be pulled, say so. Never estimate.** An invented baseline
  becomes a PRD target nobody can hit or verify.
- Verify event and property names against the project before using them. An
  unconfirmed event name is not a fact — flag it and ask.
- Break funnels down by cohort or platform. Aggregate-only figures hide the
  drop-off these numbers exist to expose.
- Read-only. Creating dashboards, cohorts, or saved reports is an external write
  and needs explicit scoped approval.
- Return the figures, not the raw result set. A pasted export is a defect.

## Output
`outputs/<feature-name>/baseline/<feature-name>-baseline.md`, or return the
figures in chat when no durable artifact is needed. For historical features,
follow the feature README.

End by listing the specific current-state figures the PRD must set targets
against, and naming anything that could not be pulled.

## Folder resources
- `references/mcp-queries.md` — per-source mechanics and query discipline.
- `references/connect-looker.md` — one-time Looker setup, when it is needed.
- `../../../domains/<domain>/config.json` — project IDs, endpoints, readiness.
- `corrections/` — if it holds entries, apply them; empty is normal (see `../_shared/corrections.md`).

## Run mode (standalone)
Default to Quick; do not ask. Follow `../_shared/run-mode.md`.

## Evidence on completion
Show each figure with its source, query, and window. Name every metric that
could not be pulled and why. A baseline whose numbers cannot be re-derived is
not a baseline.
