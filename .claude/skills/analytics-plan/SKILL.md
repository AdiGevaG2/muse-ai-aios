---
name: analytics-plan
description: Write a feature's measurement plan — decision supported, hypotheses, metric definitions, events, analysis design, governance. Use for "analytics plan", "measurement plan", "what should we instrument", "define the events", "how will we know it worked". Runs after the spec.
---

# Analytics Plan

Write the measurement plan for $ARGUMENTS (a feature name). If empty, ask which
feature is in scope.

This runs **when relevant**, not for every feature. A plan is warranted when the
feature has a success metric worth defending, an experiment or staged rollout,
or new instrumentation. A small internal change with no decision riding on it
does not need one — say so rather than producing a plan nobody reads.

## Before you start
- Confirm active domain and feature name.
- Follow `../../../outputs/README.md`. If the feature workspace does not exist,
  initialize `outputs/<feature-name>/README.md`; otherwise read its README
  first.
- Read the PRD's `Success Metrics` and `Required Events / Signals`, and the
  spec's `Analytics Events`. This plan **elaborates** those; it does not invent
  a parallel set of metrics. If PRD and spec disagree on an event, surface the
  conflict rather than picking one.
- Read `../../../domains/<domain>/config.json` for the Mixpanel project and the
  customer-only default.
- Do not load org/domain brains wholesale.

## Write
Follow `references/analytics-plan-template.md`. Its shape is authoritative;
fill every section or mark it `N/A - [reason]`.

Rules that matter more than the table structure:

- **Lead with the decision.** "What launch, rollout, or iteration call does this
  plan support?" A plan with no decision attached is a dashboard request.
- **Every metric needs a definition, a grain, and a window.** "Adoption" is not
  a metric. "Distinct analysts who recorded a Decision, per week, of analysts
  with queue access" is.
- **Baselines before targets.** A target with no baseline is unreadable. Mark it
  `TBD` with an owner rather than inventing a number.
- **Name the guardrail.** What negative outcome would make you roll back? A plan
  with only success metrics cannot detect harm.
- **State the analysis design honestly.** If the rollout cannot support an
  experiment, say pre-post or cohort and name the confounds — do not dress a
  trend line as a causal result.
- **Minimum detectable effect.** If the population cannot detect the effect you
  care about within the window, the analysis will be inconclusive by
  construction. Say that before instrumentation, not after.
- Mark every event `Required for MVP: Yes / No`. Instrumentation competes with
  feature work; an unprioritized event list gets cut arbitrarily by engineering.
- Do not invent owners, dashboards, baselines, or thresholds.

## AI features
When the feature has AI behavior, this plan covers **product** measurement.
Model quality belongs to `/ai-eval` and its `ai-eval.md`. Keep them separate:
adoption and accuracy are different questions and fail independently. Where the
feature captures human corrections of model output, record that here as a data
source and cross-reference the eval — those events are the label pipeline.

## Output
Default for new features:
`outputs/<feature-name>/analytics-plan/<feature-name>-analytics-plan.md`.
For historical features, follow the artifact path in the feature README.
If no durable artifact is needed, return the plan summary in chat.

## Stop conditions
- Stop and ask when the success metric was never defined in the PRD — do not
  invent one here; route back to `/prd`.
- Stop on product ambiguity about what counts as success.
- Do not rewrite the PRD or spec; propose amendments.
- External writes (creating dashboards, editing tracking plans) require
  explicit scoped approval.

## Folder resources
- `references/analytics-plan-template.md` — the template to fill.
- `../../../domains/<domain>/config.json` — Mixpanel project, customer filter.
- `corrections/` — skill-specific corrections; apply them every run.

## Run mode (standalone)
If invoked directly, ask **Quick one-off** or **Strict**. Follow
`../_shared/run-mode.md`. High-stakes gaps still stop.

## Evidence on completion
Show the artifact path, the metric definitions with their baselines, and the
event list marked by MVP priority. Name explicitly which metrics have no
baseline and which events are not yet instrumented — an analytics plan that
hides its own gaps guarantees an inconclusive launch review.
