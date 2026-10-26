# PRD: Connected Sites, Findings Triage

Document Name: connected-sites-graph-prd

Feature Name: Connected Sites, Findings Triage
Owner: Adi Geva
Product: Atlas
Status: Draft
Version: 1.1
Last Updated: 2026-09-02

Amendment 1.1 (PM, 2026-09-02): Ignore is redefined as a **scope** judgment, not
a risk lever, and its default is governed by the portfolio-level graph-isolation
flag. Affects DEC-2, DEC-3, REQ-3 to REQ-6, AC-3 to AC-6, SC-3, SC-4, OQ-5.

Upstream: [Discovery](../discovery/connected-sites-graph-discovery.md) ·
[Reverse engineering V2](../current-state/connected-sites-graph-reverse-engineering-v2.md)

## 1. Summary

A merchant declares its website. UP's scan follows the trail outward and finds
other sites connected to it, through shared WHOIS records, shared payment keys,
or shared infrastructure. Those connected sites are how an analyst catches a merchant who
reported a clean storefront and runs the risky business one hop away.

In Merchant View, an analyst can work a connected site exactly like a declared
one: assign it, set its status, snooze or dispute its findings, and delete a
connection that is wrong. In Atlas the connected URL is
presented in the Findings tab and its findings affect merchant risk, but the
analyst has no way to act on the site itself. There is no durable marker
saying why it is there, no URL-level actions, no way to say this one site is
not the merchant's without reviewing its findings first, and the only lever
is a portfolio-wide flag affecting every merchant at once.

This PRD makes a connected site workable in UP. It delivers a flat list of
connected sites under the merchant, the triage actions to act on them, and a
reversible **Ignore** that lets an analyst declare a site is not part of this
merchant, taking it out of merchant risk and out of future scans without
deleting anything. Two of the gaps it closes are silent regressions that would
otherwise reach every migrating MV customer.

**This feature is rows, not a graph.** The Network Evidence tab is a later
phase. Reported URLs are out of scope entirely.

## 2. Problem

### 2.1 Why now

UP must take MV's traffic. Two of the gaps below are not missing features but
regressions that appear at the moment a customer migrates, with no visible
cause and no error to investigate:

- If UP's risk path does not branch on reported status, every migrating
  customer's connected-site risk silently drops to declared-site levels. The
  merchant scores change and nobody is told why.
- UP discards connection depth, node count, and confidence score before storage.
  Every day this continues enlarges the historical re-scan that any later
  decision to surface them would require.

The third reason is that connected-site triage has a real, identifiable
audience that the aggregate usage number hides. See §3.

### 2.2 Problems this solves

| # | Problem | Consequence |
|---|---|---|
| P1 | A false connection inflates merchant risk and the analyst has no lever | The merchant is scored on a site that is not theirs, and it stays that way. MV's graph-edit workflow does not exist in UP. |
| P2 | A connected URL cannot be worked | Only a per-finding resolution dropdown exists. An analyst who forms a judgment has nowhere to record it. |
| P3 | Connected-site risk may be scored on the wrong scale | MV scores the same finding higher on an undisclosed site. If UP has no equivalent, migration silently lowers risk. |
| P4 | A connected URL is not reliably marked as connected | The badge renders only when a peer resolved to an existing store row. A connected site with no resolved peers reads as an ordinary URL. |
| P5 | A row can under-report its connections | An unmatched peer is skipped and never re-checked, so the analyst's explanation of why the site is there is incomplete or absent. |
| P6 | Triage requires expanding every row | Categories, counts, severity and new-finding indicators are hidden until a row is opened. |
| P7 | Connection evidence is discarded on arrival | Depth, node count, timing and per-entry score are dropped before storage and are unrecoverable without a re-scan. |

## 3. Users and evidence

**Primary user.** Risk and compliance analysts at acquirer and PSP customers who
triage merchant findings.

**Secondary.** G2RS internal analysts. Migrating MV customers, who inherit UP's
risk scoring whether or not they ever open a connected site.

**Job to be done.** Decide whether a URL under a merchant represents real risk,
record that judgment so it survives review, and understand why a URL nobody
reported is attributed to this merchant.

### The usage number that matters

Aggregate connected-site expansion is 3.8% of findings-grid expansions. That
number is a concentration artifact and should not be used to size this work.

| Segment | Connected share of expansions |
|---|---|
| MVB-bank | 57% (52 of 92) |
| CBA | 40% (435 of 1,076) |
| Wansheng | 39% (68 of 174) |
| Afterpay | 20% (121 of 595) |
| Fresno First | 16% (654 of 4,027) |
| Adyen | 2.1% (295 of 13,758) |
| Moneris | 0.2% (10 of 4,965) |
| NAB | 0.05% (4 of 7,304) |

