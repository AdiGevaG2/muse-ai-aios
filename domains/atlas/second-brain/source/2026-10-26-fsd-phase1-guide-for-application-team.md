# FSD in Phase 1 - Guide for the Application Team

Raw capture. Do not edit.

- Source: Claude Doc, https://claude.ai/artifact/E1eRigJ5VVwct2iST1FGMW (tab 0ac34194-0f82)
- Author on byline: Gal Sahar. As-of date on byline: 2026-10-26. Later inline edits by a second editor (the "I think" phrasing, "(TBD)" heading suffix, open-question mentions).
- Captured: 2026-11-09, doc rev 137. Converted from doc XML to markdown; wording unchanged. Embedded journey diagram (two layout options) not captured.

---

## TL;DR

Front Site Detection (FSD) flags merchants whose website looks legitimate but who don't behave like a real business anywhere else. For Phase 1, Application needs to know three things:

1. **What arrives:** via the CMP, FSD returns a binary result (suspected front site, yes or no) plus a long, human-readable explanation of why.
2. **How serious it is:** an FSD finding is a critical, call-to-action signal meaning "review this merchant before activation or continuation". It is not informational.
3. **How to show it:** in Phase 1, I think it reasonable that FSD appears like every other finding, but with critical risk and visual highlighting or alerting. I think a dedicated FSD experience is a later-stage decision.

