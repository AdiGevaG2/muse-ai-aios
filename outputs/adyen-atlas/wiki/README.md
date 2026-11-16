# Adyen Client Wiki

Knowledge about Adyen as a G2RS client, built from Outlook, Slack and the November 2026 QBR deck. Started 2026-11-12.
Scope: this folder only. Not linked into `org-brain/` or `second-brain/`.

## Snapshot

- Adyen is a payments company headquartered in Amsterdam. Client since June 2018; contract runs to 6 June 2027.
- Adyen has MerchantView (6 portfolios, about 348K URLs scanned per month) and SmartScan (40 marketplaces). See [account.md](account.md).
- Atlas replaces MerchantView, so Adyen is a migration client. The QBR deck tells Adyen Atlas rolls out in 2027. Adyen gave product feedback for Atlas on 2026-06-11.
- Adyen engages with 76.1% of critical and high findings, above the 70.8% acquirer average. See [metrics.md](metrics.md).
- Next event: Adyen QBR, November 2026. Internal sync on 2026-11-16.

## Pages

| Page | What it holds |
|---|---|
| [account.md](account.md) | Relationship, products, Atlas position, people on both sides |
| [../adyen-asks-mv-atlas-list.md](../adyen-asks-mv-atlas-list.md) | One list: each Adyen ask and MerchantView feature in use, against Atlas now and Atlas planned by 27 Feb 2027 |
| [../atlas-for-adyen-by-feb-27.md](../atlas-for-adyen-by-feb-27.md) | Which Adyen asks Atlas answers by 27 Feb 2027, per the Monday roadmap, and the recommended QBR story |
| [feedback-2026-06-11.md](feedback-2026-06-11.md) | Adyen's Atlas feature asks from the June feedback session, with usage evidence and Atlas coverage |
| [requests.md](requests.md) | What Adyen has asked G2RS to build or support, with QBR status |
| [metrics.md](metrics.md) | Volume, engagement, SmartScan, card brand and TL figures from the QBR deck |
| [../baseline/adyen-mv-usage-baseline.md](../baseline/adyen-mv-usage-baseline.md) | What Adyen does in MerchantView today, from Mixpanel and Looker |
| [issues.md](issues.md) | Defects, incidents, data-quality problems affecting Adyen |
| [timeline.md](timeline.md) | Dated events, January to November 2026 |
| [meeting-2026-11-16-qbr-internal-sync.md](meeting-2026-11-16-qbr-internal-sync.md) | Internal QBR planning call: session plan, Adyen product questions, concerns about presenting Atlas now, dates instead of quarters, next steps |
| [sources.md](sources.md) | Every source used, with gaps |

## Open items

- Confirm which of Adyen's 12 June feedback themes Atlas covers at launch. Most are unconfirmed.
- Find out what G2RS told Adyen at the 2026-07-02 follow-up.
- Confirm whether the Atlas slides in the QBR deck (22 to 25, 27) cover what Mary Williams asked for, before the 2026-11-16 internal sync.
- Correct the "+42% growth June to November" claim on QBR slide 6; the deck's own chart does not support it.
- Get Juan's notes from the 2026-11-11 bi-weekly meeting with Adyen.
- Confirm whether the Atlas product session stays on 25 November or moves to December or January (JJ asking Sasha, per the 2026-11-16 sync).
- Find out what Adyen means by onboarding: speed and SLA, extra signals, or both.
- Confirm the date for the one-off cleanup of carried Email and Phone Mismatch findings (RT-1407).
- Confirm the outcome of the IP mismatch request for Adyen's UAE Mastercard onboarding. It is not on the QBR deck.
