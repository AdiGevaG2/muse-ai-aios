# Connected Sites

> **What this doc is.** An explanation of what this feature is and why it
> exists, for anyone who needs to understand it without building it. It is not
> a spec — it does not define required behavior, and `spec.md` overrides it
> wherever they differ.

| Field | Value |
| --- | --- |
| Product Area | Unified Platform — merchant findings |
| Primary user | Risk and compliance analysts at banks, acquirers and PSPs; plus G2RS internal analysts |
| Where it lives | The merchant's findings list in Unified Platform |
| Status | In build — phase 1 of the MerchantView migration |
| Owner | Not recorded |
| Last verified | 2026-09-01 |
| Verified by | Adi Geva (`/learn-feature` session) |

---

## In one line

When a client tells us about one of their merchant's websites, we look for other
websites run by the same people and show them alongside it, so an analyst can
see risk the client did not report.

**Who uses it:** Risk and compliance analysts. In MerchantView, **701 unique
users** expanded a website row in the findings list over the six months to
2026-08-30, across roughly 50 customers. Usage is flat, not growing. Only **4%**
of those expansions were on a discovered site rather than a client-reported one.
*(Source: Mixpanel MerchantView project `2040581`, pulled 2026-08-31.)*

## Why it exists

A merchant applying for payment processing tells their bank "this is my
website". That site is often clean. The business that actually carries the risk —
the pharmacy without a licence, the shop selling something the bank will not
process — can be one hop away, run by the same people, sharing a registration
email or a payment key.

Connected sites is how an analyst catches that. Without it, a merchant is
assessed only on what they chose to disclose.

Nobody wrote down the original business case for building it in MerchantView.
The above is the problem the feature demonstrably solves, not a recorded
rationale.

## How it works, end to end

1. **A client reports a website** — the merchant declares a URL to their bank or
   PSP, who passes it to us. This is the **reported site**.
2. **We scan it**, and follow the trail outward looking for other sites that
   share an identifying detail with it.
3. **We link sites that share an identifier.** There are twelve kinds: domain,
   email, IP address, phone, postal address, geographic address, alias, Google
   Analytics ID, AdSense ID, mobile app, payment-provider key, and social
   account. Any one shared detail creates a link.
4. **Each discovered site becomes its own row** under that merchant, marked as a
   **connected site** — meaning we found it, nobody reported it.
5. **We scan each connected site too**, so it gets its own findings — the
   individual risk issues detected on that site.
6. **All the sites appear as one flat list** under the merchant: reported sites
   first, then connected sites, highest risk first within each group.
7. **A connected site's findings raise the merchant's risk score** automatically,
   with no analyst action needed.
8. **An analyst can exclude a connected site** they judge not to belong to this
   merchant. Its risk contribution is removed; the row stays visible and marked
   as excluded. The exclusion can be reversed.

Two terms worth pinning down, because they are used loosely in meetings:

- **Reported** means *this client reported it for this merchant*. It is not a
  global property. The same web address can be reported under one merchant and
  discovered under another — they are separate records that know nothing about
  each other.
- **Connected** is a label describing where a site came from, not a score. It
  does not mean "suspicious" or "confirmed related". It means our scan found it
  and no client declared it.

## What it does *not* do

**By design:**

- **It is not a network graph.** Phase 1 is a flat list. There is no map, no
  expandable tree, no way to walk from one site to the next. MerchantView has a
  Network Evidence tab that does this; it is deliberately deferred to a later
  phase.
- **It does not show connections on reported sites.** If a reported site and a
  connected site share an email, that link appears on the connected site's row
  only. Showing it on both would be the same fact twice.
- **It does not treat redirects as connected sites.** If a reported site
  redirects somewhere, anything found at the destination is recorded against the
  reported site itself. No separate row appears.
- **It does not judge whether a connection is real.** A shared phone number
  creates a link whether it means common ownership or a shared web host. Judging
  that is the analyst's job — which is what exclusion is for.

**Not yet / known limits:**

- **No explanation of *how* two sites are connected beyond the shared
  identifier.** Unified Platform records "these two share an email"; it discards
  the route between them, along with how many steps it took and how confident
  the scan was. MerchantView keeps the full trail. Recovering it would need a
  data change and a re-scan, not a screen change.
- **A connected site can show fewer connections than we actually found.** Saving
  a link requires both sites to already have a record; if one has not been
  created yet, that link is dropped and logged. The site still appears — its
  connection list is just incomplete. How often this happens is unmeasured.
- **Twelve ways to link two sites, against MerchantView's eighty-nine.** Where
  MerchantView distinguishes a shared billing contact from a shared technical
  contact, Unified Platform records only "email".
- **No way to correct a wrong connection.** MerchantView lets analysts add,
  edit, delete and undo connections. Unified Platform does not, so exclusion is
  the only correction available.

## Where it sits

