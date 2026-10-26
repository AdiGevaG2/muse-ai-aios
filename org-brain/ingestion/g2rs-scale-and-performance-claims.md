# G2RS scale and performance claims

Every quantified claim G2RS makes about itself in the 2024 corporate overview,
with its exact wording and what it does and does not mean. Use this before
quoting any G2RS number in a PRD, business case, or customer-facing artifact.

Source: [2026-08-30-g2rs-overview-decks.md](../source/2026-08-30-g2rs-overview-decks.md)
(slides 9, 16–18, 23). ©2024 deck; figures are 2023–2024 vintage.

> **These are marketing figures, not measured metrics.** They are [documented] in
> the sense that G2RS published them — not in the sense that anyone has verified
> the definition, population, or denominator behind them. None carries a stated
> methodology. Per the workspace evidence rules, **do not use any number here as
> a baseline.** Pull baselines from Mixpanel/Coralogix/Looker instead. These are
> useful for knowing what the company claims publicly, and for spotting when a
> product metric would contradict the corporate story.

## Merchant and Digital Commerce Risk

| Claim | Stated as | Caveat |
|---|---|---|
| $2.56B in potential fines and operational costs saved for clients | in 2023 | "Potential" — a modelled avoidance figure, not realised savings. No methodology given. |
| 5M content violations reported | all time | Cumulative since inception; not comparable to any annual rate. |
| 40.5B pages monitored | yearly | Pages, not merchants or sites. A scanning-volume figure. |
| 20+ years of merchant data | — | Matches the Merchant Map® tenure in [company.md](../context/company.md#the-merchant-map-moat). Consistent. |

## Bankruptcy Risk

| Claim | Stated as | Caveat |
|---|---|---|
| 99.9997% accuracy, "never miss a bankruptcy" | — | Accuracy against what denominator is unstated. The strongest claim in the deck and the least specified. |
| 29 years of bankruptcy filing data | — | Slide 16 separately says "30+ years" of consumer credit insight and "30+ years" of experience. [inference] 29 = the data archive; 30+ = the company's operating history. Not a contradiction, but do not merge them. |
| 20M+ docket events collected and categorized | yearly | — |
| 121M+ bankruptcy notices delivered to clients | yearly | — |
| 800M accounts, 30M archived bankruptcies | database size | — |
| >$5T client accounts monitored for bankruptcies | — | Portfolio value under monitoring, not revenue. |
| Partnered with 6 of the top 10 financial institutions | — | — |
| +95% customer retention, +90 NPS | — | No period or population stated. |
| 25–60% cost reduction vs PACER | Online Case Search | Range, not a point estimate. |
| 66% reduction in manual processes | Payment Management | — |
| 94 BK courts with unique requirements | Electronic Filing | Coverage count, not a performance figure. |
| ~90% of irrelevant docket events filtered out | one named client outcome | A single case-study result, not a product-wide figure. |

[documented] Compliance and operating posture claimed for this line: 100%
domestically based (no offshore outsourcing), PCI/CISP compliant, SAE 18 Type II
audit compliance, weekly bankruptcy statistics package.

## Identity Verification

| Claim | Stated as | Caveat |
|---|---|---|
| 2 million verifications per month | — | — |
| ISO 27001:2022 certified | — | The only formal certification claimed anywhere in the deck for this line. |
| 99.7% uptime "and above" | — | Below a typical enterprise 99.9% SLA. Worth noting if uptime ever becomes a Atlas commitment. |
| 15,000+ identity documents supported | — | — |
| 50+ countries with identity data sources | — | — |
| 1000+ global PEP/Sanction data sources | — | — |
| "Instant onboarding" | — | Listed as an accomplishment. [company.md](../context/company.md#explicitly-not-in-focus-deprioritized) records Instant Onboarding (sub-15-second decisioning) as **deprioritized**. The deck predates that decision; the deck is not current on this point. |

## Data and Regulatory

[documented] 50+ financial and regulatory institutions implemented; 300+
person-years of relevant expertise across risk/regulatory, banking, and product
consulting.

## The four "previous vendor" case studies

[documented] The bankruptcy section runs four anonymised displacement stories —
the only competitive comparison anywhere in the deck. All four follow the same
shape: named-tier client, quantified previous-vendor failure, business
consequence, G2RS outcome.

- **Top 3 credit bureau** — 7.54% of bankruptcy records had incorrect status →
  lost clients, brand damage, threat of lawsuits.
- **Top 5 mortgage servicer** — of 16,000 bankruptcies, 2,200 false positives and
  2,800 missed → lost recoveries, compliance issues, manual system-of-record
  correction.
- **Top 5 debt buyer** — vendor failed to notify of 443,000+ bankruptcies and
  46,000 deceased hits → missed Bar Dates, decreased recoveries, automatic-stay
  violation lawsuits.
- **Top 3 enterprise bank** — only ~70 docket event categories left significant
  noise → ongoing FTE cost to manually review relevance.

[inference] All four failures are **data quality failures, not feature gaps** —
false positives, false negatives, wrong status, insufficient categorisation. The
implied competitive thesis for the whole company is that in risk monitoring,
precision and recall *are* the product. That is a direct argument for treating
detection quality as a first-class product metric in
[[atlas-consolidation-context]], and it is why an
[[ai-eval]]-style accuracy bar matters more here than in most products.

[inference] The mortgage-servicer figures are the most useful of the four: 2,200
false positives and 2,800 missed out of 16,000 implies a competitor running at
roughly 82% recall and 88% precision. [hunch] If that is representative of the
displaced field, it sets a rough sense of the accuracy floor a risk-monitoring
product has to clear to be credible — well below anything G2RS would ship, but
useful as a "what bad looks like" anchor.

## Claims that conflict with current org context

1. **"Instant onboarding" as an accomplishment** vs. Instant Onboarding
   deprioritized (2026 business-context brief). The brief is newer and wins.
2. **78 countries of presence** vs. 50+ countries of partner FIs. Different
   measures — see [[g2rs-positioning-and-differentiators]].
3. **Bankruptcy, Identity, and Data/Regulatory all carry heavy scale claims** in
   this deck, yet all three are "not in focus" per current org context. The deck
   describes a company with four-plus healthy lines; current strategy concentrates
   on two. [inference] Do not read deck prominence as current investment priority.

Related: [[g2rs-solution-suite]], [[g2rs-positioning-and-differentiators]],
[[atlas-consolidation-context]]
