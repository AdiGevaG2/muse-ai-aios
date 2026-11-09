# Content Compliance Parity: MerchantView vs Atlas

Checked: 2026-11-05. Scope: every Content Compliance capability MerchantView offers, and whether Atlas offers it. Content Compliance means the website content findings product: restricted content categories, evidence, decisions, risk settings, reports and integrations.

## Verdict

Atlas does not have full Content Compliance parity with MerchantView. Of 21 MerchantView capabilities checked, Atlas has 4, has 5 in part, lacks 4, and 8 remain unverified.

This is a code comparison. It shows what exists in source, not what is deployed or switched on for each client.

Each status in the capability table means the following. Present: Atlas source has the capability as MerchantView offers it. Partial: Atlas source has the capability, with a confirmed difference. Missing: the inspected Atlas source does not have it. Unverified: the comparison did not reach a conclusion, because one side was not checked or not confirmed.

## Gaps: Atlas behind MerchantView

The gaps cover every Missing row and the missing part of every Partial row. Each gap names its table row.

1. Clients cannot see a finding's change history. Row: See a finding's change history.
2. Clients cannot add a note to a single finding. Row: Add a note to a finding.
3. Clients do not see text or keyword evidence. Row: Text snippet and keyword evidence.
4. Clients cannot rescan a single URL or start an on-demand scan. Rows: Rescan a single URL; Scan modes.
5. Clients do not receive webhook callbacks per scan. Row: Webhook callbacks per scan.
6. Clients cannot download a PDF report. Row: Download a report.
7. Clients cannot set separate severity for reported and unreported URLs. Row: Category risk settings with reported and unreported URL severity.

## Capability Table

| MerchantView capability | Atlas | Difference |
| --- | --- | --- |
| Set a finding's status | Present | The list of Atlas status values was not re-checked on the latest code. |
| Snooze a finding, with expiry, edit and cancel | Present | Shown only when the portfolio snooze setting is on. |
| Snooze a URL | Present | Same portfolio setting. |
| Screenshot evidence with page URL | Present | |
| Add a note to a finding | Partial | Notes per merchant and per dispute, not per finding. |
| Filter, search and saved filters on findings | Partial | Filters are at merchant and portfolio level. A findings list across all merchants was not checked. |
| Download a report | Partial | CSV present. PDF not found. |
| Category risk settings with reported and unreported URL severity | Partial | Category risk settings present. Reported and unreported split not found. |
| Scan modes: boarding, scheduled, on-demand | Partial | Boarding and scheduled monitoring present. Client-triggered on-demand scan not found. |
| See a finding's change history | Missing | |
| Rescan a single URL | Missing | An internal reprocess exists; no client action found. |
| Text snippet and keyword evidence | Missing | |
| Webhook callbacks per scan | Missing | |
| Email when a snooze expires | Unverified | Not found in the inspected Atlas repositories. The repository that connects the Atlas portal to its services was not searched. |
| Assign an owner | Unverified | Atlas assigns per merchant. Whether MerchantView assigns per finding or per merchant is not confirmed. |
| Client API to read and update findings | Unverified | Atlas has an API to read findings. Whether clients can use it is not established. No way to update findings through the API was found. |
| Finding counters and summary dashboard | Unverified | Not checked. |
| Export risk settings | Unverified | Not checked in Atlas. |
| Automation rules that react to findings | Unverified | Atlas has portfolio rules. Triggers not compared. |
| Permissions on Content Compliance actions | Unverified | Not compared. |
| Risk calculation behavior | Unverified | Atlas risk service not re-read on the latest code. |

Atlas has three capabilities MerchantView lacks:

- Bulk decision changes and disputes on findings.
- Analyst marking of findings as false positive or reviewed.
- Ignoring a store.

## Change Since the October 20 Comparison

The October 20 comparison recorded Atlas snooze as a setting only. Atlas portal code now has finding and URL snooze with expiry, edit and cancel.

## Out of Scope

Findings on undisclosed merchants and transaction laundering are not Content Compliance and were not compared.

## Evidence and Limits

Default branch `develop` in every repository, as published on 2026-11-05. Local working copies were not used.

| Repository | Commit | Date |
| --- | --- | --- |
| merchantviewui | 0eb1473a | 2026-08-25 |
| mvserver | b4d04b6d | 2026-08-24 |
| mvnextgen | a1994e1c | 2026-08-24 |
| marketview-portal | 2795e1b0 | 2026-11-05 |
| mlrc-risk | 34b2209b | 2026-10-04 |
| mlrc-finding | b11f95a8 | 2026-10-04 |
| mlrc-account | 8ea581e8 | 2026-11-05 |

MerchantView commits are from August because MerchantView has no later commits on its default branch.

- No deployment, client entitlement or runtime check ran.
- The repository that connects the Atlas portal to its services was not searched, so a snooze-expiry email or client API there is not ruled out.
- Only recent mlrc-finding history was downloaded, so older changes in that repository were not visible.
- Prior analysis: [Content Compliance across Atlas, MV, WS and SP](../content-categories/current-state/content-compliance-platform-comparison.md), October 20, 2026.
- Confluence search outside the Unified Platform space found no existing MerchantView vs Atlas Content Compliance parity page.

### Brain Sources

- [G2RS glossary](../../org-brain/glossary/g2rs-terms.md): Content Compliance definition.
- [Atlas product areas](../../domains/atlas/second-brain/context/product-areas.md): records Content Compliance target ownership and parity as unknown. This document is the first parity evidence for it.
- The brains have no feature page for Content Compliance parity.

### Source Anchors

MerchantView: `merchantviewui` finding.service.ts:57, :76, :105, :122, :146, :183, :192, :196; risk-matrix.service.ts:40, :78; scan.service.ts:54, :63, :79; grid-action-buttons.component.ts:132; report.component.html:94. `mvserver` FindingSnoozeApi4Controller.groovy:23-46; UrlSnoozeApi4Controller.groovy:23-46; NotificationSenderService.groovy:78; UrlScanRequestApiController.groovy:39; EvidenceApi4Controller.groovy:87; FindingApi4Controller.groovy:30, :37; CallbackApi4Controller.groovy:45-163. `mvnextgen` ContentEvidenceCreator.java:26; KeywordEvidenceCreator.java:17.

Atlas: `marketview-portal` mlrc-bff generated api.ts:2515, :2557, :2600, :4061, :4554, :4603, :4766, :5573, :6083, :6238, :7373, :7458, :7726-7863; snoozeService.ts:32; useSnoozeEnabled.ts:5; useUrlSnoozeMenu.tsx; MerchantCommentsModal.tsx; FindingReportButton.tsx:48; DownloadReportsModal.tsx; FindingsBulkBar.tsx:61, :72; EvidencePopup.tsx:70-74, :171-178; MerchantDetails.tsx:40. `mlrc-finding` FindingController.java:90, :124; FindingRetriggerController.java:94; FalsePositiveController.java:49, :72; ReviewedController.java:53.

## Open Questions

- Decide which of the seven gaps Atlas must close before MerchantView clients migrate.
- Confirm whether the portfolio snooze setting is on for migrating MerchantView clients.
- Confirm with engineering whether clients can use the Atlas API to read findings.
