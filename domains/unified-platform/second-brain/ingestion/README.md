# Ingestion — the LLM-maintained wiki

Karpathy LLM-wiki layer. The LLM maintains this, not you: it ingests `source/`,
writes interlinked concept/entity/synthesis pages, and keeps them dense over
time. You rarely edit these by hand.

## Page types
- **concept** — an idea/mechanism (e.g. transaction-laundering.md)
- **entity** — a system, team, or actor
- **synthesis** — a page connecting multiple sources into one thread

## Rules
- Every page: a 1-2 line summary at the top, then body.
- Every claim carries a provenance tag ([documented] > [verbal] > [hunch] >
  [industry]) and points back to the `source/` file it came from.
- **Cross-link every concept** with wiki-links: `[[other-page]]`. The value is
  the graph — a source insight linked to a regulation linked to a prior decision
  surfaces threads no single source shows. Density compounds.
- Never edit `source/`. If a source changes, add a new dated source file and
  re-ingest.
- Navigation: `index.md` lists all pages; `log.md` records what happened.

## Scope (important)
This wiki is for domain RESEARCH knowledge. Governed facts — compliance,
access-controlled policy — do NOT live here; they stay in `context/org-*.md` and
`context/compliance.md` as human-owned facts, not LLM-maintained pages.
