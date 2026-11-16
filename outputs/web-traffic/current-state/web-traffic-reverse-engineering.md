# Reverse Engineering: Web Traffic

Scope: Web Traffic in MerchantView (MV), Single Platform (SP) and WebShield (WS). Target: Atlas. Mode: Quick.
Evidence: local clones in `code-repos-git` at commit 0ea9af4 (2026-09-06), `ufp-backend` at b1f96e5 (2026-09-01); Confluence and Jira read 2026-11-09. Local clones are about two months old; treat as a caveat.

## Executive Summary

- WS and SP both show Similarweb traffic to analysts and score it. MV shows only a Tranco rank and Scamadviser pageviews, with no visits, countries, sources or referrers.
- WS has the richest display: monthly visits graph, audience countries, traffic sources, Similarweb share per outgoing/backlink URL, related mobile apps, and monitoring alerts on visit changes.
- SP shows a risk flag (Low / Medium / High), a top-10 country table with pages per visit and bounce rate, and a 6-month visits trend. Onboarding (GO) adds referrals, traffic sources and related apps. Monitoring (RM) compares the flag with the previous run.
- No legacy product separates "No traffic data available" from "Zero visits". WS and SP both treat them as the same value, and SP has a client-reported defect on exactly this (G2ENG-24592, FortunePay: "Low - 0" flag shown with "No information found for this URL").
- None of the three products compares traffic with transaction volume. The Ballerine-style traffic-versus-transactions check is new for Atlas.
- Atlas has no traffic display or traffic finding in production code. K9, the detection team whose Jira project and Confluence space carry this work, has planned work to send web traffic and backlink findings to Atlas through the MV adapter (K9-1249, K9-1283, target 28 Feb 2027), and a draft data contract for a Similarweb adapter that is meant to back an Atlas "Traffic Intelligence" view.

## Current Behavior by Platform

### WebShield

| Area | Behavior | Source |
|---|---|---|
| Investigation view | Similarweb box: "Data retrieved on" timestamp, Visitor Information ("approx. N per month" plus monthly graph), Audience Geography (country, flag, share; under 0.5% hidden), Traffic Sources (share per source; "Mail" shown as "E-Mail", "Search" as "Paid Search") | `gate_site_visitor.php:39-44`; `SimilarwebView.php:173-450` |
| Outgoing / backlinks tab | "SW" column with Similarweb share per URL, next to Majestic ("MJ") link count | `gate_site_out_back.php:85-106` |
| Mobile apps tab | Related apps list | `gate_site_mobile_apps.php:20-22` |
| Engagement | Not shown. Only visits are used from the provider response | `sentinel.class.php:4488` (inferred) |
| Monitoring | "Visitors" monitor item per site; alert detail shows 12-month visits graph before the alert date | `multi.mon.class.php:132, 3288`; `json_monitor_view.php:396-408`; `mon.class.php:5335-5360` |
| Reports | PDF investigation report has visits line, audience geography and mobile apps; History report has a 24-month visits graph | `report.gate.class.php:2693-2761`; `report.history.class.php:1008-1011` |
| Manual fetch | Admin-only "Fetch recent data (for testing purposes only)" button | `SimilarwebView.php:458-515` |

### Single Platform

| Area | Behavior | Source |
|---|---|---|
| Modules | GO is onboarding review of a new merchant. RM is Reputation Monitoring of existing merchants on a recurring frequency | `rm-queries.properties:196-199`; migrations V2_0_415, V2_0_416 |
| Displayed data (RM and GO) | Risk flag with severity label, response status, top-10 country table (country, share, visitors, pages per visit, bounce rate), 6-month visits trend with a month-over-month change band | `rm-queries.properties:3372-3485`; `go-queries.properties:916-1000` |
| GO only | Separate "online traffic" section with its own risk flag: referrals, traffic sources, related apps | `go-queries.properties:1030-1057` |
| Analyst override | Analyst can override the flag or clear it (clear sets flag to 0 and disables the service on the case) | `RmSimilarwebUpdateService.java:21-77`; `GbxService.java:357-377, 1313-1434` |
| Monitoring comparison | Compares the current flag with the previous run's flag, not with transactions; result is negative, neutral or positive | `rm-comparision-queries.properties:1038-1100` |
| Enablement | Per client through vendor config options `similarweb` and `similarweb_extra` | `rm-queries.properties:183-191`; V2_0_390 |
| Reports | Similarweb appears in GO UI PDF and API PDF (defects G2ENG-24886, G2ENG-24404) | Jira |

