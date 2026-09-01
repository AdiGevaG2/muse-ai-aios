# Discovery: View Connected Sites in the Findings Graph

Document Name: view-connected-sites-in-findings-graph-discovery

Feature Name: View Connected Sites in the Findings Graph
Owner: Adi Geva
Product: Unified Platform
Last Updated: 2026-09-01

> **On the name.** "Findings graph" is the PM's shorthand for the connected-sites
> data under a merchant, not a commitment to a graph or hierarchy UI. Delivery is
> a flat list of rows; the Network Evidence tab and any graph presentation remain
> out of scope. `ASSUMED:` shorthand, not a scope reversal — PM, 2026-09-01.

> **Amended 2026-09-01** after `/learn-feature` narrowed scope: Phase 1 is a flat
> list of connected sites only; reported URLs are out of scope; the "projection
> gap" is retired, not deferred; redirects are not connection edges. New
> requirement: reversible exclusion of a connected site from merchant risk.
> Corrected: a connected *site* is never dropped (a single *connection record*
> can be).

## TL;DR

This feature is about **how a connected site is represented in the Findings tab**
of Unified Platform (UP). A connected row carries a **Graph - Connected URL**
badge today. Two things are unresolved about it: the badge can be suppressed by
a data path that discards the connection record, leaving a connected site
looking ordinary while it still raises the merchant's risk — the mechanism is
confirmed in code but has not been measured in production. And it is not
established whether UP scores a connected site's findings on the same severity
scale MV uses.

A false connection makes this worse. The site's findings raise the merchant's
score automatically, and UP offers no way to correct it.

Delivery is a **flat list of rows under the merchant**, in two phases. Phase 1 is
representation: mark the row, score it correctly, and let an analyst exclude a
site whose connection is wrong — **reversible exclusion**, which replaces MV's
graph-edit workflow as the correction. Phase 2 extends UP's existing finding
actions to those rows, so a judgment about a connected site can be recorded
rather than just applied.

Collapsed-row previews, sorting, filtering, and category grouping are out of
scope — revisit only if Phase 2 shows analysts working connected sites in
volume. `PRODUCT DECISION` — PM, 2026-09-01.

## Problem

### Pain Points

- **A false connection inflates merchant risk with no way to correct it.** A
  connected site's findings count toward the merchant score automatically. If
  the connection is wrong, the analyst has no lever — MV's graph-edit workflow
  does not exist in UP, so the inflation persists until a re-scan that may never
  change the answer.
- **A row can under-report its connections.** Peer resolution matches against
  store rows already created under the merchant; an unmatched peer is skipped
  with a warning and nothing re-checks it. The site still gets its row — what is
  lost is the connection record, and with it the analyst's explanation of why
  the site is there.
- **A judgment cannot be recorded, only a status set.** An analyst can set a
  finding's `Resolution` and see its evidence and risk, but there is no snooze,
  no dispute, no notes, and no history. The reasoning behind a decision is lost,
  and the next analyst to open the row cannot see that it was already reviewed.
- **Connected-site risk may be silently wrong.** MV picks finding severity by
  reported status (`finding-sub-type.component.ts:61-62`). Whether UP does the
  same is unverified — `mlrc-risk` was never inspected, and the UP findings row
  shows Severity and Risk as separate columns, which may mean it already
  distinguishes them. `UNKNOWN` — if UP has no equivalent, connected-site risk
  drops to reported levels on migration with no visible cause. If it does, this
  is not a gap at all.
- **The connected marker can be missing on a connected site.** The **Graph -
  Connected URL** badge is driven by the saved connection record. When the
  connection is found, UP looks for the site at the other end among the
  merchant's existing rows; if it has not been saved yet, the connection is
  discarded with a warning and never retried — described in source as a race
  with out-of-order store creation (`StoreConnectionService.java:78-83`). The
  site keeps its row and still raises the merchant's risk, but shows no badge.
  The row's `connected` flag stays correct throughout, and the API already sends
  it separately (`StoreFindingMapper.java:22`) — but the badge requires a
  connection record as well, so the flag alone does not surface it. `UNKNOWN` —
  what causes the ordering to vary, and whether a later re-scan repairs it, is
  not established.
- **Assessing a row requires expanding it.** Categories, counts, severity, and
  new-finding indicators are not visible on the collapsed row, so an analyst
  cannot tell which URL deserves attention without opening it. This feature does
  not solve it — collapsed-row previews are out of scope. It is the evidence for
  revisiting them after Phase 2.
- **Evidence is being discarded as it arrives.** UP drops depth, node count,
  timing, and per-entry score before storage. Every day this continues adds to
  the historical re-scan any later decision would require.

## Proposed Solution

