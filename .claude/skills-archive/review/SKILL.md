---
name: review
description: Periodic maintenance sweep of the brains. Flags stale, contradictory, weakly-evidenced, or orphaned knowledge so it can be confirmed, downgraded, or cut. Use on a cadence (e.g. weekly) or when the user says "review the brain", "sweep for drift", or "clean up knowledge". Distinct from /retro, which captures new learnings at feature close.
---

# Review (brain maintenance sweep)

Keep the brains from rotting. `/retro` adds knowledge; `/review` audits what's
already there. A brain nobody sweeps quietly fills with stale facts that corrupt
future outputs.

## Scope
Sweep `org-brain/` and the active domain `second-brain/` (glossary, context,
decisions, ingestion, hypotheses, stakeholders).

## What to flag
1. **Contradictions** — two entries that disagree. Surface both with their
   provenance tags; the stronger tag wins unless the user overrides.
2. **Weak evidence still load-bearing** — `[hunch]` or `[industry]` claims that
   downstream artifacts have been relying on as if solid. Flag for confirmation
   or downgrade.
3. **Staleness** — entries whose source is old or whose `context/` fact may have
   changed (systems, regulations). Flag for re-verification.
4. **Orphans** — `ingestion/` synthesis with no `source/` behind it, or source
   never synthesized. Broken provenance chains.
5. **Wiki integrity** — broken `[[wiki-links]]` (pointing to nonexistent pages),
   pages missing from `index.md`, index entries with no page, pages with no
   cross-links (isolated nodes that should connect to the graph).
6. **Hypotheses to resolve** — open hypotheses that now have enough evidence to
   mark supported/refuted, or promote into `context/`.
7. **Confirmed-repeatedly** — a claim reinforced across features; note it's
   durable (keep). A claim contradicted repeatedly; propose cutting it.

## Rules
- **Propose, don't auto-edit.** Same gate as `/retro`: the brain is ground truth,
  so show a diff (what to confirm / downgrade / cut / promote) and change only on
  approval.
- Never strengthen a provenance tag on your own — only a human can promote a
  `[hunch]` to `[documented]`.
- Rule of thumb: a rule confirmed repeatedly stays; a contradicted one gets cut.

## Output
A sweep report: flagged items grouped by category, each with a proposed action
(confirm / downgrade / cut / promote / re-verify) and its provenance. On
approval, apply the edits.
