# Maintenance

Sweep records. `/review` writes one dated report per run to
`log/YYYY-MM-DD.md`.

## Why the log exists

Without it, every sweep starts blind. You cannot tell a fresh finding from one
that has survived four reviews unresolved — and an item recurring across sweeps
is a different, usually more important, finding than the item itself.

Recurrence is the signal. A stale `context/` fact flagged once is housekeeping.
The same fact flagged four sweeps running means nobody owns it, and that is
worth escalating.

## Report shape

```markdown
# Sweep — YYYY-MM-DD

Scope: <which brains and directories were swept>

## Recurring (flagged in a previous sweep, still open)
- <item> — first flagged YYYY-MM-DD, <n> sweeps running  → <proposed action>

## New findings
### <failure mode, per ../system-evolution.md>
- <item>  <provenance tag>  → <confirm | downgrade | cut | promote | re-verify>

## Applied this sweep
- <what the PM approved and what changed>

## Deferred
- <flagged, PM chose not to act, and why — so the next sweep does not re-raise it blind>

## Counts
Open hypotheses: <n> | Pending decisions: <n> (oldest: <date>) | TODO: <n> | Unknown: <n>
```

## Rules

- **Never auto-apply.** The sweep proposes; the PM approves. Same gate as
  `/retro` (`CLAUDE.md § Authority`).
- **Log the deferrals too.** An item the PM deliberately declined is resolved,
  not open. Re-raising it every sweep is how maintenance becomes ceremonial
  (failure mode 7).
- **Track the counts.** Four sweeps of monotonically rising `TODO` and
  `Unknown` is a degradation signal, and only the log makes it visible.
- Reports are append-only history. Do not edit a past sweep to reflect what
  happened later; write it in the next one.
