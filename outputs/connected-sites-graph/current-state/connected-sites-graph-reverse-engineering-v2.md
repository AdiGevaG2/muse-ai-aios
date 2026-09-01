# Reverse Engineering: Connected Sites — Graph View (V2)

Strict second run. Unified Platform (UP) is the **target**. WebShield (WS),
Merchant View (MV), and Single Platform (SP) are **legacy evidence sources**, not
port targets. Analysis date: 2026-08-30.

This version supersedes conclusions where it conflicts with the 2026-08-27
first run; that artifact remains preserved as historical evidence.

## Executive Summary

- UP already has the core connected-site object model and a usable row-based
  presentation: one store row per URL, findings owned by that store, reported
  URLs first, connected URLs after them, and connection details in a popover.
  This is an extension of current behavior, not a new data model.
- UP does **not** currently render a graph/hierarchy. Its UI is collapsible URL
  panels. If “Graph View” means an explorable network, that presentation remains
  a product and implementation gap.
- MV is the strongest legacy UX precedent. It renders searchable, recursive
  Network Evidence rooted at a reported URL; distinguishes reported from
  unreported domains; exposes risk and findings navigation; and lets authorized
  analysts add, edit, delete, and undo connections.
- UP stores edges on the discovered/connected row and deliberately hides
  connections on reported rows. It can list all merchant URLs, but it cannot
  answer “show the connected sites from this reported URL” without a reverse
  projection or a different graph response.
- V2 corrects two V1 claims: UP now maps `lastScanned` from the store's
  `lastUpdated`, including stores with no findings; and SP has limited adjacent
  precedents (a direct redirect target and transaction-laundering associated
  URLs), though still no general merchant connected-site graph.
- WS remains **NOT VERIFIED**. No WS source is available locally, and the
  alternate workspace evidence does not establish connected-site graph
  behavior. No WS behavior should be treated as a migration requirement yet.

## Current Behavior by Platform

### Unified Platform — target

1. **The URL is the ownership grain.** A merchant store is unique by
   `(merchantId, urlHash)` and carries `connected` plus optional peer
   connections. Findings are grouped by `storeId`, so each reported or
   discovered URL owns its own findings.
   - Evidence: `UP/mlrc-merchant/.../StoreEntity.java:25-69`;
     `UP/mlrc-bff-2.0/.../FindingServiceImpl.java:106-138`.

2. **The target API returns a row for every store, even with no findings.** It
   starts from the merchant's stores and defaults each store's finding list to
   empty. Rows are reported-first, then highest-risk within reported/connected
   groups.
   - Evidence: `UP/mlrc-bff-2.0/.../FindingServiceImpl.java:57-73,126-138`;
     independently exercised in
     `FindingControllerIntegrationTest.java:460-589`.

3. **The current UI is a row/panel view, not a graph.** Each store becomes a
   collapsible panel with URL, outbound link, risk, scan date, and its category
   table. A connected badge appears only when the connected row has at least
   one surfaced connection; its popover shows peer URL, connector type/value,
   and last checked.
   - Evidence: `UP/marketview-portal/.../MerchantFindings.tsx:49-110`;
     `ConnectionPopover.tsx:21-75`; `ConnectedURLBadge.tsx:15-63`.

4. **Reported status wins over discovered status.** A scanner-created URL can
   later become reported without changing its store ID or losing factual
   connections. A reported URL discovered later cannot be demoted to connected.
   - Evidence: `UP/mlrc-merchant/.../StoreConnectionsMergeIntegrationTest.java:542-631`.

5. **Connection direction is asymmetric at the product boundary.** Incoming
   peers are resolved only when a matching store already exists for the same
   merchant, then saved on the row being upserted. Missing peers are WARN-dropped.
   The BFF returns connections only when `connected=true`, even if the merchant
   service has factual connections on a reported row.
   - Evidence: `UP/mlrc-merchant/.../StoreConnectionService.java:36-92`;
     `UP/mlrc-bff-2.0/.../StoreFindingMapper.java:30-43`.

6. **UP reduces the source graph to peer + connector evidence.** It prefers
   `connectionInfo` and temporarily falls back to legacy `reasoning` GraphSON
   when the new input is absent or empty. It ignores depth, node count, timing,
   and per-entry score, retaining paths only long enough to derive peers and 12
   connector types.
   - Evidence: `UP/mlrc-finding/.../FindingExtractorService.java:386-447`;
     `ConnectionInfoModel.java:8-22`;
     `UP/mlrc-merchant/.../ConnectorType.java:3-16`.

