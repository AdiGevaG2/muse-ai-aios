# C.A.L Visa - MerchantView usage, Nov 2025 to Oct 2026

Source: Mixpanel, MerchantView Production, Customer = "C.A.L Visa". Pulled 3 Nov 2026.
Includes G2 staff working in CAL's account on CAL's behalf.
Quarters: Q1 = Nov-Jan, Q2 = Feb-Apr, Q3 = May-Jul, Q4 = Aug-Oct.

## Overall

| | Q1 | Q2 | Q3 | Q4 | 12 months |
|---|---|---|---|---|---|
| All events | 27,918 | 27,705 | 32,381 | 32,772 | 120,776 |
| Logins | 936 | 733 | 931 | 826 | 3,426 |

Monthly users who logged in: 34 (Nov 2025) to 25 (Oct 2026). Advanced users: 27 to 17.
Admin logins per month: 82 to 139. Super Admin: 3-4 users a month throughout.

Last 90 days by account: Shulam 13,713 | UP 7,642 | Luck 4,965 | Luck-Matal 4,030 | GMA 1,429 | Tranzilla 145 | Pday 141 | Igud Haslika 68 | P-M 6.

## Usage by area

| Area | Main action | Q1 | Q2 | Q3 | Q4 | 12 months |
|---|---|---|---|---|---|---|
| Portfolio | Portfolio page opened | 3,212 | 2,847 | 3,621 | 3,435 | 13,115 |
| | Merchant checked | 1,256 | 1,285 | 1,578 | 1,354 | 5,473 |
| | Paging through merchant list | 1,361 | 2,636 | 2,788 | 4,840 | 11,625 |
| | Search | 622 | 565 | 889 | 739 | 2,815 |
| | Go to merchant findings | 750 | 709 | 1,015 | 1,327 | 3,801 |
| Onboarding | Merchant added one by one | 1,723 | 1,602 | 1,954 | 2,363 | 7,642 |
| | Bulk upload confirmed | 50 | 56 | 64 | 60 | 230 |
| Offboarding | Deboarded from findings | 388 | 365 | 485 | 893 | 2,131 |
| | Deboarded from portfolio | 357 | 313 | 400 | 264 | 1,334 |
| Findings review | Evidence reviewed | 729 | 649 | 830 | 611 | 2,819 |
| | Website opened from evidence | 157 | 186 | 212 | 143 | 698 |
| | Website opened from findings | 213 | 204 | 189 | 196 | 802 |
| | Website opened from audit screen | 65 | 72 | 84 | 95 | 316 |
| | Domain findings expanded | 1,046 | 1,026 | 1,104 | 757 | 3,933 |
| | Finding status changed | 174 | 219 | 314 | 216 | 923 |
| | Filter used | 2,069 | 1,998 | 2,449 | 1,152 | 7,668 |
| Audit | Merchant audit finished | 143 | 153 | 108 | 94 | 498 |
| | Finding added manually | 86 | 72 | 34 | 38 | 230 |
| | Finding removed | 47 | 68 | 34 | 33 | 182 |
| | Censoring approved | 32 | 18 | 46 | 29 | 125 |
| Disputes | Disputes tab opened | 95 | 174 | 456 | 392 | 1,117 |
| | Dispute submitted | 6 | 9 | 14 | 12 | 41 |
| | Dispute chat | 38 | 66 | 75 | 29 | 208 |
| History | Portfolio history opened | 190 | 154 | 137 | 112 | 593 |
| | Findings history opened | 194 | 179 | 116 | 73 | 562 |
| Network (TL) | Network page | 7 | 7 | 2 | 3 | 19 |
| | General network view | 1 | 30 | 44 | 4 | 79 |
| Dashboard | Executive dashboard opened | 74 | 101 | 108 | 55 | 338 |
| Reports | Report generated | 26 | 20 | 17 | 19 | 82 |
| | URL report generated | 4 | 2 | 10 | 6 | 22 |
| | File downloaded | 56 | 45 | 26 | 32 | 159 |
| Other | Underwriting page | 7 | 18 | 11 | 9 | 45 |
| | Rules manager | 5 | 2 | 9 | 0 | 16 |
| | WebID page | 2 | 1 | 2 | 1 | 6 |
| | Account switch | 200 | 114 | 144 | 88 | 546 |

## Billed services and their use

Billing sheet row for C.A.L Visa: billed for Monitoring, WebID, New Onboarding QI, Graph, API, ScamAdvisor and Keywords. Monitoring usage on the sheet: 23,458. Usage data below is Mixpanel, Nov 2025 to Oct 2026. Looker is not connected, so no Looker data is included.

| Billed service | Usage in MerchantView, 12 months | Read |
|---|---|---|
| Monitoring | 38,139 portfolio clicks, 18,735 findings-review clicks, 3,801 jumps from merchant to findings, 923 finding status changes | Core service, used every day |
| WebID | 9 clicks: WebID page opened 6 times, searched 3 times | Billed, nearly unused in the UI |
| New Onboarding QI | 304 underwriting clicks: 204 opens of underwriting merchant details, 45 underwriting tab opens, 10 underwriting searches, 2 underwriting PDF reports. Quick Insights results show in the underwriting tab and merchant page, so these clicks are how CAL views them | Low UI use; scans run count unknown |
| Graph | 117 network clicks: general network view 79, network page 19 | Billed, nearly unused in the UI |
| API | Not tracked in Mixpanel; API calls bypass the UI | Usage unknown from Mixpanel |
| ScamAdvisor | No event in Mixpanel | Usage unknown from Mixpanel |
| Keywords | No event in Mixpanel | Usage unknown from Mixpanel |

### Billing read

1. **CAL pays for 7 services. Mixpanel shows real use of one: Monitoring.**
2. **Low UI use of billed services is a renewal risk.** WebID got 9 clicks and Graph 117 in a year. CAL may see them as paid-for and unused.
3. **Four services have no usage data in Mixpanel:** New Onboarding QI, API, ScamAdvisor and Keywords. Their use, such as API call volume or QI checks run, needs a backend or Looker source before the meeting.

## What the data shows

