# Adyen MerchantView Usage Baseline

What Adyen does in MerchantView today, to ground the Atlas slides in the November 2026 QBR deck. Pulled 2026-11-13.

## How to read this

- **Adyen users** means MerchantView users whose `Is Customer` flag is `true`: Adyen's own staff.
- **G2RS users on Adyen** means users working inside Adyen's account with `Is Customer` = `false`: G2RS analysts, mostly running manual review. Both groups are shown and kept separate.
- Mixpanel covers instrumented MerchantView screens only. A screen without events shows nothing; that is a coverage gap, not zero use.
- Default window: 2026-08-14 to 2026-11-12 (90 days).

## Headline

1. Adyen has **12 active users** in MerchantView. They logged in **2,187 times** in 90 days. Monthly active users held at 9 from May to September and fell to 7 in October.
2. Adyen works across **many portfolios at once**. 10 of the 12 users switched portfolio **1,986 times** in 90 days. Users logged in to 6 portfolios.
3. Adyen's work is a **review workflow on findings**: 9,189 status changes, 9,972 notes, 2,119 snoozes, 120 disputes.
4. Adyen **barely uses self-service rules**: 2 clicks on Rules Customizer by 2 users in 90 days. Adyen reported Rules Customizer broken in July 2026 (MERV-45774).
5. **34 G2RS users** work inside Adyen's account, generating 64% of all events there, mostly manual review.

## Adyen users, 90 days

| Behavior | Events | Users | Mixpanel event |
|---|---|---|---|
| Logins | 2,187 | 12 | `MV_login` |
| Filter findings | 19,374 | 10 | `filter` |
| Expand a domain in the findings grid | 12,406 | 10 | `findings_grid_domain_expand` |
| Open a finding's log | 12,982 | 10 | `findings_grid_finding_log` |
| Add a note to a finding | 9,972 | 9 | `findings_grid_finding_log_note_add` |
| Change a finding's status | 9,189 | 10 | `findings_grid_status_apply` |
| Change statuses in bulk | 144 | 6 | `findings_grid_status_bulk_confirm` |
| Snooze a finding | 2,119 | 8 | `findings_grid_snooze_submit` |
| Switch portfolio | 1,986 | 10 | `bank_switch` |
| Search for a merchant | 1,572 | 8 | `findings_merchant_search` |
| Review evidence | 1,288 | 9 | `findings_grid_review_evidence` |
| Open the network view | 383 | 7 | `merchantview_general_network` |
| Submit a dispute | 120 | 8 | `findings_grid_dispute_submit` |
| Open the executive dashboard | 48 | 6 | `ExecDashboard_Tab` |
| Generate a report | 42 | 4 | `create_report_modal_generate` |
| Download files | 42 | 4 | `files_download` |
| Generate a URL report | 40 | 5 | `findings_grid_url_report_generate` |
| Assign a finding | 12 | 5 | `findings_grid_assignee_dropdown_open` |
| Add merchants in bulk | 13 | 1 | `add_merchant_bulk_confirm` |
| Open Rules Customizer | 2 | 2 | `rules_customizer_clicked` |

## Users and logins by month

| Month | Adyen users | Adyen logins | G2RS users on Adyen | G2RS logins on Adyen |
|---|---|---|---|---|
| May 2026 | 9 | 523 | 20 | 327 |
| Jun 2026 | 9 | 519 | 19 | 359 |
| Jul 2026 | 9 | 660 | 24 | 358 |
| Aug 2026 | 9 | 798 | 22 | 550 |
| Sep 2026 | 9 | 584 | 30 | 338 |
| Oct 2026 | 7 | 751 | 22 | 1,115 |

## Who uses each portfolio, 12 months

Users are split by email domain here: `@adyen.com` is Adyen, any other domain is G2RS or EverC staff. The `Is Customer` flag is not used for this table because 2 of the 17 `@adyen.com` users also appear with `Is Customer` = `false`. Every non-Adyen user carries `Is Customer` = `false`. Window: 2025-11-13 to 2026-11-12.

| Portfolio | Adyen users | Adyen logins | Adyen status changes | G2RS/EverC users | G2RS/EverC logins | Used by |
|---|---|---|---|---|---|---|
| Sonar Acquiring | 14 | 3,119 | 5,414 | 36 | 1,769 | Both |
| Sonar AO - Acquiring | 10 | 2,360 | 3,917 | 32 | 1,242 | Both |
| Sonar - Advanced | 13 | 2,060 | 24,431 | 32 | 2,156 | Both |
| Sonar Manage | 10 | 398 | 559 | 28 | 325 | Both |
| Sonar PayFac | 9 | 128 | 453 | 31 | 159 | Both |
| Sonar AO - Platforms | 5 | 38 | 0 | 6 | 18 | Both, Adyen view only |
| Sonar Banking | 0 | 0 | 0 | 3 | 5 | G2RS/EverC only |
| Sonar Investigation | 0 | 0 | 0 | 4 | 6 | G2RS/EverC only |
| Sonar | 0 | 0 | 0 | 5 | 7 | G2RS/EverC only |
| Sonar Entity | 0 | 0 | 0 | 0 | 0 | No one (exists in Looker only) |
| Sonar non-Acquiring | 0 | 0 | 0 | 0 | 0 | No one (exists in Looker only) |
| Sonar Lead Evaluation | 0 | 0 | 0 | 0 | 0 | No one (exists in Looker only) |

