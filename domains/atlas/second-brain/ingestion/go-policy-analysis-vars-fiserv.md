# GO Policy Analysis (VARS) — Fiserv

Global Onboarding's website policy-and-content analysis component, built to a
Fiserv requirements set: name/location/currency match, product match and
restrictions, T&C/refund/delivery/privacy/card-brand/contact-us checks, and
SSL validation. Mid-build as of July 2025, targeting Fiserv sandbox and
production integration by Q4 2025.

[documented] `../source/2025-07-25-g2rs-go-vars-update-fiserv.md`

## What VARS is

"VARS" is the component name for GO's **Policy Analysis** report — one of two
named component reports in the GO architecture (the other is SSL Certificate
Check). Both sit downstream of a shared source-data layer that also feeds
merchant risk history, watchlist/sanctions, adverse media, and Merchant Map.
[documented] same, slide 4

The problem framing given to Fiserv: "Time = Money" — the business case is
automation that resolves onboarding risk quickly with minimal human
involvement, not new risk categories. [documented] same, slide 3

## Requirements, as a rule table

Each Fiserv requirement below follows the same shape: crawl the merchant
website, extract one thing, score it as a 0-4 risk flag. This is the full set
captured in the deck.

| Area | Fiserv requirement | Output |
|---|---|---|
| Name/DBA match | DBA name on application matches website | Merchant Name Risk flag 0-4 |
| Contact Us | Electronic email and/or phone present; business located in country of origin | Email/Phone/Address Risk flags 0-4 each |
| Currency | Accepted currency matches native/local currency for country of origin | Currency mismatch flag 0-4 |
| Restricted MCC | Merchant's industry acceptable per channel's credit policy | Disallowed MCC Risk flag 0-4 |
| Product match | Website product description consistent with application | Product mismatch Risk flag 0-4 |
| Import/export/legal | Legal or export restrictions apply (e.g. age-gating) | Product restriction Risk flag 0-4, by MCC risk-level |
| Terms & Conditions | No deceptive practices (free trials, free gifts, rebates, negative renewal, prizes/sweepstakes, hidden disclosures, pre-checked boxes, bogus claims) | T&C Risk flag 0-4 |
| Refund policy | No consumer-adverse refund/cancellation terms (short return period, return fees, no refunds) | Refund Risk flag 0-4 |
| Delivery policy | Timeframes align with the Merchant Processing Application | Max delivery time in days; Long delivery Risk flag 0-4 (buckets: 0-3, 4-7, 8-14, 15-21, >21 days) |
| Privacy policy | Acceptable handling of consumer data, evaluated against GDPR principles | Privacy Risk flag 0-4, by count of missing principles |
| Card brand usage | Visa/MasterCard brand mark present per Network Product Brand Standards | Visa/MC logo Risk flag 0-4 each, with screenshot |
| Contact Us friendliness | Customer service info clearly/properly displayed | Customer service Risk flag 0-4 |
| SSL | Secure payment method present, disclosed to cardholders | Certificate validity + ID + issued/expiry dates + issued-to + common name + org + org unit |

[documented] same, slides 7-14

Every risk flag uses the same 0-4 scale, but the "default" value and
direction of severity differ per check (e.g. Address flag defaults to 1, most
others default to 0) — no single pass/fail threshold is stated across checks.
[documented] same, slides 7-14

## Build status (as of July 2025)

**Done:** architectural design; data collection pipelines for website
content, SSL, MCC configuration, and product/services description; analysis
pipelines for homepage, Contact Us, Privacy, T&C, Return/Refund, Product Page,
and Logo Identification; MVP of "10 model builds"; preliminary API/UI output
design. [documented] same, slide 17

**Named challenges, unresolved at time of deck:**
- Website crawling: not all sites are crawlable without a proxy; policy pages
  are sometimes missed, requiring "crawling topology experimentation"; a
  speed-vs-page-count tradeoff is still being tuned. [documented] same, slide
  18
- Model accuracy: insufficient test data volume (G2RS operations generating
  more) and insufficient variety — the deck states a need for "real world
  Fiserv examples" specifically, implying internally generated test data
  wasn't representative enough. [documented] same, slide 18

**Roadmap (Q2-Q4 2025):** product requirements -> analytical engine MVP build
-> analytical engine test -> API build -> API sandbox -> UI build -> Fiserv
sandbox integration -> Fiserv production test -> Fiserv data test ->
analytical engine refine. A parallel collaboration track covers Fiserv sandbox
integration/testing, production test, bulk test and feedback, test data
sharing, and API documentation review, same Q2-Q4 2025 span. [documented]
same, slides 20, 23

No evidence in this source of whether these milestones were hit — the deck is
a snapshot from the review date, not a status report with actuals.

## Open questions this source does not answer

- **Current build status.** This deck is from July 2025; nothing here
  confirms whether Fiserv sandbox/production integration happened, slipped, or
  changed scope since.
- **Relationship to MCC mismatch work.** VARS's "Disallowed MCC" and "Product
  restriction" checks both consume MCC data, but this deck doesn't engage with
  the reported-vs-predicted MCC mismatch problem tracked in
  [[mcc-mismatch-for-global-onboarding]] — these appear to be a different,
  simpler MCC use (a restricted-list check and an import/export lookup), not
  the group-based comparison Core computes. Unconfirmed whether they share a
  data source or pipeline.
- **Architecture diagram (slide 16) was not text-extracted** — only labels on
  shapes would clarify where VARS physically runs (Core, MLRC, a standalone
  service). Worth a follow-up pull if the diagram matters to a current
  decision.
- **"10 model builds"** is stated with no definition of what a "model" is
  here (ML classifier per check? per page type?) or which of the 13
  requirement rows they cover.

## Links

- [[mcc-mismatch-for-global-onboarding]] — separate MCC work in GO; this deck's
  MCC checks (restricted-category, import/export) are narrower and don't
  appear to be the same mechanism.
- [[crawler-capability-gaps]] — the crawling challenges named on slide 18
  (proxy need, policy-page capture, speed/coverage tradeoff) are the same
  category of gap catalogued there; worth reconciling whether this is the same
  crawler estate.
- [[atlas-architecture]] — target platform context for where GO
  and its component reports sit relative to the EverC/Core convergence.