1. **Activity grew, users shrank.** Events rose 17% from Q1 to Q4 while monthly users fell from 34 to 25. Fewer people do more work.
2. **Offboarding doubled in Q4.** Merchants deboarded from findings went from 485 (Q3) to 893 (Q4).
3. **Onboarding is manual.** 7,642 merchants added one by one against 230 bulk uploads. Q4 is the highest quarter.
4. **Paging through the merchant list nearly doubled in Q4** (2,788 to 4,840). The team scrolls lists to find merchants.
5. **CAL leaves MerchantView to verify findings.** 1,816 website opens from evidence, findings and the audit screen. This fits their TL complaint about finding the link themselves.
6. **Disputes tab use jumped from Q2** (174 to 456 and 392). Only 41 disputes submitted in 12 months.
7. **The network view, where TL links show, is barely used.** 98 opens in 12 months.
8. **History and findings review are declining.** Findings history opened 194 (Q1) to 73 (Q4). Domain findings expanded down 31% in Q4.

## Year over year, January to October each year

Same 10 months each year so 2026 compares fairly. Several actions started tracking in May 2023, so 2023 is partial for them (marked *).

| Action | 2023 | 2024 | 2025 | 2026 | 2026 vs 2025 |
|---|---|---|---|---|---|
| Monthly users who logged in, average | 38.7 | 42.5 | 36.0 | 29.0 | -19% |
| Logins | 7,189 | 3,206 | 6,555 | 2,755 | -58% |
| Merchants added one by one | 4,500 | 4,383 | 4,919 | 6,530 | +33% |
| Bulk uploads confirmed | 4 | 193 | 174 | 197 | +13% |
| Deboarded from findings* | 1,982 | 2,975 | 927 | 1,876 | +102% |
| Deboarded from portfolio* | 94 | 240 | 1,131 | 1,087 | -4% |
| Monitoring checks | 645 | 1,038 | 4,055 | 4,699 | +16% |
| Evidence reviewed* | 1,666 | 1,329 | 2,543 | 2,262 | -11% |
| Finding status changed* | 221 | 306 | 664 | 799 | +20% |
| Merchant audits finished | 10,481 | 1,739 | 6,067 | 397 | -93% |
| Disputes submitted | 36 | 24 | 25 | 36 | +44% |
| Reports generated* | 7 | 37 | 47 | 67 | +43% |

### Yearly read

1. **Users are at a four-year low.** Average 29 a month in 2026, down from a 42.5 peak in 2024. The drop started April 2025 (51 in Feb 2025 to 33 in Apr 2025) and has not recovered.
2. **Logins swing with audit work.** High-login years (2023, 2025) match high audit volume. In 2026 both are at their lowest.
3. **Merchant audits nearly stopped.** 6,067 in Jan-Oct 2025, 397 in 2026. Audits fell from about 600 a month to under 100 in August 2025 and stayed there. Cause unknown; may reflect a change in who audits CAL's portfolio.
4. **Portfolio keeps growing.** Merchants added one by one up 33%, the highest of four years. October 2026 is the highest month on record (908).
5. **Offboarding doubled.** Deboarding from findings up 102% vs 2025, concentrated July to October 2026.
6. **Monitoring checks keep rising.** 645 (2023) to 4,699 (2026). Portfolio monitoring is now the core workflow.

## Funnels CAL uses

Mixpanel funnels, Nov 2025 to Oct 2026, Customer = "C.A.L Visa". Each number is people who did the step in order, not clicks. Steps are the workflows CAL runs most, based on their event volume.

| Workflow | Steps | People at each step | Completion |
|---|---|---|---|
| Add a merchant one by one | Add/remove page → Add merchant → Upload | 20 → 15 → 13 | 65% |
| Bulk upload | Start bulk upload → Confirm | 7 → 4 | 57% |
| Monitoring to action | Monitoring check → Go to findings → Review evidence → Change status | 13 → 6 → 6 → 1 | 8% |
| Deboard from findings | Review evidence → Deboard → Confirm | 31 → 5 → 5 | 16% |
| Deboard from portfolio | Deboard → Confirm | 10 → 8 | 80% |
| Merchant audit | Audit merchant → Open audit screen → Save → Finish | 19 → 15 → 7 → 6 | 32% |
| Generate a report | Open report → Generate → Download | 11 → 7 → 7 | 64% |
| Dispute a finding | Disputes tab → Dispute → Submit | 19 → 3 → 0 | 0% |

### Funnel read

1. **Onboarding works once started.** 87% of people who add a merchant finish the upload. The work is manual, not blocked.
2. **Monitoring rarely ends in a decision inside MerchantView.** 13 people ran monitoring checks; 6 reached evidence; 1 changed a finding status. Review happens, recorded action does not.
3. **Evidence review leads to deboarding for few people.** 31 people reviewed evidence; 5 deboarded from findings. Those 5 deboard every time they start (100% confirm), and on average about 15 hours after reviewing evidence.
4. **Half of audits stop before saving.** 15 people opened the audit screen; 7 saved. Fits the audit collapse in the yearly view.
5. **Disputes are viewed, not filed through this path.** 19 people opened the Disputes tab; none submitted through Tab → Dispute → Submit. The 41 disputes submitted this year followed a different sequence or fell outside the funnel's time window; which one is not known.

## Finding status: did CAL agree with our risk?

Mixpanel, Nov 2025 to Oct 2026, event "Finding status changed". "Our risk" is the risk G2 assigned in the scan, before the status change. Counts are status changes, not unique findings.

| Status CAL set | What it means | Critical | High | Low / unassigned | Total |
|---|---|---|---|---|---|
| Review Completed | Risk confirmed, stays as found | 106 | 407 | 3 | 516 |
| Allowed | Finding correct, violation acceptable, risk set to Low | 11 | 165 | 1 | 177 |
| Remediated | Finding correct, merchant agreed to fix, risk set to Low | 1 | 12 | 0 | 13 |
| Rejected | Finding untrue or irrelevant, risk set to No Risk | 6 | 20 | 2 | 28 |
| In Progress | Open, action under way | 71 | 82 | 2 | 155 |
| Not Checked | Open, not reviewed yet | 9 | 19 | 6 | 34 |
| **All** | | **204** | **705** | **14** | **923** |

### Agreement with G2's findings

