# Stakeholder Schema

Filename: `<first-last>.md`, lowercase and hyphenated. One file per person.

> Record names verbatim, as the person and the organization use them. Do not
> substitute a role label for a name.

## Shape

```markdown
# <Name> — <role>

- **Owns / decides:** <scope of their authority>
- **Asks / wants:** <their recurring requests>
- **Concerns:** <what they push back on>
- **Communication style:** <async or sync, terse or detailed, data or narrative>
- **Influence on this domain:** low | medium | high
- **Open asks:** <what I owe them, what they owe me>

## Touchpoint log
- YYYY-MM-DD — <one-line summary>  [documented] `<link to ../ingestion/... if any>`

## Last touched
YYYY-MM-DD
```

## Field discipline

Two kinds of field, and the difference matters:

- **PM-fillable** — concerns, communication style, open asks. When unknown,
  write `TODO` plus a one-line note on what is needed. `/review` treats `TODO`
  as a knowledge gap and surfaces it.
- **Auto-maintained** — `Last touched`, touchpoint log. When there is no data
  yet, leave blank or write `—`. Never write `TODO` here; it corrupts the
  gap signal.

## Provenance

Claims about what a person wants or believes are claims like any other. Tag them
per `../hypotheses/_SCHEMA.md § Provenance enum`. A stakeholder's position heard
secondhand is `[verbal]` at best — never `[documented]` unless they wrote it.
