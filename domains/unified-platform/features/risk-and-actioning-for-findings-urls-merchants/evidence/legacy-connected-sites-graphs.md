---
artifact: cross-platform-behavior-reference
feature: risk-and-actioning-for-findings-urls-merchants
status: verified
last_verified: 2026-08-27
---

# Connected Sites Across Platforms

## Scope

This reference compares behavior associated with the phrase "View connected
sites" across four platform lineages:

1. **Merchant View**: Review Evidence > Connection Info and Findings > Network.
2. **G2RS Single Platform**: merchant related-data and associated-violator APIs.
3. **WebShield/ZignSec**: source unavailable; behavior not established.
4. **Unified Platform**: Merchant Findings connected-URL badge and popover.

The exact phrases `View connected sites` and `connected sites` do not occur in
the verified Merchant View, Single Platform, or Unified source. The capability
mapping is a product-language interpretation requested by the PM, not a shared
platform label.

Excluded: graph editing persistence, network discovery jobs, unrelated finding
views, deployed runtime configuration, and runtime visual inspection.

## Source Baseline

| Platform / repository | Ref | Commit | Working tree |
| --- | --- | --- | --- |
| Merchant View / `merchantviewui` | `origin/develop` | `0eb1473a375bf4308a1bcb0eabc8ddf57db992ac` | Not modified |
| Merchant View / `mvserver` | `origin/develop` | `b4d04b6d6a962a3437639910b394b100b8fc79b9` | Not modified; pre-existing documentation changes ignored |
| Single Platform / `g2-singlePlatform` | `origin/master` | `e84729b4cb884c5c95beae0b52bb79b907d3bcbe` | Not modified |
| Unified / `marketview-portal` | `origin/develop` | `e3c755409ca0aa8a225e9ed292b070d102f3e74e` | Not modified; pre-existing changes ignored |
| Unified / `mlrc-bff-2.0` | `origin/develop` | `5f8a58bc1ea4c1863604ad63f33ed15ac6cdbfc4` | Not modified; pre-existing changes ignored |
| Unified / `mlrc-finding` | `origin/develop` | `7a174886224ad8c2e9636790a703712caf4fffc9` | Not modified; pre-existing changes ignored |
| Unified / `mlrc-merchant` | `origin/develop` | `692cf84402cb69074215b67cedabc790f4f99877` | Not modified |
| WebShield/ZignSec | Unknown | Unknown | No repository or deployed-system source available |

Remote refs were fetched and verified on 2026-08-26 or 2026-08-27. Stale local
branches were not used as behavioral authority. The PM confirmed that default
branch-to-production mapping is **not verified**, so this artifact establishes
pinned source behavior, not deployed customer behavior.

## Coverage

| Platform / surface | Entry and eligibility | Data contract | Rendering | Interaction | Errors and empty states | Authorization | Tests |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Merchant View / Connection Info | Covered | Covered | Covered | Covered | Covered | Covered | Partial |
| Merchant View / Findings Network | Covered | Covered | Covered | Covered | Covered | Covered | No direct tests found |
| Single Platform / related entities | API covered | Covered | No frontend in source | No frontend in source | API covered | Covered | Partial |
| WebShield/ZignSec | Blocked | Blocked | Blocked | Blocked | Blocked | Blocked | Blocked |
| Unified / connected URLs | Covered | Covered | Covered | Covered | Covered | Partial | Backend strong; frontend gap |

## Graph Comparison

