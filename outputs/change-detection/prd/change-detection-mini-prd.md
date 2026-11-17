# Change Detection - Mini PRD

**TL;DR:**
Replace Visualping by September 2027 with G2RS Change Detection: a monitoring engine with screenshot evidence, an analyst review queue and Excel delivery to the G2 client, followed by monitoring profiles. In Atlas, when Change Detection is enabled for a service in a portfolio, each merchant monitoring scan marks that service's findings whose page, policy or document changed since the previous scan.

<br>

## Definitions

- **Change Detection**: the G2RS capability that compares a merchant's pages between two scans and reports what changed.
- **Monitor**: one enrolled merchant's set of monitored pages, scanned on a daily, weekly or monthly cadence.
- **Baseline capture**: the first capture of a monitored page. It is stored for comparison and produces no Change.
- **Previous scan**: the merchant's most recent completed scan before the current scan. It can be an onboarding scan or a monitoring scan.
- **Change**: a detected difference between a page's current capture and its previous capture, recorded with both texts and both full-page screenshots, or a failed site-health or control-presence check.
- **Significance note**: the analyst's sentence on why a Change matters. The G2 client reads it in the export.
- **Release**: the analyst action that sends reviewed Changes to the G2 client's next export and locks them.
- **Fingerprint**: a value recorded with each capture that shows the capture was not altered after it was taken.
- **Monitoring profile**: the set of rules that decides which Changes are reported for a G2 client.
- **Changed marker**: the label "Changed from scan X" on an Atlas finding, where X is the previous scan.
- **Change evidence**: the previous and current text of the changed page, policy or document, with removed and added text marked, next to the previous and current screenshots.

<br>

## Problem and Goal

Every monitored page, comparison and screenshot in Change Detection comes from Visualping, and G2RS has no capability of its own. G2 clients receive changes in an Excel report outside Atlas. Client-specific reporting rules live in analysts' heads, and site health and control checks are manual monthly analyst walkthroughs.

Goal: Every G2 client with Change Detection receives its changes from the G2RS capability before the Visualping contract ends, and sees changed findings on the merchant's scan in Atlas.

**Why we need it:** Change Detection is a $1.15M revenue line at about 70% gross margin that depends on one vendor, at $140K a year. Visualping now markets content-compliance monitoring that overlaps with G2RS, built partly on G2RS analysts' engagement. Owning it aligns the monitored unit with the billed unit; the Cliq right-sizing cut that account about 67% at renewal.

**Value for the client:** The G2 client receives the same Excel report tabs with current and previous screenshots for every change, and in Atlas sees a changed refund policy, business detail or product page on the finding, with the old and new text.

**Why now:** The Visualping contract ends in September 2027, and the foundations are due November 15, 2026.

<br>

## Prototype

Open prototype: TBD, hosted at publish

<br>

## Milestones

| # | Milestone | Target | Needed to replace Visualping |
|---|---|---|---|
| M0 | Foundations, decisions and benchmarks | Nov 15, 2026 | Yes |
| M1 | Monitoring engine and screenshot evidence | TBD | Yes |
| M2 | Analyst review and client delivery | Feb 2027 | Yes |
| M3 | Monitoring profiles | Feb 2027 | No |
| M4 | Atlas service integration and changed findings | Q2 2027 onward | No |

<br>

## Feature Behavior

### Prerequisites

- The G2 client has registered for Change Detection and submitted its merchant list.
- Atlas supplies page sources for the G2 client's monitored page types.

### M0: Foundations, decisions and benchmarks

1. Page-type classification: G2RS identifies whether a URL is a refund or returns, shipping, privacy, contact, T&C, payment or product page. Product collection and product detail pages come from PLRC, the Atlas product-level data collection.
2. Entity extraction: G2RS extracts business name, address, billing descriptor, contact details, prices and payment methods from a page.
3. Benchmarks: scan throughput, model cost, missed-change rate, sites that block scanning and scan operations, plus the technology decision.
4. Rule catalog: every client-specific reporting requirement is listed and assigned one of the seven rule types in M3.
5. Change signal format: the format of the change information Atlas services receive is defined. Foundations are built for Atlas use, so M4 does not rebuild them.

### M1: Monitoring engine and screenshot evidence

