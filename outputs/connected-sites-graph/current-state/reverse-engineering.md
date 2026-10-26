# Connected Sites - Graph — Current-State Evidence

Feature: view connected sites as URL rows beneath a merchant, each URL owning its
findings. Grain: **per-URL rows under the merchant** (PM decision).
Approach: **build from scratch** — legacy is precedent, not a port target.

Sources read: WebShield (blocked), Merchant View (legacy), Single Platform
(legacy), Atlas (target).
Analysis date: 2026-08-27.

---

## Bottom line

UP already returns per-URL rows with per-store findings. This is an **extension,
not a new build**. The gaps are edge semantics, bidirectionality, and graph
confidence — not the row list.

---

## What UP already gives you

| Capability | Where | Status |
|---|---|---|
| One URL row per store, keyed `(merchantId, urlHash)` | `mlrc-merchant` `StoreEntity.java:25-32` | Works |
| Explicit reported-vs-discovered flag `connected` | `StoreEntity.java:64` | Works |
| Findings owned per URL (`storeId`-keyed, `GSI-StoreId`) | `mlrc-finding` `FindingEntity.java:19-28` | Works |
| One response row per store with its own findings, risk, connections | `mlrc-bff-2.0` `StoreFindingResponse.java:9-41` | Works |
| Rows sorted reported-first, then highest risk | `FindingServiceImpl.java:68-73` | Works |
| Store with zero findings still returns a row | `FindingServiceImpl.java:126-138` | Works |
| Per-store panels with URL label + connected badge | `marketview-portal` `MerchantFindings.tsx:214-230` | Works |
| Peer popover: connector type + value, last-checked | `ConnectionPopover.tsx` | Works |
| 12 connector types (DOMAIN…SOCIAL) | `ConnectorType.java:3-16` | Works |
| Per-URL and per-finding **snooze** (connected sites included) | `UrlSnoozeCell.tsx`, `SnoozeController` | Works, flagged |

Connected-site findings use the same workflow as the main URL — confirmed, no
separate finding type.

---

## Gaps to close for this feature

**1. The graph is directional — the main URL cannot see its connected sites.**
Connections are written only on the connected store's row, never mirrored onto
peers (`StoreController.java:102-103`). No reverse index exists; "which stores
name X as a peer" requires scanning the merchant partition. **This is the central
gap for a merchant-anchored view.**

**2. Graph confidence is discarded.** `connectionInfo` carries `depth`,
`number_of_nodes`, `score`, `paths`; UP keeps only `(peer, connectors[])`.
`ConnectionInfoModel.java:10-21` javadoc states the rest is ignored. Ranking or
explaining connected sites by confidence needs consumer re-plumbing.

**3. "Connected by redirect" is not representable.** Redirect is a magic finding
subtype (`61`), not a connection. A redirect-absorbed URL produces **zero**
connection records, so no edge kind distinguishes redirect from graph-peer.

**4. Discovered URLs are silently dropped.** Three paths, all WARN-log only, none
visible in any API or UI:
- Doorway URLs hard-dropped, findings discarded (`FindingExtractorService.java:193-197`)
- Merchant-API 4xx rejection drops that URL (`:344-354`)
- Peer with no existing store dropped (`StoreConnectionService.java:79-83`)

A user cannot tell a connected site was suppressed. **PM decision needed:
is discarding a doorway's findings acceptable?**

**5. No scan entity to anchor "related to a merchant scan."** Hierarchy is
Merchant → Store(URL) → Finding. A scan-completion *signal* exists (RT-1466,
`ScanProgressEvent`) but the ledger lives in `mlrc-analysis`, covers scheduled
monitoring runs only, and is explicitly non-authoritative.

**6. `lastScanned` is blank for clean sites.** Now derived from newest finding
`lastModifyDate` (`StoreFindingMapper.java`). A connected site scanned with zero
findings shows no scan date. RT-1289 will fix via a scan-completion table.

**7. Snooze views are not complements.** Snooze is keyed `(store, category)`, so a
category snoozed on one URL and live on another puts the merchant in **both**
`CURRENTLY_SNOOZED` and `NOT_SNOOZED`.