| Dimension | Merchant View: Connection Info | Merchant View: Findings Network | Single Platform | WebShield | Unified |
| --- | --- | --- | --- | --- | --- |
| Purpose | Explain typed evidence relationships | Summarize finding URLs by severity | Return directly related merchant-profile data and violating entities | Unknown | Explain one-hop URL connections |
| User surface | Recursive evidence tree | Force-directed severity star | Unknown; no frontend in repository | Unknown | Connected-URL badge and popover |
| Relationship shape | Recursive, multi-parent paths | No site relationships; root spokes | Flat typed lists and associated-violator records | Unknown | Flattened one-hop peer links |
| Entities shown | Domains, IPs, email, phone, address, analytics, apps, PSP keys, social identities | Merchant, URLs, synthetic severity groups | URLs, merchants, names, people, descriptors, addresses, emails, phones, violators | Unknown | Peer URLs and typed connectors |
| Main interaction | Search, root selection, expand/collapse | Drag; click to filter Findings | Unknown | Unknown | Hover/click badge; open peer URL |
| Scale behavior | No explicit cap found | 10,000 backend rows; up to six URLs per grouped severity | Independent pagination per category; no hard result cap found | Unknown | 500 peers and 20 connectors per peer |

## Connection Info Rules

All rules below are **confirmed, core legacy behavior** unless marked otherwise.

| ID | Behavior | Evidence |
| --- | --- | --- |
| CI-001 | A non-audit user opens evidence through `Review Evidence`; zero evidence makes the action inert. Audit/global-audit mode can open its audit variant without the evidence-count check. | `merchantviewui/src/app/pages/findings/components/grid-action-buttons/grid-action-buttons.component.html:2-12`; `.../grid-action-buttons.component.ts:140-149`; `merchantviewui/src/app/core/services/grid-finding.service.ts:389-412` |
| CI-002 | An unregistered URL with a LINK finding receives Network evidence only when its merchant scan has a network-evidence ID. The visible evidence title is `Connection Info`. | `mvserver/MerchantViewServerAPI/grails-app/controllers/v4/com/evercompliant/api/EvidenceApi4Controller.groovy:111-120`; `merchantviewui/src/app/core/models/evidences/network.evidence.model.ts:3-9` |
| CI-003 | Selecting Network evidence, a LINK finding, or audit `Edit Network` loads `networkEvidence/{id}` when an ID exists and the result is not already cached. | `merchantviewui/src/app/core/services/audit.service.ts:89-133`; `merchantviewui/src/app/core/factories/network-evidence.factory.ts:18-28` |
| CI-004 | Reading full network evidence requires an allowed role and object permission. Declared roles are superadmin, admin, read-only portfolio, and bank user. | `mvserver/MerchantViewServerAPI/grails-app/controllers/com/evercompliant/data/api/NetworkEvidenceApiController.groovy:34-40` |
| CI-005 | The API returns persisted path data and enriches each scan item with registration status and severity. | `mvserver/MerchantViewServerCommon/src/main/groovy/com/evercompliant/marshalling/NetworkEvidenceMarshaller.groovy:36-49` |
| CI-006 | A path entry encodes `edgeType:nodeType:value`. Supported node types include domain, email, IP, phone, address, analytics, mobile app, PSP key, and social identity. Values may contain colons. | `mvserver/MerchantViewServerCommon/grails-app/services/com/evercompliant/services/data/NetworkEvidenceService.groovy:120-150`; `mvserver/GrailsUtils/src/main/groovy/com/evercompliant/enums/GraphNodeType.groovy:3-15` |
| CI-007 | Equal encoded nodes merge across paths. Parent-child links are deduplicated, multiple parents are retained, and roots are grouped by scan-item ID. | `merchantviewui/src/app/core/factories/network-evidence.factory.ts:31-100` |
| CI-008 | A terminal domain receives scan-item ID, registration, severity, and connection type. Intermediate domains do not receive this terminal metadata. | `merchantviewui/src/app/core/factories/network-evidence.factory.ts:54-69` |
| CI-009 | Filtering retains matching connection types and selected-scan paths, preserves needed ancestors, and suppresses cycles. Visible siblings sort by localized edge label, node-type label, then name. | `merchantviewui/src/app/core/factories/network-evidence.factory.ts:111-147` |
| CI-010 | Unreported-site graphs initially expand all retained levels. Reported-site graphs initially expand the first level and collapse deeper levels. | `merchantviewui/src/app/core/factories/network-evidence.factory.ts:121-126`; `merchantviewui/src/app/shared/modals/dialogs/evidence/evidence-network-evidence/evidence-network-evidence.component.ts:99-110` |
| CI-011 | Search uses case-sensitive substring matching. Nonmatches remain in the graph but are dimmed and noninteractive; ancestors of matching descendants remain enabled. Search does not expand matching branches. | `merchantviewui/src/app/shared/modals/dialogs/evidence/evidence-network-evidence/evidence-network-evidence.component.ts:85-96`; `merchantviewui/src/app/core/factories/network-evidence.factory.ts:127-128`; `.../graph-node/graph-node.component.scss:6-10` |
| CI-012 | Nodes display edge type, node type, value, domain registration, severity, and child count when applicable. Root nodes omit edge type. | `merchantviewui/src/app/shared/modals/dialogs/evidence/evidence-network-evidence/graph-node/graph-node.component.html:1-28` |
| CI-013 | Clicking a node or child count toggles its branch. Clicking the main node also selects it and briefly shows a loading indicator. | `merchantviewui/src/app/shared/modals/dialogs/evidence/evidence-network-evidence/graph-node/graph-node.component.ts:90-105` |
| CI-014 | Clicking a domain opens it in a new tab; the UI prepends `http://` when the value does not contain `http`. `View findings` opens a new tab filtered to that domain, using the continuous-monitoring or legacy route. | `merchantviewui/src/app/shared/modals/dialogs/evidence/evidence-network-evidence/graph-node/graph-node.component.ts:82-88,178-191` |
| CI-015 | Multiple roots for an unreported URL produce a `Reported URL` selector. Reported URLs do not receive this selector. | `merchantviewui/src/app/shared/modals/dialogs/evidence/evidence-network-evidence/evidence-network-evidence.component.html:19-29`; `.../evidence-network-evidence.component.ts:68-76` |
| CI-016 | Pending evidence shows a loading surface. Missing network data shows `No network available`; missing roots can show `Nothing to display`. HTTP failures use the global error alert, with no graph-specific retry state. | `merchantviewui/src/app/shared/modals/dialogs/evidence/evidence.component.html:4-14`; `.../evidence-network-evidence.component.html:1-5`; `merchantviewui/src/app/core/interceptors/error-handler.interceptor.ts:26-57` |
| CI-017 | Audit mode exposes add/edit/delete controls for a selected node; read-only evidence mode omits them. Some controls additionally require a registered selected URL. | `merchantviewui/src/app/shared/modals/dialogs/evidence/evidence-network-evidence/graph-node/graph-node.component.html:29-44` |

