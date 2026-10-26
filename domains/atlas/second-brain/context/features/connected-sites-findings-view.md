# Connected Sites — Findings View

Learning session note. Created 2026-08-31.

**Scope:** how connected (unreported) sites are *presented and acted on* under
the reported URL inside the Findings tab. Explicitly **not** the Network tab
graph visualization — that is a separate feature.

## What it is and who it's for

A merchant declares a URL ("this is my website"). The scan follows the trail
outward — links, shared WHOIS records, shared PSPs, redirects — and finds other
sites connected to it. Those connected sites are how an analyst catches a
merchant who reported a clean storefront but runs the risky business one hop
away.

The Findings tab lists all of a merchant's URLs, reported and connected
together, each expandable to its own findings. Users are risk/compliance
analysts at banks, acquirers, and PSPs, plus G2RS internal analysts. In MV it is
the primary connected-sites surface; the Network tab is the niche one.

## Vocabulary

| Term | Means here | Aliases |
|---|---|---|
| Reported URL | The URL the merchant declared | registered URL; `is_registered=true`; **`R`** badge in UI |
| Connected site | Discovered by the scan graph | unreported URL / domain; **`U`** badge; UP: "connected URL" |
| Network Evidence | MV's name for the graph feature | UP: "connected sites" |
| Store | UP's internal name for one URL row | findings hang off a store, not the merchant |
| WHOIS | Public domain-registration record (registrant/admin/technical/billing contacts) | — |
| Connector / edge type | What links two sites | MV `GraphEdgeType`, UP `ConnectorType` |
| Dual severity | Same finding scored differently on reported vs unreported URL | `registeredSeverity` / `unregisteredSeverity` |

## Usage — measured

Source: Mixpanel MV project `2040581`, 6 months to 2026-08-30.

| Metric | Value | Counts |
|---|---|---|
| `findings_grid_domain_expand` | **701 unique users**, 177,713 events | Expanding any URL row in the findings grid |
| `findings_grid_domain_collapse` | 577 unique users | — |
| `findings_grid_domain_view_all_findings` | 158 unique users | Deep-link from graph back to findings |
| `findings_summary_page` | 322 unique users | Summary page (reported/unreported rollups) |
| `findings_network_page` (**out of scope** — Network tab) | 157 unique users | For contrast only |

**Reported vs connected split** of `findings_grid_domain_expand` by
`is_registered`: **170,627 (96%) reported** vs **7,086 (4%) connected**.

**Trend:** flat. 437 → 442 → 389 → 396 → 400 → 394 unique users/month
(Mar–Aug 2026).

**Heaviest connected-site users** (unreported expands): Adyen 1,011 · Fresno
First Bank 738 · CBA 682 · Paysafe 595 · STMP/Servired 395 · Payoneer 391 ·
Amex 388 · Afterpay 382 · Global Payments 332 · MVB-bank 306 · Moneris 283.
~50 customers total.

**CBA is the outlier:** 682 unreported vs 993 reported expands — a 41%
connected-site ratio, far above every other customer. Adyen leads on total
volume (45,533 reported) but connected sites are only 2% of its use.

## How MV behaves

Verified against source; see § Sources.

### Structure
Flat virtual-scrolled table, one row per URL, "Load more" paging. Reported and
connected interleave in one list. Sortable by reported, URL, risk, assignee,
status. Reported-first by default (observed in UI screenshot).

### The URL row
`R`/`U` badge · URL (+ search highlight, external link) · findings preview (top
finding named + overflow count, e.g. `Website Not Secure +2`) · risk (count of
findings at top severity) · assignee dropdown · status dropdown ·
bulk-select checkbox (audit mode) · hover action buttons.

### Three action tiers
| Tier | Actions |
|---|---|
| Merchant | `Action` menu, Create Report |
| **URL** | Evidence (with count), Download Report, Snooze, Rule indicator, assignee, status, bulk select |
| **Finding** | Evidence, Snooze, Rule, Finding log/note, Dispute, status |

