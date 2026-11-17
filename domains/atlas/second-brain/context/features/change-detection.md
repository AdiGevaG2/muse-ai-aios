# Change Detection

Knowledge base: 2026-11-11 · Adi Geva
Source: `outputs/change-detection/sources/change-detection-q4-planning.md`
(Sarah Craven, Change Detection Q4 Planning, captured 2026-10-20). The
2026-11-06 version differs in one row: Significant price changes map to
Marketing content (TBD). Ingestion page: [[change-detection]] under
`ingestion/`.

## What it is

Change Detection tells a G2 client what changed on a merchant's website since
an earlier scan. Today the whole service runs on Visualping with no
integration: analysts review Visualping's output and Ops delivers an Excel
report. [documented]

The plan builds it in-house as a shared Atlas capability that emits change
signals. Atlas services consume those signals; the analyst Excel report becomes
one consumer among several. [documented]

**Example.** A G2 client monitors joesshoes.com. In March the refund policy
says "30-day returns". In April it says "no refunds". Change Detection finds
the difference on the refund page, and the Atlas service that analyzes refund
policies re-runs on the new text.

## Why

- $1.15M revenue line, about 70% gross margin, about $800K gross profit. [documented]
- Visualping costs $140K a year and now markets content-compliance monitoring
  that overlaps with G2RS, built partly on G2RS analysts' engagement. [documented]
- Owning it aligns the monitored unit with the billed unit. Cliq right-sizing
  cut that account about 67% at renewal. [documented]
- Seven rule types cover every client exception; today they live in analysts'
  heads. Making them configuration is the main lever on analyst overhead.
  [documented]

## Vocabulary

| Term | What it means here |
|---|---|
| CD | Change Detection |
| Visualping | Current vendor; replaced by September 2027 |
| Baseline capture | First capture of a page; produces no change. The second scan gives the first comparison |
| Change signal | What CD emits for Atlas services to consume, defined by the M0 change event contract |
| page.discovered | Signal that a new page was found and classified by page type |
| Materiality gate | Rule that only material changes re-run Policy Analysis or UaaS |
| Monitoring profile | A client's rule configuration, built from the seven rule types (M3) |
| PLRC | Atlas product-level data collection, a separate pipeline; CD reuses it for products |
| CC | Content Classification |
| UaaS | Underwriting-as-a-Service |

## Foundations, built first for every use case

- **Page-type classification:** knowing a URL is a T&C, contact or product page.
- **Structured entity extraction:** business name, address, billing descriptor,
  contact details, prices, payment methods. Atlas core pipeline gives most of
  it; likely gaps are billing descriptor, payment methods and prices, prices
  possibly via PLRC.
- **Page types Atlas core supports today:** refund/returns, shipping, privacy,
  contact, T&C, payment. Product pages go through PLRC. TBD: about us, billing
  descriptor, blog, payment methods, home, header/footer, ingredients,
  subscription/cancellation, age gate.

All [documented].

## What it runs on: Atlas service per use case

From the source's use case catalog. "Current CD" says whether Visualping-based
CD covers it today.

| Atlas service | Use cases | Current CD |
|---|---|---|
| Business Policies | Business name, ownership, rebranding (mismatch flag); address and contact details (mismatch flag); billing descriptor (mismatch flag); payment methods; new policy page identification; page-type selection | Yes; new pages Partial; page-type selection Partial, manual |
| Policy Analysis / UaaS | Policy page content: T&C, privacy, refund, shipping (re-trigger) | Yes |
| Policy Analysis (TBD) | Surcharges, convenience fees, APRs | Yes |
| Policy Analysis (TBD), UaaS | Control presence: age verification removed | Manual |
| CC + PLRC | Products added or removed, product types; client-selected product URLs and new product pages; product claims and ingredients | Yes; product URLs Partial |
| CC | Site health: SSL, redirects, server errors, parked domains | Manual |
| Marketing content (TBD) | Promotions, discounts, going-out-of-business, banners, home page claims; reviews and blog; also shared on business name and product claims | Yes |
| No home (TBD) | Significant price changes (Marketing content in the 11-06 version); licenses and bank partnerships; watchlist mentions | Yes |
| CD core, all clients | Cosmetic change exclusions | Yes |

All [documented]. Business Policies and the Policy Analysis re-trigger come
first in Atlas integration. [documented]

**How each service consumes a change (M4 table):**

