# Runtime Pointer

The canonical Claude contract is `../CLAUDE.md`. Do not add independent PM rules
here; this file exists only because Claude Code discovers `.claude/CLAUDE.md`.

Engine machinery lives in this folder:
- `skills/` - callable workflows, loaded only when relevant.
- `agents/` - isolated specialists for evidence-heavy work.
- `hooks/` - mechanical guardrails.

If a rule belongs everywhere, put it in `../CLAUDE.md`. If it belongs to a
domain, put it in that domain's `CLAUDE.md` or `INDEX.md`. If it is a workflow,
put it in one skill.
