# Front Site Detection (FSD) in the application, Phase 1

FSD reaches the application in Phase 1 as one more finding on the CMP findings
topic: a yes/no "suspected front site" plus a paragraph of reasoning. The
proposal is to show it through the existing findings model at Critical risk
with visual emphasis, with a dedicated FSD experience deferred.

Source for every claim below unless marked otherwise:
`source/2026-10-26-fsd-phase1-guide-for-application-team.md` (Gal Sahar's
guide for the Application team, byline 2026-10-26, captured at doc rev 137).
That guide names the GTM Brief as its primary source. The GTM Brief is
ingested in the section "From the GTM Brief" below, with its own source file.
The code inspection behind the CMP contract is ingested in "From the
detection-logic page (CATS 4349263873)" below, with its own source file.

## What FSD detects

- FSD flags merchants whose site looks legitimate but who do not act, behave
  or exist like a real business elsewhere. Target: constructed fronts hiding
  fraud, scams, laundering or other higher-risk activity. [documented]
- Three signal families, extracted with GenAI and weighed by ML models:
  behavioral consistency of content, story and pricing; domain integrity, meaning
  age, update patterns and registration horizon; online presence, meaning
  reviews, directories, social profiles and mentions. [documented]
- Expected flag rate is about 0.5% of a portfolio, illustrated as ~100 flagged
  out of 10,000 sites. This is an expectation, not a measured rate. [documented]
- FSD is not an auto-block. The expected action is manual review guided by
  the reasoning. [documented]

## FSD versus Transaction Laundering (TL)

FSD asks "is this site a front?" from the site, domain and footprint, at
onboarding, before activation. TL asks "where does the money come from?" and
needs payment, traffic or network evidence; it runs as continuous,
analyst-driven monitoring of suspected networks. A positive FSD is a reason to
investigate TL, not a TL verdict. Sub-types FSD_TL and FSD_scams are on the
roadmap for Q4-26 to Q1-27. [documented]

Linking FSD to known front-site merchants in the database is planned, not
integrated. [documented]

## How the signal arrives (CMP contract)

- The FSD worker runs after crawl and text extraction when the scan's
  `front_site_detection` flag is on, analyzes the homepage only, and appends
  its result to the scan message on `core-prod-fast-onboarding-findings`.
  [documented, from code inspection]
- Positive result = `finding_sub_type` 389 with `score` 80. Any other score
  (0 to 70) or sub-type 1012 is not a positive result and is not rendered in
  Phase 1. CMP adds `finding_type` 18, `classifier_origin` 40 and
  `culture` "N/A" to every FSD finding. [documented, from code inspection]
- `score` is an outcome code, not a probability. It is not shown as a number.
  [documented]
- `evidence_text` is a multi-sentence paragraph written for a risk analyst;
  `evidence_url` is the analyzed page. [documented]
- Evidence strength: field values were read from source code at the
  2026-10-14 revision, not observed in production traffic. The path from CMP
  publish through ingestion, client filtering and UI rendering is **not
  verified**. [documented as a gap]

## Proposed Phase 1 presentation

- Risk: a positive FSD carries the highest risk level shown. Phase 1 releases
  only the "critical" grade, stated as above 90% precision. One FSD finding
  makes the merchant Critical, because a merchant's tier is set by its highest
  single signal in the draft risk-tier taxonomy. [documented; the taxonomy is
  a WIP draft]
- Legacy MerchantView callback labels it `findingRisk: critical`,
  `findingName: Suspected Front Site`, category Signals. [documented] See
  [[merchantview]].
- Portfolio or queue row: an FSD indicator such as a "Suspected Front Site"
  chip, overall risk Critical that sorts and filters with other critical
  merchants, visual emphasis, and the application's critical-finding alert.
  [documented as proposal]
- The finding: full `evidence_text` visible, not behind a hover; analyzed URL
  and screenshot at most one click away. [documented as proposal]
- No "FSD: clear" or "verified" state. No finding can mean skipped (offline,
  parked, excluded category), missing data, or a processing error.
  [documented]
- User journey: clicking a flagged URL, violation or merchant lands on one
  page with the screenshot, the FSD reasoning below it, and other violations
  on the same URL. Two layouts were drawn: a dedicated finding page (A) or
  the single merchant view (B). The guide leans to B because the URL is the
  unit of truth and B needs no new screen. [documented as proposal]
- The "show it like any other finding" stance was later softened in the doc
  to "I think it reasonable" and the section heading marked "(TBD)", so the
  presentation is a proposal under discussion, not a decision. [verbal]

## Later stages (roadmap, not Phase 1)

A second "Suspected FSD" level at High risk; FSD_TL and FSD_scams sub-types
(Q4-26 to Q1-27); structured reasoning split by contributing signal; a post-FSD
review workflow from the operational playbook, such as cross-checking KYB data;
and feeding a Scams solution (2027). A dedicated FSD page is judged useful only
once these exist. [documented] Related: [[scam-network-intelligence]],
[[network-intelligence]].