**8. False positive is UI-only.** `RemoveFalsePositiveModal` + analyst FP table
exist behind a permission gate, but handlers are `console.log` stubs. Not wired.

---

## Legacy precedent worth borrowing

**MV has a connection-type vocabulary UP lacks.** Unregistered URLs get
`ASSOCIATED` / `UNDISCLOSED_MERCHANT` / `VERIFIED_UNDISCLOSED_MERCHANT`, then MV
**reverses them onto the reported URL** as `ASSOCIATOR` /
`POTENTIAL_TRANSACTION_LAUNDERER` / `VERIFIED_TRANSACTION_LAUNDERER`
(`UpdateRegisteredUrlsConnectionService.java:28-34`). That is how MV solves gap 1
— by writing reverse findings onto the main URL. Not invertible: `ASSOCIATED` and
`REDIRECT` both collapse to `ASSOCIATOR`.

**MV has ~82 edge types vs UP's 12 connector types** — WHOIS registrant roles,
hyperlink, iframe, subdomain, test transaction (`GraphEdgeType.java:4-87`).

**Compliance-shaped rule, likely mandatory:** MV rewrites any "bank-reported"
edge to `PRIVATELY_ACQUIRED_DATA` when the value does not match the merchant's
own reported data (`EdgeDataService.java:29-70`). Implemented twice in two
languages. UP has no equivalent. **Confirm whether this is a data-licensing
obligation.**

**Other MV rules:**
- Connected sites do not exist for automated scans (SIGNUP, WEB_ID,
  QUICK_INSIGHTS, PLRC) — only BOARDING and MONITORING_ON_DEMAND
- MCC findings are reported-URL-only (`MCCAdjustmentFindingService.java:38-42`)
- MV's UI is an indented tree in a modal, **not a graph** — no graph library
- Review is expressed as mutation verbs (CREATE/UPDATE/DELETE/PURGE/
  CREATE_AND_SCAN), not a status
- **MV does not build the graph.** All four repos treat `connectionInfo` as an
  opaque string from an external "Core" service. Depth limits, cycle handling,
  max nodes, and scoring are outside every repo read.

---

## Sources and limits

**Single Platform: no equivalent capability.** One scan creates one `url_case`
per merchant URL and findings *are* URL-scoped (`CategoryUrlCase.java:28-29`),
but every URL is a peer — no parent/child, no graph, no discovery edges. ~60
naming patterns returned zero hits; no `Site`/`Node`/`Edge` class in 7,995 files.

**WebShield: not read.** Code is on self-hosted GitLab (`xcode.swdev.ws`, group
`ws1`), unreachable — host refuses on 443, `glab` not installed, no token.
Secondhand `pm-os` docs do **not** establish that WebShield has a site graph:
its method is IP/domain reverse lookup plus SimilarWeb traffic profiling, and its
case model holds *declared* URLs. "Graph–Connected Sites" is a UP-side capability
name applied to WS billing codes (SAM TLS, IGM Transaction Laundering).
Relevant repos if access appears: `ws-tls`, `ws-domain`, `ws-backend`.

**Branch caveat.** UP repos have **no `master`** — `develop` is the default
branch on `mlrc-finding`, `marketview-portal`, `mlrc-merchant`; `mlrc-bff-2.0`
also has `main` (not default). All UP rules above are verified at `develop` tips
`7cba93c3` / `5cba00fb` / `edd7463e` (2026-08-27) — **development state, not
confirmed deployed**. Long-standing capability (rows, per-store findings,
ordering) is low-risk; newer items (RT-1356 connector types, snooze, RT-1466
scan events) have unknown deployment status.

MV read at `develop` (`a1994e1c`, `0eb1473a`); `mvserver` at stale `master`
(`236d62054`, 2026-07-09, 24 uncommitted files) — its rules may be superseded.

**Unknowns:** Core traversal parameters (outside all repos); which MV finding
subtypes are LINK / CONNECTION_SOURCE (DB config, not code); whether snooze
filtering happens server-side or client-only; `mlrc-analysis` scan ledger not
read.
