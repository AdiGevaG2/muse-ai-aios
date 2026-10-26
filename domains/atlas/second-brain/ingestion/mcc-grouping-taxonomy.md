# MCC Grouping Taxonomy

The reference data under MCC mismatch scoring: 39 business-equivalence groups
plus ~18 risky codes held deliberately alone, so that "same business?" and "how
risky?" stay separate questions. This is the *grouping* half; [[mcc-risk-scoring]]
is the interpretation half that consumes it.

Sources: `source/2026-07-29-mcc-grouping-rationale-confluence-cats-4082302977.md`
(Confluence `CATS`/K9 page 4082302977, Gal Sahar, modified 2026-07-29) for the
rationale; `source/2026-09-06-mcc-groups-mapping-xlsx.md` (Gal Sahar's
workbook) for full membership.

## Shape of the taxonomy

- **39 business-level groups** span the full MCC space — Fashion, Travel,
  Health, Money and Financial Services, and so on. [documented]
- **~18 stand-alone risky MCCs**, each its own single-member group.
  [documented]
- **One deliberate exception:** five gambling codes (7995, 7800, 7801, 7802,
  9406) fold into a single **Gambling** group rather than standing alone.
  [documented]

## The five design principles

| Principle | What it means | Scoring consequence |
|---|---|---|
| Groups encode business-equivalence, not risk | 5611 men's apparel and 5651 family apparel are the same business at different granularity | Same-group mismatch is noise; cross-group is real signal |
| Risky MCCs stand alone | Each carries its own regulatory burden — registration, licensing, monitoring | Any drift into or out of these codes surfaces as a mismatch |
| Gambling folds into one group | Card brands treat all gambling as one activity; the separate codes only indicate licensure flavour | No false alarms between lottery, casino and racing codes |
| Brand ranges fold into their parent | Airline 3000–3299, hotel 3501+, car-rental 3351+ identify a *brand*, not a business | "United (3000)" vs. generic airline (4511) is not a mismatch |
| Risk tier is per-MCC, inherited by the group | Tiering is orthogonal to grouping | An outlier code can be re-tiered without restructuring any group |

All five are [documented] from the page. The last one is the load-bearing one
for maintenance: **the fix for a mis-tiered code is a re-tier, never a
regrouping.**

## The stand-alone risky set

Grouped by the network tier the page assigns. The Gambling five are listed
under Tier 1 but share one group, not five.

| Tier | MCCs |
|---|---|
| VIRP Tier 1 — Gambling group | 7995 Wagering/Betting · 7800 Gov-owned Lottery · 7801 Gov-licensed Casinos (online) · 7802 Gov-licensed Horse/Dog Racing · 9406 Gov-owned Lottery (non-US) |
| VIRP Tier 1 — own group each | 7273 Dating Services · 5912 Drug Stores and Pharmacies · 5122 Drugs, Proprietaries, Sundries |
| Tier 1-adjacent (historic adult-content family) | 4816 Computer Network Services · 7841 Video Entertainment Rental |
| VIRP Tier 2 | 6051 Quasi Cash (non-FI, crypto onramp) · 5816 Digital Goods — Games (skill-based) · 6012 FI merchandise/services, debt repayment (financial harm) |
| VIRP Tier 3 | 6211 Securities Brokers/Dealers · 5966 Outbound Telemarketing · 5967 Inbound Teleservices (+ adult audio/videotext) · 5968 Continuity/Subscription (negative-option billing) · 5993 Cigar Stores and Stands |

[documented] throughout. Note 6012 is tiered "Tier 2" without the VIRP prefix
the others carry — treat the framework attribution there as unconfirmed.

## Why this shape was chosen

- **It speaks the card networks' language.** The stand-alone set maps close to
  one-for-one onto Visa VIRP registration tiers and Mastercard BRAM categories.
  A cross-group move into or out of a stand-alone code therefore means a
  *registration obligation appearing or disappearing* — precisely the miscoding
  networks fine acquirers for. [documented]
- **It keeps the scoring lattice simple.** The group answers "same business?";
  the per-MCC tier answers "how risky?". Holding those orthogonal is what lets
  [[mcc-risk-scoring]] run two independent axes into one tier without a
  combinatorial exception table. [documented]
- **It is noise-resistant by construction.** Granularity artifacts — sibling
  codes, brand codes — cannot fire an alarm, so every alarm that fires is a
  genuine cross-business move. [documented]

## Open refinements — risky codes sitting in benign groups

The page names five codes whose current group is benign but whose real risk
profile is not, and asks whether they should be treated differently. Still open
as of 2026-07-29. [documented]

| MCC | Description | Currently grouped in | Proposed treatment |
|---|---|---|---|
| 4829 | Wire Transfer Money Orders | Telecommunication | High, or stand-alone (quasi-cash) |
| 6540 | POI Funding / Stored Value | Money and Financial Services | High (crypto onramp, VIRP Tier 2) |
| 5933 | Pawn Shops | Antiques and Second Hand | Elevated (AML profile) |
| 9223 | Bail and Bond Payments | Legal and Finance | Elevated (commonly restricted) |
| 5921 | Beer/Wine/Liquor Stores | Food and Beverage | Medium (age-restricted) |

The page's own answer: **re-tier these MCCs; no group restructuring needed**,
because tiering is per-MCC. [documented]