6. The analyst adds, removes and maintains a G2 client's enrolled merchants in Atlas, reconciled against the G2 client's merchant submissions.
7. Each Monitor has a daily, weekly or monthly cadence.
8. G2RS scans each Monitor's pages at the end of its cadence period and records the scan time on each capture.
9. On a page's first scan, G2RS stores the Baseline capture and records no Change. The second scan produces the first comparison.
10. On each later scan, G2RS compares the page with its previous capture, using Atlas page sources and filtering out pages that are not monitored.
11. If the content differs, G2RS records a Change with the current and previous text and the current and previous full-page screenshots.
    - If the only difference is in fonts or styling, G2RS records no Change, including as a Visual change. This applies to every client.
12. Every capture is fingerprinted and timestamped.

**Screenshot evidence**
- If G2RS locates the changed regions, they are highlighted and labelled on both screenshots.
- If G2RS cannot locate them, both screenshots show with no highlighting, and the evidence states that the region could not be located.
- A page found for the first time is listed on the newly identified URLs tab, and its first capture is its Baseline capture.

**What Change Detection reports**

Change Detection reports every change type reported to G2 clients today, from Visualping or from manual analyst checks:

| Change type | Client examples |
|---|---|
| Business name, ownership and rebranding | All clients |
| Address and contact details | Contact, T&C and privacy pages |
| Billing descriptor | NAB |
| Payment methods: Visa, Mastercard, Discover, AMEX | All clients |
| Policy page content: T&C, privacy, refund, shipping | NAB terms; Cliq policy pages |
| Newly identified policy pages | Quarterly newly identified URLs tab |
| Selected page types only | NAB and Cliq |
| Significant price changes | NAB over $100; Glacier small catalogs; ING site-wide only |
| Products added or removed; change in product types | Cliq; all clients |
| Client-selected product URLs and new product pages | 300-page sample |
| Product claims and ingredient lists | NAB ingredients |
| Promotions, site-wide discounts, going-out-of-business, banners, home page claims | Cliq; ING; TabaPay |
| Customer reviews and blog content | Cliq; excluded for Fibonatix and CMS |
| Surcharges, convenience fees and APRs | TabaPay; all clients |
| Licenses and bank partnerships | TabaPay |
| Watchlist mentions: red-flag countries, client name | TabaPay |
| Site health: SSL, redirects, server errors, parked domains | Banka Credins; Cliq |
| Control presence: age verification removed | PayNovus |

### M2: Analyst review and client delivery

13. The analyst opens Change Detection in Atlas and selects a G2 client.
14. The Review Queue lists the G2 client's unreleased Changes with merchant, page URL, change type, detection time, Significance note and evidence status.
15. The analyst filters the queue by change type or searches by merchant or URL.
16. The analyst opens a Change. The Change view shows the previous and current text side by side, with removed and added text marked, next to both highlighted screenshots and their fingerprints.
17. The analyst edits the Significance note and saves it. A toast confirms the save.
18. The analyst removes a false positive with one click and a reason. The Change leaves the queue, is excluded from the export, and is recorded as a labelled removal used to improve detection accuracy. A toast confirms the removal.
19. The analyst selects Release. A confirmation names the G2 client and the number of Changes.
20. On confirm, every Change in the queue is released, the queue shows its empty state, and a toast confirms the release.
21. G2RS generates the Excel export with these tabs:
    - Change report: URL, current text, previous text, Significance note and screenshot evidence for each released Change.
    - Merchant list: the G2 client's enrolled merchants.
    - Newly identified URLs.
22. For G2 clients with a catalog-aware profile, the export includes catalog trend summaries for large sites.
23. Ops delivers the export to the G2 client through the SP File Share.
24. The G2 client sees the same released Changes and exports in the Atlas client portal from launch. The Excel export is the fallback.

**Released Changes**
- The Released tab lists released Changes with their release date.
- A released Change opens read-only. Its note cannot be edited and it cannot be removed.

**Empty state**
- A G2 client with no unreleased Changes shows "No changes to review" and the time of the most recent scan. Release is disabled.
- An export with no released Changes states on the change report tab that no changes were reported for the period, and fills the other two tabs.

**Errors**
- If a monitored page cannot be captured, G2RS records no Change for it, keeps the previous capture as the comparison point, and lists the page URL and scan time on the Scan Failures tab.
- If the analyst confirms a removal without a reason, the Change is not removed and the Reason field shows "Select a reason to remove this change."

**Permissions**
- G2RS analyst: enrolls merchants, sets cadence, reviews, removes, edits notes and releases.
- G2RS Ops: delivers the export.
- G2 client: no access to the Review Queue. Receives released Changes in the export and the Atlas client portal.

### M3: Monitoring profiles