| Atlas use case | Trigger from CD | Service | Open product decision |
|---|---|---|---|
| Website data mismatch flag | Name, address or descriptor changes vs. onboarded data | Business Policies | Source of truth for onboarded values; mismatch severity |
| New policy page identification | page.discovered classified as a policy type | Business Policies | Auto-enroll into monitoring, or require selection |
| Page-type selection | Configuration, not a signal | Business Policies | Client self-serve vs. G2RS-configured; per-page-type pricing |
| Policy content change | Material change on a policy page | Policy Analysis and/or UaaS re-trigger | Materiality gate and debounce; automatic vs. analyst-approved |
| Product pages | Client-selected URLs; page.discovered as product detail | CC + PLRC | Auto-classify new product pages, or queue them |
| Marketing content | Changes on home, banner, promo, claims regions | TBD | Recommended: extend Policy Analysis with a claims-and-promotions mode; run discovery first |

Re-trigger cost: policy pages change often and trivially, and each Policy
Analysis or UaaS re-run costs money. The materiality gate is a hard
requirement. [documented]

## Milestones

| # | Milestone | Target | Gates Visualping exit |
|---|---|---|---|
| M0 | Foundations, decisions, benchmarks: throughput, LLM cost, false-negative rate, anti-bot, fleet ops, stack; rule catalog; change event contract | 2026-11-15 | Yes |
| M1 | Core engine: enrollment reconciled to client submissions; daily, weekly, monthly cadence; baseline capture; Atlas page sources; screenshot evidence, hashed and timestamped, changed regions highlighted or unmarked fallback | "Jan 2026" in source, before M0 | Yes |
| M2 | Analyst review queue, false-positive removal with reason, significance note; Excel export by Ops via SP File Share; ideally same changes in the Atlas client portal | Feb 2027 | Yes |
| M3 | Monitoring profiles, seven rule types, possibly deferred | Feb 2027 | No in table; prose says M0-M3 give parity |
| M4 | Atlas service integration | Q2 2027 onward | No |

All [documented]. Prose calls the integration milestone M5.

## Seven rule types (M3)

| Rule type | Client examples |
|---|---|
| Page-type scope | NAB terms, ingredients, descriptor; Cliq contact, terms, privacy |
| Numeric thresholds | NAB price >$100; APR >36%; fee >$2; surcharge >3% Visa / 4% MC |
| Catalog-aware logic | Glacier under ~30 products; Cliq small vs. large catalog |
| Watchlists / entity mentions | TabaPay name; red-flag countries; card brands; bank partnerships; licenses |
| Exclusions | Cliq fonts, styling; Fibonatix copyright year, prices, reviews; CMS reviews; ING all but site-wide sales |
| Site-health signals | Banka Credins SSL; Cliq redirects, server errors, parked domains |
| Control presence | PayNovus age verification removed |

Site health and control presence need their own capture logic, not the page
comparison, and run today as manual monthly analyst walkthroughs. [documented]

## PM direction (Adi Geva, 2026-11-08)

The user journey for the in-Atlas experience:
1. A merchant monitoring scan runs on a merchant.
2. Change Detection is enabled for a specific service.
3. Changes show in Merchant details → Scan → Findings list.
4. A changed service finding is marked "Changed from scan X". Example: the
   refund policy finding is marked Changed, and its evidence shows where and
   what changed in the refund policy.

This matches the source's M4, which the source places after the Visualping
exit path. [inference]

Decisions, 2026-11-11:
- Change Detection is enabled per portfolio, for a specific service.
- A finding is "changed" when its page, policy or document changed since the
  previous scan.
- "Scan X" is the previous scan of that merchant.
- Change Detection runs from a merchant's second scan. The first scan sets the
  baseline and can be an onboarding or a monitoring scan; a merchant with no
  earlier scan gets no change marking.
- Follow the source on what counts: cosmetic changes such as fonts and
  styling are excluded for every client; copyright year is a Fibonatix-only
  exclusion, and only material changes
  re-run Policy Analysis or UaaS. How materiality is decided is not defined in
  the source.

## Open decisions in the source

- Billing unit: URL, page or page-type bundle; whether the 300-pages-per-site
  cap becomes a per-client page budget.
- Client self-serve vs. G2RS-configured page-type and product-URL selection.
  Suggested: configured first.
- Policy Analysis and UaaS re-triggers automatic or gated in the first release.
- Marketing content owner and anchor customers. Recommended: Policy Analysis.
- Excel evidence: embedded screenshots vs. links to hosted evidence.
- Follow-ups: Visualping historical export; severity support; changes without
  a screenshot; daily, weekly, monthly volumes; Visualping walkthrough with
  Margo.

## Gaps for the PRD

- How a material change is told apart from a trivial one: no definition or
  owner in the source. [unknown]
- M1 date conflict and M3 gating conflict in the source. [documented conflict]
