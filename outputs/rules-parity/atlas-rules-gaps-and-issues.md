# Atlas Rules: Gaps and Issues

As of 2026-11-15. Based on the MerchantView and Atlas code and on MerchantView production data in Looker. No Atlas production data was available.

## Summary

**MerchantView.** Rules work as configured.

- MerchantView respects the on/off switch and the rule order the client sets.
- It warns about conflicting rules on save.
- It shows on each finding which rule changed its risk.

There are three limits:

- In the last 90 days, 296 of the 547 categories that can be rule conditions had no findings. Rules built on those categories did not run. Verified Transaction Launderer is one of them.
- "MCC is not X" never matches.
- Rules on the Online category miss the scan that found it.

**Atlas.** Rules do not work reliably.

- Switched-off rules still run.
- When two rules change the same category, the last stored rule wins, and the client cannot see or set that order.
- A false positive still counts as found.
- The condition list shows every category in the catalog, including switched-off and deprecated ones, and categories nothing in Atlas creates, such as Verified Transaction Launderer.

**Gaps.** Atlas has none of these MerchantView features:

- MCC, country and site type conditions
- Rule order and conflict warnings
- A record of which rule changed a finding's risk
- History of rule changes
- Templates
- Account-wide rules

Atlas has one thing MerchantView does not: a client API for rules.

**Usage.** In MerchantView, 5 clients saved rules in the last 12 months. Adyen saved 31 of the 40.

## How rules work today

A rule reads: if these categories are found or missing, change the risk of a found category to a set level.

| Area | MerchantView | Atlas |
|---|---|---|
| Conditions | Category found or not found, reported MCC, merchant country, owner country | Category found or missing |
| Site filter | Reported sites, unreported sites, or any site | None |
| What the rule looks at | One site at a time, with all of its current findings | The findings from one scan of one store |
| Logic | All conditions must match | All conditions must match, at least 2 conditions |
| Result | Change the risk of a found category to a level | Same |
| Order between rules | Set by the client; the first rule wins | None; the last stored rule wins |
| Switched-off rules | Do not run | Still run |
| Templates | 16 | None |
| Scope | Account | Portfolio |
| Client API | None found | List, create, update and delete |

## MerchantView: what works and what does not

**Works**

- Category found and not found conditions, checked per site against that site's findings.
- Merchant country and owner country conditions, both "is" and "is not".
- Site filter: reported, unreported or any site.
- Switched-off rules do not run.
- Rule order: the client drags rules into order, and the first matching rule wins on a category.
- Conflict warning on save, with "Save anyway".
- Each finding records which rule changed its risk, and the findings grid shows it.
- Network, link and MCC findings exist before rules run, so rules can use them.
- An analyst editing a finding triggers an immediate recalculation, so rules re-run.

**Does not work**

- "MCC is not X" never matches. The MCC condition only works as "is".
- The Online category is created after rules run. A rule on Online misses the scan that found it and applies only at a later recalculation.
- A site with no findings is skipped, so a rule with only country conditions does not run on it.
- In the last 90 days, 296 of the 547 categories that can be rule conditions had no findings. Rules on them did not run. Each bank sees a subset of the catalog set by its risk matrix, so the number of these categories a client sees differs per bank.
- Verified Transaction Launderer had 0 findings in the last 90 days. MerchantView adds it to a client's site only after an analyst verifies a connected site as an undisclosed merchant. The scanner does not detect it.
- A "change finding status" result is built in the server but not offered in the form.
- Saving a rule does not recalculate risk for existing merchants. It applies at the next recalculation.

## Atlas: what works and what does not

**Works**

- Category found and missing conditions, checked against the findings from one scan of one store.
- The result changes the risk of a found category.
- The findings table shows the original risk next to the final risk.
- Duplicate rule names are blocked.
- Clients can list, create, update and delete rules through the external API.

**Does not work**