## From the GTM Brief

Source: `source/2026-09-09-gtm-brief-front-site-detection-confluence-cats-4031382506.md`
(Confluence CATS 4031382506, v20, last updated 2026-09-09). The brief
confirms the guide's positioning, roadmap and explainability examples; the
points below are what it adds.

- **How the binary is produced.** An LLM extracts features from site content
  and search results; domain metadata and online presence are added; an ML
  model outputs a probability of front site versus legitimate. A threshold is
  set per use case or portfolio type to turn that into the yes/no. Phase 1
  releases only Critical results. [documented]
- **Signal detail beyond the guide.** Behavioral signals split into content
  uniqueness, content consistency across domain, homepage, search results and
  legal pages, and pricing versus offering. Domain integrity includes
  registrar metadata, short expiry horizon, very new domains and scam-pattern
  domain endings such as .xyz and .top. The model's interaction list also
  names transactional flow and policy adherence. [documented]
- **Three explainability examples**, all one paragraph each, all ending in a
  verdict such as "confirming the entity's unsuitability for continued
  merchant services". One example cites "a suspicious transactional flow".
  [documented]
- **MV callback** carries `reviewerNotes` and `findingStatus` fields beyond
  the ones the guide quotes. Their values are blank in the example.
  [documented] Relevant to open question 6 on analyst actions. [hunch]
- **Deployment is two modes, not onboarding only.** FSD is an add-on to scans
  over API or the application, used either as a pre-activation onboarding
  scan or as a "quota" portfolio clean-up on a cadence, for example twice a
  year. [documented]
- **Pricing, work in progress.** Add-on to base capabilities. Client price
  drafted at $0.50 per scan for onboarding, quota or both, with volume
  discounting toward $0.40. Internal model serving cost noted as 0.07 to 0.1
  per scan, dated 28/12, unit not stated. Owners named: Gal Sahar and Mary
  Williams, who is deactivated. [documented, marked WIP in source]
- **Success metrics drafted:** precision 85%; flag volume 0.5% of portfolio
  normally, up to 1% when new fraud networks emerge, with spikes
  investigated. [documented]
- **Pilot:** Global Payments, raised by Customer Success after client issues.
  Findings on existing client merchants were to go to Melissa for review by
  21/12 and then be presented in a discovery session aiming at a second POC.
  Year not stated; outcome not in source. [documented]
- **Client-facing user manual** is being written by the Knowledge team.
  [documented]

### Conflicts with the Phase 1 guide

Surfaced, not resolved. Both claims are kept.

1. **Precision bar.** "How FSD is meant to be used" and the Phase 1 guide say
   above 90% precision for released findings. The brief's success metrics say
   85%. [documented, both in the GTM Brief] PM decision 2026-11-09: 85%. See
   `decisions/2026-11-09-fsd-phase1-precision-85.md`. Open: whether the
   "critical" grade threshold itself changes.
2. **Where FSD runs.** The guide's FSD-versus-TL table places FSD at
   onboarding, before activation, and TL at post-activation monitoring. The
   brief also sells FSD as a portfolio clean-up across active merchants.
   [documented in both sources] PM decision 2026-11-09: Phase 1 shows FSD
   for both onboarding and monitoring. See
   `decisions/2026-11-09-fsd-phase1-onboarding-and-monitoring.md`. Open: the
   guide documents only the onboarding findings topic, so delivery of FSD for
   monitoring scans is unverified.
3. **Probability versus outcome code.** The brief describes a probability
   with a per-portfolio threshold; the guide says the CMP `score` is an
   outcome code, not a probability, and shows a single positive code, 80.
   Not a contradiction, but the threshold per portfolio type is not visible
   in the CMP contract the guide describes. [hunch]

## From the detection-logic page (CATS 4349263873)

Source for this section:
`source/2026-10-15-fsd-detection-logic-legacy-core-cmp-confluence-cats-4349263873.md`
(Gal Sahar, Confluence page updated 2026-10-15, evidence date 2026-10-14). It
is the code inspection the Phase 1 guide's CMP contract was assembled from.
All claims are [documented, from code and deployment configuration], not from
production traffic, unless marked otherwise.

**The service.** FSD is the Suspectra service. Two paths call the same
analysis engine: legacy Core / MerchantView over HTTP (`POST /predict`), and
CMP through a Kafka worker. FSD does not crawl; it needs crawled homepage
content.

**CMP path, the one the application gets.**
- Input: the content-text message on `core-prod-fast-onboarding-content-text`
  with `request_id`, `url`, `url_meta.raw_html_path`, and optional
  `url_meta.content_text_path`. Runs only when the scan flag
  `front_site_detection` is on; default is off. Other message fields pass
  through unchanged.
- Output: the same scan message with FSD findings appended to its existing
  findings array, published to `core-prod-fast-onboarding-findings`.
  Dead-letter topic in production: `core-prod-fast-onboarding-content-text-dlt`.