Adyen and NAB alone contribute ~21,000 expansions and suppress the average.
Connected-site triage is heavily used by a defined segment and barely used by
another. This reframes the feature from "low usage, deprioritize" to "high value
for a known cohort, plus a silent regression for everyone".

**Validation cohort:** CBA, MVB-bank, Fresno First, Afterpay.
**Regression-watch cohort:** Adyen, NAB, Moneris, high volume, near-zero
connected usage. They feel P3 without wanting any new surface.

Source: Mixpanel MV project `2040581`, 90-day customer-only window, 2026-08-31.

## 4. Product decisions

Decisions already made. These are constraints on the spec, not open items.

| ID | Decision | Rationale |
|---|---|---|
| DEC-1 | Phase 1 is a **flat list** of connected sites as rows under the merchant. No graph, hierarchy, or node expansion. | The Network Evidence tab is a later phase and a separate decision. |
| DEC-2 | A connected site can be **excluded from merchant risk, reversibly**. | This is UP's answer to a false connection, replacing MV's graph-edit workflow. |
| DEC-3 | An analyst can exclude a connected site from merchant risk, and can reverse it. This PRD states behavior only, not a toggle, dropdown, or status list. | This PRD owns the required behavior, not the control's form. |
| DEC-4 | **Reported URLs are out of scope entirely.** Whether a reported URL can be excluded is not a question this feature answers. | Scope discipline. Do not spec or raise it. |
| DEC-5 | **Reported rows must not display their connections.** UP's BFF returns connections only for connected rows; this is correct behavior. | Showing the same link on both sides is redundant noise. Retires the "projection gap" in reverse-engineering V2 § Gaps 2. |
| DEC-6 | **Redirects are not connection edges.** | A redirect destination's findings are absorbed onto the reported store; a doorway is skipped. Neither produces a connected row. The discarded doorway finding belongs to the findings pipeline, not here. |
| DEC-7 | **Connection add, edit, delete and undo stay out of scope.** | All 104 audit-network-edit users in 90 days are internal G2RS staff. It is internal tooling, not customer parity. Exclusion covers the customer need. |

All decisions: PM, 2026-09-01.

## 5. Requirements

Phased by rising UI investment. Phase 1 is the release gate for MV migration.

### Phase 1, Correctness and control

| ID | Requirement | Solves |
|---|---|---|
| REQ-1 | A connected URL row displays a durable marker identifying it as connected. The marker renders from the store's stored connected status, independent of whether any peer connection resolved. | P4 |
| REQ-2 | Finding severity is selected by reported status, matching MV's dual reported/unreported scale, including each customer's configured risk matrix. | P3 |
| REQ-3 | An analyst can exclude a connected site from merchant risk in one action, without reviewing its findings first. On exclusion, every risk contribution from that site is removed from the merchant risk calculation immediately, and the site is excluded from that merchant's future scans until the exclusion is reversed. | P1 |
| REQ-4 | An excluded connected site remains visible in the list and is identifiable as excluded. | P1 |
| REQ-5 | An analyst can reverse an exclusion. On reversal, the site's original risk contribution is restored. | P1 |
| REQ-6 | An exclusion and its reversal are attributable: who changed it and when is retrievable. | P1 |
| REQ-7 | The `connectionInfo` payload is persisted in full from this release onward: depth, node count, per-entry score, and full path. | P7 |

**REQ-3 default:** a connected site's findings contribute to merchant risk
automatically, with no user action. Exclusion is an explicit act.

**On REQ-7:** persistence only. Nothing in Phase 1 displays these fields. The
requirement exists because the data is unrecoverable once discarded, and every
release without it grows the backfill.

### Phase 2, Triage actions

Extending patterns that already exist in UP for reported URLs to connected rows.
This is not new interaction design.

| ID | Requirement | Solves |
|---|---|---|
| REQ-8 | URL-level on a connected row: assign an owner, set a URL status, download a URL report. | P2 |
| REQ-9 | Finding-level on a connected row: review evidence, set status/resolution, snooze, dispute, add and view notes, view finding history, and see when a rule affected the finding. | P2 |

### Phase 3, Surfaces

