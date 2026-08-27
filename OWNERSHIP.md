# Ownership

Who owns what. Ownership means: this person curates the folder, reviews changes
to it, and is accountable for its accuracy. Others propose via PR; the owner
approves. This is what makes the repo self-serving without rotting — every folder
has someone accountable for keeping it true.

## Engine
| Path | Owner | Notes |
|---|---|---|
| `.claude/` (skills, agents, CLAUDE.md) | <engine owner / you> | Machinery. One owner bumps versions; others propose via PR. |

## Org knowledge
| Path | Owner | Notes |
|---|---|---|
| `org-brain/context/policies.md` | <compliance / security lead> | Governed. Human-owned, never LLM-maintained. |
| `org-brain/context/systems.md` | <platform / eng lead> | Shared systems facts. |
| `org-brain/glossary/`, `org-brain/decisions/` | <org owner> | Company-wide. |

## Domain: unified-platform
| Path | Owner | Notes |
|---|---|---|
| `domains/unified-platform/CLAUDE.md` + `config.json` | <domain PM — you> | Domain index + setup. |
| `second-brain/context/compliance.md` | <compliance lead> | Governed, human-owned. |
| `second-brain/context/platform.md` | <domain PM / eng> | Target + legacy systems. |
| `second-brain/ingestion/` (wiki), `source/` | <domain PM> | LLM-maintained; PM curates. |
| `second-brain/stakeholders/`, `hypotheses/` | <domain PM> | |
| `features/` | <feature PM per feature> | Each feature's outputs owned by its PM. |
| analytics / baseline outputs | <data scientist / analytics owner> | Metric definitions + queries. |

## Rules
- Every folder has exactly one accountable owner (not "the team").
- Governed folders (compliance, policy) are human-owned — never auto-written by
  `/ingest`, `/retro`, or `/review`; those skills propose, the owner approves.
- Changes to a folder route through its owner. This is the team-scale version of
  the approval gates.

_(Fill in the &lt;owners&gt; as the pilot expands past a single PM.)_
