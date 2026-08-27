# Connected Sites - Graph

Unified Platform feature: review sites related to a merchant scan. The reported
main URL and connected-site URLs appear as URL rows beneath the merchant, and
each URL owns its findings. Connected sites use the same findings and evidence
workflow as the main URL.

- **Domain:** unified-platform
- **Target platform:** Unified Platform
- **Grain:** per-URL rows under the merchant (PM decision)
- **Approach:** build from scratch — legacy is precedent, not a port target

## Stage artifacts

| Stage | Artifact | Status |
|---|---|---|
| Reverse engineering | [current-state/reverse-engineering.md](current-state/reverse-engineering.md) | Done 2026-08-27 |
| Discovery | — | Not started |
| PRD | — | Not started |
| Spec | — | Not started |

## Open PM decisions

1. Is discarding a doorway URL's findings acceptable? (silent data loss, WARN only)
2. Is `PRIVATELY_ACQUIRED_DATA` edge rewriting a data-licensing obligation?
3. Should "connected by redirect" be a representable edge kind?
4. Does the main URL need to show its connected sites? (requires reverse index —
   the graph is directional today)