7. **Redirect is a finding rule, not a graph edge in the response.** A scanned
   destination named by a reported URL's redirect finding is absorbed into the
   reported store. A non-reported doorway carrying its own redirect is skipped
   with its findings. Other discovered URLs are upserted as connected stores.
   - Evidence: `UP/mlrc-finding/.../FindingExtractorService.java:169-200`.

8. **Clean-store scan dates are now representable, but their meaning is broad.**
   `lastScanned` maps from store `lastUpdated`, not newest finding time. This
   fixes V1's “blank for clean sites” conclusion, but the timestamp can also
   reflect a non-scan store write unless the store update contract guarantees
   otherwise.
   - Evidence: `UP/mlrc-bff-2.0/.../StoreFindingMapper.java:19-24`;
     `FindingControllerIntegrationTest.java:460-525`.

### Merchant View — legacy precedent

9. **MV has an actual explorable hierarchy.** Network Evidence is rooted at a
   reported URL, searchable, recursively expandable/collapsible, and labels
   each edge and node. Domain nodes show reported/unreported state, risk, a link
   to the site, and a “view findings” action.
   - Evidence: `MV/merchantviewui/.../evidence-network-evidence.component.html:1-30`;
     `.../graph-node.component.html:1-54`.

10. **MV graph review is an analyst workflow.** In audit mode users can edit all
    domains, add a connection, edit a non-domain connection, delete, and undo.
    Persistence expresses changes as `CREATE`, `UPDATE`, `DELETE`, `PURGE`, or
    `CREATE_AND_SCAN`; creating a site may immediately scan it.
    - Evidence: `MV/merchantviewui/.../graph-node.component.html:29-43`;
      `MV/mvserver/.../ConnectionInfoAction.groovy:3-9`;
      `SiteConnectionUtils.groovy:288-324,495-504`.

11. **MV explicitly projects connected-site meaning back to reported URLs.** It
    reverses `ASSOCIATED → ASSOCIATOR`, `UNDISCLOSED_MERCHANT →
    POTENTIAL_TRANSACTION_LAUNDERER`, and verified/affiliate variants onto the
    registered URL. `REDIRECT` also collapses to `ASSOCIATOR`, so the mapping is
    not invertible.
    - Evidence: `MV/mvnextgen/.../UpdateRegisteredUrlsConnectionService.java:28-70`;
      independently present in stale legacy
      `MV/mvserver/.../SiteConnectionUtils.groovy:431-489`.

12. **MV preserves richer path semantics than UP.** Its edge vocabulary spans
    codes 1–88, including hyperlink, iframe, WHOIS roles, bank-reported data,
    affiliate, PSP, social, test transaction, and payment-flow redirects. When
    a bank-reported edge value does not match the merchant's reported data, MV
    rewrites it to `PRIVATELY_ACQUIRED_DATA`.
    - Evidence: `MV/mvserver/.../GraphEdgeType.groovy:4-100`;
      `MV/mvnextgen/.../NetworkEvidenceService.java:107-115`;
      independently tested in `NetWorkEvidenceServiceTest.java:54-70`.

### Single Platform — legacy precedent

13. **SP is URL-scoped but not a general connected-site graph.** `URLCase` owns
    URL-level classifications and can point to one `redirectedUrl`. This is a
    direct redirect relationship, not an arbitrary peer/path model.
    - Evidence: `SP/g2-singlePlatform/.../URLCase.java:267-312`;
      `CategoryUrlCase.java:21-45`.

14. **SP has a separate transaction-laundering association model.** An
    `AssociatedViolatorUrl` links a categorized URL to an associated violator,
    and evidence records capture type, text, merchant source, and violator
    source. It is case-centric and does not provide the reported-URL-rooted graph
    or per-peer connector paths needed here.
    - Evidence: `SP/g2-singlePlatform/.../AssociatedViolatorUrl.java:27-48`;
      `AssociatedViolatorEvidence.java:20-46`.

### WebShield — legacy evidence gap

15. **NOT VERIFIED.** The canonical repo map states no WS/ZignSec checkout is
    present. The one permitted alternate route—targeted workspace evidence—only
    establishes legacy transaction-laundering/domain-research context, not a
    connected-site graph contract. Relevant repos remain `ws-tls`, `ws-domain`,
    and `ws-backend` if access becomes available.