### Connection Info Defects And Unknowns

- The registered-site expansion comment says "up to 3 levels," but executable
  logic initially expands only first-level nodes.
- Backend decoding preserves arbitrary colon-containing values; the frontend
  reconstructs only three post-prefix colon segments
  (`merchantviewui/src/app/core/models/network/node.model.ts:52-59`).
- `ROLE_AUDITOR` is absent from the read endpoint's declared roles even though
  audit UI loads it. Effective inherited-role behavior is unknown.
- No graph-specific feature flag or explicit path, node, or depth limit was
  found.
- A failed request may leave the local pending state active because no local
  failure path clears it. This is inferred from reducer and subscription flow,
  not runtime-tested.

## Findings Network Rules

All rules below are **confirmed, core legacy behavior** unless marked
`peripheral`.

| ID | Behavior | Evidence |
| --- | --- | --- |
| NW-001 | The Findings tab header, including Network, is hidden when there are no scans. Without a selected merchant scan, the Network tab is translucent and ignores pointer input, but its route has no guard. | `merchantviewui/src/app/pages/findings/findings.component.html:10-20`; `merchantviewui/src/app/pages/findings/findings-routing.module.ts:11-22`; `merchantviewui/src/app/pages/findings/network/network-routing.module.ts:6-10` |
| NW-002 | The component requests nothing until both a scan list and selected merchant scan exist. Once eligible, it concurrently requests finding rows and severity distribution; both must complete before rendering. | `merchantviewui/src/app/pages/findings/network/network.component.ts:55-73`; `merchantviewui/src/app/core/services/scan-item.service.ts:102-134` |
| NW-003 | The row request filters to selected merchant and scan, risk-matrix finding subtypes, and severities below `NO_RISK`. The UI requests 100,000 rows, but the single-merchant backend path caps results at 10,000 without warning. | `merchantviewui/src/app/core/services/scan-item.service.ts:102-115`; `mvserver/MerchantViewServerAPI/grails-app/controllers/com/evercompliant/data/api/ScanItemApiController.groovy:332-354` |
| NW-004 | Both endpoints allow superadmin, admin, and read-only portfolio roles. Distribution also performs object-level permission checking. | `mvserver/MerchantViewServerAPI/grails-app/controllers/com/evercompliant/data/api/ScanItemApiController.groovy:397-399,732-742` |
| NW-005 | Default row order is registered first, severity ascending, risk score descending, then URL ascending. This determines which URLs survive display grouping. | `mvserver/MerchantViewServerAPI/grails-app/controllers/com/evercompliant/data/api/ScanItemApiController.groovy:315-325` |
| NW-006 | Query timeout defaults to 60 seconds unless runtime configuration overrides it; timeout returns HTTP 408 with data-size guidance. | `mvserver/MerchantViewServerAPI/grails-app/controllers/com/evercompliant/data/api/ScanItemApiController.groovy:348-363` |
| NW-007 | Distribution counts all scan items for the merchant scan by severity; null severity becomes `NOT_SCANNED`. It does not apply the row request's risk-matrix subtype filter. | `mvserver/MerchantViewServerAPI/grails-app/controllers/com/evercompliant/data/api/ScanItemApiController.groovy:732-758` |
| NW-008 | The graph root is the merchant's computed name. Leaves use URL, severity, and registration from scan-item rows. | `merchantviewui/src/app/core/services/scan-item.service.ts:117-141`; `mvserver/MerchantViewServerCommon/src/main/groovy/com/evercompliant/marshalling/ScanItemMarshaller.groovy:122-137` |
| NW-009 | A severity with four or fewer rows renders individual URL nodes. More than four creates a synthetic severity group and instantiates only the first six ordered URLs. | `merchantviewui/src/app/pages/findings/network/network.component.ts:118-156` |
| NW-010 | A collapsed group label lists five URLs and then `See all {distribution total}`. The sixth instantiated URL is omitted from that label. | `merchantviewui/src/app/pages/findings/network/network.component.ts:163-172` |
| NW-011 | Every non-root edge points from the merchant root, including grouped children. The graph is a star, not a representation of site-to-site relationships. | `merchantviewui/src/app/pages/findings/network/network.component.ts:193-224` |
| NW-012 | Nodes display URL text; severity controls fill color; registered URLs use bold text. Root uses the default black fill. No legend is rendered. | `merchantviewui/src/app/core/services/network.service.ts:34-53`; `merchantviewui/src/app/pages/findings/network/network.component.html:1-5` |
| NW-013 | Clicking any rendered node invokes severity filtering and navigates to Findings or Scan Findings. The root is also clickable but has no severity, so it attempts an undefined filter. | `merchantviewui/src/app/core/services/network.service.ts:25-32`; `merchantviewui/src/app/pages/findings/network/network.component.ts:175-190`; `merchantviewui/src/app/core/services/navigation.service.ts:98-102` |
| NW-014 | `peripheral`: Nodes are draggable. The SVG is fixed to 75% of viewport width and viewport height minus 91px; there is no resize listener or responsive breakpoint behavior. | `merchantviewui/src/app/core/services/network.service.ts:25-32`; `merchantviewui/src/app/pages/findings/network/network.component.ts:72-104` |
| NW-015 | Pending requests show `Loading Network. This may take up to a few minutes...`. Success with no rows renders only the merchant root and no empty message. Request errors can leave loading active indefinitely because no error/finalize path clears it. | `merchantviewui/src/app/pages/findings/network/network.component.html:1-5`; `merchantviewui/src/app/pages/findings/network/network.component.ts:63-77` |