1. Switched-off rules still run. The rule check, the rules service and the rule fetch do not filter on the on/off flag.
2. When two rules change the same category, the last stored rule wins. The client cannot see or set that order.
3. The condition list shows every category in the global catalog. The copy in the code holds about 1,729 categories, of which 164 are switched off, 28 are deprecated, 79 are internal and 177 are hidden. Whether production matches this copy is not confirmed.
4. Some categories in the list have nothing in Atlas that creates them, so rules on them never run. Verified Transaction Launderer, Transaction Laundering Blacklist and the "- all" grouping categories are examples.
5. Atlas analysts cannot add findings. They can only mark false positives or ignore stores. Categories that only analysts add in MerchantView therefore cannot fire in Atlas. In MerchantView, 58 categories got findings only from analysts in the last 90 days.
6. A finding an analyst marked as a false positive still counts as found.
7. Re-running a single finding sends only that finding to the rule check, so every "missing" condition matches. A rule with a missing condition can then change risk when it should not.
8. A rule that needs two categories fires only when one scan of one store finds both. Findings on the merchant's other stores, or from earlier scans, do not count.
9. Saving or editing a rule changes nothing until the store's next scan. The risk service also caches rules per portfolio. No data was found on the cache lifetime.
10. The API accepts a rule whose result targets a category that is not in a found condition. That result never applies.
11. The server does not check that a condition's category exists or is switched on.

## Which conditions can fire

A condition fires only when a finding of that category exists.

**MerchantView production data.** This covers scans in the last 90 days up to 2026-11-15, with test accounts excluded. Of the catalog, 547 categories can be rule conditions in MerchantView, after removing MCC and Platform categories.

| Where the findings come from | Categories | Share |
|---|---|---|
| The scanner | 193 | 35% |
| Analysts only | 58 | 11% |
| No findings at all | 296 | 54% |

- Verified Transaction Launderer: 0 findings.
- Transaction Laundering Blacklist: 35 findings.
- Test transaction categories 187, 188, 189 and 197: 0 findings.
- Medical - all, Porn - all and Weapons - all: 0 findings.

**Atlas.** No data was found on Atlas finding counts by category. Looker holds no Atlas findings data. Atlas uses a scanner for its findings, so the 193 categories the MerchantView scanner produced are the best estimate of what can fire in Atlas. This is an inference, not a measurement.

## Gaps between MerchantView and Atlas

| Area | MerchantView | Atlas |
|---|---|---|
| Switched-off rules | Do not run | Still run |
| MCC condition | Yes, "is" only | No |
| Merchant country and owner country conditions | Yes | No |
| Site filter: reported, unreported, any | Yes | No |
| What one rule looks at | One site with all its current findings | One scan of one store |
| Rule order | Drag to reorder; the first rule wins | None; the last stored rule wins |
| Conflict warning on save | Yes, with "Save anyway" | None |
| False positives | Not checked | Count as found |
| Which rule changed a finding's risk | Shown on the finding | Only the original and final risk are shown |
| History of rule changes | Kept on every update and delete | None |
| Scope | One rule covers the whole account | Each portfolio needs its own rules |
| Templates | 16 | None |
| Rules list | Order, name, date created, created by, active; filter by author | Name, description, state |
| Limits | 200 rules, 50 active, names up to 100 characters | None |
| Server check on results | Rejects a result on a category not in a found condition | Accepts it; the result never applies |
| Duplicate check inside a rule | Yes | No; only duplicate rule names are blocked |
| Read-only roles | Auditors and read-only users cannot edit | No role check found |
| Usage tracking | Create, save, reorder and save-error events | None found |
| Client API | None found | Yes |

"False positives: not checked" means this research did not check how MerchantView rules treat findings marked as false positives.

**The "then" restriction.** In both products, a rule's result can only target a category that is in a found condition, with at most one result per found condition. MerchantView enforces this in the form and on the server. Atlas enforces it only in the form. A rule such as "if Payment Page is missing, raise Alcohol to High" is not possible in either product unless Alcohol is also a found condition. No written reason for this restriction was found.

**Missing in both products.**

- OR logic in the form.
- A result that changes a finding's status. The MerchantView server supports it, but the form does not offer it.
- Recalculating existing merchants when a rule is saved.

## How clients use rules in MerchantView

This section covers the last 12 months up to 2026-11-15. The source is MerchantView rule events in Looker.

| Step | Customers |
|---|---|
| Opened the rules page | 44 |
| Started creating a rule | 21 |
| Cancelled rule creation | 15 |
| Saved a rule | 5, plus one internal G2 user |

| Who saved rules | Rules saved |
|---|---|
| Adyen | 31 |
| Moneris Solutions Corporation | 5 |
| CBA | 1 |
| EpicPay | 1 |
| NAB | 1 |
| Internal G2 user | 1 |

