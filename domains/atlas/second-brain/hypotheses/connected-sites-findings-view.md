# Connected Sites — Findings View: Open Questions

Opened by a `/learn-feature` session, 2026-08-31. Scope is the presentation and
actions for connected (unreported) sites under the reported URL in the Findings
tab — not the Network tab graph visualization.

### UP does not carry reported status into risk calculation — 2026-08-31

- **Belief:** UP scores findings without the `is_registered` dual-severity rule
  MV applies, so migrating MV customers will see unreported-site risk silently
  drop to reported levels.
- **Evidence for:**
  - MV picks severity by reported status: `this.severity = this.isRegistered ? finding.registeredSeverity : finding.unregisteredSeverity`  [documented] `merchant-view-legacy-ec/merchantviewui/src/app/shared/finding-sub-type/finding-sub-type.component.ts:61-62`
  - MV's risk contract carries `is_registered` on every scanned URL  [documented] `merchant-view-legacy-ec/everc-global-services/global-shared/src/main/java/com/everc/global/model/riskCalculation/RiskCalculationScannedURL.java:24-25`
  - MV's risk model item holds both `registeredSeverity` and `unregisteredSeverity` per finding sub-type, scoped by `bankId`  [documented] `merchant-view-legacy-ec/everc-global-services/global-shared/src/main/java/com/everc/global/model/riskCalculation/RiskCalculationRiskModelItem.java:10-11`
  - The dual scale is customer-configurable via the Risk Matrix settings screen, with separate tracking events for reported and unreported configuration  [documented] `merchant-view-legacy-ec/merchantviewui/src/app/pages/settings/risk-matrix/risk-matrix.component.ts:42,135`
- **Evidence against:**
  - _(none yet)_
- **Open questions:**
  - UP's risk service (`mlrc-risk`) was not inspected in this session. The belief is about UP but rests entirely on MV-side evidence plus the absence of a known UP equivalent.
  - Migration also requires moving each customer's configured matrix as data, not only building the code path. Per-customer configuration volume is unknown.
  - `RiskCalculationRiskModelItem` also exposes `exclude` and `isShown`; whether UP has equivalents is unknown.
  - Where `unregisteredSeverity` values are populated server-side was not traced.
- **What would settle it:** read `mlrc-risk` and the UP finding-severity path for
  any reported/unreported branch; if absent, confirm with the risk team whether
  it is planned. Then confirm whether per-customer matrix data has a migration path.
- **Status:** open
- **Action:** Blocks `/spec`. This is a silent customer-visible regression, not a
  feature gap — it must be resolved before UP takes MV traffic.

### Connected sites are under-used because the row does not explain them — 2026-08-31

- **Belief:** The 96/4 reported-vs-connected expansion split reflects a
  presentation failure, not low connected-site volume. Nothing on a connected row
  motivates opening it.
- **Evidence for:**
  - `findings_grid_domain_expand` splits 170,627 reported (96%) vs 7,086 connected (4%) over 6 months to 2026-08-30  [documented] Mixpanel MV project `2040581`
  - MV's findings page contains no connection evidence at all — a grep of the whole page returns zero connection references, so the row cannot state which reported URL a connected site links to or why  [documented] `merchant-view-legacy-ec/merchantviewui/src/app/pages/findings/`
  - The only row-level signal distinguishing a connected site is the `U` badge  [documented] `merchant-view-legacy-ec/merchantviewui/src/app/pages/findings/components/grid-findings/grid-findings.component.html:20-22`
- **Evidence against:**
  - CBA runs a 41% connected-site ratio (682 unreported vs 993 reported expands), showing the presentation does not prevent heavy use where the appetite exists  [documented] Mixpanel MV project `2040581`
- **Open questions:**
  - The competing explanation — merchants genuinely have few connected sites surfacing — was not tested. The two explanations point at opposite designs, so this must be settled before design work.
  - Whether the 4% represents deliberate triage (analysts correctly skipping low-risk connected sites) rather than a failure was not investigated.
  - No analyst was interviewed in this session; the inference rests on code and event data only.
- **What would settle it:** ask the MV analyst team how they decide whether to
  open a connected site; and pull the ratio of connected sites *present* per
  merchant against connected sites *expanded*, to separate volume from behavior.
- **Action:** Blocks `/discovery`. Determines whether the UP design invests in
  explaining connections on the row or in surfacing more of them.

### UP cannot restore graph fidelity without a re-scan — 2026-08-31

- **Belief:** Depth, confidence score, node count and full path are discarded
  before storage in UP, so any later decision to surface them requires a data
  model change plus historical re-scan — not a UI change.