**Not gated on reported status.** The guards are `*ngIf="!finding"` (URL tier)
and `*ngIf="finding"` (finding tier) — the same component renders at both
levels for reported and connected URLs alike. A connected site is a
first-class citizen with the full triage surface.

Observed exception in UI: a reported URL showed status `No Action Required`
greyed with no dropdown while connected URLs showed actionable `Not Checked`.
That is the `findingStatus.locked` condition, a consequence of which status the
URL landed in — not a reported/connected rule in the markup.

### What a connected site gets that a reported one does not
1. **`U` badge** — the only thing on the row explaining why the URL is present.
2. **Reported-URL selector** in the Network tab — rendered only when
   `!scanItem.isRegistered` and >1 root, because a connected site can link to
   several reported URLs.
3. **Its own severity scale** — see below.

### Dual severity (the significant find)
Every finding sub-type carries two severities and MV picks by reported status:

```
this.severity = this.isRegistered ? finding.registeredSeverity
                                  : finding.unregisteredSeverity;
```

The same finding scores higher on an undisclosed site. This is
**customer-configurable** via the Risk Matrix settings screen — per finding
sub-type, independent Reported and Unreported severities, with separate
Mixpanel events (`RM_CONFIG_REPORTED` / `RM_CONFIG_UNREPORTED`). The risk model
item also carries `bankId`, `exclude`, and `isShown` — so **the matrix is
per-customer**, and a sub-type can be excluded from risk entirely.

### Edge-type vocabulary
MV `GraphEdgeType`: **89 types** (codes 0–88). Distinguishes WHOIS registrant
vs admin vs technical vs billing email; also `IFRAME`, `SUBDOMAIN`,
`WEBSITE_IS_IDENTICAL`, `WEBSITE_IS_AFFILIATE`, `CONNECTED_BY_TEST_TRANSACTION`,
`REDIRECT_IN_PAYMENT_FLOW`, `TLI_DETECTED_*`, `PRIVATELY_ACQUIRED_DATA`, PSP
pairs.

### No connection evidence on the findings tab
Grepped the entire MV findings page: **zero connection references.** An analyst
sees *that* a URL is unreported but nothing about which reported URL it
connects to or why. That lives one tab away.

## How UP behaves

### Structure
Accordion. Each URL is a collapsible panel; expanding reveals a 4-column table
of that URL's findings: `Finding` · evidence icon · `Risk` · `Resolution`. No
paging, no sorting, no category grouping.

### Panel header
URL · external link · `RiskTag` · **connection badge** (only when
`connected && connections.length > 0`) · last-scanned date.

**No `R`/`U` marker.** No findings preview, no assignee, no URL-level status, no
bulk select, no hover actions.

### Where UP is ahead of MV
The connection badge popover shows, per peer: peer URL (clickable), connector
type + value for each connector, and last-checked date; multiple peers scroll
in one popover. **MV's findings tab has none of this.** UP put connection
evidence on the row where MV never did.

UP also renders a redirect finding as "Redirect to `<url>`" and marks findings
detected under a redirect with a `RedirectedIndicator`.

### Where UP is behind
1. **No `R`/`U` marker.** A connected site whose peer did not resolve looks
   identical to a reported URL.
2. **Only the finding action tier exists** — one `Resolution` dropdown. No
   snooze, dispute, note/log, per-URL report, assignee, URL status, bulk
   actions, or rule indicator. The entire URL tier is absent.
3. **No sorting or filtering.** Fixed accordion order.
4. **No findings preview** — every URL must be opened to see anything.
5. **No graph edit workflow** (add/edit/delete/undo a connection).

### Evidence fidelity loss
UP's `ConnectionInfoModel` is documented as a "minimal read model" and
explicitly discards `total_time`, `fetch_time`, `depth`, `number_of_nodes`, and
per-entry `score`. It keeps only peer domain → paths, long enough to derive
peers and connector types. **Not stored** — not recoverable without a re-scan.

