# PM Workflow Navigation

Top-level map. This is a router, not a methodology warehouse.

- `CLAUDE.md` - single canonical PM/Claude contract.
- `AGENTS.md` - Codex implementation contract.
- `.claude/skills/` - the workflow skills: reverse-engineer, baseline-data,
  discovery, prd, spec, ai-eval, analytics-plan, validation, publish, plus the
  compounding loops ingest, retro, review.
- `.claude/skills-archive/` - preserved optional/legacy skills, intentionally
  not part of the default discoverable workflow.
- `.claude/agents/` - isolated specialists for evidence-heavy work.
- `.claude/hooks/` - mechanical guardrails.
- `outputs/` - canonical workspace for new feature artifacts, grouped by stage.
- `domains/<domain>/` - domain routers, context, decisions, and historical
  features.
- `org-brain/` - org-wide context, loaded only when routed.
- `scripts/` - deterministic validators.
- `tools/scripts/` - diagram conversion (mermaid -> editable draw.io SVG).

Start feature work at `outputs/<feature-name>/README.md`. On a new requirement
or standalone feature stage, follow `outputs/README.md` to initialize the
feature workspace. Create stage folders and artifacts only when that stage
actually happens.

## Flow

```
reverse-engineer -> discovery -> prd -> figma delta (in /spec) -> spec
                 -> ai-eval (AI features) -> validation
                 -> analytics-plan (when measurement is warranted)
                 -> publish (Jira handoff; Confluence only when asked)

baseline-data  -- pull real numbers; run before any stage that needs them
```

Three pairs are deliberately not interchangeable:

- `/ai-eval` vs `/validation` — one asks whether the model output is good enough
  to ship, the other whether the build matches the spec. A feature can pass one
  and fail the other.
- `validation.md` vs `alignment-report.md` — acceptance results vs. artifact
  drift against a moved spec.
- `spec.md` vs the Confluence spec page — the markdown is the source of truth;
  the Confluence page is a rendering of it.