25. Every G2 client starts on a default profile equal to the User Guide's recommended monitoring scope.
26. Each client exception is configured as one of seven rule types:

| Rule type | What it does | Client examples |
|---|---|---|
| Page-type scope | Reports all changes on selected page types | NAB terms, ingredients, billing descriptor; Cliq contact, terms, privacy, all policy pages |
| Numeric thresholds | Reports only when an extracted value crosses a limit | NAB price change over $100; APR over 36%; convenience fee over $2; surcharge over 3% Visa or 4% Mastercard |
| Catalog-aware logic | Reports every product for small catalogs, trends and samples for large ones | Glacier under about 30 products; Cliq small vs. large catalog, "NEW" section in full |
| Watchlists and entity mentions | Reports presence or change of named terms | TabaPay name; Russia, Ukraine, Iran and red-flag countries; card brand relationships; bank partnerships; lending and money transmission licenses |
| Exclusions | Suppresses categories of change | Cliq fonts, styling; Fibonatix copyright year, prices, review counts, star ratings; CMS all reviews; ING all but site-wide sales |
| Site-health signals | Technical checks, not content comparison | Banka Credins SSL validity; Cliq redirects, server errors, parked domains |
| Control presence | Reports when an expected control disappears | PayNovus age verification removed |

27. Site-health signals and control presence run as their own checks, separate from the page comparison, and replace the manual monthly analyst walkthroughs.

### M4: Atlas service integration and changed findings

28. Change Detection is enabled for a portfolio per service.
29. Change Detection marks findings on merchant monitoring scans only.
30. When a monitoring scan completes, G2RS compares each finding of an enabled service with the same page, policy or document in the merchant's previous scan.
31. If the content differs, G2RS marks the finding "Changed from scan X". A difference only in fonts or styling is not marked.
32. A finding with no difference, a finding on the merchant's first scan, and a finding of a service not enabled for the portfolio show no marker.
33. The G2 client opens Merchant details, then Scan, then the Findings list. Each changed finding shows the Changed marker.
34. The G2 client opens a changed finding. Its evidence shows the Change evidence: what was removed and added, and where on the page.
35. Atlas services act on changes:

| Atlas use case | What triggers it | Atlas service |
|---|---|---|
| Website data mismatch flag | Business name, address or billing descriptor differs from onboarded data | Business Policies |
| New policy page identification | A new page classified as a policy page | Business Policies |
| Page-type selection | The portfolio's selected page types | Business Policies |
| Policy content change | A material change on a policy page | Policy Analysis, UaaS or both re-run |
| Payment methods | Accepted payment methods change | Business Policies |
| Surcharges, convenience fees and APRs | A fee or rate changes | Policy Analysis (TBD) |
| Control presence | Age verification is removed | Policy Analysis (TBD) and UaaS |
| Product pages | Client-selected URLs; a new page classified as a product detail page; products added or removed; product claims and ingredients | CC and PLRC |
| Site health | SSL, redirect, server error or parked domain check fails | CC |
| Marketing content | Changes on home, banner, promotion and claims regions; significant price changes; reviews and blog; business name and product claims | Marketing content (TBD) |

36. Policy Analysis and UaaS re-run only on a material change. Repeated changes to the same page within the grouping period trigger one re-run.

**Example:** The refund policy finding for joesshoes.com is marked "Changed from scan X". Its evidence shows "30-day returns" removed and "No refunds" added, with the refund paragraph highlighted on both screenshots.

<br>

## Acceptance Criteria

**Scenario: First scan sets the baseline**
- Given a page is monitored and has never been scanned
- When its first scheduled scan completes
- Then G2RS stores the capture as the Baseline capture
- And no Change for that page appears in the Review Queue

**Scenario: Later scan records a Change with evidence**
- Given a page has a previous capture
- And the next scheduled scan finds content that differs from it
- When the analyst opens the Change from the Review Queue
- Then the previous and current text show side by side
- And both full-page screenshots show with the time and fingerprint of each capture
- And the changed regions are highlighted, or both screenshots show unmarked with the "could not be located" note

**Scenario: Font or styling difference records no Change**
- Given a page has a previous capture
- And the next scheduled scan finds a difference only in fonts or styling
- When the scan completes
- Then no Change for that page appears in the Review Queue
- And no finding for that page shows the Changed marker

**Scenario: Filter the queue by change type**
- Given a G2 client's Review Queue holds Changes of several change types
- When the analyst filters by one change type
- Then only Changes of that type are listed
- And selecting All Change Types lists every unreleased Change

