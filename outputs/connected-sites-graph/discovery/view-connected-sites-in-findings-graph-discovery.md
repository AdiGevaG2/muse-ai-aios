# Discovery: Connected Sites in the Findings Tab

Document Name: view-connected-sites-in-findings-graph-discovery

Feature Name: Connected Sites in the Findings Tab
Owner: Adi Geva
Product: Atlas
Last Updated: 2026-09-02

## TL;DR

### Executive Takeaway

A client reports one URL for a merchant. If the client has registered for the
connected-sites service, we also scan for other sites that share an
identifier with it, like an email or phone number, and treat those as
connected to the same merchant. Those connected sites get findings too, and the connected URL is presented in
the Findings tab, but an analyst has no way to judge or act on one site at a
time — only review its findings one by one. Today the only control is a
portfolio-wide flag that turns connected-site risk on or off for every
merchant at once. This feature lets an analyst ignore one connected site under
one merchant directly, without reviewing its findings first. The open
question is whether UP's risk scoring already treats connected sites
separately, which affects how big this build is.

## Problem

### Pain Points

- An analyst cannot say *this one connected site is not the merchant's* —
  only the portfolio-wide flag exists, and it applies to every merchant at once.
- A site the analyst judges irrelevant keeps being scanned and keeps producing
  findings. Setting its findings to `No Risk` does not stop the scan.
- To dismiss a connected site, the analyst must review its findings one at a
  time — there is no way to act on the site itself in a single step.

## Proposed Solution

### Feature Behavior

Show connected sites as URL rows in the Findings tab, at the same level as
reported URLs, each with its own findings and a note on how it was found.
Add a per-site **Ignore** action so an analyst can exclude one connected site
from a merchant's risk and future scans, without touching the portfolio flag.

Key rules:

- Reported URLs list first, then connected sites. A connected site is not
  nested under a reported URL — same flat list, same columns, same severity
  and risk display. The only differences: it's marked as connected, it shows
  how it was found, and it can be ignored.
- A portfolio-wide flag (**isolated graph risk**, already built) sets each
  connected site's starting state and gates the ignore action:
  - **Flag on:** connected-site findings never count toward merchant risk.
    Every site arrives already ignored, and the ignore action is not offered
    — there is nothing left for the analyst to decide.
  - **Flag off:** connected-site findings count toward merchant risk like a
    reported URL's would. Every site arrives active, and the analyst can
    ignore any of them.
