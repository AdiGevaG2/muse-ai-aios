# Gambling and miscoding

Gambling is the beneficiary industry behind the overwhelming majority of
transaction laundering G2RS sees — 51% of incident reports 2020–2025 and 97% in
early 2026. Miscoding is how it reaches the network.

## Required MCCs

Per Mastercard Rule 5.1.2.1, all gambling-related transactions must be coded
non-face-to-face gambling with one of [documented — GLB 13720.1]:

- 7800 Government Owned Lottery (US only)
- 7801 Internet Gambling (US only)
- 7802 Government Licensed Horse/Dog Racing (US only)
- 7995 Gambling Transactions
- 9406 Government-owned Lottery (specific countries)

Acquirers should verify that merchants coded 7995 hold a valid gambling license
in the jurisdiction where they operate. Mastercard treats coding failure as a
serious Standards violation, investigates it under BRAM, and may treat it as a
5.12.7 violation. On finding miscoded gambling in-portfolio, the acquirer must
apply *SRP* §8.8.1–8.8.4.

Rule 7.6.7 prohibits Staged Digital Wallet Operators from using MCC 6540
(Funding Transactions) where funds may subsequently be used for gambling.
*SRP* §9.4.2 sets registration requirements for online gambling merchants,
including those enabling gambling through an SDWO. Registering a merchant is an
acquirer attestation that controls are in place.

## Underwriting a gambling merchant (MCC 7995)

Risks [documented — Berlin *Data-driven Merchant Onboarding*]: no license or
false license claims; offshore licenses (e.g. Comoros); no KYC or region
restrictions; selective KYC applied only at withdrawal; poor player satisfaction
driving chargebacks; miscoded transactions; matched-betting targeting.

Mitigation: verify and authenticate the license; limit exposure to reputable
regulators; confirm KYC happens at account creation or deposit, not withdrawal;
check for additional websites.

Traffic profile: diverse mix. Popular platforms skew direct (repeat visitors);
unknown platforms show more diverse profiles. High referral traffic often means
affiliates; high social often means influencer marketing.

Withdrawal-only KYC is the sharpest single tell — it lets a platform take money
from anyone while screening only those trying to take money out. [inference]

## Adjacent models

**Skin gambling** — wagering with tradable in-game cosmetic items. G2RS reports
these as a potential violation under gambling, subcategory "skin gambling".
Denmark requires a license where a stake, chance, and a convertible prize are
all present; the UK treats tradable in-game items as "money's worth" and
requires a licence; Sweden refuses to license skin betting at all; Australia
captures "anything else of value". Brazil's Law 15,211/2025 banned loot boxes in
games accessible to minors, in force March 2026. In February 2026 the New York
Attorney General sued Valve over CS2, Team Fortress 2 and Dota 2. [documented —
G2RS *Skin Gambling* guide, April 2026]

**Sweepstakes casinos** — casino-style games on a dual-currency promotional
model, one currency valueless for play and a second redeemable for cash. As of
March 2026 at least five states had enacted prohibitions (California,
Connecticut, Montana, New Jersey, New York). **California AB 831 and New York
S5935A explicitly extend liability to financial institutions and payment
processors that support these models** — direct exposure for the payments side,
not just the operator. Enforcement without statute in Arizona, Illinois,
Maryland, Michigan. Payment risks: legal gray area, MCC miscoding, elevated
"no value received" disputes. **From April 2026 G2RS reports social gaming and
sweepstakes casinos as a pVIO under gambling** (subcategory: social gaming and
sweepstakes casinos). [documented — G2RS *Sweepstakes Casinos* guide]

**Loot boxes** — randomized rewards bought with real currency; regulated as
gambling in some countries (e.g. Belgium). ~$15bn revenue, ~90% from a small
population of "whales". MCC 5816 covers in-game item purchase without wagering;
7995 applies once betting is involved. [documented — Berlin *TL Typologies*]

## Jurisdictional notes

Some jurisdictions prohibit or nationalize online gambling — Sweden, Norway,
Türkiye. Kazakhstan and Slovakia both maintain lists of prohibited foreign
operators; any operator unlicensed there is illegal. [documented — GLB 13720.1]

CJEU **C-440/23** (16 April 2026): contracts concluded in breach of gambling
prohibitions may be null and void; consumers may claim restitution of lost
stakes even against operators established in another Member State; and Member
States may continue prohibiting online gambling services even where lawfully
licensed elsewhere. Earlier: C-124/97 (consumer protection and AML override
Art. 56 TFEU) and C-42/07 (proportionate restrictions justified by fraud risk).
[documented — Berlin *TL Typologies*]

C-440/23 matters commercially: a licensed-elsewhere defence no longer travels,
and restitution claims create a chargeback-like tail. [inference]

## Related

[[transaction-laundering]] · [[crypto-as-gambling-payment-rail]] ·
[[mastercard-bram-and-mmp]] · [[merchant-risk-by-mcc]] · [[website-data-analysis]]

Source: [[../source/2026-08-30-g2rs-academy/MANIFEST.md]]