| Relationship | What | Why it matters here |
| --- | --- | --- |
| Depends on | The scan service that builds the connection graph | It decides which sites are linked and how far to look. Its rules are not visible in the platform. |
| Depends on | Per-site scanning | A connected site with no scan has no findings and so no risk contribution. |
| Feeds | Merchant risk score | Connected-site findings raise it automatically. Excluding a site lowers it. |
| Often confused with | Network Evidence tab | Same underlying data, different job. The tab is a visual map for tracing relationships; this is a list for triaging sites. The tab is a later phase. |
| Often confused with | Redirects | A redirect destination is folded into the reported site, not listed as a connected site. |

---

<!-- Everything below the fold is for the PM and the build team. -->

## Open questions

| Question | What would settle it | Who to ask | Blocks |
| --- | --- | --- | --- |
| Does excluding a site persist per customer, per user, or globally on the merchant? | PM decision | Adi Geva | Spec |
| Does an exclusion survive a re-scan that rediscovers the site? | PM decision, then confirm feasibility | Adi Geva + merchant service team | Spec |
| Does MerchantView's `Allowed` status actually remove a URL from risk? | Trace the status-to-risk path in MV | MV risk team | Nothing — parity context only |
| How do per-site risks combine into the merchant score? | Read the risk aggregation service | Risk team | PRD — sizes the effect of one exclusion |
| Does Unified Platform score a discovered site higher than a reported one, as MV does? | Read UP's risk service for a reported/unreported branch | Risk team | Spec — silent regression risk on migration |
| How often are connection records lost to the store-creation race? | Count the WARN in 30 days of production logs | Owner not recorded | Spec |
| Is the 4% connected-site expansion rate a presentation failure or genuinely low volume? | Interview MV analysts | MV analyst team | Discovery |

## Confidence and sources

Every claim above traces to something read, or is marked as a gap. Labels:
**read in code** · **read in a doc** · **inferred** · **nobody wrote this down**.

| Claim | Basis | Source |
| --- | --- | --- |
| Reported vs connected is a flag recording origin, not a score | read in code | `mlrc-merchant/.../StoreEntity.java` |
| Reported status is per-merchant, never global | read in code | `StoreEntity.java` — keyed on merchant + URL hash |
| Twelve connector types | read in code | `mlrc-merchant/.../ConnectorType.java` |
| Connections are hidden on reported rows deliberately | read in code | `mlrc-bff-2.0/.../StoreFindingMapper.java` |
| Redirect destinations fold into the reported site; doorways are discarded | read in code | `mlrc-finding/.../FindingExtractorService.java` |
| Unresolved peers are dropped with a warning | read in code | `mlrc-merchant/.../StoreConnectionService.java` |
| MerchantView keeps the full path; UP does not | read in code | `mvnextgen/.../NetworkEvidenceService.java`; `ConnectionInfoModel.java` |
| MerchantView's six URL statuses | read in a doc | MV Findings tab screenshot, 2026-09-01 |
| Exclusion behavior required for UP | nobody wrote this down | PM decision, this session, 2026-09-01 |
| Why the feature exists | inferred | Reconstructed from what it does; no recorded rationale |

**Not verified:**

- Whether MerchantView's `Allowed` status is risk-affecting. The status list is
  confirmed from the screen; its effect on risk is not traced.
- Whether the lost-connection race resolves itself on the next scan.
- Whether Unified Platform scores discovered sites higher than reported ones, as
  MerchantView does. If it does not, migrating customers' risk scores drop
  silently.
- All Unified Platform claims describe inspected local source. Two of the four
  repositories were last synced in June 2026 and lag current development, so a
  gap named here may already be closed.
- WebShield behavior is entirely unverified — no source access.

**Numbers used in this doc:**

| Number | What it counts | Population & window | Source | Pulled |
| --- | --- | --- | --- | --- |
| 701 unique users | Users who expanded any website row in the MV findings list | All MV customers, 6 months to 2026-08-30 | Mixpanel MV project `2040581` | 2026-08-31 |
| 4% | Share of those expansions on a discovered rather than reported site | 177,713 total expansions, same window | Mixpanel MV project `2040581` | 2026-08-31 |
| ~50 customers | Distinct customers expanding discovered-site rows | Same window | Mixpanel MV project `2040581` | 2026-08-31 |

No Unified Platform usage data exists — the feature is not yet in customers'
hands. No new data was pulled on 2026-09-01.

## Keeping this current

This doc describes the feature as of **2026-09-01**. It is explanation, not a
controlled document — it does not need approval to change, but a stale doc that
reads as current is worse than none.

- Re-verify when the feature changes materially, or every 6 months.
- If it contradicts `spec.md`, the spec wins — fix this doc.
- If it contradicts `prd.md` on **product intent**, that is PRD drift. Raise it
  with the PM rather than writing the new behavior forward here.