| Year | Rules saved |
|---|---|
| 2023 | 187 |
| 2024 | 175 |
| 2025 | 79 |
| 2026, to 2026-11-15 | 39 |

**Clients with the most active rules.**

| Client | Highest number of active rules recorded |
|---|---|
| Paddle | 43 |
| Pay.com | 32 |
| Natixis Payment Solutions | 31 |

- These numbers come from the active-rule count that MerchantView records on every rule event. The table shows the highest count seen for each client, across all time.
- None of these three clients saved a rule in the last 12 months, so these counts come from earlier rule events. No data was pulled on the date of each count.

**Other figures.**

- Looker's rules adoption view counts 0 of 60 customers as adopted in November 2026, and 1 in October.
- No data was found on how many findings rules changed. Looker has no field for it.

## Recommended order of fixes

These are recommendations, not decisions.

1. Fix the Atlas defects that make rules ignore the client's settings:
    - the on/off switch
    - false positives counting as found
    - single-finding re-runs matching "missing" conditions
    - server checks on conditions and results
2. Limit the Atlas condition list to categories that get findings in Atlas.
3. Add rule order and a conflict warning on save.
4. Show which rule changed a finding's risk, and keep a history of rule changes.
5. Add MCC, country and site filter conditions.
6. Move existing MerchantView rules for Adyen, Paddle, Pay.com, Natixis and Moneris, and add templates.

## Open questions

- Check how MerchantView rules treat findings marked as false positives.
- Decide whether an Atlas rule should check one store or all of a merchant's sites.
- Decide whether saving a rule should recalculate risk for existing merchants.
- Decide whether a rule's result should be able to target a category that is not in a found condition.
- Check the second business rules screen under the PLRC settings, to see if it is a separate rule setup.
- Confirm who may create and edit rules in Atlas.
- Confirm which of Adyen, Paddle, Pay.com, Natixis and Moneris are moving to Atlas.

## Evidence

Detailed research is in `research/` and data in `data/` in this folder.

Code, under `code-repos-git/`:

- Atlas rule check: `unified-platform-new/mlrc-risk/risk-consumer/.../rules/RulesEvaluator.java`, called from `RiskCalculationService.java` lines 131-147.
- Atlas rule form: `unified-platform-new/marketview-portal/.../BusinessRulesModal/NewBusinessRuleModal/NewBusinessRuleModalHelpers.tsx` lines 11-39.
- Atlas rule storage and checks: `unified-platform-new/mlrc-account/.../RiskRulesService.java`, `JsonUtilsMapper.java` lines 81 and 98, `RiskRulesValidator.java` lines 32-58.
- Atlas category list: `mlrc-account/.../GlobalCategoryService.java` lines 42-55; test copy `mlrc-merchant/api/src/test/resources/common/default-categories.json`.
- Atlas findings sent to risk: `mlrc-finding/.../FindingRecordHandler.java` lines 190-236, `FindingRetriggerService.java` lines 122-169, `FindingRiskOverrideResolver.java` lines 58-111.
- MerchantView rule check: `merchant-view-legacy-ec/merv-global-services/merv-risk-calculation-api/.../augmentation/AugmentationExecutionService.java`.
- MerchantView conditions and results: `merchant-view-legacy-ec/everc-global-services/global-shared/.../model/rule/`; form at `merchantviewui/src/app/pages/settings/rules/new-rule/`; templates in `rule-templates/templates.ts`.
- MerchantView rule order, conflicts, limits and history: `everc-global-services/global-ams-api/.../AugmentationRuleServiceImpl.java`, `AugmentationRuleValidator.java`.
- Verified Transaction Launderer creation in MerchantView: `merchant-view-legacy-ec/mvnextgen/merchant-processor-job/.../NetworkEvidence/UpdateRegisteredUrlsConnectionService.java` lines 28-70.

Data, from Looker:

- Findings by category: model `mv`, explore `fact_finding`, finding sub type by "is manual", measure "Findings" with test accounts excluded, scan date in the last 90 days up to 2026-11-15. Category names from explore `categories`.
- Rules usage: model `mixpanel`, explore `rules_customizer`, events in the last 365 days up to 2026-11-15. Rules saved per year and highest active rule counts from the same explore, all time.
- Adoption: model `mixpanel`, explore `customers_rules_adoption`, last 6 months.