| ID | Requirement | Solves |
|---|---|---|
| REQ-10 | The collapsed row previews finding categories, counts, severity, new/updated indicators, URL risk, assignee, and status. | P6 |
| REQ-11 | The list can be sorted and filtered by URL type, risk, assignee, status, and exclusion state. | P6 |
| REQ-12 | Findings can be grouped by category, preserving per-finding risk, indicators, evidence, and status. | P6 |
| REQ-13 | The connection popover additionally shows the connection path, hop count, and confidence score, for sites scanned after REQ-7 shipped. | P5, P7 |
| REQ-14 | UP's existing redirect indicators and screenshot evidence popup are retained. | n/a |

**Phase 3 is a decision gate, not a commitment.** Its value rests on analysts
changing behavior once rows become workable. Review after Phase 2 ships against
the validation cohort. See OQ-3.

## 6. Acceptance criteria

Observable and testable. Full criteria belong in the spec; these are the
product-level bars.

| ID | Criterion |
|---|---|
| AC-1 | A connected site with zero resolved peer connections still displays the connected marker. |
| AC-2 | A finding of a given sub-type on a connected site resolves to that sub-type's unreported severity for that customer's risk matrix; the same sub-type on a declared site resolves to its reported severity. |
| AC-3 | Excluding a connected site whose findings contributed to the merchant score lowers the merchant score by exactly that contribution, with no other site's contribution changed. |
| AC-4 | A merchant whose only high-severity findings sit on an excluded site scores as if that site had no findings. |
| AC-5 | An excluded site appears in the merchant's URL list, marked as excluded, and its findings remain viewable. |
| AC-6 | Reversing an exclusion returns the merchant score to its pre-exclusion value, given no other change. |
| AC-7 | The actor and timestamp of the most recent exclusion change are retrievable for any excluded or previously excluded site. |
| AC-8 | For a site scanned after REQ-7 ships, the stored connection record contains depth, node count, per-entry score, and path. |
| AC-9 | A reported URL row displays no connection information. |
| AC-10 | Excluding a site under one merchant does not change the same URL's state under any other merchant. |

## 7. Out of scope

- **Reported URLs entirely** (DEC-4).
- **The Network Evidence tab, and any graph or hierarchy presentation** (DEC-1).
- **Redirects as connection edges** (DEC-6).
- **Connection add, edit, soft-delete, and undo** (DEC-7).
- **Reported-URL reverse projection** (DEC-5).
- **Historical re-scan to backfill path, depth, and score.** A separate
  programme: data model, API, UI, and a re-scan of every existing URL. REQ-13
  surfaces this data only where it was captured.
- **The full 88-type connector vocabulary.** UP recognises 12 types against MV's
  89. Closing this depends on the same re-scan.
- **Bulk owner assignment, bulk status change, audit-mode selection, "allow
  all".** Parity items with no stated user problem. Revisit if Phase 2 shows
  analysts working connected URLs in volume.
- **A retry or reconciliation mechanism for the peer-resolution race.** Accepted
  as a Phase 1 limit; REQ-1 removes its worst symptom. Revisit on OQ-5.
- **`PRIVATELY_ACQUIRED_DATA` rewrite obligation.** Unresolved whether this is a
  licensing requirement. Needs a compliance answer, not a product one.

## 8. Success measures

Measured against the validation cohort (CBA, MVB-bank, Fresno First, Afterpay),
not in aggregate — the aggregate is dominated by customers who do not use this.

| ID | Measure | Why this one |
|---|---|---|
| SC-1 | Connected rows carrying a non-default status or an owner, as a share of connected rows, approaches the reported-row rate. | The direct test of "workable". |
| SC-2 | Connected-site findings reach a resolution instead of sitting at default. | Distinguishes triage from viewing. |
| SC-3 | Exclusion is used, and reversals stay a small share of exclusions. | A high reversal rate means the control is being used to hide noise, or connection quality is wrong. |
| SC-4 | Share of a merchant's connected sites excluded stays low per customer. | A customer excluding most connected sites is reporting a connection-quality problem, not using a feature. |
| SC-5 | Migrating MV customers show no unexplained movement in merchant risk attributable to connected sites. | The regression watch. Applies to the regression-watch cohort, who will not appear in SC-1 to SC-4. |
| SC-6 | Fewer support escalations asking why a connected site appears under a merchant. | Tests whether the marker and popover explain the row. |

SC-5 needs a before/after baseline captured before Phase 1 ships. Flagged as a
dependency, not an assumption.

## 9. Open decisions

Recorded open, with a recommendation. None blocks Phase 1 design; OQ-1 and OQ-2
must be answered before the spec sizes Phase 1.

