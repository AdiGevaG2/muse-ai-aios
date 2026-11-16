# Adyen Account

## Relationship

| Item | Value | Source |
|---|---|---|
| Client since | June 2018 | QBR deck, Nov 2026 |
| Contract | Renewed for 12 months; expires 6 June 2027 | QBR deck, Nov 2026 |
| Services | MerchantView Content Monitoring, Graph and TL, SmartScan | QBR deck, Nov 2026 |
| MerchantView portfolios | 6: Sonar Advanced, Sonar Acquiring, Sonar AO, Managed, Payfac, Sonar Banking | QBR deck, Nov 2026 |
| Partner referral program | Adyen is part of it. Adyen would also refer marketplaces under the planned SmartScan marketplace access model. | QBR deck, Nov 2026 |

G2RS frames the relationship as moving from monitoring delivery to risk infrastructure, with Adyen looking to G2RS for marketplace risk, regulatory and card scheme obligations, and new risk use cases. (QBR deck, executive summary)

## Products and setup

| Product | What Adyen has | Source |
|---|---|---|
| MerchantView (MV) | Merchant monitoring. Tenant `europe_production` (example merchant 471032). Adyen submits no merchant emails or phone numbers. About 348K URLs scanned in October 2026. See [metrics.md](metrics.md). | Slack #team-merchantview, 2026-08-05; QBR deck |
| MV manual review | Adyen is the only client whose "Marketplaces" category goes through manual review. | MV Risk Ops monthly recaps, Apr to Sep 2026; Slack #mv-rag-bot, 2026-04-14 |
| SmartScan (SmS), PLRC | Marketplace listing scans, 40 marketplaces in Q4 2026. UI access only, no API. Adyen is one of three PLRC clients, with AmEx and eBay. | QBR deck; Mary Williams, Slack #mlrc-product, 2026-07-08; #announce-production-escalations, 2026-11-11 |
| Action monitoring | "No API action" availability monitoring, live since 2026-01-23. Tracks Live, Sold Out and Removed listings. | Slack #announce-apps-new-features |
| MLRC | Enabled on Adyen's account. Shmuel Blitz asked why on 2026-02-15. No answer found. | Slack #rocket-team |

Marketplaces scanned for Adyen include TaoBao, TMall, iFood, TikTok US, Shopee Brazil and Skelbiu, a Lithuanian classifieds marketplace. Excluded from availability monitoring because availability is unstable: Alipay-Lazada, Instacart, RappiCOM, Shpock.

## Atlas

The QBR deck tells Adyen that Atlas rolls out in 2027 and combines G2RS, EverC and WebShield. Atlas slides in the deck: 22 to 24 (Atlas value, combined capabilities, features driven by client feedback), 25 (2026 roadmap) and 27 (Merchant Risk History for Atlas).

## Adyen people

| Name | Role | Notes |
|---|---|---|
| Rosa van Valkenhoef | Global Head of Payment Risk Operations | QBR attendee |
| Sasha Kononov | Team Lead, Global Brand Protection, Amsterdam | Primary platform user. Represented Adyen at the 2026-06-11 feedback session and built the Figma for it. |
| Maciej Antosiewicz | Product Manager | QBR attendee |
| Richard Filer | Senior Procurement Manager | QBR attendee |

## G2RS people

| Name | Role on the account |
|---|---|
| Franz Reinhofer | Head of Underwriting and MD Europe. QBR attendee. |
| Marc Temple | SVP Sales EMEA. QBR attendee. |
| Jack Voice | Sales EMEA. QBR attendee. |
| Juan Jose Jovel Ramos | Senior CSM, CET. Runs a bi-weekly meeting with Adyen. Owns the QBR deck. |
| Mary Williams | SVP Product Management. Sponsor on Adyen product asks. |
| Ishai Froind | Product leadership. Copied on all Adyen product threads. Visited Adyen in Amsterdam, June 2026. |
| Anna Pogreb | SmS product manager. Runs Adyen's quarterly scans. |
| Lee Peled Hayoon | SmS. Checks scan quality, meets with Adyen. |
| Gal Sahar | MV product manager. Answers MV signal questions from Adyen. |
| Sarah Craven | Director, Product Management. Consolidated the 2026-06-11 feedback notes. |
| Jeebu Kurian | Support. Raises Adyen-reported MV defects. |
| Viktoriia Shein | Creates Adyen monitoring scans. |
| Adi Geva | Atlas PM. Asked to add Atlas slides to the QBR deck. |
