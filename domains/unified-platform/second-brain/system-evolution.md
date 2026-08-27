# System Evolution — how the brains degrade

> Governs the knowledge system itself, not the product knowledge inside it.
> Load before running `/review`. The sweep checks in `.claude/skills/review/`
> are the *how*; this is the *why*.

## Core principle

The brains should get more compressed, more decision-relevant, and easier to
retrieve from over time. If they instead get larger, noisier, more ceremonial,
or harder to navigate, the architecture is degrading.

The enemy is not missing information. It is entropy.

This is the same discipline `CLAUDE.md § Context` states as "optimize for
minimum irrelevant context" — here applied to the knowledge base rather than a
single session.

## The eight failure modes

Named, so a sweep can look for them instead of vaguely hunting for rot.

**1. Knowledge bloat.** Too many files, overly long files, the same concept
restated across `context/`, `glossary/`, and a feature README. Narrative prose
where an operational line would do.
→ Compress. Merge duplicates. Reference instead of repeating. A `context/` file
that cannot be loaded for a routine task has already failed.

**2. Over-promotion from ingestion to durable knowledge.** A one-off remark in a
single interview hardens into a `context/` fact. A weak stakeholder opinion
becomes a standing constraint.
→ Require recurrence before promotion. Preserve uncertainty explicitly. Move
weak signals back to `ingestion/`. A `[verbal]` claim cited once is not
`[documented]`.

**3. Hypothesis theater.** Hypotheses written and never referenced again. Open
questions accumulating with no test attached. A hypothesis marked `supported`
with no decision record behind it.
→ Keep only decision-relevant hypotheses open. Archive the rest. Audit whether
any hypothesis actually changed a decision. Rigor that is simulated is worse
than absent, because it reads as covered.

**4. Tension graveyards.** The same contradiction surfaced sweep after sweep,
never resolved. `CLAUDE.md` requires recording conflicts with `PM decision:
Pending` — that is correct, but a pending decision that ages indefinitely stops
being a record and becomes landfill.
→ Merge recurring tensions. Escalate the high-confidence ones. A conflict
pending past two sweeps is itself the finding.

**5. Retrieval breadth explosion.** Agents loading whole directories for narrow
tasks. Simple work triggering recursive scans. Exactly what the `CLAUDE.md`
loading order exists to prevent.
→ Reinforce INDEX/README routing before file loading. Routers are routing
candidates, never automatic reads.

**6. Canonical ownership drift.** The same fact stated differently in
`org-brain/` and a domain `second-brain/`. A metric defined twice. Product
intent drifting between a PRD and a decision record.
→ Reassert single ownership; replace the duplicate with a reference. Surface
drift, never silently overwrite. `CLAUDE.md § Authority` sets who wins:
`prd.md` for intent, `spec.md` for behavior, domain over org on specificity.

**7. Maintenance becoming ceremonial.** Long sweep reports that produce no
decisions. The same stale item flagged every time. The PM stops reading.
→ Compress the report. Cut low-value checks. If a check has never produced an
action, delete the check.

**8. Over-compression.** Minority signals vanish. Contradictions get smoothed
away. Everything starts sounding aligned.
→ Preserve meaningful dissent and contradicting evidence. Retain provenance on
high-leverage claims. Prefer unresolved ambiguity over false consensus — a brain
that is coherent but wrong is more dangerous than one that is visibly unsure.

Modes 1, 5, and 7 push toward *less*. Mode 8 pushes back toward *more*. They are
in deliberate tension; that tension is the judgment the sweep exercises.

## Staleness thresholds

Defaults, not rules. **Flag — never auto-decay.** The PM resolves each as
refresh, retire, or accept-as-current.

| Knowledge | Flag after | Why |
|---|---|---|
| Market and competitor intel | 30–60 days | Moves fast; a stale competitor claim misleads positioning. |
| User interview signals | 90 days | Durable, but the population shifts. |
| Stakeholder positions | 30 days | People change their minds and their roles. |
| Platform and repo facts | 60 days | Branches move, services get renamed, ownership changes. |
| Compliance and regulatory | 90 days, or on any known change | A stale obligation is a real risk, not a documentation problem. |
| Strategy assumptions | Quarterly | Slow-moving by design. |
| AI eval results | On any model, prompt, or eval-set version change | An unversioned score is not reproducible (`CLAUDE.md`). |

An item past threshold is not wrong. It is unverified. Those are different, and
the sweep report must not conflate them.

## Degradation signals

The brains are degrading if agents routinely load large portions of the repo;
sweep reports get ignored; `TODO` and `Unknown` counts only ever grow; decisions
stop being recorded; the same question keeps being re-asked after it was already
ingested; or the PM starts bypassing the system entirely.

The last one is the real alarm. Every other signal is measurable from the repo;
that one is only visible to you.

## Cadence

- **Weekly** — `/review` sweep. Log it (`maintenance/log/`).
- **Monthly** — reread this file against the last four logs. Which failure mode
  is actually showing up? Are the same items recurring?
- **Quarterly** — architecture review. Prune checks that never fire, retire
  knowledge areas that never get read, revisit the thresholds above.

The architecture is not fixed. If a rule here stops matching how the work
actually goes, change the rule — deliberately, and write down why.
