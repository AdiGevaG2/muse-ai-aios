# Transaction laundering (TL)

Using a benign "front" website to process card transactions whose real goods or
services sit behind it. The single largest violation category G2RS sees, and the
thing most of the merchant-risk toolkit exists to catch.

## What it is

A cardholder pays what looks like an ordinary merchant. The front site holds a
valid MCC and acquiring relationship; the actual product — most often gambling,
sometimes pharma or adult — is delivered elsewhere. The acquirer is processing
for a business it never underwrote. [documented — Berlin *TL Typologies*,
*Data-driven Merchant Onboarding*]

Miscoding is treated alongside third-party TL as the same problem class: the
transaction reaching the network under a code that misrepresents it.

## Scale

Of G2RS incident reports [documented — Berlin *TL Typologies*, internal data
2020–2025 + Q1 2026 to 20 Apr]:

| Measure | 2020–2025 | 2026 (to 20 Apr) |
|---|---|---|
| TL or miscoding as main culprit | 63% | 97% |
| Gambling as beneficiary industry | 51% | 97% |

Card brand assessments split roughly 66% TL / 34% content violations.

The 2026 figures are a partial-quarter sample and should not be read as a stable
run-rate. The direction — TL crowding out every other violation type, with
gambling as the near-universal beneficiary — is the durable claim. [inference]

Beneficiary industries across 2020–2025: gambling 60.5%, IP infringement 10.9%,
pharma & medical devices 3.4%, adult & CSAM 2.7%, cyberlockers 2.0%, drugs 1.4%,
nutra 0.7%.

## Which merchant types get used

Share of incident reports [documented — Berlin *TL Typologies*]:

| Front type | 2020–2025 | 2026 |
|---|---|---|
| AI merchants | ~0.8% | ~36% |
| Other digital goods/services | ~24% | ~29% |
| Digital games & skins | ~18% | ~26% |
| Physical goods | ~14% | ~6% |
| Crypto | ~7% | ~3% |

The AI jump is the headline movement — from a rounding error to the largest
single front category in roughly a year. See [[ai-merchants-as-tl-fronts]].

Digital services work as fronts because ticket sizes match average spend on
high-risk sites: online courses, digital marketing, copywriting, translation,
web development. Mostly MCC 8299, and often covering training for unauthorized
activity such as trading.

## Detection

87% of websites assessed for TL showed irregularities in one of three areas —
website usage (65%), adverse media (20%), backlinks (15%). The method is in
[[website-data-analysis]]; there is no single indicator, and any anomaly is
worth pursuing. "No data is also data." [documented]

Additional predictors: geographic mismatches (language dropdowns, currencies),
price-point irregularities, social media presence, background research.

## Worked example — cosmetics front

MCC 5977 Cyprus cosmetics merchant: no social media presence, virtual address,
no organic traffic (direct-only in a single activity peak), IP scan hit known
violating sites, checkout impossible for the 5977 products but working for gift
cards, payment page connected by double redirect to gambling sites during the
peak. [documented — Berlin *TL Typologies*]

The gift-card-only checkout is the tell worth generalizing: a storefront whose
nominal catalogue cannot actually be bought is not a storefront. [inference]

## Related

[[website-data-analysis]] · [[merchant-risk-by-mcc]] ·
[[crypto-as-gambling-payment-rail]] · [[ai-merchants-as-tl-fronts]] ·
[[mastercard-bram-and-mmp]] · [[seo-poisoning]] · [[osint-toolkit]]

Source: [[../source/2026-08-30-g2rs-academy/MANIFEST.md]]