- **Evidence for:**
  - UP's read model is documented as minimal and explicitly ignores `total_time`, `fetch_time`, `depth`, `number_of_nodes`, and per-entry `score`, keeping only peer domain → paths  [documented] `unified-platform-new/mlrc-finding/consumer/src/main/java/com/everc/finding/consumer/graph/ConnectionInfoModel.java:8-16`
  - UP recognises 12 connector types against MV's 89 edge types, collapsing WHOIS registrant/admin/technical/billing distinctions into single buckets  [documented] `unified-platform-new/mlrc-merchant/shared-spring/src/main/java/com/everc/merchant/entity/ConnectorType.java` and `merchant-view-legacy-ec/mvserver/GrailsUtils/src/main/groovy/com/evercompliant/enums/GraphEdgeType.groovy:4-94`
- **Evidence against:**
  - _(none yet)_
- **Open questions:**
  - Whether MV customers actually read path/depth detail today is unmeasured — Network tab events could show this, and it would size the obligation.
  - The inspected UP clones (`marketview-portal`, `mlrc-bff-2.0`) date to June 2026 and lag remote `develop`; current remote behavior was not read.
  - Whether the scan engine still computes depth and score at all, or only UP's consumer ignores them, was not established — graph construction lives in the external scan/Core service.
- **What would settle it:** query Network tab events for path-detail interaction
  by the heavy connected-site customers (Adyen, CBA, Fresno First); and confirm
  with the scan team whether `connectionInfo` retains the discarded fields upstream.
- **Status:** open
- **Action:** Feeds `/discovery` and `/prd`. Cheaper to decide before migration
  than after customers complain.

### MV's graph edit workflow is load-bearing for risk accuracy — 2026-08-31

- **Belief:** Analysts editing connections is a risk-correction mechanism, not
  cosmetic curation. UP having no edit workflow means a falsely connected site
  permanently inflates merchant risk until re-scan.
- **Evidence for:**
  - MV's risk chain runs merchant → scanned URLs → findings, with severity and risk score stored at each level, so removing a URL from a merchant changes the merchant score  [documented] `merchant-view-legacy-ec/everc-global-services/global-shared/src/main/java/com/everc/global/model/riskCalculation/RiskCalculationScannedMerchant.java:29-33`
  - MV offers add, edit, delete and undo on graph connections in audit mode, persisted as `CREATE`/`UPDATE`/`DELETE`/`PURGE`/`CREATE_AND_SCAN`  [documented] `merchant-view-legacy-ec/merchantviewui/src/app/shared/modals/dialogs/evidence/evidence-network-evidence/graph-node/graph-node.component.html:29-43`
  - 127 unique users touched the MV audit network edit screen in 6 months to 2026-08-30, against 157 who viewed the network page — most viewers also edit  [documented] Mixpanel MV project `2040581`
  - UP's findings surface exposes only a per-finding `Resolution` dropdown; the entire URL action tier and any graph mutation are absent from inspected source  [documented] `unified-platform-new/marketview-portal/src/features/MerchantDetails/Drawer/tabs/MerchantFindings/useMerchantFindingsColumns.tsx:21-92`
- **Evidence against:**
  - _(none yet)_
- **Open questions:**
  - The edit-screen user count includes G2RS internal analysts (13 internal users appear in the network page breakdown); the customer-vs-internal split for editing was not separated, and this changes who the workflow is for.
  - Whether deletes actually trigger recalculation, or only take effect on the next scheduled scan, was not traced.
  - The merchant risk aggregation formula (max, weighted, or count-based) was not read — it lives in `merv-risk-calculation-api`'s service layer — so the size of a single false connection's effect on merchant score is unquantified.
  - Graph editing sits in the Network tab, outside this feature's scope, but its risk consequences land inside it. Scope boundary needs a PM decision.
- **What would settle it:** read the aggregation formula in
  `merv-risk-calculation-api`; and split the audit-edit user count by internal
  vs customer to establish who depends on it.
- **Status:** open
- **Action:** Blocks `/prd` scope definition — decides whether connection
  curation is in or out of the migration's first release.

### UP has no reported/connected marker on the row — 2026-08-31

- **Belief:** UP cannot visually distinguish a reported URL from a connected one,
  which is a cheaper and higher-impact gap than the missing graph fidelity.
- **Evidence for:**
  - MV marks every row with an `R`/`U` badge driven by `isRegistered`  [documented] `merchant-view-legacy-ec/merchantviewui/src/app/pages/findings/components/grid-findings/grid-findings.component.html:20-22`
  - UP's panel header renders URL, external link, risk tag, last-scanned date and a connection badge, with no reported-status indicator  [documented] `unified-platform-new/marketview-portal/src/features/MerchantDetails/Drawer/tabs/MerchantFindings/MerchantFindings.tsx:53-71`
  - UP's connection badge renders only when `connected && connections.length > 0`, so a connected site whose peer did not resolve is indistinguishable from a reported URL  [documented] `unified-platform-new/marketview-portal/src/features/MerchantDetails/Drawer/tabs/ConnectedURLBadge/ConnectedURLBadge.tsx:16-18`
- **Evidence against:**
  - _(none yet)_
- **Open questions:**
  - The inspected `marketview-portal` clone dates to June 2026; a marker may exist on remote `develop`. Verify before treating as a gap.
  - UP's default panel ordering was not established, so whether reported-first grouping compensates is unknown.