| ID | Question | Recommendation |
|---|---|---|
| OQ-1 | Does UP's risk path already branch on reported status? | Read `mlrc-risk` before sizing Phase 1. Drafted against: it does not, making REQ-2 the highest-priority item. If a branch exists, Phase 1 shrinks to REQ-1, REQ-3–7. Also unresolved: whether each customer's configured risk matrix has a migration path as data. |
| OQ-2 | Does the upstream scan service still compute depth, score, and path? | Confirm with the scan team. Drafted against: it does, and only UP's consumer discards them, so REQ-7 is a consumer change. If it does not, REQ-7 and REQ-13 both fall away. |
| OQ-3 | Is Phase 3 committed or gated? | Gate it. Review after Phase 2 ships against the validation cohort. |
| OQ-4 | Does an exclusion persist per customer, per user, or globally? | Per customer, on the merchant's store row — matching UP's per-merchant store identity, so a judgment is visible to colleagues and to no other organization. Confirm before spec. |
| OQ-5 | Does an exclusion survive a re-scan that rediscovers the site? | Yes. An exclusion is a standing judgment that a connection is wrong; a re-scan finding the same wrong connection is not new information. Revisit if analysts report stale exclusions hiding real risk. |
| OQ-6 | Does MV's `Allowed` status actually remove a URL from merchant risk? | Trace before positioning exclusion to migrating customers as parity rather than as new behavior. Does not block build. |
| OQ-7 | How often does the peer-resolution race drop a connection record? | Count the skipped-peer WARN over 30 days. Only if common does Phase 1 need a retry requirement. |
| OQ-8 | Is the `PRIVATELY_ACQUIRED_DATA` rewrite a provenance obligation? | Compliance question. Out of scope until answered. |

## 10. Dependencies and risks

- **Risk-matrix data migration.** Building the dual-severity code path is not
  enough if each customer's configured matrix does not migrate as data. Volume
  unknown (OQ-1).
- **Scan service.** REQ-7 and REQ-13 depend on the upstream scan still emitting
  depth, score, and path (OQ-2).
- **Baseline capture.** SC-5 requires pre-migration merchant-risk baselines for
  the regression-watch cohort, captured before Phase 1 ships.
- **Risk aggregation formula unread.** UP's per-URL-to-merchant aggregation was
  not traced, so the magnitude of a single exclusion on a merchant score cannot
  be predicted. Affects AC-3 test design, not the requirement.
- **Source freshness.** UP `marketview-portal` and `mlrc-bff-2.0` clones date to
  June 2026 and lag remote `develop`. Pull current `develop` before the spec, to
  avoid specifying a marker that already exists.

## 11. Evidence base

- Discovery (amended 2026-09-01) —
  `../discovery/connected-sites-graph-discovery.md`.
- Reverse engineering V2 (2026-08-30) —
  `../current-state/connected-sites-graph-reverse-engineering-v2.md`. Current;
  § Gaps 2 retired by DEC-5.
- `/learn-feature` session note, sessions 1–2 —
  `domains/atlas/second-brain/context/features/connected-sites-findings-view.md`.
  Source of DEC-1 to DEC-7 and the mechanism confirmations.
- Open hypotheses —
  `domains/atlas/second-brain/hypotheses/connected-sites-findings-view.md`.
- Feature decisions — `../README.md`.
- Mixpanel MV project `2040581`, 90-day customer-filtered queries, 2026-08-31.

### Key source evidence

| Claim | Source |
|---|---|
| `connected` is a durable origin label; store identity is per-merchant | `mlrc-merchant/shared-spring/.../StoreEntity.java:23-68` |
| Peer resolution skips unmatched peers with a WARN | `mlrc-merchant/api/.../StoreConnectionService.java:36-93` |
| BFF returns connections only for connected rows, by design | `mlrc-bff-2.0/.../StoreFindingMapper.java:30-44` |
| Redirect destinations absorb onto the reported store; doorways are skipped | `mlrc-finding/consumer/.../FindingExtractorService.java:169-201` |
| Connection badge renders only when connections resolved | `marketview-portal/.../ConnectedURLBadge.tsx:16-18` |
| UP exposes only a per-finding resolution dropdown | `marketview-portal/.../useMerchantFindingsColumns.tsx:21-92` |
| UP's read model discards depth, node count, timing, score | `mlrc-finding/consumer/.../ConnectionInfoModel.java:8-22` |
| MV selects severity by reported status | `merchantviewui/.../finding-sub-type.component.ts:61-62` |
| MV's risk matrix is per-customer, per sub-type, dual-severity | `everc-global-services/.../RiskCalculationRiskModelItem.java:10-11` |