- Ignoring one site (flag off only) means: *this site is not the merchant's,
  or I don't want it considered* — not a safety judgment, not `No Risk`.
  Ignoring:
  - Stops future scans and new findings on that site.
  - Removes it from the merchant's risk calculation.
  - Keeps the row visible, marked as ignored.
  - Leaves existing findings untouched — no severity or risk changes.
  - Persists across re-scans until the analyst removes it.
  - Is reversible — the analyst can remove the ignore, returning the site to active.
  - Does not survive merchant termination (follows Snooze's precedent).
- Ignore applies to connected sites only, never reported URLs.
- Each connected site states how it was found — the shared identifier (UP
  tracks 12: domain, email, IP, phone, postal address, geographic address,
  alias, Google Analytics ID, AdSense ID, mobile app, payment-provider key,
  social account) plus the nature of the link, at MerchantView's level of
  detail (see Assumptions). This does not apply retroactively to sites already
  scanned — see Out of Scope.
- Design owns exact wording, visual treatment of an ignored row, the
  ignore/un-ignore controls, and whether risk icons change. This discovery
  states required behavior only.

### User Journey

1. Analyst opens a merchant's Findings tab.
2. Analyst sees connected sites listed alongside reported URLs, each showing
   how it was found and its findings.
3. Analyst reviews a connected site and decides it isn't the merchant's.
4. Analyst ignores it (available only when the portfolio flag is off) — the
   site drops out of merchant risk and future scans, but stays visible as ignored.

### Assumptions

| Assumption | Current behavior or evidence | Caveat or validation needed |
|---|---|---|
| A connected site is found via one of 12 shared identifiers | Confirmed. Source: `mlrc-finding` connector vocabulary — see [Reverse engineering V2](../current-state/connected-sites-graph-reverse-engineering-v2.md) § 12, § Gaps 3 | The scan does not judge whether a shared identifier means common ownership; that judgment is the analyst's |
| MerchantView expresses the *nature* of a link with more precision than UP's 12 identifiers | Confirmed — MerchantView has ~88 edge codes (hyperlink, iframe, WHOIS roles, bank-reported data, affiliate, PSP, social, test transactions) | Which of the 88 codes matter to an analyst is unresolved — see Open Questions |
| UP discards connection depth, node count, confidence score, and full path before storage | Confirmed | Unrecoverable for sites already scanned; carrying richer classification forward applies only to sites scanned after this ships. Backfilling existing connections is a separate, out-of-scope programme |
| Isolated-graph-risk flag already exists and is portfolio-wide | Confirmed — flag is already developed and defined | This feature only consumes its state; does not build or change the flag or its settings screen |
| Connected badge requires a saved connection record on both ends | Confirmed — `StoreConnectionService.java:78-83`, `ConnectedURLBadge.tsx:16-18` | If the far-end site wasn't saved yet, the badge is dropped. Frequency unmeasured |

## Scope

### In Scope

- Connected sites shown as URL rows in the Findings tab, same level as reported URLs, each with its findings.
- Stating how each connected site was found, at MerchantView's level of precision.
- The isolated-graph-risk flag governing both risk contribution and each site's default ignored state.
- The new store-level ignore action, and the analyst's ability to remove an ignore.
- Taking an ignored site out of the next scan and out of merchant risk.

### Out of Scope

- Any change to how findings are displayed or worked.
- Any change to reported URLs, including an ignore action on a reported URL.
- Other store types (ignore may extend to them later).
- The isolated-graph-risk flag itself and its settings screen — already built, this feature only consumes its state.
- A filter for ignored stores in the Merchant List.
- A graph, hierarchy, or network-map view; editing connections.
- URL-level owners or statuses; sorting, filtering, collapsed-row previews.
- A historical re-scan to backfill richer connection classification, depth, path, and confidence onto sites already scanned — separate programme (data model, API, full re-scan).

## Success Signals

- Analysts see the connected sites attributed to a merchant, and how each was found, without leaving the Findings tab.
- Migrating MerchantView customers do not lose explanatory detail they have today.
- Analysts use the ignore action on sites that aren't part of the merchant, and rarely reverse it.
- A merchant with most connected sites ignored signals a connections problem, not a feature problem.
- New findings stop arriving on ignored sites.
- Portfolios with the flag on show no connected-site contribution to merchant risk.

## Open Questions

- **Does UP's risk path already branch on connected status?** If not, "flag off means connected-site risk counts" is a scoring change, not a description of current behavior, and merchant scores would move for existing customers. Blocks sizing.
- **Engineering estimate for the ignore action** — needed to prioritize and decide if this splits into phases. Requested, not yet available.
- **Does the upstream scan still emit the richer connection semantics, or does only UP's consumer discard them?** If the scan still computes them, carrying them over is a consumer-side change; if not, the requirement is larger. Confirm with the scan team before sizing.
- **Which of MerchantView's ~88 edge codes actually matter to an analyst?** Carrying all of them is unlikely to be right. Recommend mapping the codes seen in real MerchantView data and treating the rest as out of scope.
- **When a portfolio turns the flag off, what happens to sites ignored while it was on** — do they stay ignored or become active? Recommend recording whether an ignore came from the flag or an analyst, so the two can be told apart.
- **Does an ignore apply to everyone at the customer, or only the analyst who set it?** Recommend everyone at the customer.
- **Does "not scanned" mean stop crawling entirely, or keep crawling and suppress findings?** Recommend stop crawling, accepting the loss of visibility into what changed if the ignore is later removed.
- **A connected site reachable from more than one reported URL appears once in the flat list** — confirm the ignore is per merchant, so it covers the site regardless of which reported URL led to it.
- **An ignored site still appears in the Merchant List view, marked** — whether it still feeds any merchant-level count or indicator there is unresolved. Recommend it does not.

## Appendix

### Persona / Target Audience

**Primary user:**
Risk analysts at acquirer and PSP customers reviewing a merchant's findings.

**Secondary audience:**
Migrating MerchantView customers, who lose explanatory detail today unless this ships.

**Job to be done:**
Judge whether a merchant is risky, and record which attributed sites genuinely belong to it.

### Data

- Number of users affected: TBD
- Current usage: see Legacy EverC Mixpanel Analytics below
- CS tickets: N/A - not queried for this discovery

#### Legacy EverC Mixpanel Analytics

Source: MV, 90 days to 2026-08-31, customer-only, project `2040581`.

| Signal | Legacy EverC evidence | Discovery implication |
|---|---|---|
| Coverage | N/A - not segmented by coverage for this pull | N/A |
| Usage | 93,141 findings-grid expansions; 3,496 (3.8%) on connected sites | Aggregate is misleading — see Key clients. Validate rollout priority with the highest-usage clients first |
| Key clients | MVB-bank 57%, CBA 40%, Wansheng 39%, Afterpay 20%, Fresno First 16%, vs. Adyen 2.1% and NAB 0.05% | Wide spread means this is a concentration story, not a uniform 3.8% usage feature |

### Future Considerations

- Ignore action extended to other store types.
- Sorting, filtering, and collapsed-row previews for connected sites.
- Network Evidence tab.
- Connection path, hop count, and confidence surfaced in the popover (not stored today).
