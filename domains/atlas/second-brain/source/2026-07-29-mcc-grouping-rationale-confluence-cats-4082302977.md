# Source: MCC Grouping Rationale: Stand-Alone Risky Codes and Design Principles

- Origin: Confluence, space `CATS` ("K9"), page 4082302977
- URL: https://g2rs.atlassian.net/wiki/spaces/CATS/pages/4082302977/MCC+Grouping+Rationale+Stand-Alone+Risky+Codes+and+Design+Principles
- Author: Gal Sahar
- Last modified: Jul 29, 2026
- Retrieved: 2026-09-02
- Raw, unedited body below.

---

# Our MCC Grouping - Rationale

## What it is

* 39 business-level groups covering the full MCC space (Fashion, Travel, Health, Money and Financial Services, ...)
* \~18 **stand-alone risky MCCs**, each its own "group"
* One exception: 5 gambling codes fold into a single **Gambling** group

## Design principles

| Principle | Meaning | Effect on scoring |
| --- | --- | --- |
| Groups = business-equivalence, not risk | Same business at different granularity (5611 men's vs. 5651 family apparel) | Same-group mismatch = noise, no risk; cross-group = real signal |
| Risky MCCs stand alone | Each carries its own regulatory burden (registration, licensing, monitoring) | Any drift in/out of these codes is visible as a mismatch |
| Gambling folds into one group | Card brands treat all gambling codes as one activity; codes indicate licensure flavor | No false alarms between lottery/casino/racing codes |
| Brand ranges fold into parent | Airline (3000–3299), hotel (3501+), car-rental (3351+) codes identify a _brand_, not a business | "United (3000)" vs. generic airline (4511) is not a mismatch |
| Risk tier per MCC, inherited by group | Tiering is orthogonal to grouping | Outlier codes score correctly without restructuring groups |

## The stand-alone risky MCCs

| MCC | Description | Network context |
| --- | --- | --- |
| 7995 | Wagering and Betting | VIRP Tier 1 — **Gambling group** |
| 7800 | Government Owned Lottery | VIRP Tier 1 — **Gambling group** |
| 7801 | Gov-Licensed Casinos (Online Gambling) | VIRP Tier 1 — **Gambling group** |
| 7802 | Gov-Licensed Horse/Dog Racing | VIRP Tier 1 — **Gambling group** |
| 9406 | Gov-Owned Lottery (non-US) | VIRP Tier 1 — **Gambling group** |
| 7273 | Dating Services | VIRP Tier 1 |
| 5912 | Drug Stores and Pharmacies | VIRP Tier 1 |
| 5122 | Drugs, Proprietaries, Sundries | VIRP Tier 1 |
| 4816 | Computer Network Services | Tier 1-adjacent (historic adult-content family) |
| 7841 | Video Entertainment Rental | Tier 1-adjacent (historic adult-content family) |
| 6051 | Quasi Cash (Non-FI) | VIRP Tier 2 — crypto onramp |
| 5816 | Digital Goods — Games | VIRP Tier 2 — skill-based games |
| 6012 | FI — Merchandise/Services, Debt Repayment | Tier 2 — financial harm |
| 6211 | Securities Brokers/Dealers | VIRP Tier 3 — trading platforms |
| 5966 | Outbound Telemarketing | VIRP Tier 3 |
| 5967 | Inbound Teleservices | VIRP Tier 3 (+ adult audio/videotext) |
| 5968 | Continuity/Subscription | VIRP Tier 3 — negative-option billing |
| 5993 | Cigar Stores and Stands | VIRP Tier 3 — tobacco |

## Why it's good

* **Speaks the networks' language.** The stand-alone set maps almost one-for-one to Visa VIRP registration tiers and Mastercard BRAM categories. A cross-group move into/out of a stand-alone code = a registration obligation appearing/disappearing — exactly the miscoding networks fine acquirers for.
* **Right shape for scoring.** Group answers "same business?", per-MCC tier answers "how risky?". Keeping them orthogonal keeps the mismatch lattice simple.
* **Noise-resistant.** Granularity artifacts (sibling codes, brand codes) never fire alarms; every alarm that fires is a cross-business move.

## Known Open Questions on Refinements - risky codes (In otherwise benign groups - Should we treat them differently?)

| MCC | Description | Currently in | Should be |
| --- | --- | --- | --- |
| 4829 | Wire Transfer Money Orders | Telecommunication | High / stand-alone (quasi-cash) |
| 6540 | POI Funding / Stored Value | Money and Financial Services | High (crypto onramp, VIRP Tier 2) |
| 5933 | Pawn Shops | Antiques and Second Hand | Elevated (AML profile) |
| 9223 | Bail and Bond Payments | Legal and Finance | Elevated (commonly restricted) |
| 5921 | Beer/Wine/Liquor Stores | Food and Beverage | Medium (age-restricted) |

Fix = re-tier these MCCs; no group restructuring needed (tiering is per-MCC).
