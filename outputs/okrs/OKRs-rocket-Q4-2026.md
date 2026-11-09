# Rocket Team OKRs, Q4 2026

Q4 ends February 27, 2027. Each Rocket project is listed once, under the company Key Result it moves most. Projects are the items marked Must in the Q4 group of the Atlas Migration Packages Roadmap monday board, Dev Team = Rocket.

NAB is the first client to migrate to Atlas, close to the end of Q4. NAB parity projects are the projects marked NAB on the monday board: Full MCC Parity, WebID, Client Data Migration, Wizard for Add Merchant MVP, and Finding Dispute and Reassessment. They are ready and used by NAB by December 31, 2026.

## Objective: Bottom Line Efficiencies

| Rocket project | Company KR | What it changes |
|---|---|---|
| Full MCC Parity, MVP | Analyst efficiency and faster reporting | Atlas shows each store's predicted Merchant Category Code next to the reported code and flags a mismatch the way MerchantView does today. |
| WebID | Analyst efficiency and faster reporting | For a merchant with no website on file, Atlas finds the website from the merchant details the client has: business email domain first, then the identity graph, then web search. It accepts a website only on strong evidence and otherwise returns not identified. The found site goes into monitoring automatically or after analyst approval. |
| Existing Merchant Management | Analyst efficiency and faster reporting | Sets the logic for approving a merchant after its onboarding scan, lets clients move a scanned onboarded merchant to monitoring manually, and splits results into Monitored and Onboarding tabs. |
| CRAM & WSL Risk Assessment | Analyst efficiency and faster reporting | Atlas shows the Consumer Ratings and Adverse Media results, meaning public reviews, complaints, and news coverage, and the Watchlist, Sanctions, and Legal results, meaning sanctions, watchlist, and legal-case matches. The analyst resolves each finding as Risk or No Risk with a reason. |
| Client Data Migration, including migration POC | Consolidate and Modernize Product Portfolio | Maps and transforms legacy client data so it is ready to migrate to Atlas, starting with NAB. |
| CC / UI full parity validation | Consolidate and Modernize Product Portfolio | Validates that Atlas has full parity with MerchantView. |
| Wizard for Add Merchant, MVP | Consolidate and Modernize Product Portfolio | Takes the client step by step through adding a merchant. |
| Wizard for Add Merchant, Enhancements | Consolidate and Modernize Product Portfolio | Collects the merchant details up front, ending the offline back-and-forth: portfolio selection, choice of services per merchant, moving an approved merchant to monitoring automatically or manually, a monitored or onboarding filter, and login fields for password-protected websites, in single and bulk add. |
| Finding Dispute and Reassessment | Consolidate and Modernize Product Portfolio | The client disputes a released finding, adds evidence, and tracks its status; G2RS reassesses it, corrects the risk resolution if needed, and re-releases it, with the full dispute history kept. |
| Help Center in Atlas | Consolidate and Modernize Product Portfolio | User guides inside Atlas that show clients how to use the platform and each feature, so users do not need to contact Customer Support or Customer Success. |

## Objective: Top Line Sustainable Growth

| Rocket project | Company KR | What it changes |
|---|---|---|
| Graph Enhancement: evidence screenshots for violations | Graph and Merchant Map: First New Use Case | Each connected site with a violation shows the evidence screenshot in addition to the URL, with connected sites' screenshots side by side. |
## Objective: Retention and Customer Value

| Rocket project | Company KR | What it changes |
|---|---|---|
| Website Pages Change Detection, Phase 1 | User Engagement: Distilled Value | G2RS monitors merchant pages daily, weekly, or monthly, captures before and after screenshots of every change, and analysts review changes before they reach the client's Excel report. |
| "New" indication for scan | User Engagement: Distilled Value | Adds a New flag to each new scan. |
| Web Traffic | User Engagement: Distilled Value | Atlas shows a merchant website's SimilarWeb traffic metrics, backlinks, and referring domains, flags suspicious traffic, compares trends, and lets the analyst resolve a traffic or backlink finding. |
| Legacy MV support | Usage Growth: Maintenance | MerchantView keeps running for clients that have not moved to Atlas, so they keep screening until they migrate. |
| Front Side Detection, Application | User Engagement: Distilled Value | Atlas shows a front site finding, set per portfolio: a merchant built to pass onboarding checks while hiding fraud, scams, or laundering. Only critical findings, over 90% precision, are shown, and each one calls for manual review before activation or continuation. |

## How each KR is measured

For NAB migration KRs, the primary success metric is measured in Q4 and the secondary on NAB in Atlas 30 days after cutover. For the other KRs, the primary success metric is measured from each project's release and the secondary 30 days after release. Baselines come from MerchantView usage data, August to October 2026. Primary success metrics are leading indicators of adoption, speed, and quality; secondary success metrics are lagging indicators of outcome. Targets without a baseline are initial and are revised after the first 4 weeks of data.

| Company KR | Primary success metric | Secondary success metric |
|---|---|---|
| Analyst efficiency and faster reporting | Full NAB parity in production by December 31, 2026. Measured from release: decrease time from onboarding scan to approval decision: 3 business days or less. Decrease time from approval to first monitoring scan: 7 days or less. Decrease time to resolve a CRAM or WSL finding as Risk or No Risk: 2 business days or less | Decrease time from opening a merchant to the violation decision: 32 to 30 minutes. Increase opened merchants decided within 1 day: 84% to 88% |
| Consolidate and Modernize Product Portfolio | Full NAB parity in production by December 31, 2026. Increase clients migrated to Atlas onboarding and monitoring: 0 to 1, NAB. Measured from release: close parity gaps that block client migration by end of Q4: 0 open. Decrease merchant additions that need offline follow-up for missing details: 10 or fewer per month. Keep how-to support tickets per client per month: 2 or fewer | Keep support tickets from NAB in the 30 days after cutover: 10 or fewer. Reach NAB user satisfaction with Atlas, measured through user interviews: 4 of 5 or higher |
| Graph and Merchant Map: First New Use Case | Measured from release: decrease time to decide a connected-site violation: 1 business day or less | Increase connected-site evidence views per month: increase by 10% (baseline 92) |
| User Engagement: Distilled Value | Measured from release: decrease false positive rate of detected page changes: 40% or less. Decrease time from scan to first view of new findings: 2 days or less. Decrease time to resolve a traffic or backlink finding: 5 business days or less. Keep front site finding precision: 90% or higher. Decrease time to review a front site finding: 1 business day or less | Increase finding decisions per month: 8,994 to 9,900. Decrease disputes submitted per month: 116 to 104 or fewer |
| Usage Growth: Maintenance | Measured monthly in Q4: keep MerchantView support tickets per month: no increase | Keep merchants added per month in MerchantView: 1,672 or more |

## Check-in Cadence

- **Weekly:** red, amber, or green per KR in the Rocket sync.
- **Mid-quarter:** review KRs against actuals; adjust if migration order or scope changed.
- **End of quarter:** score each KR and feed results into next quarter's planning.