### MerchantView

| Area | Behavior | Source |
|---|---|---|
| Traffic Analysis card | Finding card with Tranco rank and Scamadviser pageviews | `TrafficAnalysisFindingCardCommand.groovy:14-27`; `FindingCardService.groovy:18` |
| Pageviews evidence | Modal shows "Pageviews: {value or 'No Data'}" | `evidence-page-views-details.component.html:2-6` |
| No rank | `NO_TRANCO_RANK` insight sets a "no Tranco rank" state on the card | `TrafficAnalysisFindingCardCommand.groovy:36-41` |
| Not present | No visits, countries, traffic sources, referrers or engagement; no Similarweb | No `similarweb` match in MV code (`mvserver`, `merchantviewui`, `mvnextgen`); the Traffic Analysis card and pageviews modal hold only rank and pageviews |
| Dormant sub types | `TRAFFIC_DATA` (Signals) exists in config only, with no producer found. `NO_TRAFFIC_DATA` is commented out in the crawler | `categories.json:18365-18385`; `FindingSubType.java:379, 560` |

## Business Rules to Preserve

Rules are listed so the PM can decide which carry into Atlas. Thresholds are legacy values, not recommendations.

1. **WS spike rule.** A month-over-month change of 70% or more, up or down, is a spike when either month has at least 100 visits. A move between 0 and a non-zero month is a spike. (`multi.gate.class.php:3984-4010`)
2. **WS website usage score**, labeled "Transaction Laundering Risk / Website Usage" in WS. Daily visits are last month's visits divided by 30, or an Alexa-derived figure when that is higher. Daily visits of 0 scores 1, under 11 scores 2, a spike scores 3, otherwise 4. The score replaces the case score only when higher. (`multi.gate.class.php:3983-4028`)
3. **WS monitoring alerts.** Visits drop of 50% or more alerts; rise of 50% or more alerts; going to 0 after having visitors alerts; going from 0 to above 0 alerts. The 50% thresholds and an ignore floor are per-client settings. (`multi.mon.class.php:1882-1935`; `settings_monitor.php:108-121`)
4. **WS data freshness.** A stored month is not re-fetched; before the 8th of the month the previous month is not requested, because the provider has not published it. (`sentinel.class.php:4465-4552`)
5. **SP severity labels.** SP displays flag 0 or 1 as Low, 2 as Medium, 3 or 4 as High, anything else as Unknown. (`rm-queries.properties:3461-3466`) This is the display mapping only. The scoring that sets the flag value runs in AME, the G2 service that calls Similarweb and calculates SP's traffic risk flags, and was not read, so what traffic produces each flag value is Unknown.
6. **SP trend bands.** Month-over-month change within 20% is ±1, within 50% is ±2, above 50% is ±3. From 0 or empty: +1 under 1,000 visits, +2 under 5,000, +3 above. (`rm-queries.properties:3393-3445`)
7. **SP monitoring comparison.** Flag 3 or 4 is always negative; equal flags are neutral; 0 to 1 or 1 to 0 is neutral; lower is positive; higher is negative. With no previous monitoring run, the onboarding flag is the baseline. (`rm-comparision-queries.properties:1038-1100`)
8. **SP analyst override.** The analyst can override or clear the traffic flag on a case, with an audit record. (`RmSimilarwebUpdateService.java:21-77`)
9. **Display filters.** WS hides countries under 0.5% share and sources at or below 0.005%. SP shows the top 10 countries by visits. (`SimilarwebView.php:9, 385-450`; `rm-queries.properties:3385-3391`)
10. **Retrieval date is shown.** WS shows "Data retrieved on" with the data. (`SimilarwebView.php:173-181`)
11. **Per-client enablement.** SP turns Similarweb on per client; WS alert thresholds are per client. (`rm-queries.properties:183-191`; `settings_monitor.php:108-121`)

## Target Platform: What Already Exists

