---
name: prd
description: Write or amend the feature PRD from approved discovery or explicit PM direction. Use when the user says "write the PRD", "draft the PRD", or asks to amend product intent. The PRD is product intent, not implementation detail.
---

# PRD

Create or amend a PRD from approved discovery or explicit PM direction.

## Required reads
1. `../../../outputs/README.md`, then the feature `README.md`. If the feature
  workspace does not exist, initialize `outputs/<feature-name>/README.md`
  before drafting.
2. Approved discovery, or the explicit PM direction replacing it.
3. Existing PRD only when amending.
4. `references/prd-template.md`.
5. `references/prd-ai-sections.md` — AI features only, including ones built on
   another team's model.

README links are routing candidates, not required reads. Do not load `INDEX.md`,
`config.json`, style guides, samples, corrections, brains, repos, analytics,
designs, integrations, or agents unless the source exposes a gap.

## Write
- Preserve every template section and order. Mark N/A sections `N/A - [reason]`.
- Direct, concise, verdict first. No hype or invented precision.
- Keep product behavior in the PRD, not implementation or Figma detail.
- AC as Gherkin: happy paths, failures, permissions, stale/conflicting state,
  empty data, boundaries.
- Use `Unknown` or `TBD` for missing evidence. Do not invent owners, dates,
  metrics, targets, behavior, or decisions.
- Stamp version `vN`. Intent changes flow through the PRD first.
- Surface source conflicts for PM arbitration.

## Output
Default for new features:
`outputs/<feature-name>/prd/<feature-name>-prd.md`, with the version stamped at
the top. For historical features, follow the README.

After writing, inspect the artifact or diff, report unresolved items, and stop.
Do not proceed to spec without approval.
