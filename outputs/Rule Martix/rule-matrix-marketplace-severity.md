# Rule matrix: category severity and marketplace risk configuration

Category-level severity has no home today; findings-volume math over-weights
low-risk categories. Decision: configure severity per marketplace inside the
**rule matrix**, and extend its condition types from category-only to include
merchant/URL.

## Problem [verbal, source: 2026-09-10-rule-matrix-marketplace-severity-transcript]

PLRC UI (the smart-scan UI, shared with the eBay/marketplace flow) has no
concept of category **severity** — only finding-level **confidence** (red/
yellow). Aggregate risk today would let volume dominate: e.g. Amazon shows 55
findings from critical categories vs. 5,000 from low-risk categories, and low-
risk volume should not drown out the critical signal. There is currently no UI
surface, in the marketplace/portfolio area or elsewhere, to mark a category as
high/critical severity or to have that severity feed a risk calculation.

## Entity model clarified in this session [verbal, same source]

- A **marketplace** (PLRC term) = a **portfolio** containing **sellers**, and
  sellers are merchants. Acquirer clients' portfolios are marketplaces.
- Two client types can see overlapping entities without data sharing: e.g. IDN
  (acquirer) has eBay as a merchant, but eBay is also a direct paying client.
  Findings scanned for eBay are never shared with IDN — the two views are
  logically siloed even though the underlying merchant is the same entity. A
  sub-UI showing only the relevant slice was discussed as a possible future
  mechanism for sharing back to a marketplace, but is **not built and not
  prioritized**.
- Personas: marketplace side = team leads / policy managers (e.g. at eBay);
  acquirer side = risk manager (e.g. at IDN) managing the marketplace's risk.
- **Atlas gap vs. PLRC**: UP presents findings at the merchant level
  only (list of scanned merchants → click in → findings). PLRC/smart-scan
  aggregates findings across an entire portfolio/marketplace in one grid (a
  grid was a specific, deliberate client request from eBay over a list view,
  because reviewers resolve items in place rather than click-in/back
  repeatedly). UP has no portfolio-level aggregated findings view today — this
  is called out as a gap UP will need to close, separate from the severity
  work.

## Product decision [verbal, PM direction, same source]

**Add risk configuration per marketplace under the rule matrix.**

- Today the rule matrix supports one condition type: **category**.
- Requirement: add a second condition type — **merchant/URL** (a path or URL) —
  so severity/risk rules can be scoped by category, by merchant/URL, or
  presumably both.
- This gives each marketplace a **default severity per category**, with the
  ability to override/change it, without needing a per-merchant portfolio
  workaround (rejected — see below).

### Options considered and rejected
- **Per-merchant portfolio workaround**: model each marketplace as its own
  UP portfolio so existing per-portfolio settings could carry severity. PM
  explicitly rejected doing this as a one-off ("I don't want to do this
  work") when only justified by a single client; reversed once volume was
  clarified as growing to hundreds of marketplaces (Sparta-camp-tier client
  moving from ~40 to "hundreds" next year) — at that scale it's judged to
  justify a real requirement rather than a workaround. **This did not settle
  which approach ships; the rule-matrix condition-type decision above is what
  the PM ultimately chose instead.**
- **Snooze-style precedent**: UP's existing finding-level snooze already lets a
  client locally lower a finding's severity in monitoring (e.g. "this category
  is low-risk for this specific merchant, don't resurface it"). Raised as a
  possible parallel/precedent for merchant-level severity override, but not
  adopted as the mechanism — the rule-matrix condition approach is orthogonal
  (marketplace/category-scoped, not finding-instance-scoped).

## Open questions / not yet decided [verbal, same source]
- Whether merchants (not just marketplaces) need the same category-severity
  override, or only marketplaces do. PM's stated preference is one consistent
  mechanism usable by both, built once.
- Exact UI location/flow for setting and editing severity per category per
  marketplace (deferred — "I would need to work with that now on how exactly
  it's going to be seen").
- Whether/how a future sub-UI could let a marketplace see only their own slice
  of findings, without a full CSV/finding hand-off (raised, not scoped).

## Cross-links
- [[merchantview]] — MerchantView drives the merchant-level UP findings view
  this decision extends.
- [[smartscan]] — smart-scan is the PLRC product/UI this transcript compares
  UP against; portfolio-grid aggregation and category confidence (red/yellow)
  live there.
- [[marketview]] — product-level red/yellow/green/blue classification is the
  other PLRC severity-adjacent signal, distinct from the category severity
  gap described here.