### Feature Behavior

Connected sites appear as a **flat list of rows under the merchant** — no graph,
no hierarchy, no node expansion. Each row supports the same
workflow as any other URL row, says why it is connected, and can be excluded from
merchant risk.

Three rules make this coherent:

1. **Connected and reported rows get the same treatment.** A connected URL is a
   first-class findings row, and its findings are worked like any other.
2. **Reported status still changes risk.** Same actions, different severity
   scale. Parity of workflow is not parity of scoring.
3. **Exclusion is the correction for a wrong connection.** The analyst removes
   the site's risk contribution; the row stays on screen, marked.

**Phase 1 — Correctness. Backend plus one badge.**

- Apply reported-status severity in UP's risk path, matching MV's dual scale —
  conditional on open question 1 confirming UP does not already do this.
- Render the connected marker from the row's stored `connected` flag rather than
  from whether its peers resolved, so every connected site is marked.
- Persist the full `connectionInfo` payload — depth, node count, score, path.
- **Reversible exclusion from merchant risk.** By default a connected site's
  findings contribute to merchant risk with no user action. An analyst can
  exclude the site from the row itself, and can reverse the exclusion from the
  same place. On exclusion, every risk contribution from that site leaves the
  merchant calculation and the merchant score updates. The row stays in the
  list, marked as excluded, showing who excluded it and when. Reversing restores
  the original contribution.

**Phase 2 — Recording the judgment. Extend existing UP patterns to connected rows.**

- Snooze, dispute, add and view notes, view finding history, and show when a
  rule affected the finding.

Category, evidence, risk, and the Resolution dropdown already render on every
findings row — `useMerchantFindingsColumns.tsx:23-89`. Phase 2 adds what is
missing rather than rebuilding the row. These patterns exist for reported URLs;
reported-row behavior is unchanged.

### User Journey

1. An analyst opens a merchant's Findings tab and sees the merchant's URLs as a
   flat list, with connected sites marked as connected.
2. On a connected row they open the connection popover to see which peer it
   links to, by what connector, and when it was last checked.
3. They expand the row to see its findings, their severity, and their evidence.
4. They snooze, dispute, or resolve individual findings, and record notes
   against them.
6. Judging the connection wrong, they exclude the site. Its findings stop
   contributing to merchant risk, the row stays listed and marked excluded, and
   the merchant score drops accordingly. They can restore it later.
7. The judgment is recorded against the URL and its findings, and merchant risk
   reflects the connected site at its correct severity.

### Assumptions

| Assumption | Evidence | Validation needed |
|---|---|---|
| UP already owns findings per URL, including connected | Store unique by `(merchantId, urlHash)`, carries `connected`; findings grouped by `storeId` — `StoreEntity.java:25-69`, `FindingServiceImpl.java:106-138` | None — this is why the feature is an extension |
| UP returns a row for every URL, including clean ones | `FindingServiceImpl.java:57-73,126-138`, `FindingControllerIntegrationTest.java:460-589` | None |
| Popover already shows peer URL, connector, last checked | `ConnectionPopover.tsx:21-75`, `ConnectedURLBadge.tsx:15-63` | Only path, depth, score are missing |
| Reported status is durable once set | `StoreConnectionsMergeIntegrationTest.java:542-631` | None |
| The **Graph - Connected URL** badge exists but is conditional on resolved peers, not on the stored `connected` flag | `MerchantFindings.tsx:53-71`, `ConnectedURLBadge.tsx:16-18`; badge confirmed in UP screenshot (MLRC Playground Prod, 2026-09-01) | Clone is June 2026; verify against remote `develop` |
| `connected` is a durable origin label, not a score | `StoreEntity.java:23-68` | None — the marker can render from this field alone |
| Store identity is per-merchant | Partition `merchantId` + sort `urlHash` — `StoreEntity.java:23-68` | Exclusion must be scoped to the merchant's store row, not the URL globally |
| A connection record can be lost to a store-creation race | Unmatched peers skipped with WARN — `StoreConnectionService.java:36-93` | Frequency unmeasured; self-healing unverified. The site is never lost, only the record |
| The BFF returns connections only when the row is `connected` **and** has connection records, so a dropped record hides the badge even on a correctly flagged row | `StoreFindingMapper.java:30-44` | None — the reported-row half of this filter is PM-confirmed as correct |
| MV's `Allowed` status is the nearest analogue to exclusion | MV Findings screenshot, 2026-09-01 | Whether `Allowed` removes the URL from risk is untraced. If not, exclusion is new behavior, not parity |
| UP discards graph fidelity before storage | `ConnectionInfoModel.java:8-22`, `ConnectorType.java:3-16`, `GraphEdgeType.groovy:4-100` | Confirm the upstream scan still computes these |
| MV scores on a dual reported/unreported scale | `finding-sub-type.component.ts:61-62`, `RiskCalculationRiskModelItem.java:10-11` | UP's `mlrc-risk` not inspected — confirm before sizing Phase 1 |
| UP's finding row renders category, evidence icon, risk tag, and Resolution dropdown — no snooze, dispute, notes, or history | `useMerchantFindingsColumns.tsx:23-89` | Same June-2026 clone caveat |