**Scenario: Edit the Significance note**
- Given an unreleased Change
- When the analyst edits its Significance note and saves
- Then the Review Queue row shows the edited note
- And the G2 client's export shows the edited note for that Change

**Scenario: Remove a false positive**
- Given an unreleased Change
- When the analyst removes it as a false positive without a reason
- Then the Change stays in the queue and the Reason field shows "Select a reason to remove this change."
- When the analyst selects a reason and confirms
- Then the Change leaves the Review Queue
- And the removal is stored with its reason, the analyst and the time
- And the Change does not appear in the G2 client's export

**Scenario: Release locks Changes**
- Given a G2 client's Review Queue holds unreleased Changes
- When the analyst releases them
- Then the Review Queue shows "No changes to review" with the most recent scan time
- And the Changes appear on the Released tab, in the G2 client's next export and in the Atlas client portal
- And opening a released Change shows its note read-only and no remove action

**Scenario: Export tabs**
- Given a G2 client has released Changes for the reporting period
- When the export is generated
- Then it has a change report tab, a merchant list tab and a newly identified URLs tab
- And it contains no Change removed as a false positive

**Scenario: Export with no released Changes**
- Given a G2 client has no released Changes for the reporting period
- When the export is generated
- Then the change report tab states that no changes were reported for the period
- And the merchant list and newly identified URLs tabs are filled

**Scenario: Scan failure**
- Given a monitored page cannot be captured on a scheduled scan
- When the scan for that page fails
- Then no Change is recorded for that page
- And the Scan Failures tab lists the page URL and scan time
- And the next scan compares the page with the previous successful capture

**Scenario: G2 client cannot open the Review Queue**
- Given an Atlas sign-in without G2RS analyst access
- When that sign-in requests a G2 client's Review Queue
- Then access is denied and no unreleased Change is shown

**Scenario: Numeric threshold**
- Given NAB's profile reports price changes over $100
- When a product price changes by $40
- Then no Change is recorded
- When a product price changes by $150
- Then a Change is recorded

**Scenario: Exclusion**
- Given CMS's profile excludes all reviews
- When only customer reviews change on a page
- Then no Change is recorded

**Scenario: Control presence**
- Given PayNovus's profile checks for age verification
- When a scan finds the age verification is gone
- Then a Change is recorded for that merchant

**Scenario: Page-type scope**
- Given NAB's profile reports all changes on terms pages
- When any text on a NAB merchant's terms page changes
- Then a Change is recorded

**Scenario: Catalog-aware logic**
- Given Glacier's profile reports every product for catalogs under about 30 products
- When a merchant with 20 products adds a product
- Then a Change is recorded for that product

**Scenario: Watchlist mention**
- Given TabaPay's profile watches for the TabaPay name and red-flag countries
- When a merchant page adds a mention of Iran
- Then a Change is recorded

**Scenario: Site-health signal**
- Given Banka Credins's profile checks SSL validity
- When a scan finds a merchant's SSL certificate is not valid
- Then a Change is recorded for that merchant

**Scenario: Policy re-run only on a material change**
- Given a policy page change is not material
- When the monitoring scan completes
- Then Policy Analysis and UaaS do not re-run
- Given a policy page has two material changes within the grouping period
- Then Policy Analysis or UaaS re-runs once

**Scenario: Changed refund policy is marked in Atlas**
- Given Change Detection is enabled for the portfolio for the service that produces the refund policy finding
- And the merchant has a previous scan
- And the refund policy text differs from the previous scan
- When the monitoring scan completes
- Then the refund policy finding in Merchant details, Scan, Findings list shows "Changed from scan X"
- When the G2 client opens the finding
- Then the evidence shows the previous and current text with removed and added text marked
- And each screenshot shows its scan time and fingerprint

**Scenario: Unchanged or not-enabled finding is not marked**
- Given the refund policy text is the same as in the previous scan, or Change Detection is not enabled for the portfolio for that service
- When the monitoring scan completes
- Then the refund policy finding shows no Changed marker

<br>

## Data

**Baseline**
- Daily, weekly and monthly Monitor volumes: TBD. Visualping holds the volumes.
- G2 clients delivered from the G2RS capability: 0, as of 2026-11-11.
- Portfolios with Change Detection in Atlas: 0, as of 2026-11-11.