`ConnectorType`: **12 types** (domain, email, IP, phone, address, geo-address,
alias, Google Analytics, AdSense, mobile app, PSP key, social) vs MV's 89. An
MV analyst sees "shared WHOIS billing phone, two hops, confidence 0.8"; a UP
analyst sees "PHONE".

## Does the graph affect merchant risk level?

**Yes, but indirectly — and only via one mechanism.** The graph is not a risk
input as a graph: no depth, path count, connection score, or connected-site
count appears in the risk-calculation request model.

The chain:
1. Graph discovers a connected site → becomes a scanned URL on the merchant
2. URL is scanned → produces findings
3. `is_registered` rides into the risk contract (`RiskCalculationScannedURL`)
4. Risk model holds both severities per sub-type and selects by that flag
5. URL severities roll up to the merchant score

So the graph affects merchant risk **by adding URLs whose findings then score
higher than they would on a declared site.**

Consequence: **deleting a false connection in MV changes merchant risk.** The
graph edit workflow is not cosmetic. UP has no edit workflow, so a false
positive is permanent until re-scan.

## Established vs assumed

**Established (read in source or measured):**
- All MV and UP behavior above, per § Sources.
- All usage numbers, per § Usage.
- Dual severity exists, is per-customer, and reaches the risk contract.
- UP discards depth/score/path before storage.
- MV's findings tab carries no connection evidence.

**Inference, not verified:**
- The 96/4 expansion split is caused by nothing on the row motivating an
  analyst to open a connected site (no evidence trail, no visible link to the
  reported URL). Plausible alternative: merchants genuinely have few connected
  sites. These point at opposite designs — worth testing with analysts.
- `PRIVATELY_ACQUIRED_DATA` likely exists because WHOIS privacy protection and
  GDPR redaction gutted public-record coverage, so connection data is sourced
  commercially with provenance strings attached. Read from the name and its use
  alongside bank-reported data; nobody documented it.

**Not verified — open:**
- Whether UP has dual severity / `is_registered` in its risk contract. **Highest
  priority.** If absent, every MV customer's unreported-site risk silently drops
  on migration.
- Whether UP preserves multi-parent connected sites (MV assumes a connected site
  can link to several reported URLs; UP stores edges as peers on the connected
  row).
- The merchant risk **aggregation formula** (how URL severities combine — max,
  weighted, count). Lives in `merv-risk-calculation-api` service layer; not read.
- Graph construction itself — traversal limits, cycle handling, max nodes,
  scoring — lives in the external scan/Core service, not in the inspected
  consumers.
- Where `unregisteredSeverity` values are set server-side.
- WebShield behavior: no source checkout available. Unverified.

**Freshness caveat:** the UP `marketview-portal` and `mlrc-bff-2.0` clones date
to June 2026 and lag remote `develop`. Treat UP gaps as "absent in inspected
source", not confirmed absent in production.

## Sources read (2026-08-31)

Prior artifact, taught from and carried forward:
- `outputs/connected-sites-graph/current-state/connected-sites-graph-reverse-engineering-v2.md`

MV (`merchant-view-legacy-ec`):
- `merchantviewui/.../findings/components/grid-findings/grid-findings.component.html`
- `merchantviewui/.../findings/components/grid-findings-row-expanded/grid-findings-row-expanded.component.html`
- `merchantviewui/.../findings/components/grid-action-buttons/grid-action-buttons.component.html`
- `merchantviewui/.../core/enums/grid/grid-header-finding-items.ts`
- `merchantviewui/.../shared/finding-sub-type/finding-sub-type.component.ts`
- `merchantviewui/.../pages/settings/risk-matrix/risk-matrix.component.ts`
- `merchantviewui/.../evidence/evidence-network-evidence/evidence-network-evidence.component.html`
- `merchantviewui/.../evidence-network-evidence/graph-node/graph-node.component.html`
- `mvserver/GrailsUtils/.../enums/GraphEdgeType.groovy`
- `everc-global-services/global-shared/.../riskCalculation/RiskCalculationScannedURL.java`
- `everc-global-services/global-shared/.../riskCalculation/RiskCalculationRiskModelItem.java`