4829's proposed "High / stand-alone" is the one entry that would change the
group set, not just tiering — a tension with the stated fix. Unresolved on the
page. [hunch]

## How this lands against what we already hold

- It **answers an open question** already logged on [[mcc-risk-scoring]]:
  "do any MCC groups mix risk bands widely enough to need splitting or a curated
  exception list?" The five-code refinement table is that curated list, with
  re-tiering rather than splitting as the proposed remedy. Not yet decided.
- It **supplies the reference data** [[mcc-risk-scoring]] assumes when it makes
  "the MCC group, never numeric code proximity" the proxy for same-business.
  That principle is stated there; the group set that implements it is here.
- It **explains a worked example** on that page — Gambling→Gambling at High vs.
  Shoes→Gambling at Critical only works because all gambling codes share one
  group.
- It is **compatible with, and more general than**, MerchantView's verified
  rule captured on [[mcc-mismatch-for-global-onboarding]]: same configured group
  → match, different group → `MCC_MISCODE`. Same group semantics; this page adds
  the tier dimension MV has no equivalent of. No contradiction.
- It stays **downstream of the detection gap** on [[crawler-capability-gaps]].
  A grouping taxonomy improves interpretation of a predicted MCC; it does not
  make the prediction more accurate.

## Full membership: the groups-mapping workbook

`MCC Groups mapping.xlsx` (Gal Sahar, 2026-09-02 / 2026-09-06) is the
code-to-group table the Confluence page lacked. Raw:
`source/2026-09-06-mcc-groups-mapping-xlsx.md`.

**It matches the Confluence page on structure.** [documented]
- 38 named business groups plus the Gambling group = 39, as the page states.
- 13 stand-alone codes plus the 5 gambling codes = 18, matching "~18".
- The stand-alone list is the same 13 codes as the VIRP table above.
- The five refinement codes sit where the page says: 4829 in
  Telecommunication, 6540 in Money and Financial Services, 5933 in Antiques
  and Second Hand Goods, 9223 in Legal and Finance, 5921 in Food and Beverage.
- Brand ranges fold into parents: airline brands with 4511 in Airlines, car
  rental brands with 7512 in Auto Rental.

**New: a `Group Risk` column that contradicts the per-MCC tier principle.**
The 2026-09-02 copy adds a `Group Risk` column scored on what looks like a 1-5
scale: Gambling = 5, Veterinary Services and Supplies = 1, Agricultural
Services and Supplies = 1, every other group blank. [documented] A group-level
risk score runs against this page's principle that "risk tier is per-MCC,
inherited by the group". The 2026-09-06 copy in the `MCC score and UX` folder
drops the column. Whether it was abandoned or moved elsewhere is unknown; the
1-5 scale matches neither the Low/Medium/High bands nor the five tiers in
[[mcc-risk-scoring]]. [hunch]

**Placements beyond the five-code refinement list that look risk-mixed.**
Placement is [documented]; the risk reading is [hunch], not raised by Gal:
- 5723 Guns and Ammunition Shops in Sporting Goods.
- 7297 Massage Parlors in Health Services and Supply.
- 5813 Bars and Nightclubs in Food and Beverage, alongside 5921.
- 6050 Quasi Cash–Member FI and 6532/6533 Payment Service Providers in Money
  and Financial Services, while 6051 Quasi Cash–Non-FI stands alone.
- Casino-hotel brand codes (3551 Mirage, 3596 Wynn, 3771 Caesars, others) in
  Hotels and Casinos, not in Gambling. A casino site declared under its brand
  hotel code and predicted as 7801 would be a cross-group mismatch.
- 5962 and 5969 direct marketing in Marketing and Advertising, while their
  siblings 5966, 5967 and 5968 stand alone.

**What the workbook does not carry.** [documented absence]
- No per-MCC risk band or tier. The tier column the Confluence page describes
  is not in this file.
- No specialty marker. The prototype's "Specialty (nn)" labels (7995, 7801,
  9406, 5912, 6051, 5967, 5993) are all members of the stand-alone set,
  which suggests the specialty list is drawn from it. That is not confirmed.
  [hunch]
- The 5 "highlighted" gambling codes are marked by cell colour, which the
  connector does not return. Identified here from the Confluence page.
- The airline brand range ends at 3308, with 3281 missing. Whether codes after
  3308 exist in the production reference is unknown.

## What is not here

- ~~No code-to-group mapping table.~~ Closed 2026-10-08 by the workbook above.
- No band or tier definitions beyond the VIRP/BRAM references — the risk-band
  vocabulary used by [[mcc-risk-scoring]] (Low/Medium/High) is not defined here.
- No provenance for the VIRP/BRAM tier assignments themselves. The page asserts
  the near one-for-one mapping; no Visa or Mastercard document is cited.
  [documented] as claim, [industry] as fact.

## Links

- [[mcc-risk-scoring]] — the interpretation layer that consumes these groups:
  seven verdicts, two axes, one tier.
- [[mcc-mismatch-for-global-onboarding]] — the PayPal-driven delivery of the
  subset of this into the MLRC pipeline; carries MerchantView's verified
  group-based rule.
- [[merchantview]] — the legacy group-based comparison this taxonomy
  generalizes.
- [[crawler-capability-gaps]] — the upstream MCC detection-accuracy gap this
  does not address.