- Each finding carries `finding_sub_type`, `score`, `evidence_text`,
  `evidence_url`; CMP adds `finding_type` 18, `classifier_origin` 40,
  `culture` "N/A". This confirms the guide's merged object.
- CMP drops client and language before analysis: account defaults to
  "unknown", language is not forwarded, special-page text is empty.

**Outcome codes.** Sub-type 389 is a suspected front site; every other outcome
uses sub-type 1012. `score` is an outcome code:

| Score | Meaning |
|---|---|
| 80 | Suspected front site after threshold and business filters |
| 70 | Below the category's model threshold |
| 12 | Parked page, early exit |
| 4 | Category excluded from positive detection |
| 3 | Unknown or missing business category |
| 2 | Above threshold but suppressed by business filters |
| 1 | Processing error |
| 0 | Neutral, such as empty HTML in CMP |

No finding, or a non-80 code, does not mean legitimate: the site may have been
skipped, excluded, under-enriched, filtered or failed.

**How a decision is made.** Parked-page check by LLM, then WHOIS and two
search queries, then LLM feature extraction (Amazon Nova Pro on AWS Bedrock,
up to 50,000 characters of homepage text), then six CatBoost models in two
groups of three. The group's three probabilities are averaged and compared to
a threshold per business category:

| Category eligible for a positive | Threshold |
|---|---|
| PHYSICAL_RETAIL | 0.65 |
| HIGH_RISK_DIGITAL_B2B | 0.66 |
| PASSIVE_DIGITAL_GOOD | 0.86 |
| PAYMENT_PAGE_ONLY | 0.65 |

Above-threshold results are suppressed when all four WHOIS dates are missing,
or when the site cannot transact money immediately or falls in a low-viability
tier. Professional services, offline commercial services, regulated or
restricted businesses and insufficient-data categories never return a positive.
The pipeline response exposes only the outcome code, not the probability or
category.

**Evidence.** A suspected result gets an extra LLM-written explanation in
`evidence_text`. The page lists no screenshot field in the output.

**Code gaps found by static inspection, impact not measured.**
- A transaction feature name mismatch means one model feature always gets the
  missing-value fallback.
- Special-page content is never used.
- CMP accepts HTML with empty homepage text, and does not run the domain
  validation the HTTP path runs.
- Failed extraction can produce a normal-looking result instead of an error.
- HTTP metrics count error-coded findings as success.
- Delivery after CMP publishes, through ingestion, client filtering and UI, is
  not traced.

**Reported drop in finding volume.** Findings fell from about 50 to 5 per
10,000 sites, 0.5% to 0.05%, starting around 2026-09-23 to 2026-09-30, all
from the legacy pipeline. No root cause confirmed. [documented as reported,
not measured by the page]

### Conflicts and threads with the rest of this page

1. **Flag rate.** "What FSD detects" above states an expected flag rate of
   about 0.5%. This page reports 0.5% fell to 0.05% from late September 2026
   on the legacy pipeline. Expected rate and observed rate now differ by 10x,
   cause unknown. [documented in both sources]
2. **Threshold per portfolio vs per category.** Conflict 3 above asks where
   the per-portfolio threshold lives. This page shows thresholds fixed per
   business category in a threshold file, not per portfolio or client, and
   CMP does not forward the client at all. [documented]
3. **Screenshot.** Open question 4 below asks whether FSD comes with the
   homepage screenshot. The FSD output here has no screenshot field.
   [documented absence; whether CMP or Core attaches one elsewhere is unknown]
4. **End-to-end delivery.** This page and the guide both leave the path from
   CMP publish to the UI untraced. Open question 7 stays open.

## Open questions carried by the source

1. Does clicking an FSD-flagged URL open a dedicated finding page or the
   single merchant view? Owner named: Dana Fridman.
2. How does "critical" map onto the application's risk levels and overall
   merchant score?
3. Which alert fires for a critical FSD finding, and to whom?
4. Does FSD come with the homepage screenshot? Owner named: Yonatan Eisenberg.
5. How much `evidence_text` shows by default, and what maximum length to
   design for?
6. Which analyst actions, if any, exist on the finding in Phase 1: review,
   override, notes?
7. When can a CMP FSD finding be traced end to end into the UI?

## Threads to other pages

- [[merchant-ip-whois-mismatch]] states that MV's current whois path runs
  through FSD or Scamadviser. That matches FSD's domain-integrity signal
  family here; this source does not mention whois by name. [hunch]
- [[mcc-risk-scoring]]: a critical MCC mismatch sits in the same Critical tier
  as FSD in the draft taxonomy, so both feed the same "highest single signal"
  rule. [documented in this source]
- [[atlas-architecture]]: the application receiving FSD over CMP is the Atlas
  path; whether Atlas ingestion passes the finding through is the unverified
  step above. [hunch]

## Sources referenced but not read

Review
Workflows: Top to Bottom (CATS 4031382543); Merchant Onboarding Risk
Investigation Framework WIP (CATS 4052123651); FSD User Guide / Operational
Playbook (CATS 4031382553). Links are in the source file.