| Of 734 closed findings | Count | Share |
|---|---|---|
| CAL agreed the finding is correct: Review Completed, Allowed or Remediated | 706 | 96% |
| CAL also kept G2's risk level: Review Completed | 516 | 70% |
| CAL agreed with the finding but lowered the risk: Allowed or Remediated | 190 | 26% |
| CAL disagreed: Rejected | 28 | 4% |

### Status read

1. **CAL agrees with G2's findings 96% of the time.** Only 28 of 734 closed findings were rejected as untrue.
2. **CAL keeps G2's risk level 70% of the time.** When CAL lowers it, the reason is mostly that the violation is acceptable to CAL: 177 Allowed. It is rarely that the merchant fixed it: 13 Remediated.
3. **Rejections concentrate on site-availability findings.** 12 of 14 availability findings were rejected. Only 14 of 863 content findings were rejected, which is 2%.
4. **Status changes are low volume.** 923 in 12 months, and 189 of them left the finding open. The share of CAL's findings that get a status is unknown, because the total finding count is not in Mixpanel. The funnel points the same way: 1 in 13 people who ran a monitoring check changed a status.

## Merchant decisions: from our finding to CAL's decision

Mixpanel, Nov 2025 to Oct 2026. Shows the risk G2 found on a merchant and what CAL decided. Counts are decisions recorded in MerchantView, not unique merchants.

### Offboarded: by the merchant risk G2 found

Merchants deboarded from the findings screen. The merchant risk is recorded on this action only.

| Merchant risk G2 found | Deboarded | Reason: terminated after investigating findings | Reason: other | Reason: removed from G2 monitoring | No reason given |
|---|---|---|---|---|---|
| Critical | 119 | 7 | 55 | 0 | 57 |
| High | 306 | 109 | 39 | 1 | 157 |
| Medium | 130 | 57 | 0 | 1 | 72 |
| Low | 25 | 10 | 1 | 0 | 14 |
| Risk level unassigned | 1,551 | 151 | 5 | 8 | 1,387 |
| **All** | **2,131** | **334** | **100** | **10** | **1,687** |

Merchants deboarded from the portfolio list: 1,334. Merchant risk is not recorded there. Reasons: 925 terminated after investigating findings, 16 other, 6 removed from G2 monitoring, 387 none given.

### Kept in monitoring

CAL keeps a merchant in monitoring by closing its finding without deboarding:

| Finding status set | Count | Meaning |
|---|---|---|
| Review Completed | 516 | Risk confirmed, merchant stays monitored |
| Allowed | 177 | Violation accepted, merchant stays monitored |
| Remediated | 13 | Merchant agreed to fix, stays monitored |

Moving a merchant from underwriting to monitoring, the "onboard" action in the underwriting tab, was used 0 times by CAL in 12 months.

### Decision read

1. **Findings drive CAL's offboarding.** 1,259 of 3,465 deboards, which is 36%, carry the reason "terminated after investigation of findings". The rest have no reason or "other".
2. **Where risk is recorded, high and critical lead.** Of 580 deboards with a known merchant risk, 425 were High or Critical, which is 73%.
3. **73% of deboards from findings were merchants with no risk level set.** 1,551 of 2,131 carry "Risk Level Unassigned". This is the default severity label when no risk has been determined, or when a "No Risk" policy applies. Checked again: the count is right. It is a steady pattern, 70 to 98 a month from November to June and 145 to 263 a month from July, done by 4 users. 1,387 of the 1,551 give no reason, and 151 cite findings investigation. These merchants are rare in CAL's review work: they make up 36 of 701 merchant selections in findings (5%) and 136 of 2,819 evidence reviews. Most of these deboards are likely portfolio clean-up of merchants with no findings, not decisions driven by a finding. This is an inference, because Mixpanel does not record whether a deboarded merchant had findings. The decision picture with a G2 risk level is the 580 deboards rated Critical, High, Medium or Low.
4. **CAL decides more often to keep a merchant than to offboard it on finding review.** 706 findings closed with the merchant kept in monitoring, against 334 deboards from findings that cite findings as the reason.

## Every button CAL clicks

Mixpanel, Nov 2025 to Oct 2026, Customer = "C.A.L Visa", including G2 staff working in CAL's account. Counts are clicks and screen opens. Plain names are read from the event names; the raw event name is next to each.

### What to show CAL in Atlas

Ranked by where CAL's clicks go.

1. **Portfolio list: find a merchant fast.** 32% of all clicks. Paging through the merchant list is CAL's second most-used action: 11,625 clicks, and 4,840 in Q4 alone. Show Atlas search, filters and risk sorting, so a merchant is one search away instead of pages away.
2. **Adding merchants.** 26% of clicks. 7,642 merchants were added one at a time against 230 bulk uploads. Show bulk onboarding and any automated merchant feed.
3. **Findings review and evidence.** 16% of clicks, spread across 57 buttons. The core path is: expand a domain (3,933) → review evidence (2,819) → open the website to check it (1,816 across findings, evidence and the audit screen). Show evidence that answers the question inside Atlas, without leaving for the website.
4. **Deboarding.** 8% of clicks. Deboarding from findings doubled in Q4, from 493 to 895. Show the action flow from finding to decision.
5. **Filters.** 7,668 filter clicks, the most-used single control after the portfolio list. Show saved views or default filters.
6. **Disputes.** The Disputes tab opened 1,117 times, but only 41 disputes were submitted. Show the Atlas dispute flow and status tracking.
7. **Low use: skip or keep short in the demo.** These areas together get under 1% of clicks:
   - executive dashboard: 338;
   - underwriting: 304;
   - network (TL): 117;
   - rules manager: 30;
   - WebID: 9.

   Network is the exception to this. CAL raised TL complaints, so that one is worth showing.

### Clicks by area

