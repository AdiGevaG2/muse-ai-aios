# Merchant Risk product list — reconciled

The single hardest thing to pin down in G2RS material is **what the merchant-risk
products are actually called**. The 2024 overview deck names them two different
ways on two adjacent slides. This page reconciles them so a PRD can use one name
consistently.

Source: [2026-08-30-g2rs-overview-decks.md](../source/2026-08-30-g2rs-overview-decks.md)
(slides 7, 8, 12, 13), cross-checked against
[company.md](../context/company.md) and [g2rs-terms.md](../glossary/g2rs-terms.md).

## The two lists

**Slide 8 — "solution suite details"** organises by tier (core product vs primary
add-on):

> Core: Global Onboarding, Persistent Merchant Monitoring, Transaction Laundering
> Detection.
> Add-ons: Change Detection, CBD Monitoring, KYC Automation, Malware Monitoring,
> Merchant MCC Check, Reputation Monitoring, WebID.

**Slide 12 — "How G2RS can help"** organises by merchant lifecycle stage:

> Onboarding: Global Onboarding, Compass Score®, Portfolio Acquisition Review.
> Monitoring: Persistent Merchant Monitoring, Transaction Laundering Detection,
> Reputation Monitoring, Brand Detection, Change Detection.
> Add-ons: CBD Risk Management, E-commerce Detection, Merchant MCC Check, Web ID.

## Reconciled product list

[documented] Products confirmed by both slides:

| Product | Lifecycle stage | Notes |
|---|---|---|
| **Global Onboarding** | Onboarding | Detect violating merchants before they board. |
| **Persistent Merchant Monitoring** (PMM) | Monitoring | Monitor merchant websites globally for non-compliant, illegal, brand-damaging content. |
| **Transaction Laundering Detection** (TLD) | Monitoring | Identify illegal payments processing operations. |
| **Reputation Monitoring** | Monitoring (slide 12) / add-on (slide 8) | Tier is inconsistent between slides. |
| **Change Detection** | Monitoring (slide 12) / add-on (slide 8) | Same inconsistency. |
| **Merchant MCC Check** | Add-on | Both slides agree it is an add-on. |

[documented] Products named on **only one** slide:

| Product | Appears on | Note |
|---|---|---|
| **Compass Score®** | Slide 12 only | Registered trademark, onboarding stage. Absent from the suite slide entirely. |
| **Portfolio Acquisition Review** | Slide 12 only | Onboarding stage. |
| **Brand Detection** | Slide 12 only | Monitoring stage. A standalone "G2RS Brand Detection Overview.pptx" exists in SharePoint — this is a real product with its own sales collateral, not a slide-only phrase. |
| **E-commerce Detection** | Slide 12 only | Add-on. |
| **KYC Automation** | Slide 8 only | Add-on. |
| **Malware Monitoring** | Slide 8 only | Add-on. |

## Naming inconsistencies to resolve

[documented] The same capability appears under different names across the two
slides. These are almost certainly the same thing:

- **WebID** (slide 8) vs **Web ID** (slide 12) — spacing only. Pick one.
- **CBD Monitoring** (slide 8) vs **CBD Risk Management** (slide 12) — [inference]
  same add-on, differently framed. "Risk Management" implies a broader scope than
  "Monitoring"; the deck does not say which is canonical.

[hunch] The two slides are likely maintained by different teams — slide 8 reads as
a product-marketing packaging view (what's in the SKU, what's an upsell), slide 12
as a sales-conversation view (where in the merchant lifecycle each thing helps).
Neither is authoritative over the other. **Before naming a merchant-risk product
in a spec, check the current product-marketing source rather than either slide.**

## Transaction laundering — the illustrated mechanism

[documented] The deck illustrates TLD with a worked example: a merchant
("RAD Advizers") applies with **no URL provided**; a G2RS expert analyst links it
to `radadvizers.us`; that domain shares **registrant data** with a known
launderer already on the Merchant Map®; the merchant is placed in a transaction-
laundering ring associated with DEA-scheduled drugs.

[inference] Three things this reveals about how the product actually works:
1. The detection unit is a **ring**, not a merchant — the value is graph
   connectivity, not per-merchant scoring.
2. **Shared registrant data** is a primary linking signal. WHOIS-style
   infrastructure attribution, not content analysis, closes this case.
3. A **human analyst** performs the URL discovery step. This is the
   "minds and machines" claim from
   [[g2rs-positioning-and-differentiators]] made concrete — the automated system
   did not have the URL at all.

This is the same graph/network-effect moat described for the Merchant Map® in
[company.md](../context/company.md#the-merchant-map-moat) and in
[g2rs-terms.md](../glossary/g2rs-terms.md), shown end to end rather than asserted.

Directly relevant to the connected-sites work in this workspace — the
registrant-data-as-link-signal mechanism is the same primitive a connected-sites
graph would implement.

Related: [[g2rs-solution-suite]], [[g2rs-positioning-and-differentiators]],
[[atlas-consolidation-context]]