### Findings Network Defects And Unknowns

- `See all N` uses unfiltered distribution totals, so it can exceed both the
  risk-matrix-filtered population and the 10,000-row response cap.
- Six grouped children are created, but only five are represented in the final
  group label.
- Synthetic groups influence animation and position, while their children
  remain connected directly to the merchant root.
- Severity-group iteration has no explicit UI ordering contract.
- The deployed query-timeout override and localized severity labels are
  unknown.
- No direct frontend or backend tests were found for this graph or its two
  endpoint behaviors.

## Single Platform Rules

No user-facing node-edge graph or `View connected sites` label exists in the
pinned monorepo source. The repository contains no frontend files. These rules
describe the verified partial equivalents.

| ID | Behavior | Evidence |
| --- | --- | --- |
| SP-001 | `getMerchantRelatedData` returns independently paged collections for URLs, merchants/legal names, DBAs, people, descriptors, addresses, emails, and phones. Results are grouped data points, not nodes and edges. | `g2-singlePlatform/client/src/main/java/com/g2llc/client/merchantprofile/dto/wrapper/response/MerchantRelatedDataResponse.java:12-24`; `.../services/MerchantProfileService.java:193-266` |
| SP-002 | Every collection follows direct associations to one merchant ID; no cross-merchant or multi-hop traversal was found. | `g2-singlePlatform/client/src/main/java/com/g2llc/client/merchantprofile/persistence/MerchantProfileRepository.java:187-368` |
| SP-003 | Current profile values are excluded only when merchant-group membership is available. Addresses are not excluded. | `g2-singlePlatform/client/src/main/java/com/g2llc/client/merchantprofile/services/MerchantProfileService.java:205-229`; `.../persistence/MerchantProfileRepository.java:195-338` |
| SP-004 | One pageable definition applies independently to every category. Missing or nonpositive page size is unpaged; `paged=false` uses `Integer.MAX_VALUE`. Most categories have no explicit order. | `g2-singlePlatform/client/src/main/java/com/g2llc/client/utils/PaginationUtils.java:36-106`; `.../persistence/MerchantProfileRepository.java:187-368` |
| SP-005 | The client endpoint adds request-composition, entity-ownership, and umbrella-organization checks before delegating to the same relationship service. It can return `400`, `401`, `403`, or `500`. | `g2-singlePlatform/client/src/main/java/com/g2llc/client/merchantprofile/endpoint/v1/ClientMerchantProfileController.java:475-506` |
| SP-006 | The tags variant decorates categories only when they contain fewer than six total items. Addresses pass through without tag decoration. | `g2-singlePlatform/data_core/src/main/java/com/g2llc/saga/cases/utils/Constants.java:81-86`; `g2-singlePlatform/client/src/main/java/com/g2llc/client/merchantprofile/services/MerchantProfileTagsService.java:447-530` |
| SP-007 | Associated violators are enabled records classified as `Front Merchant` when front-merchant data exists and otherwise as `Violating URL`. | `g2-singlePlatform/data_core/src/main/java/com/g2llc/saga/cases/services/AssociatedViolatorService.java:46-91` |
| SP-008 | No associated violators returns `204`; no linked trace cases returns `200 []`. Linked trace lookup uses only the associated-violator URL ID after client/product authorization. | `g2-singlePlatform/client/src/main/java/com/g2llc/client/endpoint/v1/ClientAssociatedViolatorController.java:67-160`; `g2-singlePlatform/data_core/src/main/java/com/g2llc/saga/cases/services/AssociatedViolatorUrlService.java:366-368` |
| SP-009 | `/summaryGraph` is a top-ten violating-URL category aggregate, not a relationship graph. The organization relationship service builds an organization hierarchy, not connected sites. | `g2-singlePlatform/client/src/main/java/com/g2llc/client/dto/ILeadGraphSummary.java:3-10`; `.../persistence/ClientLeadCaseRepository.java:627-659`; `g2-singlePlatform/data_core/src/main/java/com/g2llc/saga/dc/service/organizationRelationship/OrganizationRelationshipService.java:32-116` |

