# MerchantView Rules Usage Data

Pulled 2026-11-15 from Looker. Re-run with `looker.py query '<json>'` from this folder.

## Rule events, last 365 days to 2026-11-15

Query: model `mixpanel`, explore `rules_customizer`, fields `event_name`, `events`, `count_billing` (customers), filter `event_ts_date` = "365 days".

| Event | Events | Customers |
|---|---|---|
| rules_customizer_clicked | 352 | 44 |
| rule_creation_started | 97 | 21 |
| rule_saved | 39 | 5 |
| rule_creation_canceled | 33 | 15 |
| rule_template_started | 12 | 5 |
| rule_template_popup | 8 | 2 |
| rule_deleted | 4 | 3 |
| rule_save_error | 2 | 1 |
| rule_disabled | 2 | 2 |
| rule_template_saved | 1 | 1 |
| rule_activated | 1 | 1 |

## Who saved rules, last 365 days to 2026-11-15

Query: same explore, fields `customer_name`, `is_customer`, `events`, filters `event_ts_date` = "365 days", `event_name` = "rule_saved,rule_template_saved".

| Customer | Is customer | Events |
|---|---|---|
| Adyen | Yes | 31 |
| Moneris Solutions Corporation | Yes | 5 |
| CBA | Yes | 1 |
| EpicPay | Yes | 1 |
| Internal | No | 1 |
| NAB | Yes | 1 |

## Rules created and deleted per year, all time

Query: same explore, fields `event_ts_year`, `created_rules`, `deleted_rules`, `count_billing`, no filter.

| Year | Created rules | Deleted rules | Customers with any rule event |
|---|---|---|---|
| 2026 | 39 | 3 | 41 |
| 2025 | 79 | 11 | 58 |
| 2024 | 175 | 36 | 54 |
| 2023 | 187 | 35 | 60 |

## Highest active rule counts, all time

Query: same explore, fields `customer_name`, `total_active_rules`, `created_rules`, sorted by `total_active_rules` descending, limit 30. `total_active_rules` is recorded per event, so each row is a point in time, not the current count.

| Customer | Highest active rules seen |
|---|---|
| Paddle | 43 |
| Pay.com | 32 |
| Natixis Payment Solutions | 31 |

## Rules adoption, last 6 months

Query: model `mixpanel`, explore `customers_rules_adoption`, fields `day_month`, `total_customers`, `total_adopted_customers`, `total_strategic_customers`, `total_strategic_adopted_customers`, filter `day_month` = "6 months". The definition of "adopted" in this view is not known.

| Month | Customers | Adopted | Strategic customers | Strategic adopted |
|---|---|---|---|---|
| 2026-11 | 60 | 0 | 14 | 0 |
| 2026-10 | 60 | 1 | 14 | 1 |
| 2026-09 | 60 | 0 | 14 | 0 |
| 2026-08 | 60 | 0 | 14 | 0 |
| 2026-07 | 60 | 0 | 14 | 0 |
| 2026-06 | 60 | 0 | 14 | 0 |

## Not available

- Number of findings whose risk a rule changed: no field in Looker.
- Atlas rules usage and Atlas findings by category: no Atlas findings data in Looker. The `mixpanel_unified` explores hold user actions on findings, not the findings population.
