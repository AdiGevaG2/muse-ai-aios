# Content Compliance Gaps: MerchantView vs Atlas - Mini PRD

**TL;DR:**
Four Content Compliance capabilities that MerchantView clients have are missing or incomplete in Atlas. This doc shows each one as it works in MerchantView, what Atlas has, the gap, and what to build. It also adds a Content section to the merchant findings page.

<br>

## Definitions

- **Content Compliance**: the scanning service that scans a merchant's website content and reports each restricted content category it finds as a finding with evidence.
- **Content finding**: one restricted content category detected on one URL of a merchant website.
- **Reported URL**: a website URL the client submitted for the merchant.
- **Unreported URL**: a website URL G2 found for the merchant that the client did not submit.
- **Censored category**: a content category whose evidence images are hidden until a user reveals them.

<br>

## Problem and Goal

Atlas replaces MerchantView, and every MerchantView client must migrate. Reverse engineering of both codebases found four Content Compliance capabilities that MerchantView clients have and Atlas lacks or has in part. Capabilities that work the same for every finding type, such as notes, snooze, PDF reports and webhooks, are not part of this doc. Atlas will not carry over the MerchantView content summary widgets, the Content Violations dashboard chart, or separate risk levels for reported and unreported URLs.

Goal: a MerchantView client registered for Content Compliance who moves to Atlas keeps every capability listed below.

**Why we need it:** MerchantView clients cannot migrate to Atlas without losing these Content Compliance capabilities.

**Value for the client:** the client keeps the content evidence and content scanning languages it uses in MerchantView.

<br>

## Gap Summary

| # | Capability | Status |
| --- | --- | --- |
| 1 | Block on child sexual abuse imagery | Missing in Atlas |
| 2 | Keyword and text evidence | Partial in Atlas |
| 3 | Censoring of every image on a URL | Partial in Atlas |
| 4 | Content scanning in more languages | Missing in Atlas |

<br>

## Gap 1: Block on Child Sexual Abuse Imagery

### MerchantView today

1. Client opens a content finding's evidence.
2. If any finding on that URL is in the child sexual abuse material category, MerchantView replaces every evidence image on that URL with "Image unavailable due to explicit content".
3. No user can reveal the image.

Source: merchantviewui `scan-item.factory.ts`, child sexual abuse handling; `finding.factory.ts:145-147`; `evidence-screenshot.component.html:3, 13-15`; `evidence-content-trigger.component.html:15, 19-21`.

### Atlas today

Atlas has no separate handling for this category. A user with the reveal permission can reveal these images.

Searched: marketview-portal and mlrc-finding for censor, child sexual abuse and explicit-content handling.

### Gap

Atlas lets a user reveal child sexual abuse imagery.

### Requirement

1. If any finding on a URL is in the child sexual abuse material category, Atlas replaces every evidence image on that URL with "Image unavailable due to explicit content".
2. No user can reveal these images, whatever their permissions.

<br>

## Gap 2: Keyword and Text Evidence

### MerchantView today

1. Client opens the Findings grid.
2. Client clicks the evidence count on a content finding. The tooltip reads "Review Evidence".
3. The Evidence dialog shows a title and date.
4. For each match, the dialog shows "Keyword:" with the matched keyword.
5. The dialog shows the text excerpt from the page, with every occurrence of the keyword highlighted.
6. The dialog shows "Source:" with a link to the page where the text was found.
7. The dialog shows each image found on the page, with a link to that page.

Source: merchantviewui `grid-action-buttons.component.html:2-10`; `evidence-content-trigger.component.html:3-17`; `evidence.factory.ts`, content trigger processing; mvnextgen `ContentEvidenceCreator.java:56-85`; `KeywordEvidenceCreator.java:27-41`.

### Atlas today

1. Client opens a merchant and the findings tab.
2. Client clicks a finding's evidence. The tooltip reads "Evidence available".
3. The evidence popup shows the category description, the page URLs and screenshots.

Atlas stores the text excerpt and sends it to the portal, but the popup does not show it. The "Keywords" label appears only in the analyst raw-data view, as a list of keywords.

Source: marketview-portal `EvidencePopup.tsx`, section building and rendering; `FindingRawDataPopupContent.tsx:21`; mlrc-finding `FindingDto.java:29`.

### Gap

Clients do not see the matched keyword, the text excerpt, the highlight or the source page link.

### Requirement

1. For each keyword match on a content finding, the evidence popup shows the matched keyword.
2. The popup shows the text excerpt, with every occurrence of the keyword highlighted.
3. The popup shows a link to the page where the text was found.
4. The popup shows each image found on the page, with a link to that page.

<br>