## Scope

### In Scope

- A flat list of connected sites as rows under the merchant.
- Connected marker driven by stored connected status, not by whether peers
  resolved.
- Reversible per-site exclusion from merchant risk.
- Reported-status severity in UP's risk calculation.
- Persisting the full `connectionInfo` payload from Phase 1 onward.
- Finding-level snooze, dispute, notes, history, and rule attribution on
  connected rows.

### Out of Scope

- **Reported URLs entirely.** Whether a reported URL can be excluded from risk
  is not a question this feature answers. `PRODUCT DECISION` — PM, 2026-09-01.
- **The Network Evidence tab and any graph or hierarchy presentation.** A later
  phase and a separate decision. `PRODUCT DECISION` — PM, 2026-09-01.
- **Redirects as connection edges.** A redirect destination's findings are
  absorbed onto the reported store; a doorway is skipped and discarded. Neither
  produces a connected row; the discarded doorway finding is a findings-pipeline
  concern. `PRODUCT DECISION` — PM, 2026-09-01.
- **URL-level actions on connected rows** — assign owner, set URL status,
  download URL report. Work happens at the finding level.
  `PRODUCT DECISION` — PM, 2026-09-01.
- **Connection add, edit, soft-delete, undo.** All 104 network-edit users in 90
  days are internal G2RS staff — internal ops tooling, not customer parity.
- **Historical re-scan to backfill path, depth, score**, and the **full 88-type
  connector vocabulary** that depends on it.
- **Bulk owner assignment, bulk status change, audit-mode selection, "allow
  all".** Parity items with no stated user problem. Revisit after Phase 2.
- **Reported-URL reverse projection.** The BFF returns connections only for
  connected rows, and the PM confirmed this as correct rather than a defect: the
  same link on both sides is redundant noise. Retires the "projection gap" in
  reverse-engineering V2 § Gaps 2. `PRODUCT DECISION` — PM, 2026-09-01.
- **Collapsed-row previews, sorting, filtering, and category grouping**
  (formerly Phase 3). Their value rests on customers changing behavior once rows
  become workable, which Phase 2 has not yet demonstrated.
  `PRODUCT DECISION` — PM, 2026-09-01.
- **Connection popover extension to path, depth, and score.** Depends on the
  Phase 1 persistence change and on surfaces now out of scope.
- **`PRIVATELY_ACQUIRED_DATA` rewrite obligation.** Licensing status unresolved.

### Future Considerations

- Collapsed-row previews, sorting, filtering, and category grouping, if Phase 2
  shows analysts working connected sites in volume.
- Bulk and audit workflows, on the same trigger.
- The Network Evidence tab and a graph presentation.
- Suppressed-URL visibility: doorway URLs and unresolved peers vanish from
  product APIs with only logs retaining the event.

## Success Signals

- Connected-URL expansion rises among customers who already work connected
  sites (CBA, MVB-bank, Fresno First, Afterpay), rather than in aggregate.
- Findings on connected URLs reach a resolved state at a rate approaching
  findings on reported URLs.
- Migrating MV customers see no unexplained drop in merchant risk scores
  attributable to connected sites.
- Analysts resolve or dispose of connected-site findings instead of leaving them
  untouched — fewer connected rows sitting at default resolution.
- Exclusion is used and mostly not reversed — analysts reach for it on genuinely
  false connections rather than to quiet noisy rows. Watch the reversal rate and
  the share of a merchant's connected sites excluded; a customer excluding most
  of them is a signal the connection quality is wrong, not the feature.
- Fewer support escalations asking why a connected site appears under a
  merchant.

## Open Questions

1. **Does UP's risk path branch on reported status?** Drafted against: no,
   making this a silent regression and Phase 1's top item. Read `mlrc-risk`
   before sizing. Also open: whether each customer's configured risk matrix has
   a migration path as data.
2. **Does the upstream scan service still compute depth, score, and path?**
   Drafted against: yes, only UP's consumer discards them. If not, Phase 1's
   persistence item falls away. Confirm with the scan team.
3. **Does the June-2026 portal clone still reflect production?** Pull current
   `develop` before `/spec`, to avoid specifying a marker that already exists.
