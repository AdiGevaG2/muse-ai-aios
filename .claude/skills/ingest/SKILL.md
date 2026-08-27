---
name: ingest
description: Ingest a source into the domain wiki and maintain the interlinked knowledge graph. Use when the user says "ingest this", "add to the brain", "add this source", or drops an article/transcript/notes/data to capture. The LLM maintains the wiki — writes pages, draws cross-links, updates the index and log.
---

# Ingest (LLM-maintained wiki)

Take a raw source and fold it into the domain wiki so knowledge compounds. You
maintain the wiki; the user just supplies sources. Source: $ARGUMENTS (a path,
URL, or pasted material — ask if none given).

## Before you start
- Confirm active domain (from `config.json`).
- Read `second-brain/ingestion/index.md` so you know what pages already exist —
  navigate, don't re-read every page.

## Steps
1. **Store the raw source, untouched.** Copy it into `second-brain/source/` as a
   dated file. Never edit it. This is the citable original.
2. **Synthesize into wiki pages** under `second-brain/ingestion/`:
   - Update existing pages where the source adds to a known concept/entity.
   - Create new pages (concept / entity / synthesis) for genuinely new material.
   - Each page: 1-2 line summary on top, body below.
3. **Tag provenance.** Every claim gets `[documented] / [verbal] / [hunch] /
   [industry]` and a pointer to the `source/` file. Never dress a weak claim as
   strong.
4. **Cross-link — this is the point.** Add `[[wiki-links]]` connecting this
   material to related pages. Actively look for threads across different sources
   (an insight ↔ a regulation ↔ a prior decision). The denser the graph, the
   more the wiki can answer that no single source could.
5. **Update navigation.** Add new pages to `index.md`. Append a newest-first line
   to `log.md`: what came in, pages created/updated, links drawn.

## Rules
- **Governance boundary:** do NOT create wiki pages for compliance /
  access-controlled policy. Those stay human-owned in `context/org-*.md` and
  `context/compliance.md`. The wiki is research knowledge only.
- Compile, don't dump — synthesize in our own words; the raw stays in `source/`.
- If the source conflicts with an existing page, surface the conflict with both
  provenance tags rather than silently overwriting; `/review` resolves drift.

## Output
Updated `source/` (raw), `ingestion/` pages (synthesis + links), `index.md`, and
`log.md`. Briefly report what was created/updated/linked.

## Evidence on completion
Do not just claim done. Show the artifact: the file path written, the actual
query result / figures, the diff, or the mismatch/gap list — whatever this stage
produced. Reviewing the evidence must be faster than re-doing the check. This
catches silent failures (a stage that "ran" but produced nothing usable).
