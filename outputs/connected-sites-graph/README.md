# Connected Sites - Graph

UP feature for reviewing reported and connected URL rows under a merchant, with
findings owned per URL. Domain: `unified-platform`. Legacy is precedent, not a
port target.

## Read first

- [Reverse engineering V2](current-state/connected-sites-graph-reverse-engineering-v2.md)
  — Strict, 2026-08-30; current.
- [Reverse engineering V1](current-state/reverse-engineering.md) — 2026-08-27;
  historical and superseded where V2 differs.
- [Knowledge doc](knowledge/connected-sites-graph-knowledge.md) — 2026-09-01;
  shareable explanation for stakeholders. Not a spec.
- Discovery, PRD, and spec: not started.

A re-run of `/reverse-engineer` writes `...-v3.md` here and re-points this list.
Do not write the skill's default `<feature-name>-reverse-engineering.md` — this
feature versions its current-state docs.

## Evidence

- Target UP: `mlrc-merchant`, `mlrc-finding`, `mlrc-bff-2.0`,
  `marketview-portal`.
- Legacy: MV, SP, and WS. WS is not verified because source is unavailable.
- Last verified 2026-08-30. UP BFF/portal clones are stale; current MV/UI and SP
  matched remote tips. Exact commits and blockers are in V2.

## Decisions — PM, 2026-09-01

1. **Rows, not a graph.** Phase 1 is a flat list of connected sites under the
   merchant. Network Evidence tab is a later phase.
2. **Redirect is not a connection edge.** Out of scope; doorway findings are a
   findings-pipeline concern, not this feature's.
3. **No reverse projection.** Reported rows must not show their connections —
   duplicating the link on both sides is noise. Current BFF behavior is correct.
4. **Reported URLs are out of scope entirely.** Do not spec or raise them.

## Open decisions

1. Is `PRIVATELY_ACQUIRED_DATA` rewriting obligatory?
2. Does excluding a connected site persist per customer, per user, or globally?
3. Does an exclusion survive a re-scan that rediscovers the site?

## New requirement — PM, 2026-09-01

A connected site can be **excluded from merchant risk, reversibly**. Default is
that its findings count. When excluded, its entire risk contribution is removed;
the row stays visible and marked. The control is the designer's choice — the
requirement states behavior only.