- **What would settle it:** pull current `marketview-portal` `develop` and re-read
  the panel header.
- **Status:** open
- **Action:** Feeds `/spec`. Verify against current remote before writing a
  requirement for something that may already exist.

---

_Session 2, 2026-09-01. Scope narrowed by the PM to a flat list of connected
sites under the merchant; Network tab deferred to a later phase._

### Excluding a connected site must remove its risk contribution — 2026-09-01

- **Belief:** UP needs a reversible per-connected-site exclusion that removes
  that site's entire contribution from the merchant risk calculation while
  leaving the row visible and marked. No UP equivalent exists today.
- **Evidence for:**
  - PM stated the required behavior directly: a connected site's findings affect merchant risk by default with no user action; once excluded, all risk related to that site is removed from the merchant calculation; the row stays visible and marked; the mechanism is the designer's choice  [verbal] Adi Geva, 2026-09-01
  - MV offers the nearest analogue as a per-URL status list — Closed (`Allowed`, `Remediated`, `Review Completed`, `Rejected`) and Open (`Not Checked`, `In Progress`) — where `Allowed` keeps the row listed and marks it closed  [documented] MV Findings tab screenshot, DemoAccount merchant JAUME BONET SERRANO MID 4541370791, supplied 2026-09-01
  - MV's risk model item already carries an `exclude` flag per finding sub-type, so exclusion-from-risk is an existing concept in the legacy risk contract, though at sub-type rather than site granularity  [documented] `merchant-view-legacy-ec/everc-global-services/global-shared/src/main/java/com/everc/global/model/riskCalculation/RiskCalculationRiskModelItem.java:10-11`
  - UP's findings surface exposes only a per-finding `Resolution` dropdown, with no URL-level action tier  [documented] `unified-platform-new/marketview-portal/src/features/MerchantDetails/Drawer/tabs/MerchantFindings/useMerchantFindingsColumns.tsx:21-92`
- **Evidence against:**
  - _(none yet)_
- **Open questions:**
  - Whether MV's `Allowed` status actually removes the URL from merchant risk was not traced. If it does not, UP's exclusion is new behavior rather than parity, which changes how it is positioned to migrating customers.
  - The merchant risk aggregation formula is still unread, so the magnitude of a single exclusion on the merchant score cannot be predicted.
  - Whether exclusion should be per-customer, per-user, or global on the merchant record was not discussed.
  - Whether an excluded site's exclusion survives a re-scan that re-discovers it was not discussed.
  - Reported URLs are explicitly out of scope for this feature per the PM; do not raise reported-URL exclusion in downstream artifacts.
- **What would settle it:** trace MV's status-to-risk path to establish whether
  `Allowed` is risk-affecting; then read UP's risk aggregation to size the effect.
- **Status:** open
- **Action:** Feeds `/discovery` and `/prd`. This is the session's primary new
  requirement and needs a decision on persistence scope before `/spec`.

### UP silently loses connection records to a store-creation race — 2026-09-01

- **Belief:** A connected site can display fewer connections than the scan found,
  or lose its connection badge entirely, because peer resolution depends on the
  peer's store row already existing. Nothing re-checks a skipped link.
- **Evidence for:**
  - `resolveAndBuild` resolves each peer by canonical-host hash against stores already under the merchant and skips unmatched peers with a WARN, documented in source as "a legitimate race with out-of-order store creation, not a client error"  [documented] `unified-platform-new/mlrc-merchant/api/src/main/java/com/everc/merchant/api/service/StoreConnectionService.java:36-93`
  - UP's connection badge renders only when the connection list is non-empty, so a fully unresolved row shows no connection indicator at all  [documented] `unified-platform-new/marketview-portal/src/features/MerchantDetails/Drawer/tabs/ConnectedURLBadge/ConnectedURLBadge.tsx:16-18`
  - MV has no equivalent failure mode: it stores the full traversal path per scanned URL, assembled in one scan pass, with no peer-lookup step that can fail  [documented] `merchant-view-legacy-ec/mvnextgen/merchant-processor-job/src/main/java/com/everc/nextgen/mpj/service/scannedmerchant/NetworkEvidence/NetworkEvidenceService.java:78-105`
- **Evidence against:**
  - _(none yet)_
- **Open questions:**
  - Whether a later scan re-sends the peers and resolves them was not established; if it does, this is a transient display issue rather than permanent data loss.
  - The real-world frequency is unmeasured. The WARN log and any metric counter were not queried, so this may be rare enough to accept.
  - Whether the race is more likely on first scan of a new merchant (many stores created at once) than on re-scan was not investigated.
- **What would settle it:** count the "Skipping peer URL not present" WARN in
  production logs over 30 days, and check whether affected rows resolve on the
  next scan.
- **Status:** open
- **Action:** Feeds `/spec`. Determines whether an incomplete connection list is
  an accepted limit or needs a resolution/retry requirement.
