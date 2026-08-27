# Run mode (standalone runs)

When a workflow is invoked without enough context, ask the PM up front which mode
to use for this run:

- **Quick one-off** — make reasonable assumptions on LOW-STAKES gaps to keep
  moving, and flag every assumption inline (clearly marked, e.g. "ASSUMED: ...")
  so the PM can see and override. Fastest for a rough draft.
- **Strict** — stop at every gap and ask; assume nothing.

## Assume-vs-ask boundary (applies even in Quick mode)
Quick mode may assume only low-stakes gaps: formatting, ordering, section
structure, placeholder copy, obvious defaults.

Quick mode must STILL STOP and ask on high-stakes gaps, never assume:
- Anything compliance / regulatory / policy-related.
- A requirement or behavior decision (what the product does).
- An invented UI component or a value not in the design kit (prototype).
- A metric target with no baseline anchor.
- Anything that would write to the PRD, Jira, Confluence, or a brain.

Rule of thumb: if a wrong assumption would ship to engineering, a stakeholder,
or the source of truth, it is high-stakes — ask regardless of mode.

Do not use run mode to bypass approval gates or product decisions.