| Area | Clicks, 12 months | Share | Distinct buttons |
|---|---|---|---|
| Portfolio | 38,139 | 32% | 28 |
| Onboarding and merchant details | 30,911 | 26% | 17 |
| Findings review | 18,735 | 16% | 57 |
| General | 11,905 | 10% | 8 |
| Offboarding and pause monitoring | 9,807 | 8% | 17 |
| Audit (G2 auditors) | 4,588 | 4% | 36 |
| Portfolio history | 2,595 | 2% | 9 |
| Disputes | 1,781 | 1% | 10 |
| Findings history | 844 | 1% | 3 |
| Reports and files | 607 | 1% | 15 |
| Executive dashboard | 338 | 0% | 1 |
| Underwriting | 304 | 0% | 18 |
| Network (TL) | 117 | 0% | 7 |
| Merchant page and scans | 66 | 0% | 7 |
| Rules and settings | 30 | 0% | 6 |
| WebID | 9 | 0% | 2 |
| **All** | **120,776** | | **241** |

### Buttons: Portfolio

| Button or screen | Event | Q1 | Q2 | Q3 | Q4 | 12 months |
|---|---|---|---|---|---|---|
| Open Portfolio | `portfolio_section` | 3,212 | 2,847 | 3,621 | 3,435 | 13,115 |
| Page through monitored merchants | `PM_PV_portfolio_monitoring_pegination` | 1,361 | 2,636 | 2,788 | 4,840 | 11,625 |
| Select a merchant in the monitored list | `PM_PV_portfolio_monitoring_check` | 1,256 | 1,285 | 1,578 | 1,354 | 5,473 |
| Go from merchant to its findings | `PM_PV_portfolio_monitoring_gotofindings` | 750 | 709 | 1,015 | 1,327 | 3,801 |
| Search monitored merchants | `PM_PV_portfolio_monitoring_search` | 622 | 565 | 889 | 739 | 2,815 |
| Open Portfolio list view | `PM_PV_page` | 116 | 186 | 120 | 248 | 670 |
| Select all merchants | `PM_PV_portfolio_monitoring_checkall` | 57 | 45 | 37 | 34 | 173 |
| Open all merchants tab | `PM_PV_all_page` | 10 | 30 | 18 | 17 | 75 |
| Portfolio monitoring page | `PM_PV_portfolio_monitoring_page` | 7 | 19 | 31 | 15 | 72 |
| All search | `PM_PV_all_search` | 11 | 29 | 8 | 17 | 65 |
| Edit merchant | `PM_PV_portfolio_monitoring_editmerchant` | 14 | 10 | 18 | 7 | 49 |
| Open not-monitored merchants tab | `PM_PV_portfolio_notmonitoring_page` | 8 | 11 | 16 | 12 | 47 |
| All check | `PM_PV_all_check` | 2 | 0 | 32 | 0 | 34 |
| Sort by risk level | `PM_PV_portfolio_monitoring_sort_risklevel` | 21 | 1 | 9 | 0 | 31 |
| All go tofindings | `PM_PV_all_gotofindings` | 5 | 12 | 2 | 0 | 19 |
| Portfolio monitoring domain list | `PM_PV_portfolio_monitoring_domain_list` | 1 | 5 | 2 | 4 | 12 |
| All auditor go to merchant tab | `PM_PV_all_auditor_goto_merchant_tab` | 1 | 1 | 4 | 6 | 12 |
| Portfolio monitoring auditor go to merchant tab | `PM_PV_portfolio_monitoring_auditor_goto_merchant_tab` | 3 | 2 | 4 | 2 | 11 |
| All paging | `PM_PV_all_pegination` | 0 | 2 | 8 | 0 | 10 |
| Portfolio monitoring show100 | `PM_PV_portfolio_monitoring_show100` | 7 | 0 | 0 | 0 | 7 |
| Portfolio monitoring sort creationdate | `PM_PV_portfolio_monitoring_sort_creationdate` | 3 | 2 | 2 | 0 | 7 |
| Portfolio notmonitoring search | `PM_PV_portfolio_notmonitoring_search` | 1 | 6 | 0 | 0 | 7 |
| Portfolio monitoring sort uniqueId | `PM_PV_portfolio_monitoring_sort_uniqueId` | 1 | 0 | 0 | 2 | 3 |
| Portfolio monitoring sort merchantName | `PM_PV_portfolio_monitoring_sort_merchantName` | 2 | 0 | 0 | 0 | 2 |
| Portfolio notmonitoring paging | `PM_PV_portfolio_notmonitoring_pegination` | 0 | 1 | 0 | 0 | 1 |
| Portfolio notmonitoring go tofindings | `PM_PV_portfolio_notmonitoring_gotofindings` | 0 | 1 | 0 | 0 | 1 |
| Portfolio monitoring sort id | `PM_PV_portfolio_monitoring_sort_id` | 0 | 0 | 1 | 0 | 1 |
| All editmerchant | `PM_PV_all_editmerchant` | 0 | 0 | 1 | 0 | 1 |

### Buttons: Onboarding and merchant details

| Button or screen | Event | Q1 | Q2 | Q3 | Q4 | 12 months |
|---|---|---|---|---|---|---|
| Add a single merchant | `add_merchant_solo` | 1,723 | 1,602 | 1,954 | 2,363 | 7,642 |
| Submit single merchant | `add_merchant_solo_upload` | 1,670 | 1,561 | 1,916 | 2,320 | 7,467 |
| Close add-merchant form | `add_merchant_solo_exit` | 1,670 | 1,561 | 1,915 | 2,317 | 7,463 |
| Open Add/Remove merchants page | `add_remove_page` | 1,736 | 1,643 | 1,917 | 2,065 | 7,361 |
| Start bulk upload | `add_merchant_bulk` | 57 | 65 | 75 | 69 | 266 |
| Confirm bulk upload | `add_merchant_bulk_confirm` | 50 | 56 | 64 | 60 | 230 |
| Page through add/remove list | `add_remove_pegination` | 170 | 0 | 4 | 30 | 204 |
| Upload file | `add_remove_file` | 45 | 33 | 38 | 64 | 180 |
| Open upload diagnostics | `add_remove_diagnostic` | 9 | 12 | 1 | 8 | 30 |
| Download merchant template | `merchant_template_download` | 7 | 4 | 5 | 3 | 19 |
| Details edit website | `details_edit_website` | 8 | 3 | 3 | 4 | 18 |
| Add remove page onboarding status subtab | `add_remove_page_onboarding_status_subtab` | 2 | 2 | 1 | 4 | 9 |
| Add merchant solo apply for all | `add_merchant_solo_apply_for_all` | 5 | 0 | 2 | 0 | 7 |
| Details delete website | `details_delete_website` | 1 | 1 | 2 | 1 | 5 |
| Details add website | `details_add_website` | 1 | 0 | 3 | 1 | 5 |
| Add remove page files history subtab | `add_remove_page_files_history_subtab` | 1 | 1 | 1 | 1 | 4 |
| Details add address | `details_add_address` | 0 | 0 | 0 | 1 | 1 |