4. **Is the `PRIVATELY_ACQUIRED_DATA` rewrite an obligation UP must honour?**
   Needs a compliance answer, not a product one.
5. **Does an exclusion persist per customer, per user, or globally?** Drafted
   against: per customer, on the merchant's store row. Confirm before `/spec`.
6. **Does an exclusion survive a re-scan that rediscovers the site?** Drafted
   against: yes — a re-scan finding the same wrong connection is not new
   information. Revisit if analysts report stale exclusions hiding real risk.
7. **Does MV's `Allowed` status remove a URL from merchant risk?** Trace before
   positioning exclusion to migrating customers as parity. Does not block build.
8. **How often does the peer-resolution race drop a connection record?** Count
   the skipped-peer WARN over 30 days. Only if common does Phase 1 need a retry
   requirement.

## Appendix

### Persona / Target Audience

**Primary user:**
Risk analysts at acquirer and PSP customers who work merchant findings —
concentrated at customers already working connected sites: CBA, MVB-bank,
Fresno First, Afterpay, Wansheng.

**Secondary audience:**
G2RS internal analysts, who are the only population using the network edit
workflow. Migrating MV customers, who inherit UP's risk scoring whether or not
they work connected sites.

**Job to be done:**
Decide whether a URL under a merchant represents real risk, record that
judgment so it survives review, and understand why a URL nobody reported is
attributed to this merchant.

### Data

- Number of users affected: 75 unique customer users viewed the MV network page
  in 90 days. Findings-grid users are broader — 48 customer organizations appear
  in the expansion breakdown.
- Current usage: 93,141 MV findings-grid domain expansions in 90 days to
  2026-08-31; 3,496 connected (3.8%), 89,645 reported.
- CS tickets: `N/A - ticket system not connected to this workspace`

#### Legacy EverC Mixpanel Analytics

90-day customer-only window, MV project `2040581`, queried 2026-08-31.

| Signal | Legacy EverC evidence | Discovery implication |
|---|---|---|
| Coverage | 48 customer organizations recorded findings-grid expansions; 52,764 customer-only expansions of 93,141 total | The findings view is broadly used across the customer base, so parity gaps affect most migrating customers, not a niche. |
| Usage | Connected-site expansion is bimodal, not uniformly low: MVB-bank 57% connected (52 of 92), CBA 40% (435 of 1,076), Wansheng 39% (68 of 174), Afterpay 20% (121 of 595), Fresno First 16% (654 of 4,027). Against NAB 0.05% (4 of 7,304), Moneris 0.2% (10 of 4,965), Adyen 2.1% (295 of 13,758), C.A.L Visa 0.2% (2 of 827). | The 3.8% aggregate is a concentration artifact. Adyen and NAB alone contribute ~21,000 expansions and suppress the average. Connected sites have a real, identifiable audience — this reframes the feature from "low usage, deprioritize" to "high value for a defined segment". |
| Key clients | Validation cohort: CBA, MVB-bank, Fresno First, Afterpay. Regression-risk cohort: Adyen, NAB, Moneris — high volume, near-zero connected usage, so they feel the severity change without wanting new surfaces. | Validate Phase 2 with the first cohort. Watch the second for unexplained risk-score movement after Phase 1. |
| Connection editing | 104 unique users on `audit_screen_edit_network`, all `Is Customer = false`. Add-connection: 2 users. Delete: 18 users. Against 75 customer users on `findings_network_page`. | Customers view the network; only G2RS edits it. Editing is internal tooling — correctly out of scope for a customer parity effort. |

### Evidence Base

- Reverse engineering V2 (2026-08-30) —
  `../current-state/connected-sites-graph-reverse-engineering-v2.md`. Current;
  supersedes V1 where they conflict.
- Open hypotheses —
  `domains/unified-platform/second-brain/hypotheses/connected-sites-findings-view.md`.
  Two entries are revised by this discovery: the 4% expansion split is
  segmentation rather than presentation failure, and the network-edit population
  is entirely internal rather than mostly customer.
- `/learn-feature` session note, sessions 1 and 2 —
  `domains/unified-platform/second-brain/context/features/connected-sites-findings-view.md`.
  Session 2 (2026-09-01) supplies the four scope decisions, the exclusion
  requirement, and the mechanism confirmations amended into this document.
- Feature decisions and open decisions — `../README.md`.
- Mixpanel MV project `2040581`, 90-day customer-filtered queries, 2026-08-31.
  No new usage data was pulled for the 2026-09-01 amendment.
- Source freshness: UP `marketview-portal` and `mlrc-bff-2.0` clones date to
  June 2026 and lag remote `develop`. MV `mvnextgen` and `merchantviewui`
  matched remote tips. WebShield remains unverified — no source available.
