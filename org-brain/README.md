# Org Brain — company-wide knowledge

Knowledge that applies across **every** domain, not just one. Agents load this on
every session, before the active domain's second brain.

## What lives here (org-wide only)
- `glossary/` — company-wide terms, product names, entities every PM shares.
- `context/` — org-wide facts: company systems, security/data policies,
  compliance rules that apply everywhere, shared platform architecture.
- `decisions/` — standing org-level decisions every domain must respect.

## What does NOT live here
Domain-specific knowledge. That belongs in
`domains/<domain>/second-brain/`. If a fact only matters to one domain, it is
not org-level.

## Provenance — tag every load-bearing claim
Same discipline as the domain brains. Tag each claim by evidence strength:
`[documented]` > `[verbal]` > `[hunch]` > `[industry]`. Never present a weak
claim as documented; stronger tag wins on conflict unless a human overrides.

## Precedence (important)
Agents read **org-brain first, then the domain second-brain**. On conflict, the
**domain brain wins** — it's the more specific context. Keep org-brain to things
that are genuinely universal so this rarely comes up.

## Not the engine
This is knowledge, not machinery. It deliberately sits OUTSIDE `.claude/` so the
engine stays portable (packageable as a plugin) without carrying company data.