### Buttons: Findings review

| Button or screen | Event | Q1 | Q2 | Q3 | Q4 | 12 months |
|---|---|---|---|---|---|---|
| Expand a domain's findings | `findings_grid_domain_expand` | 1,046 | 1,026 | 1,104 | 757 | 3,933 |
| Review evidence | `findings_grid_review_evidence` | 729 | 649 | 830 | 611 | 2,819 |
| Open merchant actions menu | `findings_merchant_action_button_open` | 413 | 395 | 522 | 925 | 2,255 |
| Open Findings | `findings_section` | 416 | 381 | 373 | 229 | 1,399 |
| Open status menu | `findings_grid_status_dropdown_open` | 233 | 293 | 405 | 290 | 1,221 |
| Change finding status | `findings_grid_status_apply` | 174 | 219 | 314 | 216 | 923 |
| Collapse a domain | `findings_grid_domain_collapse` | 217 | 229 | 255 | 161 | 862 |
| Open website from findings | `findings_grid_openweb` | 213 | 204 | 189 | 196 | 802 |
| Open Findings tab | `findings_tab` | 238 | 194 | 187 | 112 | 731 |
| Select merchant in findings | `findings_merchant_click` | 178 | 149 | 217 | 157 | 701 |
| Open website from evidence | `findings_grid_evidence_openweb` | 157 | 186 | 212 | 143 | 698 |
| Search merchant in findings | `findings_merchant_search` | 137 | 77 | 138 | 90 | 442 |
| Apply merchant search | `findings_merchant_search_apply` | 116 | 97 | 139 | 60 | 412 |
| Go to merchant | `findings_grid_goto_merchant` | 112 | 100 | 74 | 43 | 329 |
| Move between evidence items | `evidence_modal_navigation` | 108 | 75 | 45 | 25 | 253 |
| Search findings | `findings_grid_search` | 77 | 74 | 61 | 26 | 238 |
| Clear merchant search | `findings_merchant_search_clear` | 40 | 50 | 44 | 35 | 169 |
| Action button close | `findings_merchant_action_button_close` | 17 | 26 | 26 | 23 | 92 |
| Status dropdown close | `findings_grid_status_dropdown_close` | 9 | 13 | 19 | 14 | 55 |
| Open findings summary | `findings_summary_page` | 10 | 18 | 13 | 5 | 46 |
| Findings merchant back | `findings_findings_merchant_back` | 6 | 8 | 12 | 9 | 35 |
| Loadmore | `findings_grid_loadmore` | 4 | 1 | 6 | 18 | 29 |
| Open assignee menu | `findings_grid_assignee_dropdown_open` | 4 | 7 | 8 | 8 | 27 |
| Assignee dropdown close | `findings_grid_assignee_dropdown_close` | 4 | 6 | 7 | 8 | 25 |
| Open finding details | `findings_details_page` | 5 | 7 | 4 | 4 | 20 |
| Clear | `findings_merchant_clear` | 5 | 7 | 5 | 2 | 19 |
| Open finding log | `findings_grid_finding_log` | 5 | 2 | 7 | 4 | 18 |
| Domain view all findings | `findings_grid_domain_view_all_findings` | 1 | 4 | 5 | 4 | 14 |
| Filter go | `findings_filter_go` | 5 | 0 | 8 | 1 | 14 |
| Notes cancel | `findings_merchant_notes_cancel` | 3 | 1 | 6 | 3 | 13 |
| Finding log cancel | `findings_grid_finding_log_cancel` | 4 | 1 | 5 | 3 | 13 |
| Notes clicked | `findings_merchant_notes_clicked` | 3 | 1 | 6 | 3 | 13 |
| Hide | `findings_merchant_hide` | 1 | 5 | 2 | 3 | 11 |
| Snooze a finding | `findings_grid_snooze_start` | 3 | 1 | 4 | 2 | 10 |
| Snooze exit | `findings_grid_snooze_exit` | 3 | 1 | 4 | 2 | 10 |
| Filter severity | `findings_filter_severity` | 0 | 0 | 8 | 2 | 10 |
| Show | `findings_merchant_show` | 1 | 4 | 2 | 1 | 8 |
| Allow all findings for merchant | `findings_findings_merchant_allowall` | 2 | 0 | 3 | 2 | 7 |
| Load100 | `findings_merchant_load100` | 2 | 0 | 1 | 4 | 7 |
| Filter finding type | `findings_filter_finding_type` | 0 | 0 | 7 | 0 | 7 |
| Filter clear one | `findings_filter_clear_one` | 1 | 0 | 5 | 0 | 6 |
| Filter category | `findings_filter_category` | 6 | 0 | 0 | 0 | 6 |
| Findings merchant allowall apply | `findings_findings_merchant_allowall_apply` | 1 | 0 | 3 | 1 | 5 |
| Finding log note add | `findings_grid_finding_log_note_add` | 1 | 0 | 2 | 1 | 4 |
| Group collapse | `findings_grid_group_collapse` | 0 | 0 | 3 | 1 | 4 |
| Summary content violations high | `findings_summary_content_violations_high` | 1 | 2 | 0 | 0 | 3 |
| Summary reported | `findings_summary_reported` | 0 | 1 | 2 | 0 | 3 |
| Findings merchant allowall cancel | `findings_findings_merchant_allowall_cancel` | 1 | 0 | 0 | 1 | 2 |
| Group expand | `findings_grid_group_expand` | 0 | 0 | 1 | 1 | 2 |
| Summary content violations show details | `findings_summary_content_violations_show_details` | 0 | 0 | 2 | 0 | 2 |
| Load100 apply | `findings_merchant_load100_apply` | 0 | 0 | 0 | 2 | 2 |
| Summary content violations critical | `findings_summary_content_violations_critical` | 1 | 0 | 0 | 0 | 1 |
| Summary content violations medium | `findings_summary_content_violations_medium` | 0 | 1 | 0 | 0 | 1 |
| Filter closed | `findings_merchant_filter_closed` | 0 | 1 | 0 | 0 | 1 |
| Filter | `findings_merchant_filter` | 0 | 1 | 0 | 0 | 1 |
| Finding log close | `findings_grid_finding_log_close` | 0 | 1 | 0 | 0 | 1 |
| Filter reported | `findings_filter_reported` | 0 | 0 | 0 | 1 | 1 |

