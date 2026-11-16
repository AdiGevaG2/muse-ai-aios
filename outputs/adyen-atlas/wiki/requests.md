# Adyen Requests

What Adyen has asked G2RS to build or support. "QBR status" is the status the November 2026 QBR deck shows Adyen.

## On the QBR deck

| Request | What Adyen needs | QBR status | Other evidence |
|---|---|---|---|
| MCC findings | Findings tied to merchant category codes, required by an Indian regulator. | Pending | None found in email or Slack. |
| Website change detection | Automated website monitoring and change detection for Adyen's "PMR initiative". The deck does not define PMR. | Pending | None found in email or Slack. |
| SmartScan category customization | Set a category's risk level separately for each marketplace. | Planned | Raised at the October 2026 meeting on category severity (Anna Pogreb weekly update, 2026-10-11). |
| SmartScan marketplace UI access | Adyen's marketplaces get their own SmartScan UI access; Adyen acts as a referral source for G2RS. | Pending | In Q4 SmartScan scope. Pricing model in draft: acquirer-direct, where marketplaces get read-only or workflow access billed to Adyen; or marketplace-direct, where the acquirer gets oversight access. (Mary Williams email, 2026-10-23) |
| SmartScan comments in reports | Analyst comments in the CSV export. | Complete | Delivered before 2026-10-25 (Anna Pogreb weekly update). |
| SmartScan sold items | Separate sold-out listings from removed listings. | Complete | Shipped 2026-11-05: `Live`, `Sold Out`, `Removed` states, CSV `Product Status` column, Availability filter (Slack #announce-apps-new-features). |

## Not on the QBR deck

| Date | Request | Status | Source |
|---|---|---|---|
| 2026-10-29 | Monitor AI-image generating platforms. Five or more clients have asked for this in 3-4 months; Adyen is the most recent. | No Adyen-specific plan found. G2RS is setting up this process for another client first. | Mary Williams email "AI-Image Generating Platforms", 2026-10-29 |
| 2026-09-07 | Monitor mismatches between a merchant's IP address and its stated location, per Mastercard's recommended controls. Needed for Mastercard Franchise onboarding under Adyen's new UAE license. | Open. A website's IP shows its hosting location, not the merchant's. A real check needs the IP the merchant used when onboarding with Adyen, which G2RS does not receive. A website lookup could satisfy a "we checked" compliance need, with caveats. MV does not run this comparison today. | Email thread "Adyen: Mismatch of e-commerce Merchant Internet Protocol (IP)", 2026-09-07 to 09-09 |
| 2026-08-05 | Email mismatch checks for Apple Pay requirements. | Open. Adyen submits no merchant emails, so MV has no data to match today. | Slack #team-merchantview, 2026-08-05 |
| 2026-06 to 2026-08 | Add marketplaces to the SmS scan: Skelbiu, TikTok US, Shopee Brazil, TaoBao. | Done. TaoBao and TikTok added to monitoring in Q3; Skelbiu scanned as a check before onboarding. | Anna Pogreb weekly updates; QBR deck slide 19 |
| 2026-06-11 | Atlas feature asks, based on Adyen's MV experience: 12 themes, most about managing work at platform level. | Each ask and its Atlas coverage is in [feedback-2026-06-11.md](feedback-2026-06-11.md). Most coverage is unconfirmed. | Session notes; Juan email "Adyen: Product Feedback Call", 2026-06-11 |
