---
name: design-prototype
description: Build an interactive prototype on demand from an imported Figma design kit and the feature requirements. Use when the user says "build a prototype", "make a clickable mockup", or "prototype this feature". Pixel-perfect to the kit; invents nothing; every gap is raised to the PM rather than guessed.
---

# Prototype (design-kit-bound)

Build a prototype strictly from two ground-truth sources: the imported Figma
**design kit** and the **requirements** (PRD/spec). You may not invent, infer, or
decide anything outside those two sources.

## Ground truth (the only two sources)
1. **Design kit** — the components, tokens (color, type, spacing, radius),
   states, and layouts imported from Figma. This defines WHAT you may render.
2. **Requirements** — the PRD/spec for this feature. This defines WHAT the
   prototype must do and which screens/flows exist.

## Before you start
- Confirm active domain + feature name.
- Read the domain `CLAUDE.md` index, then `org-brain/` + `second-brain/`.
- Load the design kit (via Figma MCP) and the feature's `spec/spec.md` +
  `prd/prd.md`. If either is missing, stop and say what's needed.
- Build an inventory of the kit: every available component, variant, state, and
  token. This inventory is your allowed vocabulary — nothing outside it exists.

## Hard rules (non-negotiable)
- **Pixel-perfect to the kit.** Use the kit's exact tokens — never approximate a
  color, spacing, font, or radius. If a value isn't in the kit, that's a GAP.
- **No invented components.** Every element on screen must map to a real kit
  component/variant. You may not create a button, field, modal, icon, or layout
  that isn't in the kit. If a screen needs something absent from the kit, that's
  a GAP — do not substitute a "close enough" component.
- **No decisions outside the sources.** Copy, states, empty/error/loading
  behavior, navigation, ordering, defaults — if the requirements don't specify
  it and the kit doesn't show it, do NOT choose. That's a GAP.
- **Never silently fill a gap.** No placeholder lorem, no assumed happy-path, no
  "I'll just use a sensible default." Every unknown stops and becomes a question.

## Gap handling (the core behavior)
Maintain a **gap list**. A gap is anything the prototype needs that is not
answered by the kit OR the requirements. For each gap:
- What's missing (component / value / copy / behavior / flow step).
- Which source should have covered it (kit vs. requirements).
- The specific question the PM must answer to resolve it.

Do NOT proceed past a gap by guessing. Build what IS fully specified, leave the
gap unrendered (clearly marked as blocked-on-PM), and raise the gap list to the
user. Resolve gaps by:
- PM answers -> if it's a requirement decision, it routes through the PRD (source
  of truth), then the prototype uses it.
- Missing component -> flag to design to add it to the kit; do not fabricate it.

## Verify (reuse the verifier)
Before delivering, delegate to the `verify` agent to independently confirm:
every rendered element traces to a real kit component (traceability), and no
value/behavior was introduced that isn't in a source. Anything that fails ->
back to the gap list, not a fix-by-guess.

## Output
- `domains/<domain>/features/<feature-name>/prototype/` — the prototype
  (HTML/React using only kit components), stamped with the PRD version it was
  built from.
- `prototype/gaps.md` — the open gap list raised to the PM (the important
  deliverable; an empty gap list means the sources fully specified the feature).

## Folder resources (read these)
- `../../../domains/<domain>/config.json` — standing setup (domain, tool IDs,
  naming, gates). Use it instead of re-asking; only ask for what is still blank.
- `corrections/` — skill-specific corrections; apply them every run.
- `references/figma-kit.md` — kit import + inventory + gap discipline.

## Run mode (standalone)
If invoked directly (not via /feature-flow), first ask the PM: **Quick one-off**
(assume low-stakes gaps, flag each inline) or **Strict** (ask on every gap)?
Follow `../_shared/run-mode.md`. Either way, high-stakes gaps (compliance,
requirement/behavior decisions, invented components, unanchored metrics, or any
write to PRD/Jira/Confluence/brain) are ALWAYS asked, never assumed.

## Evidence on completion
Do not just claim done. Show the artifact: the file path written, the actual
query result / figures, the diff, or the mismatch/gap list — whatever this stage
produced. Reviewing the evidence must be faster than re-doing the check. This
catches silent failures (a stage that "ran" but produced nothing usable).