### Buttons: General

| Button or screen | Event | Q1 | Q2 | Q3 | Q4 | 12 months |
|---|---|---|---|---|---|---|
| Apply a filter | `filter` | 2,069 | 1,998 | 2,449 | 1,152 | 7,668 |
| Log in | `MV_login` | 936 | 733 | 931 | 826 | 3,426 |
| Switch acquiring account | `bank_switch` | 200 | 114 | 144 | 88 | 546 |
| Log out | `MV_logout` | 52 | 54 | 26 | 28 | 160 |
| Sort a list | `sort` | 44 | 11 | 17 | 20 | 92 |
| Search (untagged screen) | `undefinedsearch` | 0 | 0 | 7 | 0 | 7 |
| Help button | `help_button` | 0 | 4 | 1 | 0 | 5 |
| Support button | `support_button` | 0 | 1 | 0 | 0 | 1 |

### Buttons: Offboarding and pause monitoring

| Button or screen | Event | Q1 | Q2 | Q3 | Q4 | 12 months |
|---|---|---|---|---|---|---|
| Deboard from findings | `findings_merchant_deboard_click` | 390 | 369 | 493 | 895 | 2,147 |
| Confirm deboard from findings | `findings_merchant_deboard_apply` | 388 | 365 | 485 | 893 | 2,131 |
| Deboard from portfolio | `portfolio_merchant_deboard_click` | 380 | 326 | 420 | 278 | 1,404 |
| Close deboard dialog (portfolio) | `portfolio_merchant_deboard_cancel` | 379 | 326 | 417 | 278 | 1,400 |
| Deboard result shown | `portfolio_merchant_deboard_result` | 357 | 313 | 400 | 264 | 1,334 |
| Confirm deboard from portfolio | `portfolio_merchant_deboard_apply` | 357 | 313 | 400 | 264 | 1,334 |
| Start bulk removal | `remove_merchant_bulk` | 6 | 4 | 2 | 5 | 17 |
| Deboard cancel | `findings_merchant_deboard_cancel` | 2 | 3 | 5 | 2 | 12 |
| Confirm bulk removal | `remove_merchant_bulk_confirm` | 3 | 1 | 1 | 4 | 9 |
| Pause monitoring cancel | `findings_merchant_pause_monitoring_cancel` | 1 | 0 | 2 | 1 | 4 |
| Pause monitoring click | `findings_merchant_pause_monitoring_click` | 1 | 0 | 2 | 1 | 4 |
| Pause monitoring click | `portfolio_merchant_pause_monitoring_click` | 0 | 0 | 2 | 1 | 3 |
| Pause monitoring cancel | `portfolio_merchant_pause_monitoring_cancel` | 0 | 0 | 2 | 1 | 3 |
| Deboard list | `portfolio_merchant_deboard_list` | 1 | 0 | 0 | 1 | 2 |
| Pause monitoring list | `portfolio_merchant_pause_monitoring_list` | 0 | 0 | 1 | 0 | 1 |
| Pause monitoring apply | `portfolio_merchant_pause_monitoring_apply` | 0 | 0 | 1 | 0 | 1 |
| Pause monitoring result | `portfolio_merchant_pause_monitoring_result` | 0 | 0 | 1 | 0 | 1 |

### Buttons: Audit (G2 auditors)

| Button or screen | Event | Q1 | Q2 | Q3 | Q4 | 12 months |
|---|---|---|---|---|---|---|
| Exit audit screen (Esc) | `audit_screen_exit_esc` | 149 | 135 | 125 | 132 | 541 |
| Finish merchant audit | `findings_auditor_finish_merchant` | 143 | 153 | 108 | 94 | 498 |
| Audit a merchant | `findings_auditor_audit_merchant` | 127 | 133 | 76 | 51 | 387 |
| Exit audit screen (Ctrl+E) | `audit_screen_exit_ctrl_E` | 114 | 125 | 75 | 45 | 359 |
| Open website from audit screen | `audit_screen_openweb` | 65 | 72 | 84 | 95 | 316 |
| Open audit screen for a domain | `findings_auditor_open_audit_screen_domain` | 82 | 107 | 71 | 55 | 315 |
| Open scan list | `findings_auditor_scan_list` | 87 | 78 | 93 | 39 | 297 |
| Choose a scan | `findings_auditor_scan_choose` | 76 | 69 | 80 | 29 | 254 |
| Add finding manually | `audit_screen_add_finding` | 86 | 72 | 34 | 38 | 230 |
| Choose finding type | `audit_screen_finding_type` | 97 | 63 | 29 | 34 | 223 |
| Search category | `audit_screen_search_category` | 94 | 33 | 14 | 51 | 192 |
| Remove finding | `audit_screen_remove_finding` | 47 | 68 | 34 | 33 | 182 |
| Save audit | `audit_screen_save` | 46 | 62 | 29 | 37 | 174 |
| Approve censoring | `censoring_approve` | 32 | 18 | 46 | 29 | 125 |
| Audit all | `findings_auditor_audit_all` | 3 | 17 | 37 | 49 | 106 |
| Finish audit all | `findings_auditor_finish_audit_all` | 1 | 12 | 33 | 39 | 85 |
| All | `audit_screen_all` | 16 | 5 | 7 | 21 | 49 |
| Audit status | `audit_screen_audit_status` | 2 | 7 | 17 | 14 | 40 |
| Exit X | `audit_screen_exit_X` | 2 | 7 | 17 | 14 | 40 |
| Open audit screen finding | `findings_auditor_open_audit_screen_finding` | 16 | 7 | 0 | 3 | 26 |
| Ctrl S | `audit_screen_ctrl_S` | 19 | 6 | 0 | 0 | 25 |
| Scan list close | `findings_auditor_scan_list_close` | 6 | 6 | 3 | 5 | 20 |
| Edit network | `audit_screen_edit_network` | 7 | 7 | 2 | 3 | 19 |
| Work status filter | `findings_auditor_work_status_filter` | 13 | 0 | 0 | 0 | 13 |
| Edit network edit domains | `audit_screen_edit_network_edit_domains` | 4 | 7 | 0 | 0 | 11 |
| Merchant severity filter closed | `findings_auditor_merchant_severity_filter_closed` | 1 | 3 | 6 | 1 | 11 |
| Merchant severity filter | `findings_auditor_merchant_severity_filter` | 1 | 3 | 6 | 1 | 11 |
| Edit domains save | `audit_screen_edit_domains_save` | 2 | 7 | 0 | 0 | 9 |
| Edit domains add domain | `audit_screen_edit_domains_add_domain` | 1 | 7 | 0 | 0 | 8 |
| Merchant severity filter apply | `findings_auditor_merchant_severity_filter_apply` | 0 | 3 | 4 | 1 | 8 |
| Pause audit merchant | `findings_auditor_pause_audit_merchant` | 2 | 2 | 0 | 0 | 4 |
| Discard | `audit_screen_discard` | 0 | 2 | 2 | 0 | 4 |
| Edit network delete all | `audit_screen_edit_network_delete_all` | 0 | 2 | 0 | 0 | 2 |
| Edit network delete | `audit_screen_edit_network_delete` | 0 | 2 | 0 | 0 | 2 |
| Audit settings page | `audit_settings_page` | 0 | 0 | 1 | 0 | 1 |
| Merchant severity filter clear | `findings_auditor_merchant_severity_filter_clear` | 0 | 0 | 1 | 0 | 1 |

