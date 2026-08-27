# Org Ingestion — the LLM-maintained org wiki

Same machinery as a domain wiki, scoped to company-wide knowledge. The LLM
maintains this: it ingests `org-brain/source/`, writes interlinked
concept/entity/synthesis pages, and keeps them dense over time.

## Page types
- **concept** — an idea/mechanism that applies across domains
- **entity** — a company, system, team, or actor at org level
- **synthesis** — a page connecting multiple sources into one thread

## Rules
- Every page: a 1-2 line summary at the top, then body.
- Every claim carries a provenance tag ([documented] > [verbal] > [hunch] >
  [industry]) and points back to the `source/` file it came from.
- **Cross-link every concept** with wiki-links: `[[other-page]]`. Density
  compounds.
- Never edit `source/`. If a source changes, add a new dated source file and
  re-ingest.
- Navigation: `index.md` lists all pages; `log.md` records what happened.

## Scope (important)
Org-wide RESEARCH knowledge only. Two boundaries:

- **Down:** domain-specific material belongs in
  `domains/<domain>/second-brain/ingestion/`, not here. If a fact matters to one
  domain only, it is not org-level.
- **Sideways:** governed facts — compliance and access-controlled policy — stay
  human-owned in `../context/`, not as LLM-maintained pages here.

An org write is never silent: `/ingest` confirms with the PM before creating
pages in this tree.