UP (`unified-platform-new`):
- `marketview-portal/.../MerchantFindings/MerchantFindings.tsx`
- `marketview-portal/.../MerchantFindings/useMerchantFindingsColumns.tsx`
- `marketview-portal/.../ConnectedURLBadge/ConnectedURLBadge.tsx`
- `marketview-portal/.../ConnectionPopover/ConnectionPopover.tsx`
- `mlrc-finding/consumer/.../graph/ConnectionInfoModel.java`
- `mlrc-merchant/shared-spring/.../entity/ConnectorType.java`

Other: Mixpanel MV project `2040581`; MV Findings tab UI screenshot
(DemoAccount, merchant MARINA ZUMAIA S.L., scan Feb 7 2025).

---

# Session 2 — 2026-09-01

Scope narrowed by the PM during this session. Phase 1 is **the flat list of
connected sites under the merchant**. The Network Evidence tab is explicitly a
later phase. Migration context: UP must match MV and improve on it.

## Product decisions made this session

1. **Phase 1 = flat list only.** Connected sites appear as rows under the
   merchant. No graph, no hierarchy, no node expansion. Network tab is phase 2+.
2. **A connected site can be excluded from merchant risk, reversibly.**
   - Default: a connected site's findings contribute to merchant risk
     automatically, with no user action.
   - When excluded: every risk contribution from that site is removed from the
     merchant risk calculation.
   - The row **stays visible** and is identifiable as excluded.
   - Reversing the exclusion restores the original contribution.
3. **The control is a UX decision, not a product one.** The requirement states
   the behavior; the product designer chooses the mechanism. Do not specify a
   toggle, a dropdown, or MV's status list.
4. **Reported URLs are out of scope entirely.** Whether a reported URL can be
   excluded is not a question for this feature — do not raise it, do not spec
   it, do not mention it in requirements.
