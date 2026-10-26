# Source: Change Detection - Q4 Planning

- **Original:** [Change Detection Q4 Planning.docx](https://g2risk-my.sharepoint.com/:w:/r/personal/sarah_craven_g2risksolutions_com/_layouts/15/Doc.aspx?sourcedoc=%7B3575B1CA-A67F-4EEE-967D-977AD65675CE%7D&file=Change%20Detection%20Q4%20Planning.docx&fromShare=true&action=default&mobileredirect=true)
- **Location:** Sarah Craven's OneDrive, Product / Quarterly Planning
- **Last modified:** 2026-10-20
- **Captured:** 2026-10-20, text extracted via the Microsoft 365 connector. Tables are flattened to Markdown; wording is unchanged except for extraction artifacts.

---

## Why we are building it

Change Detection is a $1.15M revenue line at roughly 70% gross margin (about $800K gross profit), run entirely on Visualping with no integration.

Visualping now markets content-compliance capabilities that overlap with G2RS's core business, built partly on our analysts' engagement. Owning the build removes the $140K vendor line, stops that knowledge transfer, aligns the monitored unit with the billed unit (the Cliq right-sizing cut that account about 67% at renewal), and lets us redesign the analyst process to enable CD at scale.

Change Detection will be built as a shared Atlas platform capability that emits change signals, not only as a Visualping replacement. Business Policies, Policy Analysis, Underwriting-as-a-Service, Content Classification and eventually a component supporting marketing monitoring will all consume those signals. The legacy analyst-delivered report becomes one consumer among several.

Two foundations serve every use case and come first.

- **Page-type classification:** knowing that a URL is a T&C page, a contact page or a product page.
- **Structured entity extraction:** pulling business name, address, billing descriptor, contact details, prices and payment methods out of a page. Most of this already comes from the Atlas core pipeline; the likely gaps are billing descriptor, payment methods and prices (prices possibly via PLRC).

The special reporting needs are config waiting to be productized. Every client exception fits one of about seven rule types that today live in analysts' heads. Making them configurable monitoring profiles is the main lever on reducing analyst overhead.

## Vendor replacement as the top priority

Visualping is replaced by September 2027, gated only on parity: the core engine with screenshot evidence, the analyst workflow UI, and client delivery via Excel export (M1-M2), followed by monitoring profiles (M3). Atlas component integration is off the critical path, and spreadsheet delivery can continue until customers migrate to Atlas. The shared foundations are built Atlas-ready so nothing is rebuilt later.

## Milestone summary

Vendor replacement comes first: M0 to M3 deliver parity, including the analyst workflow UI and Excel export, so Visualping can be retired by September 2027 even if CD is not fully live in Atlas. Atlas component integration (M5) is the only milestone that doesn't gate the exit.

| # | Milestone | Target window | Gates vendor exit? | Primary consumers |
| --- | --- | --- | --- | --- |
| M0 | Foundations, decisions and benchmarks | Nov. 15, 2026 | Yes | All |
| M1 | Core monitoring engine and screenshot evidence | Jan 2026 | Yes | CD reporting |
| M2 | Analyst workflow UI and client delivery (Excel export) | Feb 2027 | Yes | Analysts, clients |
| M3 | Configurable monitoring profiles (potentially defer) | Feb 2027 | No | CD reporting, analysts |
| M4 | Atlas component integration | Q2 2027 onward | No | Business Policies, Policy Analysis, UaaS, Content Classification |

## Use case catalog

Most change reporting use cases exist in today's CD service and map to a future Atlas component; marketing content, site health and watchlists have no confirmed Atlas home yet.

| Use case | Source / client examples | Current CD | Atlas component |
| --- | --- | --- | --- |
| Business name, ownership and rebranding changes | User Guide scope; all customers (Mar 2026) | Yes | Business Policies (mismatch flag), Marketing Content (TBD) |
| Address and contact detail changes | User Guide (contact, T&C, privacy pages) | Yes | Business Policies (mismatch flag) |
| Billing descriptor changes | User Guide; NAB | Yes | Business Policies (mismatch flag) |
| Payment methods | User Guide; all customers (Visa, MC, Discover, AMEX) | Yes | Business Policies |
| Policy page content changes (T&C, privacy, refund, shipping) | User Guide; NAB terms; Cliq policy pages | Yes | Policy Analysis / UaaS re-trigger |
| New policy page identification | Quarterly newly identified URLs tab | Partial | Business Policies |
| Page-type selection | NAB and Cliq page-scoped reporting | Partial - Manual | Business Policies |
| Significant price changes | User Guide; NAB over $100; Glacier small catalogs; ING site-wide only | Yes | TBD |
| Products added or removed; change in product types | Cliq; all customers (new products) | Yes | CC + PLRC |
| Client-selected product URLs and new product pages | User Guide 300-page sample | Partial | CC + PLRC |
| Product claims and ingredient lists | User Guide; NAB ingredients | Yes | CC + PLRC, Marketing content (TBD) |
| Promotions, site-wide discounts, going-out-of-business, banners, home page claims | User Guide; Cliq; ING; TabaPay | Yes | Marketing content (TBD) |
| Customer reviews and blog content | User Guide; Cliq (Fibonatix and CMS exclude) | Yes | Marketing content (TBD) |
| Surcharges, convenience fees and APRs | TabaPay; all customers | Yes | Policy Analysis (TBD) |
| Licenses and bank partnerships | TabaPay lists 1 and 2 | Yes | TBD |
| Watchlist mentions (red-flag countries, client name) | TabaPay | Yes | TBD |
| Site health: SSL, redirects, server errors, parked domains | Banka Credins; Cliq | Manual | CC |
| Control presence: age verification removed | PayNovus | Manual | Policy Analysis (TBD), UaaS |
| Cosmetic change exclusions | Cliq; Fibonatix | Yes | CD core (applies to all) |

## M0 - Foundations, decisions and benchmarks

M0 runs the blueprint's Phase 0 spikes (throughput, LLM cost, false-negative rate, anti-bot, fleet operations) and settles the stack decision. In addition:

1. **Confirm page type sources / service integrations needed.** Atlas core pipeline already supports: refund/returns, shipping, privacy, contact, T&C and payment page. Product collection and product detail pages map to PLRC, Atlas's product-level data collection, which sits in a separate pipeline; CD should reuse PLRC rather than build its own product extraction. To be confirmed (TBD): about us, billing descriptor, blog and payment methods, home, header/footer, ingredients, subscription/cancellation and age gate.
2. **Rule catalog.** Inventory every client-specific requirement and classify it by rule type (see M3).
3. **Define change event contract.** Define the schema Atlas components will consume.

## M1 - Core monitoring engine and screenshot evidence

Foundational components of CD:

- merchant enrollment / management: add/remove/maintain reconciliation against client submissions (supported via Atlas);
- daily, weekly and monthly cadences per monitor;
- baseline capture, so the first scan produces no report and the second produces the first comparison;
- integrations with Atlas for page sources + implement additional filtering where needed;
- screenshot evidence for every detected change: current and previous full-page captures, with the changed regions highlighted where the classifier can locate them (pixel diff plus labelled changed regions), falling back to the unmarked pair when it can't; captures are hashed and timestamped so they stand as evidence.

## M2 - Analyst workflow UI and client delivery (parity)

M2 gives analysts and clients everything they use Visualping for today, assuming CD may not be fully live in Atlas by September 2027.

**Analyst workflow UI**

- a review queue of detected changes per client, filterable by change type;
- side-by-side current vs. previous text alongside the highlighted screenshot evidence from M1;
- one-click removal of a change as a false positive, with a reason: it is excluded from the client export and recorded as a labelled disposition that feeds the precision loop;
- editing the significance note before a change is released to the client;
- merchant enrollment management in Atlas, replacing work done in the vendor UI today.

**Client delivery**

- Excel export generation matching the current report tabs: change report (URL, current and previous text, note, screenshot evidence), merchant list, and newly identified URLs;
- profile-aware exports, such as catalog trend summaries for large sites;
- SP File Share delivery (by Ops);
- ideally, the same reviewed changes and exports in the Atlas client portal from launch, so spreadsheet delivery becomes the fallback rather than the product.

## M3 - Configurable monitoring profiles

M3 ships a default profile equal to the User Guide's recommended monitoring scope, then makes every client exception expressible as configuration rather than analyst memory.

| Rule type | What it does | Client examples from the special-needs doc |
| --- | --- | --- |
| Page-type scope | Report all changes on specific page types | NAB (terms, ingredients, billing descriptor); Cliq (contact, terms, privacy, all policy pages) |
| Numeric thresholds | Fire only when an extracted value crosses a limit | NAB price changes >$100; APR >36%; convenience fee >$2; surcharge above 3% Visa / 4% MC |
| Catalog-aware logic | Exhaustive reporting for small catalogs, trends and samples for large ones | Glacier (<~30 products); Cliq small vs. large catalog, "NEW" section in full |
| Watchlists / entity mentions | Fire on presence or change of named terms | TabaPay name; Russia/Ukraine/Iran and red-flag countries; Visa/MC/Discover/AMEX relationships; bank partnerships; lending and money transmission licenses |
| Exclusions | Suppress categories of change | Cliq (fonts, styling); Fibonatix (copyright year, prices, review counts, star ratings); CMS (all reviews); ING (all but site-wide sales) |
| Site-health signals | Technical checks, not content diffs | Banka Credins (SSL validity); Cliq (redirects, server errors, parked domains) |
| Control presence | Alert when an expected control disappears | PayNovus (age verification removed) |

- **Site health and control presence are a distinct check class.** They need their own capture logic, not the diff pipeline. They also run today as manual monthly analyst walkthroughs, so they are easy, visible analyst-time wins.

## M4 - Atlas component integration

Atlas components subscribe to the M0 event contract; Business Policies and the Policy Analysis re-trigger come first.

| Atlas use case | Trigger from CD | Consuming component | Key product decision |
| --- | --- | --- | --- |
| Website data mismatch flag | Entity field change (name, address, descriptor) vs. onboarded data | Business Policies | Source of truth for "onboarded" values; mismatch severity rules |
| New policy page identification | page.discovered classified as a policy type | Business Policies | Auto-enrol into monitoring, or require selection? |
| Page-type selection | Configuration, not an event | Business Policies | Client self-serve vs. G2RS-configured; per-page-type pricing |
| Policy content change | Material change on a policy page type | Policy Analysis and/or UaaS re-trigger | Materiality gate and debounce; automatic vs. analyst-approved re-trigger |
| Product page selection and new product pages | Client-selected URLs; page.discovered classified as product detail | CC + PLRC | Auto-classify new product pages, or queue them? |
| Marketing content changes | Changes on home, banner, promo and claims regions | TBD | See below |

**Marketing content** is best treated as a content category rather than a page type, because promotions, health claims, "going out of business" messaging and banners cut across home, collection and product pages. That favors extending Policy Analysis with a claims-and-promotions mode over building a new component. Run discovery with the customers asking for it before committing.

**Re-trigger cost:** policy pages change often and trivially, and every Policy Analysis or UaaS re-run has a cost. The materiality gate is a hard requirement.

## Decisions needed

- **Billing unit:** URL, page, or page-type bundle going forward. Pricing for page-type selection and client-selected product URLs depends on it. How a billed URL maps to monitored pages, and whether the 300-pages-per-site cap becomes a per-client page budget.
- **Self-serve configuration:** whether page-type and product-URL selection are client self-serve in Atlas at launch or G2RS-configured first. Suggested: configured first, self-serve after migration.
- **Re-triggers:** whether Policy Analysis and UaaS re-triggers are automatic or gated in the first release.
- **Marketing content:** which component owns it, and which customers anchor the discovery. Recommendation: Policy Analysis.
- **Evidence in exports:** embedded screenshot images in the Excel report vs. links to hosted, highlighted evidence.

## Follow-up

- Can we export Visualping data for historical purposes?
- Is severity supported?
- How do we track / report changes w/o screenshot to show it (does this happen)?
- Get daily/weekly/monthly volumes
- Margo - set us up as a user for VisualPing and walk through the flow?
