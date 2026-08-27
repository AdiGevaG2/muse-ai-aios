# Delta — <legacy system> -> <target platform>

> Consumes the legacy behavioral spec. Classifies each behavior against the
> target. Completeness is inherited from the legacy coverage map (see caveat).

## Delta table
| Legacy BR-ID | Classification | Detail | Source (target side, if new/changed) |
|---|---|---|---|
| BR-001 | carries over | identical on target | — |
| BR-014 | changes | window becomes configurable, default 24h | target/risk/config.ts L20 |
| — | new | target requires audit-log export | target/audit/export.ts L5 |
| BR-031 | drop | legacy-only cron hack, no target equivalent needed | — |

## Coverage caveat (mandatory)
_Carried forward from the legacy spec. The delta is only as complete as the
legacy analysis._

**Legacy modules NOT covered — delta is unaccounted-for here:** <list, or "none">

## Closing summary
- Carries over: <n>  Changes: <n>  New: <n>  Drop: <n>
- Unaccounted-for areas (from legacy not-covered): <list>
