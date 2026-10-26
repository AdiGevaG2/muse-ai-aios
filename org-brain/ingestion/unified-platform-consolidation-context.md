# What the 2024 overview tells us about Atlas consolidation

A synthesis page, not a source summary. The 2024 corporate deck is a **snapshot
of G2RS's product surface immediately before the EverC acquisition** — which makes
it the cleanest available answer to "what did the legacy G2RS stack actually
sell?" That question is the starting point for every consolidation decision.

Sources: [2026-08-30-g2rs-overview-decks.md](../source/2026-08-30-g2rs-overview-decks.md)
(©2024), read against [company.md](../context/company.md) (2026-06-22 brief) and
[everc.md](../context/everc.md).

## Why a 2024 deck is useful in 2026

[documented] The deck is copyright 2024 and cites 2023 figures. EverC closed
**Oct 6, 2025**. So the deck contains **zero EverC content** — every product on
it is legacy G2RS, G2BRS, or Fintellix.

[inference] That makes it a natural "before" picture. Anything on this deck that
also exists in the ex-EverC stack is a genuine overlap requiring a consolidation
decision. Anything on this deck with no EverC counterpart carries over unchanged.
Anything in the EverC stack absent here is net-new capability G2RS acquired.

## The overlap that matters most

[inference] The current org context frames the overlap as "merchant monitoring
exists in both stacks." The deck shows the problem is **larger than that**:

| Capability | Legacy G2RS (this deck) | Ex-EverC | Overlap? |
|---|---|---|---|
| Merchant website monitoring | Persistent Merchant Monitoring | merchant monitoring | **Yes** — already flagged in [company.md](../context/company.md#product-portfolio-in-focus) |
| **Marketplace / seller monitoring** | **Marketplace Monitoring** (Digital Commerce Risk) | marketplace/seller monitoring, multi-modal AI | **Yes — not previously flagged** |
| Merchant onboarding | Global Onboarding, Compass Score® | (EverC onboarding surface) | Likely |
| Transaction laundering | Transaction Laundering Detection | [documented] noted as more G2RS than EverC | Mostly G2RS |
| Zero-integration dashboard | — | Smart Scan | EverC-native, no G2RS counterpart |
| Ad Monitoring, License Verification | Yes | — | G2RS-only |

> **This corrects an incomplete picture.** [company.md](../context/company.md)
> describes Digital Commerce Risk as the division "housing the ex-EverC
> marketplace-monitoring capability," which reads as though DCR *is* the EverC
> line. The 2024 deck shows Digital Commerce Risk existed as a G2RS line with its
> own Marketplace Monitoring product **before EverC was acquired**. EverC was
> folded into an existing line, not given a new one.
>
> Consequence: marketplace monitoring is a **two-system overlap** on the same
> footing as merchant monitoring, and needs the same canonical-system decision.
> [inference] — the deck establishes G2RS had the product; it does not establish
> which system won post-merger. **Confirm with product before building on either.**

## Capabilities with no EverC counterpart (safe to carry forward)

[inference] From the deck, these are legacy-G2RS-only and should not need a
consolidation decision — they only need a migration plan:

- **Ad Monitoring** and **License Verification** (Digital Commerce Risk) — no
  EverC equivalent recorded anywhere in org context.
- **Transaction Laundering Detection** — [documented] as more a G2RS capability
  than an EverC one.
- The merchant-risk add-on catalogue: Change Detection, CBD Monitoring, KYC
  Automation, Malware Monitoring, Merchant MCC Check, Reputation Monitoring,
  WebID, E-commerce Detection, Brand Detection, Compass Score®, Portfolio
  Acquisition Review. See [[g2rs-merchant-risk-products]] for the reconciled list
  — note that list is itself internally inconsistent, so the migration inventory
  is not yet reliable.

[hunch] The add-on catalogue is the most likely place for consolidation scope to
be underestimated. Eleven named add-ons is a long tail, each presumably with
configuration, entitlement, and billing surface. The deck treats them as
one-line bullets; a platform migration cannot.

## What is out of scope by strategy, not by architecture

[documented] Bankruptcy Risk, Identity Verification, and Data and Regulatory
occupy the majority of the full deck and carry substantial scale claims (see
[[g2rs-scale-and-performance-claims]]) — yet all three are "not in focus" per the
2026 business-context brief.

[inference] These lines are **live businesses that are not consolidation targets**.
The distinction matters: "not in focus" is a strategic investment decision, not a
statement that the products are dead or that their users disappear. A Unified
Platform scope statement should say so explicitly rather than leaving readers to
infer the four lines collapse into one platform. They do not — UP is the merchant
+ digital commerce surface.

## Product constraints the deck implies

[inference] Three things the corporate narrative constrains, which a UP spec
should respect or explicitly argue against:

1. **Human-in-the-loop is a claimed differentiator, not overhead.** The
   "minds and machines" pillar and the analyst step in the transaction-laundering
   example (see [[g2rs-merchant-risk-products]]) both position expert review as
   the reason accuracy is trusted. A consolidation that removes analyst review to
   cut cost trades directly against the stated moat. That may still be right —
   but it is a positioning change, not just an efficiency change.

2. **Detection quality is the competitive axis.** All four bankruptcy displacement
   case studies are false-positive / false-negative / miscategorisation failures
   (see [[g2rs-scale-and-performance-claims]]). [inference] Precision and recall
   are what customers switch vendors over. A UP migration that preserves every
   feature but degrades detection quality has failed, even if the feature matrix
   is complete.

3. **Configurability is promised repeatedly.** "Configured to meet client needs,"
   "configurable solutions to suit your platform's needs," "UI-driven flexible
   solutions with limited IT needs," "Reputation Monitoring configured based on
   the risks you need to monitor." [inference] Per-client configuration is a
   standing expectation across every line. A unified platform that standardises
   behaviour across clients will hit this — the migration surface includes each
   client's existing configuration, not just each product.

## Open questions this deck raises but cannot answer

- Which system is canonical for **marketplace monitoring** post-merger?
- Which system is canonical for **merchant monitoring** post-merger? (Already
  open in [company.md](../context/company.md); unchanged.)
- Are the eleven merchant-risk add-ons all still sold, and which are in UP scope?
- Is **Compass Score®** in UP scope? It is trademarked and onboarding-critical
  but appears on only one slide of the deck.
- What are the real names? See [[g2rs-merchant-risk-products]] — the deck
  contradicts itself on tier and spelling.

Related: [[g2rs-solution-suite]], [[g2rs-merchant-risk-products]],
[[g2rs-positioning-and-differentiators]], [[g2rs-scale-and-performance-claims]]
