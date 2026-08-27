# PM Workflow Navigation

Top-level map. This is a router, not a methodology warehouse.

- `CLAUDE.md` - single canonical PM/Claude contract.
- `AGENTS.md` - Codex implementation contract.
- `.claude/skills/` - the workflow skills: reverse-engineer, baseline-data,
  discovery, prd, spec, analytics-plan, validation, publish, plus the
  compounding loops ingest, retro, review.
- `.claude/agents/` - isolated specialists for evidence-heavy work.
- `.claude/hooks/` - mechanical guardrails.
- `outputs/` - canonical workspace for new feature artifacts, grouped by stage.
- `domains/<domain>/` - domain routers, context, decisions, and historical
  features.
- `scripts/` - deterministic validators, plus diagram conversion
  (mermaid -> editable draw.io SVG).

Start feature work at `outputs/<feature-name>/README.md`. On a new requirement
or standalone feature stage, follow `outputs/README.md` to initialize the
feature workspace. Create stage folders and artifacts only when that stage
actually happens.

## Flow

```
reverse-engineer -> discovery -> prd -> figma delta (in /spec) -> spec
                 -> validation
                 -> analytics-plan (when measurement is warranted)
                 -> publish (Jira handoff only when asked; Confluence only when asked)

baseline-data  -- pull real numbers; run before any stage that needs them
```

Two pairs are deliberately not interchangeable:

- `validation.md` vs `alignment-report.md` — acceptance results vs. artifact
  drift against a moved spec.
- `spec.md` vs the Confluence spec page — the markdown is the source of truth;
  the Confluence page is a rendering of it.