## Gap 3: Censoring of Every Image on a URL

### MerchantView today

1. Client opens evidence for a finding on a URL.
2. If any finding on that URL is in a censored category, every finding's evidence images on that URL show a censored placeholder.
3. Any client user clicks the placeholder to reveal the image. Users with the Auditor role see the evidence uncensored.

MerchantView censors the other findings on purpose. The evidence of another category on the same website can show the same explicit content. US employees are not allowed to be exposed to explicit content at work. Prostitution was added to the censored categories after a client received Prostitution evidence with explicit content and no warning.

Source: Confluence, MerchantView Manual, [Explicit Content Censoring Mechanism](https://g2rs.atlassian.net/wiki/spaces/MM/pages/4026499236/Explicit+Content+Censoring+Mechanism), section 3; Jira [PRD-850](https://g2rs.atlassian.net/browse/PRD-850); merchantviewui `evidence-screenshot.component.html:5-6`; `evidence-screenshot.component.ts:39-43`; `scan-item.factory.ts`, censor handling.

### Atlas today

1. Client opens evidence for a finding in a censored category.
2. The screenshot shows "Sensitive Content", "This screenshot contains sensitive content" and "Click to reveal evidence".
3. A user with the reveal permission clicks to reveal it. A user without it sees "You do not have permission to reveal it" and cannot reveal the screenshot.

Atlas censors only the evidence of the censored category itself. Other findings on the same URL show their images uncensored. Atlas has two censor rules: the category's censor setting in the evidence popup, and a second rule that censors only categories under "Adult".

Source: marketview-portal `EvidencePopup.tsx:75, 114, 298-325`; `Strings.ts:550-553`; `FindingCensorService.ts:3-6`.

### Gap

Atlas shows uncensored images from a URL that has a censored finding. Atlas applies two censor rules. In MerchantView any client user can reveal a censored image. In Atlas only a user with the reveal permission can.

### Requirement

1. If any finding on a URL is in a censored category, Atlas censors every evidence image of every finding on that URL.
2. Atlas decides censoring by one rule: the category's censor setting.
3. Any client user can click a censored image to reveal it. No permission is required.

<br>

## Gap 4: Content Scanning in More Languages

### MerchantView today

Clients have no screen for this. G2 staff set it per account.

1. G2 staff turn on a language for the account. The languages are French, Spanish, German, Japanese, Dutch, Polish and Icelandic.
2. G2 staff turn on the same language for unreported URLs as a separate setting, for example "French unreported".
3. MerchantView sends the account's languages with each scan.

Source: mvserver `BankFlagEnum.groovy:48, 53-67`.

### Atlas today

Atlas has no language setting for an account or a portfolio.

Searched: mlrc-account, mlrc-finding, mlrc-bff-2.0 and marketview-portal for "language".

### Gap

Atlas cannot turn on content scanning in French, Spanish, German, Japanese, Dutch, Polish or Icelandic for an account.

### Requirement

1. G2 staff can turn on French, Spanish, German, Japanese, Dutch, Polish and Icelandic for an account, each on its own.
2. G2 staff can turn on each language for unreported URLs as a separate setting.
3. Each scan for the account analyzes content in the languages turned on.
4. A language turned on for reported URLs only does not apply to unreported URLs.

<br>

## Content Section on the Merchant Findings Page

### Requirement

1. The merchant findings page has a section named "Content".
2. The Content section lists every finding of the merchant in a content category.
3. A finding in a content category appears only in the Content section.
4. Findings in other categories do not appear in the Content section.

### Content Categories

This list sets which findings appear in the Content section: a finding in one of these 166 categories goes to the Content section, and a finding in any other category does not.

The list has not been compared against the MerchantView and Atlas category lists. Categories that MerchantView has and Atlas lacks, and categories Atlas has that MerchantView clients do not need, are not known.

| Category Type | Category | Category ID |
| --- | --- | --- |
| Content | Adult Content | 2 |
| Content | Gambling | 3 |
| Content | Prescription Drugs | 4 |
| Content | Premier League Tickets | 5 |
| Content | Alcohol | 6 |
| Content | Bestiality | 7 |
| Content | Rape/Hate/Violence | 9 |
| Content | CSAM | 10 |
| Content | Webcams | 12 |
| Content | Counterfeit/Stolen Goods | 14 |
| Content | Cashing Checks | 17 |
| Content | Collecting Debts | 18 |
| Content | Credit Restoration Services | 19 |
| Content | Pyramid Schemes | 21 |
| Content | Prostitution | 22 |
| Content | Modification Chips and Circumvention Devices | 25 |
| Content | Affiliate | 28 |
| Content | Ads Trap | 30 |
| Content | Firearms | 32 |
| Content | Tobacco | 34 |
| Content | ENDS Products | 35 |
| Content | Illicit Drugs | 36 |
| Content | Dating Service | 40 |
| Content | Copyright Infringement | 43 |
| Content | Cyber Locker | 44 |
| Content | Nutraceuticals | 45 |
| Content | Questionable Substances | 46 |
| Content | Medical Devices | 47 |
| Content | Negative Option Billing | 49 |
| Content | Adult Website Support | 51 |
| Content | Jammers/Signal Blockers | 53 |
| Content | Sex Toys | 54 |
| Content | Government Documents and Identifications | 57 |
| Content | Payday Loans | 58 |
| Content | Get-Rich-Quick Schemes | 62 |
| Content | Gift Cards | 63 |
| Content | Affiliation Network | 70 |
| Content | Online Shop Index | 77 |
| Content | Loans | 78 |
| Content | Cold Weapons | 79 |
| Content | Psychic Services | 83 |
| Content | Health Beauty Spas | 84 |
| Content | Fantasy Sports | 85 |
| Content | Sports Forecasting or Odds Making | 86 |
| Content | Marijuana | 88 |
| Content | Drug Paraphernalia | 89 |
| Content | Fireworks | 90 |
| Content | Forex | 93 |
| Content | Financial Institution | 94 |
| Content | Airlines | 96 |
| Content | Bail Bonds | 97 |
| Content | Bankruptcy Lawyers | 98 |
| Content | Cell Phones | 99 |
| Content | Computer Technical Support | 100 |
| Content | Credit Card and Identity Theft Protection | 102 |
| Content | Mortgage or Real Estate Consulting | 105 |
| Content | Securities Brokers & Investment Consultants | 109 |
| Content | Timeshares | 111 |
| Content | Lawn Garden/Nurseries | 127 |
| Content | Diplomatic Entities | 131 |
| Content | Digital Marketing | 132 |
| Content | Academic Fraud | 133 |
| Content | Cultural Artifacts | 134 |
| Content | Prepaid Cards | 137 |
| Content | Extended Warranty | 138 |
| Content | Racism | 144 |
| Content | Brands | 162 |
| Content | Hosting Provider | 163 |
| Content | Olympic Games Tickets | 166 |
| Content | Unsupervised Money Transfer | 171 |
| Content | Pharma OTC | 172 |
| Content | Eye Drops and Contact Lenses | 173 |
| Content | Teeth Whitening | 175 |
| Content | Digital Wallet | 179 |
| Content | Binary Options Trade | 180 |
| Content | Illegal Wildlife Trade | 181 |
| Content | Adult Entertainment | 192 |
| Content | Web Services | 198 |
| Content | Online Gaming | 199 |
| Content | Crowdfunding | 200 |
| Content | Multi-level marketing | 201 |
| Content | IP Rights Protected | 202 |
| Content | IP Rights Infringement | 203 |
| Content | Precious Metals | 209 |
| Content | Cosmetics | 210 |
| Content | Hair Extensions | 211 |
| Content | Crypto Currency | 217 |
| Content | Ticketing | 219 |
| Content | Amazon Pay Not Suppressed | 220 |
| Content | Insurance | 230 |
| Content | CBD Products | 233 |
| Content | Child Pornography HE | 251 |
| Content | Rape/Hate/Violence HE | 252 |
| Content | Beastiality HE | 253 |
| Content | Prostitution HE | 254 |
| Content | Illegal Substances HE | 255 |
| Content | Modification chips and circumvention devices HE | 256 |
| Content | Illegal wildlife trade HE | 257 |
| Content | Copyright Infringement HE | 258 |
| Content | Hemp and cannabis-derived products | 263 |
| Content | Hemp | 269 |
| Content | CBD | 270 |
| Content | Firearms Accessories | 271 |
| Content | Firearms - Other | 272 |
| Content | Edible CBD | 273 |
| Content | Smokable CBD | 274 |
| Content | Cannabis Seeds | 275 |
| Content | CBD Oil | 276 |
| Content | Non-Edible CBD | 277 |
| Content | THC Variants | 278 |
| Content | Counterfeit or Sold Documents | 279 |
| Content | Ghost Guns | 280 |
| Content | Stored Value | 281 |
| Content | Marketplaces | 282 |
| Content | IPTV | 283 |
| Content | Traveler Visa Services | 284 |
| Content | Social Media Marketing | 285 |
| Content | Third Party Payment Service Provider | 286 |
| Content | Auto-trading tools | 287 |
| Content | VPN | 288 |
| Content | Kratom | 289 |
| Content | Steroids | 290 |
| Content | NFT | 291 |
| Content | Non-Profit Organizations | 292 |
| Content | Crowdfunding | 293 |
| Content | CFDs | 294 |
| Content | Firearms-Antique | 295 |
| Content | Airsoft and Paintball Guns | 296 |
| Content | Crypto Exchange | 297 |
| Content | SARMs | 299 |
| Content | Violative Peptides | 300 |
| Content | IV treatments | 302 |
| Content | Medical spas | 303 |
| Content | Erotic Massage Parlors | 304 |
| Content | Credit Privacy Numbers | 305 |
| Content | High-Risk Securities | 306 |
| Content | Video Entertainment Rental Stores | 307 |
| Content | OEM software | 309 |
| Content | Drug Test Manipulation | 310 |
| Content | Virtual Assets | 311 |
| Content | Bank Debt Repayment | 312 |
| Content | Wholesale Pharmaceuticals | 313 |
| Content | Telemarketing | 314 |
| Content | Terror Financing | 315 |
| Content | Tainted Nutraceuticals | 316 |
| Content | Topical Treatments | 317 |
| Content | AI Generated Explicit Adult Content | 701 |
| Content | Penny auctions | 702 |
| Content | Fraudulent government services or assistance | 703 |
| Content | Deceptive marketing | 704 |
| Content | High Yield Investment Scams | 705 |
| Content | Buy-Now-Pay-Later | 706 |
| Content | P2P money transmitters | 707 |
| Content | Escrow services | 708 |
| Content | Funded prop trading | 709 |
| Content | Exchangers | 710 |
| Content | Registered Charities | 711 |
| Content | Telehealth services | 712 |
| Content | Sim/Phone cards | 713 |
| Content | Bankruptcy-related Services | 743 |
| Content | Topical Hemp | 744 |
| Content | Ingestible CBD | 745 |
| Content | Marijuana Plants, Products & Cannabis Seeds | 746 |
| Content | Smokable Hemp | 747 |
| Content | Higher-Risk Cannabinoids | 748 |
| Content | AI Deepfake Tools | 749 |

Source: ContentCompliance_Categories.csv, the rows marked Active and not marked Internal, without the test rows "testtest" (714) and "testtesttest" (715) and the "Not in Use" rows (114 and 130).

<br>

## Acceptance Criteria

**Scenario: Child sexual abuse imagery blocked**
- Given a URL has one finding in the child sexual abuse material category and one finding in another category
- When the user opens evidence for either finding
- Then every image shows "Image unavailable due to explicit content"
- And no reveal action is available

**Scenario: Keyword evidence**
- Given a content finding matched the keyword "kratom" on page /shop
- When the client opens the evidence
- Then the popup shows "kratom", the page excerpt with every "kratom" highlighted, and a link to /shop

**Scenario: URL-wide censoring**
- Given a URL has one finding in a censored category and one finding in an uncensored category
- When the client opens evidence for the uncensored finding
- Then its images show the censored placeholder
- And any client user can click the placeholder to reveal them

**Scenario: Content scanning in French**
- Given G2 staff turned on French for an account
- And French for unreported URLs is off
- When a merchant has a reported URL and an unreported URL with French content in a restricted category
- Then the scan returns a content finding for the reported URL
- And no French content finding for the unreported URL

**Scenario: Content section**
- Given a merchant has a Gambling finding and a finding in a category outside the content categories
- When the client opens the merchant findings page
- Then the Content section shows the Gambling finding
- And the Gambling finding appears in no other section
- And the other finding does not appear in the Content section

<br>

## Data

**Baseline**
- MerchantView clients registered for Content Compliance: TBD. Source: MerchantView client configuration.

<br>

## Open Questions / Assumptions

- Compare the content category list in MerchantView and Atlas with a query on the category database; neither codebase holds the list.
- Check with engineering whether Atlas page screenshots include the individual images found on the page, or only full-page screenshots.
- Check whether Atlas applies the MerchantView signup scan rule: content findings shown only with a score of 0 or at least 80, and never "Premier League Tickets".
- Decide whether the card-brand warning on regulated categories is in scope: "This category is regulated by the credit card brands and may incur fines." It is missing in Atlas and applies to any regulated category.
- Check with engineering how content findings appear in Atlas reports: MerchantView reports link each content finding to its evidence and list keywords.
- Confirm the migration date that sets why now.
- Check with engineering whether the Atlas scanning engine detects page language without an account setting; only the Atlas portal, account, finding and API layer code was searched.
- List the MerchantView clients with each language turned on, to set the starting languages for each migrated client.
- ASSUMED: Behavior comes from the MerchantView code last committed in August 2026 and the Atlas code on its default branch as of November 8, 2026.