### Buttons: Portfolio history

| Button or screen | Event | Q1 | Q2 | Q3 | Q4 | 12 months |
|---|---|---|---|---|---|---|
| Search portfolio history | `PM_History_search` | 362 | 424 | 218 | 173 | 1,177 |
| Open portfolio history | `PM_History_button` | 190 | 154 | 137 | 112 | 593 |
| Go from history to findings | `PM_History_gotofindings` | 175 | 160 | 118 | 87 | 540 |
| Page through history | `PM_History_pegination` | 35 | 197 | 5 | 26 | 263 |
| History editmerchant | `PM_History_editmerchant` | 3 | 1 | 2 | 2 | 8 |
| History sort creationdate | `PM_History_sort_creationdate` | 0 | 5 | 0 | 0 | 5 |
| History filter eventstatus | `PM_History_filter_eventstatus` | 0 | 0 | 0 | 4 | 4 |
| History sort risklevel | `PM_History_sort_risklevel` | 0 | 3 | 0 | 0 | 3 |
| History filter eventtype | `PM_History_filter_eventtype` | 0 | 2 | 0 | 0 | 2 |

### Buttons: Disputes

| Button or screen | Event | Q1 | Q2 | Q3 | Q4 | 12 months |
|---|---|---|---|---|---|---|
| Open Disputes tab | `dispute_Tab` | 95 | 174 | 456 | 392 | 1,117 |
| Close dispute dialog | `findings_grid_dispute_close` | 41 | 67 | 94 | 36 | 238 |
| Dispute chat | `dispute_Chat` | 38 | 66 | 75 | 29 | 208 |
| Start a dispute | `findings_grid_dispute` | 13 | 17 | 46 | 24 | 100 |
| Submit dispute | `findings_grid_dispute_submit` | 6 | 9 | 14 | 12 | 41 |
| Go from dispute to findings | `dispute_goto_findings` | 6 | 8 | 14 | 3 | 31 |
| Dispute auditor go to merchant tab | `dispute_auditor_goto_merchant_tab` | 4 | 6 | 3 | 7 | 20 |
| Withdraw dispute | `dispute_withdraw` | 0 | 6 | 10 | 3 | 19 |
| Dispute pagination | `dispute_pagination` | 2 | 0 | 2 | 0 | 4 |
| Dispute cancel | `findings_grid_dispute_cancel` | 1 | 0 | 1 | 1 | 3 |

### Buttons: Findings history

| Button or screen | Event | Q1 | Q2 | Q3 | Q4 | 12 months |
|---|---|---|---|---|---|---|
| Open findings history | `findings_history_page` | 194 | 179 | 116 | 73 | 562 |
| Open past scans | `findings_history_scans` | 97 | 110 | 22 | 0 | 229 |
| Open evidence in history | `findings_history_evidence` | 18 | 25 | 8 | 2 | 53 |

### Buttons: Reports and files

| Button or screen | Event | Q1 | Q2 | Q3 | Q4 | 12 months |
|---|---|---|---|---|---|---|
| Download file | `files_download` | 56 | 45 | 26 | 32 | 159 |
| Open files | `files_button` | 44 | 40 | 21 | 18 | 123 |
| Open create report | `create_report_modal_open` | 26 | 25 | 29 | 25 | 105 |
| Generate report | `create_report_modal_generate` | 26 | 20 | 17 | 19 | 82 |
| Portfolio report | `PM_PV_portfolio_monitoring_report` | 27 | 11 | 4 | 8 | 50 |
| View report files | `create_report_modal_view_files` | 14 | 8 | 7 | 15 | 44 |
| Generate URL report | `findings_grid_url_report_generate` | 4 | 2 | 10 | 6 | 22 |
| History report | `PM_History_report` | 5 | 3 | 0 | 2 | 10 |
| Url report view files | `findings_grid_url_report_view_files` | 0 | 0 | 3 | 2 | 5 |
| History wesbsite report | `findings_history_wesbsite_report` | 2 | 0 | 0 | 0 | 2 |
| Merchant report | `findings_auditor_merchant_report` | 1 | 0 | 0 | 0 | 1 |
| Underwriting report | `PM_PV_underwriting_report` | 0 | 1 | 0 | 0 | 1 |
| All report | `PM_PV_all_report` | 0 | 1 | 0 | 0 | 1 |
| Merchant details merchant report | `PM_UW_merchant_details_merchant_report` | 0 | 0 | 1 | 0 | 1 |
| Merchant details domain report | `PM_UW_merchant_details_domain_report` | 0 | 0 | 1 | 0 | 1 |

