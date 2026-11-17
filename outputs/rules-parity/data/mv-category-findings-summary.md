# MerchantView Findings by Category, Last 90 Days

Pulled 2026-11-15 from Looker.

Query: model `mv`, explore `fact_finding`, fields `fact_finding.finding_sub_type`, `fact_finding.is_manual`, measure `fact_finding.count_findings_wo_test` ("Findings", excludes test accounts), filter `fact_finding.scan_date` = "90 days". Raw result: `mv-findings-by-category-90d-raw.csv`. Category names and types: model `mv`, explore `categories`, saved as `category-catalog.csv`. Joined per category by `summarize.py` into `mv-category-activity-90d.csv`.

## Totals

- Catalog categories: 1,879. Categories with MV findings in the window: 795.
- Automated only: 565. Automated and manual: 168. Manual only: 58.
- Findings: 82,668,834 automated, 470,468 manual.

## Categories eligible as rule conditions

The MV rule form excludes MCC and Platform categories, leaving 547.

| Where the findings come from | Categories | Share |
|---|---|---|
| Scanner | 193 | 35% |
| Analysts only | 58 | 11% |
| No findings | 296 | 54% |

## By category type

| Type | Automated | Manual only | None |
|---|---|---|---|
| MCC | 540 | 0 | 597 |
| Content | 97 | 25 | 149 |
| Platforms | 0 | 0 | 195 |
| Signals | 14 | 8 | 21 |
| Payment Page | 9 | 17 | 9 |
| Test Transaction | 1 | 0 | 25 |
| Keyword | 15 | 0 | 4 |
| Reputation | 10 | 5 | 3 |
| Website Section | 9 | 0 | 8 |
| Insights | 5 | 0 | 12 |
| Policies | 2 | 1 | 13 |
| Audit | 6 | 0 | 6 |
| Security Problem | 6 | 1 | 4 |
| Link | 4 | 0 | 7 |
| Availability | 5 | 0 | 4 |
| Inner | 0 | 0 | 8 |
| Third Party Payment Provider | 1 | 1 | 4 |
| Public Records | 0 | 0 | 5 |
| Storefront Platform | 0 | 0 | 4 |
| Known Bad | 1 | 0 | 2 |
| Traffic | 2 | 0 | 1 |
| Whois | 3 | 0 | 0 |
| IP | 0 | 0 | 2 |
| Analytics Service Provider | 0 | 0 | 2 |
| Hyperlink | 0 | 0 | 2 |
| No type | 0 | 0 | 1 |
| Mobile Application | 1 | 0 | 0 |
| Web ID | 1 | 0 | 0 |
| Suspicious Flags | 1 | 0 | 0 |

## Spot checks

| ID | Category | Automated | Manual |
|---|---|---|---|
| 59 | Online | 14,745,423 | 25,439 |
| 61 | Redirect | 2,083,750 | 6,587 |
| 76 | MCC Miscode | 101,194 | 57 |
| 165 | Test Transaction Validated | 2 | 18 |
| 186 | Verified Transaction Launderer | 0 | 0 |
| 187 | Test Transaction Executed | 0 | 0 |
| 188 | Test Transaction Not Completed | 0 | 0 |
| 189 | Test Transaction Not Verified | 0 | 0 |
| 197 | Test Transaction Verified not Matched | 0 | 0 |
| 235 | Transaction Laundering Blacklist | 35 | 0 |
| 1010 | Medical - all | 0 | 0 |
| 1011 | Porn - all | 0 | 0 |
| 1021 | Weapons - all | 0 | 0 |
| 1100 | MCC Type Reported | 3,353,582 | 0 |
| 1101 | MCC Type Detected | 408,472 | 0 |
| 1102 | MCC Type Verified | 202,312 | 0 |
| 1103 | MCC Type Mismatch Detected | 177,168 | 0 |

## Manual-only categories

8 Moto 22; 17 Cashing Checks 18; 29 Cybersquatting 4; 30 Ads Trap 2; 38 Digital Wallet 122; 50 Injected Links 24; 52 Inactive Payment Environment 39; 56 Bitcoin 48; 70 Affiliation Network 201; 94 Financial Institution 375; 96 Airlines 85; 98 Bankruptcy lawyers 16; 99 Cell Phones 75; 105 Mortgage or real estate consulting 140; 109 Securities Brokers & Investment Consultants 252; 116 virtual currency 10; 120 Diners Club International 402; 121 JCB 438; 122 Discover 1,338; 125 Offline Payment 44; 131 Diplomatic Entities 2; 132 Digital Marketing 9; 138 Extended Warranty 2; 155 Alipay 4; 156 Internal Currency 4; 166 Olympic Games Tickets 2; 169 Stripe 2; 179 Digital Wallet Sites 53; 182 Gift Cards or e-Vouchers Payment 13; 191 China UnionPay 157; 192 Adult Entertainment 46; 194 Pricing Patterns 4; 195 WeChat 6; 201 Multi-level marketing 9; 205 Wire Transfer 21; 207 Trustly Payment 2; 211 Hair Extensions 35; 230 Insurance 57; 250 Business with countries under sanction 21; 261 Cyber Locker blacklist 9; 269 PS - Hemp 2; 270 PS - CBD 55; 271 PS - Firearms Accessories 55; 272 PS - Firearms - Other 21; 309 CAT_309 146; 355 Address Mismatch 70; 370 Unverified FFL 125; 371 Adverse Media 27; 372 Verified FFL 1,069; 377 Lawsuit and Legal search 20; 378 Drop shipping indication 589; 379 Unusual Pricing 327; 380 Missing Search Option 186; 384 Missing or Invalid Email 46; 386 Support Email with reply 583; 701 AI Generated Explicit Adult Content 40; 743 Bankruptcy-related Services 1; 20197 Support Email Sent 560.

## Limits

- The selectable list in MV differs per bank, from each bank's risk matrix. These counts cover the full catalog, not one bank's list.
- MV counts stand in for Atlas only as an inference. Atlas findings by category were not available.
