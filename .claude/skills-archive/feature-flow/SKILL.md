---
name: feature-flow
description: Orchestrate the full PM feature pipeline from business requirement to Jira/Confluence handoff and deck. Use when the user says "run the flow", "start a new feature", or wants stages chained end-to-end. Accepts arguments to run a subset (e.g. "discovery through spec, stop before Jira"). Enforces the approval gates.
disable-model-invocation: true
---

# Feature Flow (orchestrator)

Sequences the pipeline. Each stage is its own skill and stays independently
runnable; this just chains them and enforces the gates. Invoke manually.

$ARGUMENTS may specify a subset (a start stage, an end stage, or "stop before
<stage>"). If empty, confirm the feature name and run the full flow.

## Setup (once per run)
- Confirm **active domain** and **feature name**.
- Load `org-brain/` then `domains/<domain>/second-brain/`.
- All outputs route to `domains/<domain>/features/<feature-name>/<stage>/`,
  created per stage as reached.

## Stage order
1. `/legacy-analyze` — behavioral reference (+ verify loop)   -> `legacy/`
2. `/target-platform` — delta vs. target                      -> `legacy/`
3. `/baseline-data` — Mixpanel + Coralogix current-state figures -> `baseline/`
4. `/discovery` — problem framing, cites delta + baseline     -> `discovery/`
   ⛔ **GATE: discovery approval.** Stop; get user approval + inputs before PRD.
5. `/prd` — single source of truth, metrics anchored          -> `prd/`
6. `/spec` — SpecKit spec + Figma; user arbitrates            -> `spec/`
7. `/design-prototype` — pixel-perfect build from design kit + spec; -> `prototype/`
   invents nothing; gaps raised to PM (⛔ **stops on any gap**)
8. `/testing` — prototype feedback -> PRD amendments            -> `testing/`
9. `/propagate` — PRD change fans out to local docs (auto)     -> updates docs
   ⛔ **GATE: Jira/Confluence.** Only reached via `/publish`.
10. `/publish` — Confluence + Jira, **each asked and approved separately** -> `prd/*-log.md`
11. `/deck` — feature deck from PRD                            -> `deck/`
12. `/retro` — learning loop: distill corrections + decisions  -> `retro/`
    into the brains (⛔ **GATE: brain writes require approval**)

## Orchestration rules
- **Runs strict.** Inside a full-flow run, gates are explicit — do NOT ask the
  per-stage Quick/Strict question. The Quick one-off mode is only for stages
  invoked directly. High-stakes gaps still stop for approval here as always.
- **Honor the gates even in a full run.** Never cross the discovery gate or the
  Jira/Confluence gate without explicit approval.
- **PRD is canonical.** After any change post-PRD (testing, spec arbitration),
  route through the PRD, then run `/propagate` — don't edit downstream directly.
- **Subset runs:** start/stop where asked. If a stage's inputs are missing
  (e.g. `/prd` with no approved discovery), stop and say what's needed rather
  than fabricating the input.
- **Per-stage skip:** the user can run any single stage directly by its own
  command; this orchestrator is only for chaining.

## Output
A run summary: which stages ran, where each artifact landed, which gates were
hit, and anything escalated or left diverged.