### Single Platform Defects And Unknowns

- The deprecated path-form related-data endpoint returns an empty `200` even
  though its documentation and controller test expect related data.
- Swagger status documentation for the generic endpoint exceeds the statuses
  explicitly produced by its implementation.
- The source cannot establish which external frontend consumes these APIs or
  whether deployed clients render lists, a graph, or neither.
- Linked-trace lookup is not organization- or case-scoped after its initial
  client and product authorization.

## WebShield/ZignSec Coverage Gap

No WebShield/ZignSec repository, API specification, deployed UI evidence, or
owner-confirmed source is available in this workspace. Therefore:

- no behavior, parity, or absence claim is made;
- WebShield remains **Unknown / blocked by missing evidence**;
- completing this platform requires a repository/ref, API contract, deployed
  screenshots or recording, or access to a knowledgeable owner.

## Unified Platform Rules

Unified implements connected-URL details, but no node-edge graph, recursive
graph route, or Merchant View-style severity star was found in the pinned refs.

| ID | Behavior | Evidence |
| --- | --- | --- |
| UP-001 | Merchant Details opens with Findings selected and requests `GET /api/v1/findings/{portfolioId}/{merchantId}` when both IDs exist. JWT is required. | `marketview-portal/src/features/MerchantDetails/Drawer/MerchantDetailsDrawer.tsx:86-99`; `.../hooks/useMerchantFindings.ts:228-244`; `mlrc-bff-2.0/mlrc-bff-api/src/main/java/com/everc/mlrc/bff/controller/FindingController.java:55-90` |
| UP-002 | A store with `connected=true` and nonempty connections displays `Graph - Connected URL`. Hover shows a tooltip; click opens a popover without toggling the URL findings panel. | `marketview-portal/src/features/MerchantDetails/Drawer/tabs/MerchantFindings/MerchantFindings.tsx:148-173`; `.../ConnectedURLBadge/ConnectedURLBadge.tsx:13-62` |
| UP-003 | The popover lists peer URLs, typed connector values, and optional last-checked time. Peer URLs open in a new tab. | `marketview-portal/src/features/MerchantDetails/Drawer/tabs/ConnectionPopover/ConnectionPopover.tsx:15-88` |
| UP-004 | Findings loading shows a skeleton; request failure shows a notification without inline retry; an empty store response has no explicit empty message. | `marketview-portal/src/features/MerchantDetails/Drawer/tabs/MerchantFindings/MerchantFindings.tsx:100-108,240-266` |
| UP-005 | Reported stores sort before connected stores and risk descending within each group. Connected peers sort by last-seen descending, with null timestamps last. | `mlrc-bff-2.0/mlrc-bff-api/src/main/java/com/everc/mlrc/bff/service/impl/FindingServiceImpl.java:57-73`; `.../mapper/StoreFindingMapper.java:23-53` |
| UP-006 | The exposed relationship is one hop from a connected store to a same-merchant peer, with typed connectors and timestamps. The BFF hides stored connections for stores where `connected` is not true. | `mlrc-bff-2.0/mlrc-bff-api/src/main/java/com/everc/mlrc/bff/dto/response/StoreConnectionResponseDto.java:9-30`; `.../mapper/StoreFindingMapper.java:39-52` |
| UP-007 | Connection Info parsing links other domain endpoints sharing supported typed connectors. Self-links, unsupported types, malformed input, and unanchorable paths produce no peers rather than failing the Kafka record. | `mlrc-finding/consumer/src/main/java/com/everc/finding/consumer/graph/ConnectionInfoParser.java:18-118,135-210` |
| UP-008 | Legacy reasoning is an active fallback only when Connection Info yields no peers. | `mlrc-finding/consumer/src/main/java/com/everc/finding/consumer/service/FindingExtractorService.java:386-447` |
| UP-009 | A non-reported, non-redirect URL is upserted as a connected store. Incoming peers are host-canonicalized and retained only when they match existing stores for the same merchant. | `mlrc-finding/consumer/src/main/java/com/everc/finding/consumer/service/FindingExtractorService.java:169-200,329-372`; `mlrc-merchant/api/src/main/java/com/everc/merchant/api/service/StoreConnectionService.java:36-93` |
| UP-010 | Re-observation merges connectors by type and value, preserves first-seen, and advances last-seen. Relationships absent from later scans are not removed. | `mlrc-merchant/api/src/main/java/com/everc/merchant/api/service/StoreService.java:234-295`; `.../utils/ConnectionMerger.java:31-78` |
| UP-011 | Requests reject more than 500 peers or 20 connectors per peer. Persistence retains at most 500 peers newest-first and at most 20 historical connectors per peer. | `mlrc-merchant/api/src/main/java/com/everc/merchant/api/dto/UpsertConnectedStoreRequest.java:14-42`; `.../utils/ConnectionMerger.java:19-26,80-117` |
| UP-012 | Portfolio `graphEnabled` controls exist, but the connected-URL display path does not check them. Whether an upstream service suppresses data when disabled is unknown. | `marketview-portal/src/features/settings/pages/MLRCPage/Modals/Portfolio/PortfolioGeneralSettings.tsx:245-253,280-288`; `.../MerchantFindings/MerchantFindings.tsx:148-173` |

