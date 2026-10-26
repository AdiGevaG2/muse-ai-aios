# G2RS solution suite

The four business lines G2RS sells and the named products under each, as stated
in the 2024 corporate overview deck. This is the company's own commercial
taxonomy — useful for placing any feature request inside a business line.

Source: [2026-08-30-g2rs-overview-decks.md](../source/2026-08-30-g2rs-overview-decks.md)
(slides 6–8, 12, 26). Deck is ©2024 and predates the Oct 2025 EverC acquisition.

## The four lines

[documented] G2RS sells four lines, each to a distinct buyer:

| Line | Buyer | Promise |
|---|---|---|
| **Merchant Risk** | Merchant acquirers and payments providers | Avoid fines, reputational damage, and missed growth |
| **Digital Commerce Risk** | Online platforms | Grow while keeping platform trust and safety |
| **Bankruptcy Risk** | Lenders and creditors | Increase recoveries, cut operational load |
| **Identity Verification** | Banking and financial services | Automate checks, streamline onboarding, reduce fraud |

[documented] Each line traces to a predecessor company: Merchant + Digital
Commerce Risk "powered by G2" (G2 Web Services), Bankruptcy Risk "powered by
G2BRS" (Lundquist/LCI), Data and Regulatory "powered by Fintellix". This matches
the three-company TransUnion sale recorded in
[company.md](../context/company.md#history). Identity Verification is the fourth
line and is *not* attributed to any of the three in the deck — consistent with it
arriving via ZignSec/WebShield rather than the original acquisition.

> **Note the count mismatch.** The customer slides list four lines but omit Data
> and Regulatory; the solution-suite slides list four lines and substitute
> Identity Verification for Data and Regulatory. Only the "uniting G2, G2BRS,
> Fintellix" slide shows all five buckets together. [hunch] Data and Regulatory
> is presented as a separate section rather than a customer-facing "line" in this
> deck's structure.

## Merchant Risk

[documented] Core products:
- **Global Onboarding** — detect violating merchants before they board
- **Persistent Merchant Monitoring** — monitor merchant websites globally for
  non-compliant, illegal, and brand-damaging content
- **Transaction Laundering Detection** — identify illegal payments processing
  operations among monitored merchants

[documented] Primary add-ons: Change Detection, CBD Monitoring, KYC Automation,
Malware Monitoring, **Merchant MCC Check**, Reputation Monitoring, WebID.

[documented] A second slide (12) frames the same portfolio by lifecycle stage
rather than by product tier, and introduces three names absent from the suite
slide: **Compass Score®** and **Portfolio Acquisition Review** (onboarding),
**Brand Detection** (monitoring), and **E-commerce Detection** (add-on).

| Stage | Products |
|---|---|
| Onboarding | Global Onboarding, Compass Score®, Portfolio Acquisition Review |
| Monitoring | Persistent Merchant Monitoring, Transaction Laundering Detection, Reputation Monitoring, Brand Detection, Change Detection |
| Add-on services | CBD Risk Management, E-commerce Detection, Merchant MCC Check, Web ID |

See [g2rs-merchant-risk-products.md](g2rs-merchant-risk-products.md) for the
reconciled product list and the naming inconsistencies between these two slides.

## Digital Commerce Risk

[documented] Products: **Marketplace Monitoring** (illegal and policy-violating
products), **Ad Monitoring** (problematic content and violating advertisers),
**License Verification** (high-risk advertisers hold required licensure).
Add-ons: Health Insurance, Providers Certification, Financial Services
Verification.

[documented] Differentiators claimed: integrated intelligence (AI/ML + human
expertise), regulatory insights (country-specific compliance teams), content
knowledge (20 years across high-risk verticals), flexible/configurable solutions.

> **Conflict with existing org context.** [company.md](../context/company.md)
> describes Digital Commerce Risk as "ex-EverC: marketplace/seller monitoring,
> counterfeit/hazardous/illegal/recalled product detection, multi-modal AI." This
> 2024 deck presents Digital Commerce Risk as a G2-powered line with Marketplace
> Monitoring, Ad Monitoring, and License Verification — no EverC involvement.
> [inference] Both are true at different times: G2RS had its own Digital Commerce
> Risk line before acquiring EverC (Oct 2025), and the EverC capability was
> folded into that existing line rather than creating one. This matters directly
> for [[atlas-consolidation-context]] — the overlap is not merely
> "merchant monitoring exists in both stacks," it is that **marketplace
> monitoring also existed in both stacks**. Confirm which system is canonical
> before writing a PRD against either.

## Bankruptcy Risk

[documented] Products: Bankruptcy Notifications, Bankruptcy Case Search (a
"PACER replacement"), Docket Event Monitoring, Automated Court Doc Filing.
Add-ons: Payment Applications and Claims Tracking, Electronic Bankruptcy
Notification+, Consumer Identification Services.

[documented] The technology slide names five capability areas with claimed
outcomes: Online Case Search (25–60% cost reduction vs PACER), Portfolio
Monitoring (>$5T client accounts monitored), Case Monitoring (workflow-driven
docket event queues), Electronic Filing (94 BK courts), Payment Management (66%
reduction in manual processes).

[documented] Marked "not in focus" in current org context — see
[company.md](../context/company.md#explicitly-not-in-focus-deprioritized).
Recorded here for completeness, not as active roadmap.

## Identity Verification

[documented] Products: ID and Biometric Verification (document scans, facial
biometrics, liveness detection), PEP/Sanctions/Adverse Media Checks, Document
Forensics (AI-powered detection of forged or tampered documents), Identity Data
Verification, Electronic Identification.

[documented] Also marked "not in focus" (ZignSec lineage) in current org context.

## Data and Regulatory (Fintellix)

[documented] Four solution families on a single **G2RS Data Platform** (web UI +
API): regulatory reporting, credit risk (IFRS 9 ECL computation, AI/ML Early
Alert borrower risk, non-performing asset management), data management (data
governance, self-service ad-hoc BI), and supervisory solutions for regulators
themselves.

[documented] Platform pipeline stages, in the deck's own branding: Collect →
Purify → Synergize → Energize → Analyze → Communicate. Deployable on-premise or
cloud, multi-tenant, RDBMS/NoSQL/file data stores.

[documented] Claimed experience: 50+ financial and regulatory institutions;
300+ person-years of relevant expertise.

[documented] Also "not in focus" per current org context.

## Why this page matters for Atlas

The suite here is the **pre-EverC** commercial surface. Anything
[[atlas-consolidation-context]] must reconcile has a legacy G2RS name
on this page and, often, a second ex-EverC name for the overlapping capability.
Use this page to check whether a "new" feature is actually a rename of something
G2RS already sold.

Related: [[g2rs-positioning-and-differentiators]],
[[g2rs-scale-and-performance-claims]], [[g2rs-merchant-risk-products]],
[[atlas-consolidation-context]]