## Business Rules to Preserve

1. Keep findings owned by the URL/store on which they were detected.
2. Include clean URLs; absence of findings must not remove a connected-site row.
3. Keep reported URLs ahead of graph-discovered URLs; use risk as the secondary
   ordering.
4. Once a URL is customer-reported, graph discovery must not demote it to
   connected. Preserve identity and factual connections when status changes.
5. Canonicalize hosts before peer matching; connection input can use a different
   URL shape from the stored URL.
6. Preserve connector type, connector value, first-seen, and last-seen evidence
   for an explainable connection.
7. Keep redirect behavior explicit and separate from ordinary graph discovery.
8. If MV parity is required, preserve a reported-URL projection of connected
   meaning and confirm the `PRIVATELY_ACQUIRED_DATA` handling obligation.

## Target Platform: What Already Exists

| Need | UP status |
|---|---|
| Per-URL identity and reported/connected state | Exists |
| Findings and risk per URL | Exists |
| Clean URL rows | Exists |
| Reported-first/risk ordering | Exists |
| Peer connector evidence and timestamps | Exists on connected rows |
| Connected-site row UI and evidence workflow | Exists |
| Searchable graph/hierarchy | Missing |
| Reported URL → connected-sites projection | Missing from BFF contract |
| Confidence/depth/path explanation | Discarded before API/UI |
| Analyst add/edit/delete graph workflow | Missing |
| Suppressed-URL state visible to users | Missing |

## Gaps

1. **Presentation gap:** no graph/hierarchy, search, node expansion, or graph
   navigation comparable to MV.
2. **Projection gap:** UP can list all stores for a merchant, but a reported row
   cannot surface the sites connected from/to it under the current BFF contract.
3. **Evidence-fidelity gap:** confidence, depth, node count, and full path are
   dropped; 12 connector types are a much smaller vocabulary than MV's legacy
   path semantics.
4. **Review gap:** UP has no MV-equivalent graph mutation workflow or explicit
   reviewed state for an edge.
5. **Suppression gap:** doorway URLs, non-transient merchant-API rejections,
   empty merchant responses, and unresolved peers disappear from product APIs;
   only logs/metrics retain the event.
6. **Timestamp semantics gap:** `lastScanned` is populated, but store
   `lastUpdated` is not proven to be a scan-only timestamp.

## Conflicts / Product Decisions

1. **Rows or graph?** The workspace decision says per-URL rows under the
   merchant, while the feature name says Graph View and MV supplies an actual
   hierarchy. Decide whether a graph is required, or “Graph” names the discovery
   source only.
2. **Anchor direction:** should each reported URL expose its connected sites,
   including inbound links, or is a merchant-level flat list sufficient?
3. **Explanation level:** are connector type/value and last-seen enough, or must
   users see confidence, depth, and the full path?
4. **Legacy compliance:** is MV's `PRIVATELY_ACQUIRED_DATA` rewrite a licensing
   or provenance obligation that UP must preserve?
5. **Suppressed sites:** should dropped doorway/unresolved sites be invisible,
   or represented with a reason and partial evidence?

## Evidence Gaps and Freshness

- **WS:** not verified; no source checkout and no alternate source that proves
  product behavior.
- **UP remote drift:** local source was read at `mlrc-merchant 29e6bf19`,
  `mlrc-finding 7cba93c`, `mlrc-bff-2.0 9cf08aec`, and
  `marketview-portal d778d729`. Remote `develop` tips were respectively
  `77f6487b`, `e84a39bb`, `12a2f73b`, and `0420e251` on 2026-08-30. The local
  BFF and portal commits date to June and are stale. Relevant files were not
  locally modified, but current remote behavior could not be read without
  updating the private clones; claims describe the inspected local source, not
  confirmed deployment.
- **MV:** `mvnextgen develop a1994e1c` and `merchantviewui develop 0eb1473a`
  matched their remote tips. The old `mvserver master 236d6205` checkout is
  stale and its remote default is now `develop b4d04b6d`; it is used only as an
  independent legacy check, not the primary claim source.
- **SP:** `g2-singlePlatform master e84729b4` matched its remote tip.
- **Outside source:** graph traversal limits, cycle handling, maximum nodes,
  scoring, and graph construction remain in the external scan/Core service and
  were not present in the inspected consumers.