- Adyen uses **6 portfolios**: Sonar Acquiring, Sonar AO - Acquiring, Sonar - Advanced, Sonar Manage, Sonar PayFac, Sonar AO - Platforms. 17 Adyen users in total.
- Sonar - Advanced carries 70% of Adyen's status changes (24,431 of 34,774).
- G2RS/EverC staff log in to all 6 Adyen portfolios but change almost no statuses there (91 in 12 months). Their review work runs through the audit screens.
- 3 portfolios are visited only by G2RS/EverC staff, and 3 have no logins at all.

## G2RS users on Adyen, 90 days

34 users, 171,374 events (64% of the 269,433 events in Adyen's account). Top actions are manual review: finishing a merchant audit (19,286), auditing a merchant (15,979), removing a finding in the audit screen (14,092), adding a finding (8,165).

## Account size, Looker

Merchant records under the Adyen billing account, not deleted, by portfolio:

| Portfolio | Merchants |
|---|---|
| Sonar - Advanced | 469,819 |
| Sonar Acquiring | 61,645 |
| Sonar AO - Acquiring | 61,274 |
| Sonar Manage | 14,667 |
| Sonar Entity | 14,533 |
| Sonar PayFac | 9,456 |
| Sonar non-Acquiring | 1,801 |
| Sonar Lead Evaluation | 1,009 |
| Sonar AO - Platforms | 568 |
| Sonar Investigation | 405 |
| **Total** | **635,177** |

## Conflicts

- **Portfolio list.** The QBR deck lists Adyen's 6 portfolios as Sonar Advanced, Sonar Acquiring, Sonar AO, Managed, Payfac, Sonar Banking. Adyen users actually work in Sonar AO - Platforms and never open Sonar Banking. The deck's "Sonar AO" could mean AO - Acquiring, AO - Platforms, or both.
- **Merchant count.** Looker has a yes/no field per merchant called `monitoring`. It says "No" for every Adyen merchant, which cannot be true while about 348K Adyen URLs are scanned a month (QBR deck). The field cannot be trusted, so Looker cannot say how many Adyen merchants are being scanned today. The 635,177 figure counts every merchant Adyen has added and not deleted, including ones no longer scanned.

## What this means for the Atlas slides

Recommendation, not measured data. Each line ties an Atlas feature on QBR slide 24 to observed Adyen behavior:

| Atlas feature on slide 24 | Adyen evidence |
|---|---|
| Seamless portfolio navigation | 1,986 portfolio switches by 10 of 12 users in 90 days |
| Cross-portfolio visibility, one dashboard | Adyen users work across 6 portfolios; 6 users already open the executive dashboard |
| Flexible portfolio management, merchant groups | 635,177 merchant records across 10 portfolios |
| Self-service keyword management | Rules Customizer opened twice in 90 days, after Adyen reported it broken in July. A self-service story needs to show it works, not just that it exists. |

Not on slide 24 but central to Adyen's day: the findings review workflow (status, notes, snooze, disputes, bulk actions). The deck does not tell Adyen how this carries over to Atlas.

## Not pulled

- Findings volume and engagement by portfolio. The QBR deck has account totals; a Looker `fact_finding` pull was not run.
- Session length and time in product. Not instrumented as a property used here.
- SmartScan usage. SmartScan is outside the MerchantView Mixpanel project.
- Which of the 12 Adyen users are which people. Not pulled; names are personal data.

## Queries

| Figure | Source | Query |
|---|---|---|
| Events and users by event type | Mixpanel, MerchantView Production (project 2040581) | Insights, `$all_events` total and unique, filter `Customer = Adyen`, breakdown `$event_name` then `Is Customer`, 2026-08-14 to 2026-11-12 |
| Monthly users and logins | Mixpanel, project 2040581 | Insights, `MV_login` unique and total, filter `Customer = Adyen`, breakdown `Is Customer`, by month, 2026-05-01 to 2026-10-31 |
| Users and status changes by portfolio | Mixpanel, project 2040581 | Insights, `MV_login` unique and `findings_grid_status_apply` total, filter `Customer = Adyen`, breakdown `Bank Name` then `Is Customer`, 2026-08-14 to 2026-11-12 |
| Portfolio use by email domain | Mixpanel, project 2040581 | Insights, `MV_login` unique and total plus `findings_grid_status_apply` total, filter `Customer = Adyen` and `Email` contains / does not contain `@adyen.com`, breakdown `Bank Name` (non-Adyen also by `Is Customer`), 2025-11-13 to 2026-11-12 |
| Merchant records by portfolio | Looker, model `mv`, explore `merchant` | Fields `account.name`, `merchant.monitoring`, `merchant.count`, `mhu.count_urls_mhu`; filters `billing.name = Adyen`, `merchant.deleted = No`; run 2026-11-13 |
