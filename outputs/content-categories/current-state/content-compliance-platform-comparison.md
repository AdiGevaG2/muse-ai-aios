# Reverse Engineering: Content Compliance across Atlas, MV, WS and SP

Verified: 2026-10-20. Mode: Quick. Scope: Atlas compared with Merchant View, WebShield and Single Platform. CC means Content Compliance, as named in [the NAB capability map](https://g2rs.atlassian.net/wiki/spaces/UP/pages/4142202884). Content categories are one part of CC. This is current-state evidence, not a proposed spec or a production certification.

## Executive Summary

- Atlas has CC configuration, merchant/store findings, evidence, category controls and risk overrides in source. The older local conclusion that Atlas lacks CC UI is contradicted by its portal code.
- MV combines findings, image/text evidence, reviewer decisions, temporary snooze and category risk configuration. Its risk matrix distinguishes reported from unreported URLs.
- SP combines automated ingestion with analyst classification, customer-specific risk policy and publication. Its public APIs expose published URL cases, screenshots and action/reason submissions.
- WS's historical PHP snapshot shows keyword/category findings, human verification, false-positive clearing, archived pages and PDF alerts. **Current WS support is NOT VERIFIED:** its remote requires credentials. Local historical code is the alternate evidence route; it does not establish current parity.
- Category labels alone cannot establish migration parity. The consequential differences are decision states, publication/review gates, risk policy, evidence and delivery contracts. Detector coverage and quality were not compared.

## Current Behavior by Platform

Source keys below link to the exact inspected files. “Present” means present in the cited source, not proven deployed or enabled for every customer.

| Capability | Atlas | MV | WS: historical, current unverified | SP |
| --- | --- | --- | --- | --- |
| Enablement and scan context | Separate portfolio CC switches for onboarding and monitoring. Account contract also has CC enablement. [A1] | Boarding, scheduled monitoring and on-demand scan modes exist. CC-specific scan controls not established. [M5] | Public-area violation scanning and monitoring reports are evidenced; cadence and entitlement unknown. [W1, W4] | PMM ingestion and boarding CC results exist; trigger and scheduling controls not traced. [S1, S5] |
| Detection and review | Findings arrive with category and evidence; category settings affect active status. Model quality/coverage unverified. [A2, A3] | Automated content evidence ingested; content and keyword evidence use different presentation paths. Detector algorithm unverified. [M1] | Keyword findings join scoring categories. Reports select human-marked findings and distinguish potential/confirmed violations. [W1] | Crawl/abuse aggregates become URL findings; merchant-group rules can auto-classify, followed by analyst classification and publication. [S1, S2] |
| Evidence | Descriptions, detected URL, redirect links, screenshots and last-detected date in portal. [A3] | Images, source pages and text snippets with location. [M1] | Affected URL, extracted keywords, scan date and saved scanned page. [W3] | Category/subcategory, policy notes and screenshot URLs in CC results. [S5] |
| Decisions and temporary exceptions | Customer choices: Violation, Not Violation, Not Set. Analyst snooze flag is defined, default off; implementation/deployment not established here. [A4, A6] | Status changes, notes/history; finding or URL snooze with expiry and cancellation. [M2, M3] | False Positive Clearing, Skip Alert, final-status and violation-category controls. Timed snooze not verified. [W2] | Classify, reclassify, remove and bulk classify; published classifications lock except during reprocessing. Customer API accepts action/reason pairs. [S2, S4] |
| Risk customization | Portfolio category enablement and risk overrides. Customer decisions affect finding risk. [A2, A5] | Per-category severity with separate Reported and Unreported URL values; config export. [M4] | Scoring categories exist; customer risk-configuration parity unknown. [W1] | Merchant-group policy overrides default category/subcategory severity, with vertical/region context. [S3] |
| Results and integration | Portal findings retrieval confirmed. Public client read/action parity unresolved due conflicting documentation. [A3, D1, D2] | V4 finding read/update includes category, risk, notes/status and conditional snooze indicator. That particular response omits evidence. [M2] | Verified-finding PDF alerts and service feedback. Public CC API parity unknown. [W4, W5] | Public published-case/details/screenshots APIs and action/reason submission. Boarding has its own CC result endpoint. [S4, S5] |

## Business Rules to Preserve When Assessing Parity

These are observed platform rules, not newly approved Atlas requirements.

1. **Separate service enablement from category handling.** Atlas has onboarding/monitoring CC switches as well as category settings; category filtering at ingestion does not prove that the scanner skips disabled categories. [A1, A2]
2. **Preserve the evidence location.** URL, page and image/text context matter alongside a category label. WS archived pages and SP screenshots require distinct evidence mappings. [A3, M1, W3, S5]
3. **Preserve customer risk policy.** MV's reported/unreported distinction and SP's merchant-group/vertical/region policy cannot be assumed equivalent to Atlas portfolio severity overrides. [M4, S3, A5]
4. **Keep customer verdicts and analyst decisions distinguishable.** Atlas's risk resolver gives customer verdicts precedence over analyst false-positive suppression. [A5]
5. **Keep snooze separate from permanent decisions.** MV stores expiry and supports cancellation. Atlas's feature declaration and WS's Skip Alert control do not independently establish equivalent timed behavior. [M3, A6, W2]
6. **Preserve review and publication boundaries.** WS PDF findings are human-marked; SP locks classification after publication except during reprocessing. A migration must map which results become customer-visible. [W4, S2]
7. **Do not copy classification limits across platforms.** SP's inspected individual classification service allows at most two enabled classifications per URL. That limit was not verified for all ingestion routes or other platforms. [S2]
8. **Map result and action contracts separately.** SP case action/reason, MV status/notes and Atlas customer verdicts are different contracts. Exposing a portal endpoint does not establish a supported external customer API. [S4, M2, A4, D1, D2]

## Target Platform: What Exists

Atlas's inspected source contains portfolio CC controls, category configuration, merchant/store findings, evidence presentation, customer verdict updates and risk handling. Customer visibility is also distinct from analyst visibility: the findings service returns active, non-held findings to customers, while analysts can receive review-managed held/inactive records. [A1-A5, A7]

This corrects the UI assessment in the September 17 [content-category investigation](content-categories-reverse-engineering.md), which searched the merchant backend rather than the portal. That investigation and its [gap-impact follow-up](content-categories-gaps.md) remain historical artifacts; neither was overwritten.

## Gaps and Conflicts

| Question | Supported conclusion | Remaining gap |
| --- | --- | --- |
| Does Atlas lack CC UI? | No. Portal CC switches, category configuration and evidence exist in the inspected source. | Current deployment, permissions and customer entitlements remain unverified. |
| Does Atlas preserve legacy workflow semantics? | The source contracts differ across the platforms. | No demonstrated mapping for MV snooze/reporting, SP publication/action reasons, or WS verification/clearing. This is unverified parity, not proof those capabilities are absent. |
| Is Atlas's client API write-only? | Documentation conflicts: June 20 Monitoring API discovery says retrieval/status exist; August 10 NAB map says write-only. Portal/internal reads are confirmed. [D1, D2, A3] | Trace the external client controller, authorization and response contract before claiming either public read support or a confirmed gap. |
| Does WS have MV-style snooze/API behavior? | The June documents combine “EverC/WebShield”; inspected MV code proves MV snooze. Actual WS PHP shows different review controls. | No linkage proves those Java/API/snooze claims apply to WS. Do not carry the combined label into a platform parity claim. [D1, D3, M3, W2] |
| Do all platforms run the same classifiers? | Not established. A classification-rollout brief describes qualified category groups and configuration-dependent rollout. [D4] | Category mapping, active models, languages, crawl depth, thresholds, accuracy and production rollout need independent evidence. Shared labels/origin IDs do not prove an identical detector. |

No target product behavior is selected here. The product decision, if migration parity is required, is which legacy decision, publication and risk semantics Atlas must preserve.

## Evidence Gaps and Freshness

- No runtime, deployed-environment or customer-entitlement checks ran. No performance, recall or precision comparison ran. Analysis used targeted source reads and live Rovo retrieval.
- Repo remote reachability was checked read-only. Below, remote means the remote default HEAD from `git ls-remote origin HEAD`, **not a computed ahead/behind count or a same-branch ancestry comparison**. No fetch, pull, checkout or stash ran.
- MV: `merchantviewui` develop `0eb1473`, August 25, clean, matches remote HEAD; `mvnextgen` develop `a1994e1`, August 24, clean, matches remote HEAD. Both snapshots exceed the three-week freshness threshold. `mvserver` master `236d620`, July 9, dirty, differs from remote HEAD `b4d04b6`; backend conclusions reflect the working copy.
- Atlas: portal develop `d778d72`, June 11, dirty, differs from remote HEAD `b8fec93`. Risk develop `34b2209`, October 4, clean, matches remote HEAD. Findings develop `b11f95a`, October 4, dirty, matches remote HEAD before local changes. Account develop `a5f0f7b`, September 16, clean, differs from remote HEAD `03868a5`. Portal/account snapshots exceed three weeks; current UI availability must not be inferred from their source date.
- SP: master `0a33215`, October 7, clean, differs from remote HEAD `4620c45`. Later remote changes were not inspected.
- WS: main `b3699ea`, July 21, clean, exceeds three weeks. Remote `xcode.swdev.ws` rejected unauthenticated access. **Current WS platform NOT VERIFIED.** Historical PHP evidence and Rovo are the alternate route; current absence claims are not supported.
- Full taxonomy correspondence, category-specific detection coverage, history retention, report-field parity and every role's permissions remain unknown. API presence does not establish entitlement or a supported customer contract.

## Source Evidence

Paths below are the inspected local snapshots. Line anchors identify relevant implementations; surrounding methods were read where needed.

### Atlas

- **A1:** [Portfolio CC switches](/Users/adig/vsCode/code-repos-git/unified-platform-new/marketview-portal/src/features/settings/pages/MLRCPage/Modals/Portfolio/PortfolioGeneralSettings.tsx:226); [account product enablement](/Users/adig/vsCode/code-repos-git/mlrc-account/api/src/main/java/com/everc/mlrc/account/api/dto/ProductConfig.java:9).
- **A2:** [Portfolio category risk/enablement](/Users/adig/vsCode/code-repos-git/unified-platform-new/marketview-portal/src/features/settings/pages/MLRCPage/Modals/CategoryConfigurationModal/UseCategoryConfiguration.ts:64); [category settings affect active findings](/Users/adig/vsCode/code-repos-git/mlrc-finding/consumer/src/main/java/com/everc/finding/consumer/service/FindingExtractorService.java:163).
- **A3:** [Portal findings retrieval](/Users/adig/vsCode/code-repos-git/unified-platform-new/marketview-portal/src/features/MerchantDetails/services/findingService.ts:7); [evidence presentation](/Users/adig/vsCode/code-repos-git/unified-platform-new/marketview-portal/src/features/MerchantDetails/Drawer/tabs/EvidencePopup/EvidencePopup.tsx:133).
- **A4:** [Customer verdict choices](/Users/adig/vsCode/code-repos-git/unified-platform-new/marketview-portal/src/features/MerchantDetails/Drawer/tabs/FindingStatusSelector/FindingStatusSelector.tsx:38).
- **A5:** [Category risk configuration](/Users/adig/vsCode/code-repos-git/unified-platform-new/mlrc-risk/risk-consumer/src/main/java/com/everc/risk/consumer/service/RiskCalculationService.java:131); [customer/analyst risk precedence](/Users/adig/vsCode/code-repos-git/unified-platform-new/mlrc-risk/risk-consumer/src/main/java/com/everc/risk/consumer/service/FindingRiskOverrideResolver.java:58).
- **A6:** [Analyst snooze feature declaration, default off](/Users/adig/vsCode/code-repos-git/mlrc-account/api/src/main/java/com/everc/mlrc/account/api/service/FeatureFlagRegistry.java:30). Declaration only; executable lifecycle not verified.
- **A7:** [Customer versus analyst visibility](/Users/adig/vsCode/code-repos-git/mlrc-finding/api/src/main/java/com/everc/finding/api/service/FindingApiService.java:227).

### Merchant View

- **M1:** [Content evidence creation](/Users/adig/vsCode/code-repos-git/merchant-view-legacy-ec/mvnextgen/merchant-processor-job/src/main/java/com/everc/nextgen/mpj/service/scannedmerchant/evidence/ContentEvidenceCreator.java:36); [evidence-format routing, not the detector](/Users/adig/vsCode/code-repos-git/merchant-view-legacy-ec/mvnextgen/merchant-processor-job/src/main/java/com/everc/nextgen/mpj/service/scannedmerchant/evidence/EvidenceClassifier.java:45).
- **M2:** [UI decisions, notes and history](/Users/adig/vsCode/code-repos-git/merchant-view-legacy-ec/merchantviewui/src/app/core/services/finding.service.ts:51); [V4 read/update](/Users/adig/vsCode/code-repos-git/merchant-view-legacy-ec/mvserver/MerchantViewServerAPI/grails-app/controllers/v4/com/evercompliant/api/FindingApi4Controller.groovy:29); [V4 result fields](/Users/adig/vsCode/code-repos-git/merchant-view-legacy-ec/mvserver/MerchantViewServerCommon/src/main/groovy/com/evercompliant/api/marshaller/Finding4CommandMarshaller.groovy:32).
- **M3:** [Finding/URL snooze, expiry and audit](/Users/adig/vsCode/code-repos-git/merchant-view-legacy-ec/mvserver/MerchantViewServerCommon/grails-app/services/com/evercompliant/services/data/FindingStatusSnoozeService.groovy:63).
- **M4:** [Risk matrix editing](/Users/adig/vsCode/code-repos-git/merchant-view-legacy-ec/merchantviewui/src/app/pages/settings/risk-matrix/risk-matrix.component.ts:54); [reported/unreported risk export](/Users/adig/vsCode/code-repos-git/merchant-view-legacy-ec/merchantviewui/src/app/core/services/risk-matrix.service.ts:77).
- **M5:** [Scan modes](/Users/adig/vsCode/code-repos-git/merchant-view-legacy-ec/merchantviewui/src/app/core/services/scan.service.ts:19).

### WebShield: historical alternate evidence

- **W1:** [Public-area CC report and violation history](/Users/adig/vsCode/code-repos-git/ws-legacy/ws-backend/include/class/sentinel/report.sentinel.class.php:685).
- **W2:** [False-positive clearing, skip and category/status review](/Users/adig/vsCode/code-repos-git/ws-legacy/ws-backend/include/class/mon/mon.class.php:1934).
- **W3:** [URL, keywords, scan date and saved-page evidence](/Users/adig/vsCode/code-repos-git/ws-legacy/ws-backend/backend/mon/mon_mmp.php:519).
- **W4:** [Verified-finding PDF alert](/Users/adig/vsCode/code-repos-git/ws-legacy/ws-backend/include/class/mon/mon.report.class.php:1254).
- **W5:** [Service feedback selection](/Users/adig/vsCode/code-repos-git/ws-legacy/ws-backend/include/class/smc/monitor.service.class.php:109).

### Single Platform

- **S1:** [Crawl/abuse ingestion](/Users/adig/vsCode/code-repos-git/single-platform-legacy-g2/g2-singlePlatform/data_ingestion/src/main/java/com/g2llc/ingestion/messaging/listener/TCEMessageSeedCompleteReceiver.java:398); [automatic classification](/Users/adig/vsCode/code-repos-git/single-platform-legacy-g2/g2-singlePlatform/data_ingestion/src/main/java/com/g2llc/ingestion/messaging/proxy/TCEMessageProxyToCoreDataServices.java:1339).
- **S2:** [Classification limit, publication and reprocessing rules](/Users/adig/vsCode/code-repos-git/single-platform-legacy-g2/g2-singlePlatform/data_core/src/main/java/com/g2llc/saga/cases/services/CategoryURLCaseServices.java:215); [bulk classification](/Users/adig/vsCode/code-repos-git/single-platform-legacy-g2/g2-singlePlatform/data_core/src/main/java/com/g2llc/saga/cases/services/CategoryURLCaseServices.java:806).
- **S3:** [Risk policy lookup](/Users/adig/vsCode/code-repos-git/single-platform-legacy-g2/g2-singlePlatform/data_core/src/main/java/com/g2llc/saga/cases/services/CategoryURLCaseServices.java:495); [merchant-group category controls](/Users/adig/vsCode/code-repos-git/single-platform-legacy-g2/g2-singlePlatform/risk_policy/src/main/java/com/g2llc/riskpolicy/services/MerchantGroupRiskPolicyCategorySubcategoryMappingService.java:306).
- **S4:** [Published cases API](/Users/adig/vsCode/code-repos-git/single-platform-legacy-g2/g2-singlePlatform/public_api/src/main/java/com/g2llc/publicapi/endpoint/PublishedUrlCasesController.java:28); [screenshots API](/Users/adig/vsCode/code-repos-git/single-platform-legacy-g2/g2-singlePlatform/public_api/src/main/java/com/g2llc/publicapi/endpoint/CaseScreenshotController.java:29); [CC action/reason API](/Users/adig/vsCode/code-repos-git/single-platform-legacy-g2/g2-singlePlatform/public_api/src/main/java/com/g2llc/publicapi/endpoint/ActionCaseController.java:39).
- **S5:** [Boarding CC classifications, notes and screenshots](/Users/adig/vsCode/code-repos-git/single-platform-legacy-g2/g2-singlePlatform/client/src/main/java/com/g2llc/client/go/services/ClientBoardingCaseService.java:1102); [manual/automated content score](/Users/adig/vsCode/code-repos-git/single-platform-legacy-g2/g2-singlePlatform/client/src/main/java/com/g2llc/client/go/services/ClientBoardingCaseService.java:791); [boarding CC endpoint](/Users/adig/vsCode/code-repos-git/single-platform-legacy-g2/g2-singlePlatform/client/src/main/java/com/g2llc/client/go/endpoint/v1/ClientBoardingCaseController.java:251).

### Documentation and context

- **D1:** [Monitoring API discovery](https://g2rs.atlassian.net/wiki/spaces/UP/pages/4032593942), dated June 20, 2026. Mixed “EverC/WebShield” attribution is not proof of actual WS PHP behavior.
- **D2:** [NAB capability support](https://g2rs.atlassian.net/wiki/spaces/UP/pages/4142202884), verified August 10, 2026. Establishes the CC name; external API claim conflicts with D1.
- **D3:** [Snooze discovery](https://g2rs.atlassian.net/wiki/spaces/UP/pages/4032593972), dated June 20, 2026. Legacy platform attribution requires separation.
- **D4:** [Content classification rollout brief](https://g2rs.atlassian.net/wiki/spaces/CATS/pages/4031382591). Describes rollout planning; not proof of current category activation.
- [Atlas product-area context](/Users/adig/vsCode/muse-ai-os/domains/atlas/second-brain/context/product-areas.md:27) marks CC ownership/parity unresolved. The [repo map](/Users/adig/vsCode/code-repos-git/REPO-MAP.md:1) and company-brain router were used for routing only; both omit the available WS checkout, and the company router omits SP's separate G2 organization.