**Success measure**
- Increase G2 clients delivered from the G2RS capability: every G2 client with Change Detection before September 2027.
- Decrease changes Visualping reported that G2RS missed, excluding font and styling differences: target set by the M0 missed-change benchmark.
- Decrease analyst time on manual monthly site-health and control walkthroughs: 0 walkthroughs after M3.
- Increase portfolios with Change Detection enabled in Atlas: target TBD.

**Recorded data**
- Each capture: page URL, scan time, full-page screenshot, page text and fingerprint.
- Each Change: G2 client, merchant, page URL, change type, detection time, previous and current capture, Significance note and status.
- Each removal: reason, analyst and time.
- Each release: Changes released, analyst and time.
- Each scan failure: G2 client, merchant, page URL and scan time.
- Each Atlas comparison: portfolio, merchant, service, finding, current scan, previous scan and result.
- Events: Change detected, Change removed, note edited, Change released, export generated, scan failed, Change Detection enabled or disabled for a service, finding marked Changed, Change evidence opened.

**Sources**
- Change Detection Q4 Planning, Sarah Craven, version of 2026-11-06, `domains/atlas/second-brain/source/2026-10-20-change-detection-q4-planning.md`.
- Change Detection knowledge page, `domains/atlas/second-brain/context/features/change-detection.md`.

<br>

## Open Questions / Assumptions

- ASSUMED: Release sends every Change in the G2 client's Review Queue at once, not a selected subset. Confirm with the PM.
- ASSUMED: Scan failures sit on their own Scan Failures tab next to the Review Queue. Confirm with the PM.
- ASSUMED: Anyone who can open the merchant's scan findings sees the Changed marker. Confirm with the PM.
- Confirm with Sarah Craven how analysts apply client-specific reporting rules after Visualping is retired and before M3 monitoring profiles ship.
- Confirm with Sarah Craven the M1 target. The planning doc lists January 2026, before M0.
- Confirm with Sarah Craven whether the Atlas client portal view is required at launch. The planning doc says "ideally".
- Decide the billing unit: URL, page or page-type bundle, how a billed URL maps to monitored pages, and whether the 300-pages-per-site cap becomes a per-client page budget.
- Decide whether page-type and product-URL selection are G2 client self-serve or G2RS-configured at launch. The planning doc suggests G2RS-configured first.
- Decide whether Policy Analysis and UaaS re-runs are automatic or analyst-approved in the first release.
- Define how a material policy change is told apart from a trivial one, and the period for grouping repeated changes.
- Decide which service owns marketing content changes, and which G2 clients anchor its discovery. The planning doc recommends Policy Analysis.
- Decide whether the Excel export embeds screenshot images or links to hosted, highlighted evidence.
- Decide the source of truth for onboarded values and the severity rules for the website data mismatch flag.
- Decide whether new policy pages are enrolled into monitoring automatically or need selection.
- Decide whether page types are priced per page type.
- Decide whether new product pages are classified automatically or queued.
- Confirm page sources for about us, billing descriptor, blog, payment methods, home, header and footer, ingredients, subscription and cancellation, and age gate pages.
- Confirm sources for billing descriptor, payment methods and prices, which the Atlas core pipeline may not extract. Prices may come from PLRC.
- Confirm Atlas owners for licenses and bank partnerships, watchlist mentions, and marketing content, which have no confirmed Atlas service.
- Define the change types the Review Queue filters by. The prototype uses Text change, Visual change and New page as samples.
- Define the reasons an analyst selects when removing a false positive.
- Check with Core, Juan Martini, whether an existing Core model can decide which differences are worth reporting, or whether a new model is needed.
- Confirm whether Visualping data can be exported for historical records.
- Confirm whether Change severity is supported.
- Confirm how a Change without a screenshot is reported, and whether it happens.
- Pull daily, weekly and monthly Monitor volumes from Visualping.
- Set up a Visualping account with Margo and walk through the flow.
- Decide who enables Change Detection for a portfolio and service in Atlas, and where.
- Decide which services get the Changed marker first. The planning doc puts Business Policies and Policy Analysis first.
- Decide how "scan X" is shown: scan date, scan ID or both.
- Decide what an Atlas finding shows when its page has no match in the previous scan, such as a new policy page.
- Decide what happens when the previous scan did not capture the page.
- Decide whether the Findings list can be filtered to changed findings.
- Decide what happens to existing Changed markers when Change Detection is disabled for a service.
- Decide whether a scan taken before Change Detection was enabled counts as the previous scan.
- Rebuild the prototype for the review queue and the Atlas changed-findings journey.
