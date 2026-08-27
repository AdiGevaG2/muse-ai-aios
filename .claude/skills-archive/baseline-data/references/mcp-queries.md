# MCP Query Patterns — baseline-data

How to pull current-state figures. Read this when running `/baseline-data`. Project
IDs and endpoints come from `domains/<domain>/config.json` (tools section).

## Mixpanel (product / funnel metrics)
- Auth: service account (shared team use), project from config.
- First, list available events/properties before querying — don't assume names.
- Always pass an explicit date window (e.g. "last 30 days, ending <today>").
- Typical pulls: funnel conversion by step, drop-off %, event counts over time,
  segmentation by acquisition source.
- Record each figure with its query + window so it's reproducible later.

## Coralogix (error / performance signals)
- Send `mcp-version: v2`. Region endpoint from config. OAuth or API key.
- Log queries run against ARCHIVE storage — not frequent-search-only tiers.
- One active MCP connection at a time — don't run parallel Coralogix pulls.
- Typical pulls: error rate by service, P99 latency on the relevant route,
  failure counts on the flow the feature touches.

## Query discipline (Mixpanel)
- Every query must specify all four: **Behavior** (event/action), **Population**
  (which users), **Timeframe** (explicit window), **Output** (funnel /
  retention / segmentation / count). Missing any one = underspecified — tighten
  before running.
- Only reference events/properties verified in the project. An unconfirmed
  event name is not a fact — flag it and ask, don't guess the closest match.
- Always break funnels down by platform / channel / cohort; in retention,
  always separate free vs. paid. Aggregate-only figures hide the real
  drop-off, and these numbers feed PRD success metrics.
- When ranking or prioritizing segments, rank by retention, not raw volume —
  call out high-traffic / low-retention segments explicitly.
- Any governance-affecting or write action (Lexicon edits, saved reports,
  dashboard changes) previews the change and waits for approval — same
  approval-gate rule as everywhere else in this repo.

## Output discipline
- Numbers only, each source-cited (query + window).
- If a metric can't be pulled, say so — never estimate.
- Write raw pulls to `second-brain/source/`, the synthesized baseline to
  `features/<feature>/baseline/baseline.md`, tagged `[documented]`.