### Unified Defects And Unknowns

- `Graph` names an analysis capability and badge, not a rendered graph.
- A reported store can retain persisted connections while the BFF deliberately
  hides them because `connected=false`.
- A connected store may have no peers and therefore no badge.
- The 500-peer policy contradicts documentation implying cumulative "ever
  seen" retention because oldest relationships are evicted.
- Effective gateway authorization for merchant writes and deployment rollout
  remain unknown.
- Backend parsing, mapping, and merging have direct tests; the portal badge and
  popover have no focused tests.

## Product-Relevant Gaps

| Gap | Why it matters |
| --- | --- |
| Platform behavior is not equivalent | Merchant View has recursive evidence and a severity star; Single Platform exposes flat relationship lists; Unified exposes one-hop URL details; WebShield is unknown. |
| Findings Network edges do not encode relationships | Its visual spokes must not be treated as proof that two sites are connected. |
| Unified is a flattened migration | It preserves peer URLs, connector types, and timestamps but not recursive intermediate nodes, path exploration, or search. |
| Single Platform UI parity is unprovable | The repository has backend lists but no frontend, so deployed presentation and interaction remain unknown. |
| WebShield is a hard evidence gap | No parity or migration decision should be made until a source or owner is supplied. |
| Counts and retention differ | Merchant View Network mixes filtered rows with unfiltered totals; Unified evicts oldest peers beyond 500; Single Platform paginates each category independently. |
| Error recovery is inconsistent | Merchant View can retain loading; Unified uses a notification without inline retry; Single Platform source establishes API errors only. |
| Authorization differs and has gaps | Roles vary by surface; Merchant View audit read access, Single Platform linked-trace scoping, and Unified gateway write enforcement need resolution. |
| Production applicability is unverified | Default remote branches were analyzed, but none were confirmed against deployed client versions. |

## Verification

Two independent source passes were completed for Merchant View Connection Info,
Merchant View Findings Network, Single Platform, and Unified Platform. Strict
traceability passed for each pinned source baseline. WebShield could not be
verified because no source was available. Tests were inspected but not run;
runtime execution, deployed-version confirmation, and visual inspection were
not performed.