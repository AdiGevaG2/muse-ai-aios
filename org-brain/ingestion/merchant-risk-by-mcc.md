# Merchant risk by MCC

Risk profiles keyed to merchant category code. The Academy's framing: certain
risks are inherent to specific business models, so MCC-based profiles form part
of a broader risk framework rather than a standalone verdict.

Each entry: what goes wrong, what to do about it, and the traffic profile you
should expect — read against [[website-data-analysis]].
[documented — Berlin *Data-driven Merchant Onboarding*, *Adult and AI*]

## 5968 — Direct marketing: continuity / subscription

Risks: free-trial conversions, deceptive influencer and affiliate marketing,
negative option billing requirements, chargebacks, load balancing.
Mitigation: clear terms at checkout requiring consent; no auto opt-ins or
pre-checked boxes; exposure calculation and collateral; additional website
detection; registration under VIRP/SMRP.
Traffic: diverse; heavy social where influencer-led; high referral suggests
affiliate or MLM schemes.

Note: physical goods sold as a continuity subscription are high-risk and require
SMRP registration. Exposure should reflect higher chargeback ratios and TC40
within VisaNet. See [[financial-risk-exposure]].

*The cautionary tale:* the 2008–09 acai berry supplement subscriptions — a
negative option model with subscription by default, buried in small print or
unmentioned, drawing media coverage and FTC action. The same merchant ran a
cluster of front sites alongside adult sites with brief free trials converting to
recurring subscriptions.

## 5499 — Miscellaneous food stores

Risks: one-time sale vs. negative option billing; country-specific ingredient
issues; tainted supplements; regulatory challenges for ingestible CBD;
influencer/affiliate marketing.
Mitigation: initial content screening and monitoring; identify shipping
destinations and check them against traffic geography; monitor affiliate
activity and consumer feedback via adverse media and review boards.

## 5977 — Cosmetic stores

Risks: negative option billing; deceptive influencer/affiliate marketing; false
promises and impermissible health claims; problematic ingredients.
Mitigation: as 5499.
Traffic: relies more on social and affiliates than classic SEO.

Also a documented TL front type — see [[transaction-laundering]].

## 5993 — Cigar stores and stands

Risks: age restrictions; cross-border shipping and customs; counterfeits;
illegal flavored or disposable ENDS; CBD e-liquids.
Mitigation: monitor for flavors/disposables; verify age verification; ensure
parcels declared correctly for cross-border; price comparison;
supplier/manufacturer bills.
Traffic: mainly direct and search — paid ads are themselves a risk since tobacco
advertising is heavily regulated globally.

Mastercard requires ENDS-primary merchants to use 5993 with TCC T (non-face-to-
face) or TCC R (face-to-face), and *SRP* §9.4.2 registration for NFTF tobacco.
See [[e-cigarettes]].

## 5912 — Drug stores and pharmacies

Risks: unlicensed operators and rogue pharmacies; online prescriptions;
cross-border sales; medical device rules; advertising restrictions on certain
prescription drugs.
Mitigation: license verification and accreditation; regulatory monitoring;
confirm the prescription verification process; verify medical devices meet
requirements.

Related but distinct: **5122** for RUO peptides and unapproved drugs — see
[[peptide-merchants]].

## 5921 — Package stores: beer, wine, liquor

Risks: legal liability on sales to minors; regulatory and shipping compliance
(state and local law); labelling and product requirements; advertising
restrictions.
Mitigation: age verification; block fulfillment to restricted geographies with
ZIP-level compliance logic; confirm accurate item descriptions; verify active
alcohol licenses.
Traffic: mainly direct and search; treat high ad traffic with caution.

## 5967 — Direct marketing: inbound teleservices (adult)

See [[adult-and-ai-merchants]].

## 7273 — Dating and escort services

See [[adult-and-ai-merchants]].

## 7995 — Gambling transactions

See [[gambling-and-miscoding]].

## 5816 / 7994 — Digital goods, games and video arcades

Risks: incorrect MCC across games of skill vs. chance; IP infringement via
third-party item shops; skin gambling; sweepstakes casinos; microtransaction
refunds.
Mitigation: note that Visa and Mastercard include different things under
5816/7994; verify chance does not outweigh skill; request a reseller agreement
where the merchant is not the game publisher.
Traffic: popular platforms skew direct; lesser-known platforms show a more
diverse profile.

Detection clue for TL: legitimate providers show high organic search and social;
fronts skew direct and referral. Plausibility-check player numbers against
third-party charts like steamcharts.com. [documented — Berlin *TL Typologies*]

## 7922 — Theatrical producers, ticket agencies

Risks: long pre-booking windows; bust-out scams and non-delivery; fake tickets;
high financial risk exposure.
Mitigation: retail or partnership agreement with the event operator; establish
typical pre-booking times; exposure and chargeback forecast.
Traffic: diverse; e-tickets delivered by email lift email traffic.

## 7372 — Computer programming, data processing (AI)

See [[ai-merchants-as-tl-fronts]] and [[adult-and-ai-merchants]].

## 6051 — Quasi-cash / crypto

See [[crypto-as-gambling-payment-rail]].

## 8299 — Educational services

Common front for TL as "online courses", often covering training for
unauthorized activity such as trading. See [[transaction-laundering]].

## Related

[[website-data-analysis]] · [[transaction-laundering]] ·
[[financial-risk-exposure]] · [[mastercard-bram-and-mmp]]

Source: [[../source/2026-08-30-g2rs-academy/MANIFEST.md]]
