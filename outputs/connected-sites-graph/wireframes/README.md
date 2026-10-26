# Wireframes — Connected Sites Findings Triage

Two wireframes of the **same screen**, each built with a different skill, so the
two skills can be compared directly. Both open in a browser — no build step.

Date: 2026-09-02
Subject: Connected Sites — Findings Triage, Phase 2 (URL-level + finding-level
triage on a connected URL). Grounded in
`../discovery/connected-sites-graph-discovery.md`.

## The two files

| File | Skill | What it is |
| --- | --- | --- |
| `wireframer-prototype.html` | `wireframer` (newly installed) | A **clickable prototype**. Two screens — sites list, URL detail — with real navigation. Click any table row to drill in, "Back to sites" to return. |
| `lofi-wireframe-canvas.html` | `lofi-wireframe` (pre-existing) | A **static comparison canvas**. Two competing layout *directions* for the same screen side by side (1a dense worklist, 1b split triage inbox), plus a 6-stage journey strip. Nothing clickable except the anchor links. |

## How they differ

**Visual language**
- `wireframer` — white paper, graph-paper dot grid, `Patrick Hand`, wobbly
  `border-radius` "sketchy border" trick, live `wired-elements` web components
  (real hand-drawn SVG inputs and dropdowns) loaded from a CDN. Strict grayscale.
- `lofi-wireframe` — warm `#eceae3` paper ground, `Patrick Hand`, straight
  marker borders with a hard offset drop shadow, browser-chrome frame around each
  screen. Muted risk dots (red/amber/green) carry severity; purple marks the
  AI/enrichment moment.

**What each is for**
- `wireframer` answers *"how does this interaction feel?"* — one flow, clicked.
- `lofi-wireframe` answers *"which layout should we pick?"* — several
  hypotheses compared at a glance, then a "Try next" line to branch the session.

**Interactivity**
- `wireframer` — real: JS screen switching, functional dropdowns and search
  inputs. Requires network access for the `unpkg` CDN and Google Fonts; the
  wired components render as plain boxes offline.
- `lofi-wireframe` — none by design. Self-contained apart from Google Fonts.

**Where output lands**
- `wireframer` — as installed here, `outputs/<feature>/wireframes/`, tied to the
  feature's evidence trail.
- `lofi-wireframe` — its own rule sends output to `design/wireframes/<slug>/` or
  `design/prototypes/<slug>/`. The canvas here was written into this folder
  instead, to keep the comparison in one place.

## Known deviation

The canvas file normally ships wrapped in `<x-dc>` with a `support.js` sibling
(the DC canvas runtime). That wrapper is stripped here so the file opens
standalone by double-clicking. Styling and layout are unchanged, but it will not
load in the DC editor in this form.

## Open question this comparison is meant to settle

Both skills trigger on the same words — "wireframe", "mock up", "prototype",
"sketch". Two skills competing on one trigger will fire unpredictably. Pick one
as the default and either retire the other or narrow it to an explicit lane.
