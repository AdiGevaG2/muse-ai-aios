# Crypto as a gambling payment rail

Crypto merchants are ~7% of G2RS incident reports 2020–2025 and ~3% in 2026 —
but their significance is structural rather than volumetric: crypto is how
gambling deposits get recoded as something else.

## Three scenarios

[documented — Berlin *TL Typologies*]

**Regular exchange** — MCC 6051 for on- and off-ramp services; actual fiat/crypto
exchange takes place. Legitimate.

**Crypto widget** — gambling platforms integrate a crypto widget for account
top-ups. The crypto merchant is effectively operating as a payment facilitator
with the gambling merchant as sub-merchant. Gambling top-ups get reported as MCC
6051.

**Disguised crypto** — the user selects "bank transfer", is redirected to a
crypto on-ramp, and card statements and transactions show MCC 6051.

In the second and third cases the cardholder is funding a gambling account and
the network sees quasi-cash. See [[gambling-and-miscoding]].

## PayFac obligations

Visa's *Payment Facilitator and Marketplace Risk Guide*: "Entities that miscode
MCCs of gambling merchants are in violation of the Visa Rules and subject to
non-compliance assessments or other enforcement action. Mobile and/or digital
wallets, where the end use of funds is intended for illegal gambling, also fall
under this category." [documented]

PayFac requirements: sub-merchant due diligence; KYC and AML including sanctions
compliance; monitoring of suspicious activity.

The rule reaches end use of funds, not just the immediate coding — which is what
makes the widget scenario a violation rather than a gray area. [inference]

## Other crypto/gambling overlaps

- **NFTs** — speculative token assets, misused for TL, accepted as gambling
  deposits
- **Native tokens and incentives** — platform-specific tokens on ETH, Solana or
  proprietary chains; time-sensitive sign-up bonuses and loyalty rewards
- **Payment method misuse** — crypto on-ramps integrated as payment methods,
  deposit flows re-routed via alleged transfers to obscure source of funds,
  crypto vouchers
- **Further** — casino coins trading on exchanges; prediction markets on crypto
  exchanges (NY lawsuit against Coinbase and Gemini)

The UK Gambling Commission has observed a "correlation between risky investing
and problem gambling". [documented]

## Underwriting

MCC 6051; merchants present as regular exchanges. Jurisdiction of registration
and corporate structure offer first clues. Over $11bn in losses per the FBI's
2025 Internet Crime Report.

Discovery: KYC verification and payment page irregularities; traffic source
outliers — high direct and referral against **low email** traffic; industries
represented in referral and outgoing traffic; background research and review
boards; live price charts.

Worked example from the Academy case study: Crypto Pay Ltd / cryptopay.io — UBO,
NYC address and phone present; no PEPs, sanctions or adverse media; but high
referral traffic and high-risk backlinks detected. Assessment turned on MCC 6051,
BitLicense, MTL, and sub-merchant due diligence. [documented — Berlin
*Data-driven Merchant Onboarding*]

## EU regulation

**MiCAR** — supervision and a consistent regulatory approach; the grandfathering
period ends **30 June 2026**. Under the AML Directive, CASPs are obliged
entities: due diligence, risk assessment, transaction monitoring. The 19th
sanctions package was announced September 2025. Crypto merchants must be
properly registered as high-risk merchants under card scheme rules.
[documented]

## Related

[[gambling-and-miscoding]] · [[transaction-laundering]] ·
[[merchant-risk-by-mcc]] · [[website-data-analysis]]

Source: [[../source/2026-08-30-g2rs-academy/MANIFEST.md]]