5. **Reported rows must not display their connections.** UP's BFF currently
   returns connections only for `connected=true` rows. The PM confirmed this is
   **correct behavior, not a defect**: showing the same link on both sides is
   redundant noise. Connection evidence belongs only on the connected row.
   - This reverses the framing in reverse-engineering V2 § Gaps 2 ("projection
     gap") for phase 1 purposes. V2 is not wrong; the gap simply is not one the
     PM wants closed here.

## MV's URL status list — screenshot evidence

From a MV Findings tab screenshot (DemoAccount, merchant JAUME BONET SERRANO,
MID 4541370791, 2026-09-01). Four URL rows: one `R` (reported,
`farmaciabonetonline.com`), three `U` (connected).

Each URL row carries a **status dropdown** with six values in two groups:

| Group | Values |
|---|---|
| Closed Statuses | `Allowed`, `Remediated`, `Review Completed`, `Rejected` |
| Open Statuses | `Not Checked` (default), `In Progress` |

`Allowed` is MV's nearest equivalent to exclusion: the row stays in the list and
keeps its findings while being marked closed. **UP is not adopting this list** —
per decision 3, UP specifies the exclusion behavior and lets design choose the
control.

Merchant-level risk tallies render in the header as URL counts per severity —
`0 Critical / 2 High / 2 Medium / 0 Low`.

## Corrections to session 1 and to my own statements

- **"A connected site is silently dropped" — wrong as stated.** What can be
  dropped is *a single connection record*, not the site. The site still gets its
  own row. `StoreConnectionService.resolveAndBuild` resolves each peer URL to an
  existing store under the same merchant by canonical-host hash; a peer whose
  host has no store row yet is skipped with a WARN. The source comments call
  this "a legitimate race with out-of-order store creation, not a client error".
  - Consequence: a row can show **fewer connections than the scan found**, or
    lose its connected badge entirely (the badge renders only when
    `connections.length > 0`).
  - Self-healing is **not verified**. A later scan re-sends the peers and would
    likely resolve them, but nothing re-checks a skipped link.
  - Evidence: `unified-platform-new/mlrc-merchant/api/.../StoreConnectionService.java:36-93`.

- **MV does not have this failure mode**, and the reason is structural. MV
  stores the **full traversal path** per scanned URL, assembled in one scan pass
  in memory, so there is no peer-lookup step to fail. UP reduces the graph to
  peer + connector pairs, which is what creates the lookup.
  - Evidence: `merchant-view-legacy-ec/mvnextgen/.../NetworkEvidenceService.java:78-105`.
  - Teaching shorthand that landed with the PM: **MV saves a story, UP saves a
    fact.** Saving a fact requires both endpoints to already exist.

## Mechanism confirmed this session

**`connected` is an origin label, not a computed score.** A boolean on the store
row. `false` = client-reported; `true` = scan-discovered. Reported wins
permanently — a discovered URL later reported flips to reported and cannot be
demoted.

**Store identity is per-merchant.** `StoreEntity` is keyed on partition
`merchantId` + sort `urlHash`. The same URL under two merchants is two
independent rows and can be reported for one and connected for the other.
**There is no system-wide reported state.**
- Evidence: `unified-platform-new/mlrc-merchant/shared-spring/.../StoreEntity.java:23-68`.

**Redirects are not connected sites.** `tryResolveStoreId` splits them two ways,
and neither produces a connected row:
1. **Redirect destination** — the target named by a reported URL's subType-61
   redirect finding. Its findings are absorbed onto the **reported** store; no
   separate row is created.
2. **Redirect doorway** — a non-reported URL carrying its own subType-61 that is
   not the reported URL's destination. **Skipped entirely, findings discarded**,
   on the rationale that they are thin — duplicates of the reported site or
   irrelevant. Recorded via `pipelineMetrics.recordRedirectDoorwaySkipped()`.
- Evidence: `unified-platform-new/mlrc-finding/consumer/.../FindingExtractorService.java:169-201`.
- **PM ruling:** redirects are out of scope for connected sites. The discarded
  doorway finding is a findings-pipeline concern for a different feature.

**The 12 connector types** are shared identifiers linking two sites: `DOMAIN`,
`EMAIL`, `IP_ADDRESS`, `PHONE`, `ADDRESS`, `GEO_ADDRESS`, `ALIAS`,
`GOOGLE_ANALYTICS`, `ADSENSE`, `MOBILE_APP`, `PSP_KEY`, `SOCIAL`. Confidence,
depth, and traversal limits are decided in the external scan service and are not
present in the inspected consumers.

**The BFF filter is deliberate and documented in-code.** `StoreFindingMapper`
returns connections only when `connected=true`, with a comment stating the
merchant service *can* persist peers on a reported store but "the BFF response
must not surface them — UI keys badge visibility off the schema promise". It
also sorts connections by `lastSeenEpochMs` descending.
- Evidence: `unified-platform-new/mlrc-bff-2.0/.../StoreFindingMapper.java:30-44`.

## Still unverified after this session

- **Whether MV's `Allowed` status actually removes a URL from merchant risk.**
  Not traced. The status list is confirmed from UI; its risk effect is not. This
  matters only as parity context — the PM has already specified UP's intended
  behavior independently.
- **UP's merchant risk aggregation formula** — how per-URL risk combines. Still
  unread (carried from session 1).
- **Whether the skipped-peer race self-heals** on re-scan.
- Everything else carried forward from session 1 § Not verified.

## Sources read (2026-09-01)

Prior artifact, taught from:
- `outputs/connected-sites-graph/current-state/connected-sites-graph-reverse-engineering-v2.md`
- `outputs/connected-sites-graph/README.md`
- this note, session 1

UP (`unified-platform-new`):
- `mlrc-merchant/shared-spring/src/main/java/com/everc/merchant/entity/StoreEntity.java`
- `mlrc-merchant/shared-spring/src/main/java/com/everc/merchant/entity/ConnectorType.java`
- `mlrc-merchant/api/src/main/java/com/everc/merchant/api/service/StoreConnectionService.java`
- `mlrc-bff-2.0/mlrc-bff-api/src/main/java/com/everc/mlrc/bff/mapper/StoreFindingMapper.java`
- `mlrc-finding/consumer/src/main/java/com/everc/finding/consumer/service/FindingExtractorService.java`

MV (`merchant-view-legacy-ec`):
- `mvnextgen/merchant-processor-job/.../NetworkEvidence/NetworkEvidenceService.java`
- `merchantviewui/src/app/core/factories/network-evidence.factory.ts`
- `mvserver/GrailsUtils/.../enums/ConnectionInfoAction.groovy`

Other: MV Findings tab screenshot (DemoAccount, JAUME BONET SERRANO,
MID 4541370791), supplied by the PM 2026-09-01.

**No new usage data pulled this session.** Session 1's Mixpanel figures stand.

---

# Session 2 — 2026-09-01

Scope narrowed by the PM. Phase 1 is **the flat list of connected sites under
the merchant**. The Network Evidence tab is explicitly a later phase.

## Product decisions made this session

1. **Phase 1 = flat list only.** No graph, no hierarchy, no node expansion.
2. **A connected site can be excluded from merchant risk, reversibly.**
   - Default: a connected site's findings contribute to merchant risk with no
     user action.
   - When excluded: every risk contribution from that site is removed from the
     merchant risk calculation.
   - The row stays visible and identifiable as excluded.
   - Reversing restores the original contribution.
3. **The control is a UX decision.** The requirement states behavior; the
   product designer chooses the mechanism. Do not specify a toggle or a status
   list.
4. **Reported URLs are out of scope entirely.** Do not raise, spec, or mention
   whether a reported URL can be excluded.
5. **Reported rows must not display their connections.** UP's BFF returns
   connections only for `connected=true` rows. The PM confirmed this is correct
   behavior, not a defect — showing the same link on both sides is redundant.
   This retires reverse-engineering V2 § Gaps 2 ("projection gap") for phase 1.

## MV's URL status list — screenshot evidence

MV Findings tab screenshot (DemoAccount, merchant JAUME BONET SERRANO,
MID 4541370791, 2026-09-01). Four URL rows: one `R` (reported,
`farmaciabonetonline.com`), three `U` (connected).

Each URL row carries a status dropdown with six values in two groups:

| Group | Values |
|---|---|
| Closed Statuses | `Allowed`, `Remediated`, `Review Completed`, `Rejected` |
| Open Statuses | `Not Checked` (default), `In Progress` |

`Allowed` is MV's nearest equivalent to exclusion — the row stays listed and
keeps its findings while marked closed. **UP is not adopting this list** (see
decision 3). Merchant risk tallies render in the header as URL counts per
severity: `0 Critical / 2 High / 2 Medium / 0 Low`.

## Corrections to earlier statements

- **"A connected site is silently dropped" — wrong as stated.** What can be
  dropped is a single *connection record*, not the site. The site still gets its
  own row. `StoreConnectionService.resolveAndBuild` resolves each peer URL to an
  existing store under the same merchant by canonical-host hash; a peer whose
  host has no store row yet is skipped with a WARN — the source calls it "a
  legitimate race with out-of-order store creation, not a client error".
  - Consequence: a row can show fewer connections than the scan found, or lose
    its connected badge entirely (badge renders only when `connections` is
    non-empty).
  - Self-healing on re-scan is **not verified**.
  - Evidence: `unified-platform-new/mlrc-merchant/api/.../StoreConnectionService.java:36-93`.

- **MV does not have this failure mode**, for structural reasons. MV stores the
  full traversal path per scanned URL, assembled in one scan pass in memory — no
  peer-lookup step to fail. UP reduces the graph to peer + connector pairs, which
  is what creates the lookup.
  - Evidence: `merchant-view-legacy-ec/mvnextgen/.../NetworkEvidenceService.java:78-105`.
  - Shorthand that landed with the PM: **MV saves a story, UP saves a fact.**

## Mechanism confirmed this session

**`connected` is an origin label, not a computed score.** A boolean on the store
row: `false` = client-reported, `true` = scan-discovered. Reported wins
permanently — a discovered URL later reported flips and cannot be demoted.

**Store identity is per-merchant.** `StoreEntity` is keyed partition
`merchantId` + sort `urlHash`. The same URL under two merchants is two
independent rows and can be reported for one, connected for the other. There is
**no system-wide reported state**.
- Evidence: `unified-platform-new/mlrc-merchant/shared-spring/.../StoreEntity.java:23-68`.

**Redirects are not connected sites.** `tryResolveStoreId` splits them two ways,
neither producing a connected row:
1. **Redirect destination** — target named by a reported URL's subType-61
   redirect finding. Findings absorbed onto the reported store; no separate row.
2. **Redirect doorway** — a non-reported URL carrying its own subType-61 that is
   not the reported URL's destination. Skipped entirely, findings discarded, on
   the rationale they are thin. Counted via `recordRedirectDoorwaySkipped()`.
- Evidence: `unified-platform-new/mlrc-finding/consumer/.../FindingExtractorService.java:169-201`.
- **PM ruling:** redirects are out of scope. The discarded doorway finding is a
  findings-pipeline concern for a different feature.

**The 12 connector types** — shared identifiers linking two sites: `DOMAIN`,
`EMAIL`, `IP_ADDRESS`, `PHONE`, `ADDRESS`, `GEO_ADDRESS`, `ALIAS`,
`GOOGLE_ANALYTICS`, `ADSENSE`, `MOBILE_APP`, `PSP_KEY`, `SOCIAL`. Confidence,
depth, and traversal limits live in the external scan service, not the consumers.

**The BFF filter is deliberate and documented in-code.** `StoreFindingMapper`
returns connections only when `connected=true`; the comment states the merchant
service can persist peers on a reported store but "the BFF response must not
surface them". Connections sort by `lastSeenEpochMs` descending.
- Evidence: `unified-platform-new/mlrc-bff-2.0/.../StoreFindingMapper.java:30-44`.

## Still unverified after this session

- Whether MV's `Allowed` status actually removes a URL from merchant risk. The
  status list is confirmed from UI; its risk effect is not traced.
- UP's merchant risk aggregation formula (carried from session 1).
- Whether the skipped-peer race self-heals on re-scan.
- Everything else carried from session 1 § Not verified.

## Sources read (2026-09-01)

Taught from: `outputs/connected-sites-graph/current-state/connected-sites-graph-reverse-engineering-v2.md`,
that feature's `README.md`, and session 1 of this note.

UP (`unified-platform-new`): `StoreEntity.java`, `ConnectorType.java`,
`StoreConnectionService.java`, `StoreFindingMapper.java`,
`FindingExtractorService.java`.

MV (`merchant-view-legacy-ec`): `NetworkEvidenceService.java`,
`network-evidence.factory.ts`, `ConnectionInfoAction.groovy`.

Other: MV Findings tab screenshot (DemoAccount, JAUME BONET SERRANO,
MID 4541370791), supplied by the PM 2026-09-01.

**No new usage data pulled this session.** Session 1's Mixpanel figures stand.