- No traffic display, traffic card or traffic finding in Atlas production code (`unified-platform-new`, `ufp-backend`). `TRAFFIC_DATA` appears only in JSON test fixtures.
- Atlas carries Scamadviser as a finding origin and per-bank setting, not as a traffic display (`FindingOrigin.java:55`; `BankFlag.java:39, 102`).
- Planned: WT-1 and WT-2 are K9's two web traffic milestones. WT-1 builds a Similarweb connection, a recurring Similarweb job in CMP, the K9 platform that runs detection jobs, and web traffic findings (K9-1205, K9-1253). WT-2 sends web traffic and backlink findings to Atlas through the MV adapter (K9-1249, K9-1283; planned start about 4 Jan 2027, target 28 Feb 2027).
- Draft guidance: K9 page "Traffic & Referral Signals (UW Analysis)" proposes a Similarweb data contract that should also back an Atlas "Traffic Intelligence" view, with three traffic states (no data, low, normal) and the rule "never read missing as zero".

## Gaps

What Atlas needs that no legacy product does:

- **"No traffic data available" as its own state**, separate from "Zero visits". WS and SP both collapse them; SP's G2ENG-24592 shows the client impact.
- **Traffic versus transactions.** No legacy product compares visits with processing volume. Per the PM brief, Ballerine publicly describes this check; LegitScript's public materials show no dedicated traffic module.
- **Referring websites with risk context.** WS shows a Similarweb share per URL; SP GO stores referrals as unstructured text. No product classifies referrers by risk.
- **Engagement.** Only SP shows pages per visit and bounce rate, per country. No product shows visit duration.
- **Traffic in MV.** MV clients migrating to Atlas have only rank and pageviews today; any Similarweb display is new to them.

## Conflicts / Product Decisions

1. **Atlas display scope.** WS shows visits, countries, sources, outgoing/backlink share and apps; SP shows a flag, countries with engagement and a 6-month trend; MV shows rank and pageviews. Which set is the Atlas baseline?
2. **Score versus finding.** WS and SP turn traffic into a score or flag. The proposed Atlas framing shows the data and raises a finding only when traffic conflicts with the merchant's stated business; the thresholds for that are decision 3. Do legacy scores and flags migrate, or does a finding replace them?
3. **Spike threshold.** WS uses 70% month over month with a 100-visit floor; WS monitoring uses 50% (configurable); SP uses 20% / 50% bands; the underwriting team's draft on the K9 page proposes a multiple of the trailing six-month median. Which one applies?
4. **Delivery route.** K9 plans findings through the MV adapter, while MV today has no Similarweb data. Confirm that WS and SP clients get the same traffic view in Atlas.
5. **Backlink source.** WS shows Similarweb share next to Majestic link counts; the K9 page flags that Similarweb may not provide backlinks. Confirm before committing to a backlink signal.

## Evidence Gaps

- Similarweb fetch and SP risk-flag scoring are outside the repos read (SP scoring sits in AME per G2CHNGE-7988 and G2ENG-21692). Flag thresholds 0 to 4 are Unknown.
- WS onboarding trigger and monitoring schedule: Unknown.
- SP UI and report templates were not found in the repo; SP display is inferred from report queries.
- `similarweb_extra` meaning in SP: Unknown.
- Role-level permissions in SP and WS: not checked.
- MV `TRAFFIC_DATA` producer and display text: Unknown.
- Atlas front-end repo not searched beyond keyword greps.
- Similarweb licence: which fields may appear in client-facing evidence is open (K9 page, section 4.3).
- A "Traffic Intelligence - Discovery" page is cited by the K9 page; it was not read in this run.

## Sources

- Confluence: [Traffic & Referral Signals (UW Analysis)](https://g2rs.atlassian.net/wiki/spaces/CATS/pages/4390715406), K9 space, 2026-10-26.
- Confluence: [MerchantView HUB - Traffic Data Integration HLR](https://g2rs.atlassian.net/wiki/spaces/PROD/pages/4031907892) (2020, not read; legacy context).
- Jira: K9-1205, K9-1249, K9-1253, K9-1283, G2ENG-24592, G2ENG-24591, G2ENG-24652, G2ENG-24886, G2ENG-24404, WSSDLC-596.
- Brain: `org-brain/ingestion/osint-toolkit.md` (Similarweb as a traffic estimate source).
- Input: PM brief on web traffic in merchant risk platforms, Ballerine and LegitScript comparison (2026-11-09).
