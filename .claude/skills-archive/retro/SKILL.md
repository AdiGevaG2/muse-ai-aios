---
name: retro
description: Learning loop. Capture what was learned during a feature — corrections, precedents, arbitration decisions, and repeated agent errors — and distill them back into the brains so the next feature starts smarter. Use at feature close, or when the user says "capture learnings", "run a retro", or "what should we remember". Brain writes are gated by approval.
---

# Retro (learning loop)

Close the loop: turn this feature's corrections and decisions into durable
knowledge so the system doesn't start from zero next time. The brains are ground
truth for every agent — so learnings are PROPOSED and only written on approval.

## Before you start
- Confirm active domain + feature name.
- Gather the raw material already produced during the flow:
  - Human corrections across stages (where you overrode the agent).
  - `legacy/` verify-loop escalations (ambiguities handed to a human).
  - `spec/reconcile-notes.md` arbitration decisions.
  - `prd/propagation-log.md` and `prd/publish-log.md` diverged items.
  - Post-launch: baseline re-measurement vs. the target the PRD set.

## Steps
1. **Extract candidate learnings.** For each, classify:
   - `glossary` — a term used wrong / a new entity worth defining.
   - `context` — a durable fact, constraint, or system behavior discovered.
   - `decision` — a call made worth keeping as precedent.
   - `engine-tuning` — a skill/agent repeatedly produced the same wrong output
     (this edits a `SKILL.md`/agent, NOT the brain).
2. **Scope each learning.** Org-wide -> `org-brain/`. Domain-specific ->
   `domains/<domain>/second-brain/`. When unsure, default to domain (narrower).
3. **Validate inferred learnings.** A "learning" is often an inference. Before it
   becomes brain ground truth, sanity-check it — optionally delegate to the
   `verify` agent to confirm it's supported, not a one-off. Mark shaky ones as
   tentative.
4. **Approval gate (hard).** Show the proposed brain edits as a diff — which file,
   what's added, at what scope. Write to the brains ONLY on approval. Never
   auto-write; a wrong learning corrupts every future feature.
5. **Engine-tuning suggestions go to a separate list** — they're recommendations
   to edit skills/agents, surfaced for you to action deliberately, not applied
   here.

## Rules
- Facts and durable decisions only. Don't record one-off preferences as
  precedent.
- Distill, don't dump — a learning is a tight entry, not the raw feedback.
- Keep the raw record too (below), so the distilled brain entry is traceable.

## Output
- `domains/<domain>/features/<feature-name>/retro/learnings.md` — the raw
  candidate list with classification + scope (the audit trail).
- On approval: appended entries in the target brain files (`glossary/`,
  `context/`, or `decisions/`).
- `retro/engine-tuning.md` — suggested skill/agent improvements, if any.