**Start with the [GTM Brief — Front-Site Detection (FSD)](https://g2rs.atlassian.net/wiki/spaces/CATS/pages/4031382506/GTM+Brief+-+Front-Site+Detection+FSD).** It is the primary source for this guide: what FSD offers, why it is a critical signal, and examples of the explainability text.

## What FSD is and why it matters

FSD identifies constructed fronts: merchants built to pass onboarding checks while hiding fraud, scams, laundering or other higher-risk activity. Traditional checks verify what a merchant claims; FSD checks whether the site acts, behaves and exists like a real business.

It combines three signal families, extracted with GenAI and weighed by ML models:

- **Behavioral signals** - is the content unique, is the business story consistent across the site, search results and legal pages, and does pricing make sense for the offering?
- **Domain integrity** - domain age, update patterns, registration horizon. Real businesses invest in their domain; fronts treat it as disposable.
- **Online presence** - reviews, directories, social profiles, external mentions. A "10-year leader" with no footprint is a contradiction.

**Value for the client**:

It catches what other controls miss, surfaces high-confidence risk **before activation**, and flags a **small, controlled set** of merchants (expected around 0.5% of a portfolio) instead of adding noise. Every finding comes with reasoning, so analysts understand *why*, not just *that*.

**How FSD differs from Transaction Laundering (TL)**

FSD answers "is this site a front?" from the site, its domain and its footprint.

TL asks "where does the money really come from?" and needs payment, traffic or network evidence to answer it.

A front site is often the vehicle for TL, scams or fraud, so a confirmed FSD is a strong reason to investigate TL, but it is not itself a TL verdict. Splitting FSD into sub-types such as FSD_TL and FSD_scams is on the roadmap (Q4-26 to Q1-27), not Phase 1.

**FSD is fast, targeted triage at the point of onboarding, while TL is a deep, continuous investigation of specific suspected networks.**

| | FSD | TL Monitoring offering (RIS/ compops) |
|---|---|---|
| **Purpose** | Onboarding screen | Ongoing monitoring |
| **Place in flow** | Upfront filtering before activation | Continuous, post-activation monitoring across the portfolio |
| **Depth** | Fast, targeted, high-precision triage | Deep investigation |
| **Approach** | Scalable model | Semi-automated, analyst-driven |
| **Target** | Low-hanging fruit, the worst offenders, cut at the start | Specific suspected TL networks |
| **Scale example** | ~100 flagged out of 10,000 uploaded sites | Focused on selected networks |
| **Known bads' source** | Association to known relevant Front Site merchants in our DB (Planned, not integrated) | Expands to the wild through active hunting |
| **Output** | Flags and Reasoning | Audit trail, stronger evidence, test transaction capabilities, mapped networks |

**What FSD is not:** an auto-block. It is designed to ensure the riskiest cases are never missed or delayed, and the expected action is manual review.

## How the signal arrives in Phase 1 (via CMP)

In Phase 1, Application receives FSD as a finding appended to the scan's findings on the CMP findings topic, alongside every other finding. The only result Application should treat as positive is a suspected front site; everything else is "no FSD finding".

The flow: after crawl and text extraction, the FSD worker runs (when the scan's `front_site_detection` flag is on), analyzes the homepage, and appends its result to the scan message published to `core-prod-fast-onboarding-findings`.

An illustrative positive finding on the CMP. It is assembled from the code inspection on the detection-logic page, not copied from a captured production message:

```json
{
  "finding_type": 18,
  "finding_sub_type": 389,
  "score": 80,
  "classifier_origin": 40,
  "culture": "N/A",
  "evidence_text": "<long, human-readable explanation>",
  "evidence_url": "https://example.com"
}
```

| Field | Status | Basis |
|---|---|---|
| `finding_sub_type: 389` | Known | Code: 389 is the suspected-front-site sub-type; other outcomes use 1012. |
| `score: 80` | Known | Code: 80 is the "suspected after threshold and business filters" outcome code. |
| `finding_type: 18` | Known | Code: CMP adds it to every FSD finding. |
| `classifier_origin: 40` | Known | Code: CMP adds it to every FSD finding. |
| `culture: "N/A"` | Known | Code: CMP adds it to every FSD finding. |
| `evidence_text`, `evidence_url` | Known names, placeholder values | Field names from the code; the values shown are dummies. |
| The object as one record | Deduced | The page lists the four service fields and the three CMP fields separately; we merged them. On the topic, the finding sits inside the scan message's findings array. |
| What reaches the UI | Not verified | Ingestion after CMP publishes, client filtering and rendering were not traced end to end. |

"Known" here means read from source code at the inspected revision (October 14, 2026), not observed in production traffic. To confirm, pull one real message from `core-prod-fast-onboarding-findings` for an FSD-enabled scan.

| Field | What Application should do with it |
|---|---|
| `finding_sub_type` = 389 with `score` = 80 | The binary "yes": suspected front site. Render as a critical finding. |
| Any other score (0–70) or sub-type 1012 | Not a positive FSD result. Do not render as an FSD finding in Phase 1. |
| `evidence_text` | The explainability. Show it in full on the finding / merchant view. |
| `evidence_url` | The analyzed page. Link to it and pair it with the page screenshot. |

The score is an outcome code, not a probability or confidence. Do not display it as a number to users.

**Explainability example.** The `evidence_text` is a paragraph, not a label, and is written for a risk analyst. For example:

> This tangible goods merchant has an isolated digital footprint and limited visibility across recognized validation channels. It further shows sub-par operational history and inconsistent policy compliance, confirming the entity's unsuitability for continued merchant services.

The UI therefore needs room for several sentences of text, not a one-line tooltip.

**No finding does not mean legitimate.** A site may have been skipped (offline, parked, excluded category), had missing data, or hit a processing error. Phase 1 UI should not show an "FSD: clear" or "verified" state.

## FSD is a critical signal

A positive FSD finding should carry the highest risk level the application shows. Phase 1 only releases findings at the "critical" grade (above 90% precision), so the binary "yes" already means high confidence.

What "critical" means for the user: **this merchant requires immediate review before activation or continuation.** The expected action is a manual review guided by the explanation, not an automatic decline.

In our draft risk-tier taxonomy, a high-confidence FSD sits in the Critical tier alongside a confirmed TL network, a direct link to a known-bad ring, prohibited content, and a critical MCC mismatch. The tier of a merchant is set by its highest single signal, so one FSD finding makes the merchant Critical.

The legacy MerchantView callback already labels it this way:

```json
{
  "findingRisk": "critical",
  "findingType": "suspected_front_site",
  "findingName": "Suspected Front Site",
  "findingCategory": "signals",
  "findingCategoryName": "Signals"
}
```

**Still to align:** how this maps onto Application's existing risk levels and scoring. Whatever the mapping, the requirement is that an FSD finding never sits below other findings in severity or visibility. A future "Suspected FSD" level would map to High, one step below.

## How FSD should appear in Phase 1 (TBD)

In Phase 1, FSD is shown like every other finding, using the existing findings model, plus two additions: critical risk and visual emphasis. No dedicated FSD screen is required to launch.

Requirements for the portfolio / queue view:

- The merchant or URL row shows an FSD indicator (for example, a "Suspected Front Site" chip) next to its other signals.
- The row's overall risk shows as Critical and sorts and filters with other critical merchants.
- The indicator is visually emphasized (color, icon) so it answers "why should I click?" without opening the merchant.
- Alerting: an FSD finding triggers whatever notification the application uses for critical findings.

Requirements for the finding itself:

- Name: "Suspected Front Site", category Signals, risk Critical.
- The full `evidence_text` is visible on the finding, not truncated behind a hover.
- The evidence (analyzed URL and its screenshot) is never more than one click away.

Three principles from the review-workflow thinking doc apply: the URL is the unit of truth (FSD is an attribute of it), signals must be comparable side by side, and evidence is always reachable.

## User journey: from a flagged merchant to the evidence

When a user clicks a URL, violation or merchant flagged by FSD, they should land on one page that shows the page screenshot, the FSD reasoning below it, and any other violations on the same URL. Whether that page is a dedicated finding page or the single merchant view is for Application PM and Design to confirm.

[Embedded diagram: "FSD user journey · portfolio to evidence, two layout options" - not captured]

Option B fits the review-workflow model (the URL is the unit of truth, FSD is one of its signals) and needs no new screen; Option A gives FSD more room once its reasoning becomes structured. In both, the screenshot and reasoning are visible without further clicks, and breadcrumbs lead back from evidence to finding, merchant and portfolio.

## Later stages: a dedicated FSD experience?

Whether FSD gets its own treatment beyond Phase 1 is open, and depends on how the signal grows. The roadmap points to more structure behind the single binary:

- **A second level, "Suspected FSD"** (High risk), alongside today's critical-only output.
- **Sub-types** that say what the front is hiding, such as FSD_TL and FSD_scams (Q4-26 to Q1-27).
- **Structured reasoning** instead of one paragraph: the contributing signals (footprint, domain integrity, content consistency, pricing) shown as separate, evidenced items.
- **A post-FSD workflow:** the operational playbook's review steps (for example, cross-checking KYB data against the finding) and client-side actions.
- **Feeding a broader Scams solution** (2027).

Once these exist, a dedicated FSD section or page becomes more useful than a single finding row. Until then, the generic finding pattern with critical emphasis is enough.

## Open questions for Application PM and Design

- [ ] When a user clicks an FSD-flagged URL, does it open a dedicated finding page or the single merchant view? (@Dana Fridman)
- [ ] How does "critical" map onto Application's existing risk levels and overall merchant score?
- [ ] Which alert or notification fires for a critical FSD finding, and to whom?
- [ ] Does FSD come with the URL homepage screenshot? @Yonatan Eisenberg
- [ ] How much of the `evidence_text` is shown by default, and is there a max length to design for?
- [ ] What/Do we expose any analyst actions on the finding in Phase 1 (review, override, notes)?
- [ ] End-to-end checks: When can we test that a CMP FSD finding can be traced through ingestion into the UI? The service publishes it, but downstream filtering and rendering are not yet verified.

## References

- [GTM Brief — Front-Site Detection (FSD)](https://g2rs.atlassian.net/wiki/spaces/CATS/pages/4031382506/GTM+Brief+-+Front-Site+Detection+FSD) — primary source: offering, critical-signal positioning, explainability examples. Read this first.
- [FSD Current Detection Logic and Integration in Legacy Core and CMP](https://g2rs.atlassian.net/wiki/spaces/CATS/pages/4349263873/FSD+Current+Detection+Logic+and+Integration+in+Legacy+Core+and+CMP) — CMP contract, output fields, score codes.
- [Review Workflows: Top to Bottom](https://g2rs.atlassian.net/wiki/spaces/CATS/pages/4031382543/Review+Workflows+Top+to+Bottom+--+enable+MCC+and+FSD+Integration+in+Risk+Analysis) — portfolio and merchant view structure.
- [Merchant Onboarding Risk Investigation Framework (WIP)](https://g2rs.atlassian.net/wiki/spaces/CATS/pages/4052123651/Merchant+Onboarding+Risk+Investigation+Framework+Workflow+and+Signal+Analysis+Towards+Packaging+WIP) — draft risk-tier taxonomy.
- [FSD User Guide / Operational Playbook](https://g2rs.atlassian.net/wiki/spaces/CATS/pages/4031382553/FSD+User+Guide+Operational+Playbook) — review steps after an FSD finding.