### Buttons: Executive dashboard

| Button or screen | Event | Q1 | Q2 | Q3 | Q4 | 12 months |
|---|---|---|---|---|---|---|
| Open executive dashboard | `ExecDashboard_Tab` | 74 | 101 | 108 | 55 | 338 |

### Buttons: Underwriting

| Button or screen | Event | Q1 | Q2 | Q3 | Q4 | 12 months |
|---|---|---|---|---|---|---|
| Go to underwriting merchant details | `PM_PV_portfolio_monitoring_goto_underwriting_merchant_details` | 46 | 38 | 68 | 52 | 204 |
| Open underwriting tab | `PM_PV_underwriting_page` | 7 | 18 | 11 | 9 | 45 |
| Underwriting search | `PM_PV_underwriting_search` | 2 | 7 | 0 | 1 | 10 |
| Merchant details edit url details | `PM_UW_merchant_details_edit_url_details` | 3 | 0 | 0 | 6 | 9 |
| Merchant details evidence popup | `PM_UW_merchant_details_evidence_popup` | 8 | 0 | 0 | 0 | 8 |
| Merchant details full details | `PM_UW_merchant_details_full_details` | 2 | 2 | 0 | 2 | 6 |
| Merchant details evidence popup evidence select | `PM_UW_merchant_details_evidence_popup_evidence_select` | 4 | 0 | 0 | 0 | 4 |
| Merchant details toggle merchant list | `PM_UW_merchant_details_toggle_merchant_list` | 0 | 0 | 2 | 2 | 4 |
| Merchant details back | `PM_UW_merchant_details_back` | 0 | 1 | 2 | 0 | 3 |
| All go to underwriting merchant details | `PM_PV_all_goto_underwriting_merchant_details` | 1 | 0 | 0 | 1 | 2 |
| Merchant details merchant notes | `PM_UW_merchant_details_merchant_notes` | 0 | 0 | 0 | 2 | 2 |
| Underwriting editmerchant | `PM_PV_underwriting_editmerchant` | 1 | 0 | 0 | 0 | 1 |
| Underwriting go to underwriting merchant details | `PM_PV_underwriting_goto_underwriting_merchant_details` | 1 | 0 | 0 | 0 | 1 |
| Portfolio monitoring underwriting filepopup cancel | `PM_PV_portfolio_monitoring_underwriting_filepopup_cancel` | 0 | 1 | 0 | 0 | 1 |
| Portfolio monitoring underwriting filepopup | `PM_PV_portfolio_monitoring_underwriting_filepopup` | 0 | 1 | 0 | 0 | 1 |
| Merchant details merchant notes cancel | `PM_UW_merchant_details_merchant_notes_cancel` | 0 | 0 | 0 | 1 | 1 |
| Merchant details switch url | `PM_UW_merchant_details_switch_url` | 0 | 0 | 0 | 1 | 1 |
| Merchant details merchant notes add | `PM_UW_merchant_details_merchant_notes_add` | 0 | 0 | 0 | 1 | 1 |

### Buttons: Network (TL)

| Button or screen | Event | Q1 | Q2 | Q3 | Q4 | 12 months |
|---|---|---|---|---|---|---|
| Open general network view | `merchantview_general_network` | 1 | 30 | 44 | 4 | 79 |
| Open network page | `findings_network_page` | 7 | 7 | 2 | 3 | 19 |
| Network evidence collapse | `findings_network_evidence_collapse` | 3 | 3 | 0 | 0 | 6 |
| Network evidence openweb | `findings_network_evidence_openweb` | 5 | 0 | 0 | 0 | 5 |
| Network evidence open findings | `findings_network_evidence_open_findings` | 1 | 2 | 1 | 0 | 4 |
| Network evidence expand | `findings_network_evidence_expand` | 2 | 1 | 0 | 0 | 3 |
| TL button on dashboard | `ExecDashboard_TL_button` | 0 | 1 | 0 | 0 | 1 |

### Buttons: Merchant page and scans

| Button or screen | Event | Q1 | Q2 | Q3 | Q4 | 12 months |
|---|---|---|---|---|---|---|
| View a scan on merchant page | `Merchant_tab_view_scan` | 6 | 8 | 11 | 14 | 39 |
| Choose scan | `Merchant_tab_choose_scan` | 2 | 4 | 0 | 4 | 10 |
| Merchant_tab | `Merchant_tab` | 1 | 2 | 5 | 2 | 10 |
| Details | `Merchant_tab_details` | 0 | 0 | 2 | 1 | 3 |
| Scans page | `Merchant_tab_scans_page` | 0 | 0 | 1 | 1 | 2 |
| Filter | `Merchant_tab_filter` | 0 | 0 | 0 | 1 | 1 |
| Open merchant | `Merchant_tab_open_merchant` | 0 | 0 | 0 | 1 | 1 |

### Buttons: Rules and settings

| Button or screen | Event | Q1 | Q2 | Q3 | Q4 | 12 months |
|---|---|---|---|---|---|---|
| Open rules manager | `RM_button` | 5 | 2 | 9 | 0 | 16 |
| Rules manager MCC | `RM_MCC` | 2 | 0 | 5 | 0 | 7 |
| Config Unreported | `RM_config_Unreported` | 0 | 1 | 1 | 0 | 2 |
| Edit | `RM_edit` | 0 | 1 | 1 | 0 | 2 |
| Config Reported | `RM_config_Reported` | 0 | 1 | 1 | 0 | 2 |
| Rules customizer clicked | `rules_customizer_clicked` | 0 | 0 | 1 | 0 | 1 |

### Buttons: WebID

| Button or screen | Event | Q1 | Q2 | Q3 | Q4 | 12 months |
|---|---|---|---|---|---|---|
| Open WebID | `PM_WEBID_page` | 2 | 1 | 2 | 1 | 6 |
| Search WebID | `PM_WEBID_search` | 1 | 1 | 1 | 0 | 3 |


## Limits

- Super Admin users are assumed to be G2 staff. Not verified.
- Event counts measure clicks, not merchants or findings. One action can fire several events.
- No data here on alert volumes, TL findings count, or evidence coverage. That is outside Mixpanel.
