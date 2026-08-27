# Engine — navigation

Machinery only. No domain content lives here.
- `CLAUDE.md` — engine rules (loaded every session).
- `skills/` — slash commands. Pipeline stages + `feature-flow` (orchestrator),
  `ingest`, `retro`, `review`. Each skill is a folder (SKILL.md + optional
  references/, corrections/).
- `agents/` — subagents: legacy-analyzer, target-mapper, verify,
  spec-reconciler, propagate.
