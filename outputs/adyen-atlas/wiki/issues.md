# Adyen Issues

Defects, incidents and data-quality problems affecting Adyen, newest first.

## Scan processing delays, November 2026

- 2026-11-09: Adyen scans created the evening before barely processed overnight. Other scans from 2026-11-02 were stuck at 99%. (Slack #announce-production-escalations)
- 2026-11-11: A production issue affected all PLRC clients: Adyen, AmEx, eBay. (Slack #announce-production-escalations)
- 2026-11-08: After an action monitoring change, all "not available" items for Adyen are being rerun. (Anna Pogreb weekly update)

## CSV download error, October 2026

- 2026-10-26: CSV download from the Adyen account failed every time. Raised by Lee Peled Hayoon. Resolution not found. (Slack #team-marketview-dev)

## Carried Email and Phone Mismatch findings, August 2026

- Adyen received Email Mismatch findings while submitting no merchant emails.
- Cause: defect RT-1407. Findings carry from month to month and never age out, because change detection ignores this finding type. The evidence is from September 2025; MERV-44980 fixed new detections in December 2025.
- July 2026 cycle: Email Mismatch 5,887 shown, 1 detected. Phone Mismatch 6,398 shown, 1 detected.
- Open: Adyen needs a one-off cleanup of the old findings. The fix plan waits on Gal Sahar's choice between dropping old findings and marking them as old.
- Source: Slack #team-merchantview, 2026-08-04 to 08-05 (Mikhail Yakushin).

## Rules Customizer broken, July 2026

- 2026-07-08: Adyen reported Rules Customizer not working. Ticket MERV-45774. (Slack #team-merchantview, Jeebu Kurian)
- 2026-07-13: Fix for Adyen augmentation rules in mvnextgen PR #555. (Slack #apps-group-prs)

## Advanced URL upload, June 2026

- 2026-06-03: Sasha postponed the feedback session to investigate an issue during advanced URL upload. Details not found. (Email "Product feedback meeting")

## False positives, April 2026

- 2026-04-23: Adyen had a high false positive rate. Gal Sahar's assumption: unqualified multi-language categories. Plan: turn those categories off for the June scans. (Slack #product-team)

## adyen-triggering service, May 2026

- 2026-05-24: The `adyen-triggering-prod` service was out of sync with access errors. (Slack #announce-production-escalations)

## SmS data collection limits

- Marketplace scraping success rate was below the 90% promised by the provider in September 2026. A Decodo trial unlocked TaoBao for the July scan. (Anna Pogreb weekly updates)
