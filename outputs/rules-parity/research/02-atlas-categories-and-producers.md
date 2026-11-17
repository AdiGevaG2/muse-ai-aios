# Atlas: Rule Condition Categories and What Produces Them

2026-11-15. Research agent output, code read only, about 34 tool calls. Paths under `/Users/adig/vsCode/code-repos-git/unified-platform-new/`. Each claim is marked confirmed with its source, or inferred.

A full per-category verdict was not possible. There are about 1,729 categories, the catalog lives outside the Atlas code, and the scanner returns category IDs it decides itself.

## 1. Where the category list comes from

- At runtime the list is fetched from the external Global AMS service (`categoryApi.getCategoryList()`) and cached for 1 hour. Atlas has no category table or seed data of its own. Confirmed: `mlrc-account/.../service/GlobalCategoryService.java` lines 42-55, `mlrc-account/api/src/main/resources/application.yml` lines 41-43.
- The only copy in code is the test file `mlrc-merchant/api/src/test/resources/common/default-categories.json`: 1,729 categories, of which 164 are switched off, 28 deprecated, 79 internal and 177 hidden. Confirmed by parsing the file. Whether production matches it is not confirmed.
- The rule dropdown does not drop switched-off, deprecated or internal categories. Inferred from the UI applying no filter; server-side filtering not checked.

## 2. Categories by producer

- Automated scan, the main path: the scanner returns per-URL findings, each with its own category ID; Atlas saves them and sends them to risk. Confirmed: `mlrc-finding/consumer/.../FindingRecordHandler.java` lines 190-236. Which IDs the scanner emits is decided by the scanner, not Atlas.
- Atlas-generated: 76 MCC Miscode, created by Atlas's MCC mismatch check. Confirmed: `MccMismatchService.java` lines 48 and 268. Category 61 Redirect has a named constant. Confirmed: `CategoryConstants.java` line 13.
- Analysts cannot add findings. They can mark a store-and-category pair as a false positive, or ignore a store. Confirmed: `FalsePositiveService.java` lines 68-103, `FindingRetriggerService.java` lines 65-95. No create-finding endpoint found; search was not exhaustive.
- Migrated from MerchantView: not searched.
- No producer found:
  - 186 Verified Transaction Launderer and 235 Transaction Laundering Blacklist.
  - The 164 switched-off and 28 deprecated categories, and placeholders named `CAT_xxx`. Inferred.
  - Grouping categories such as 1010 "Medical - all", 1021 "Weapons - all", 1011 "Porn - all". Inferred from their names.

## 3. What the rule sees

- One message covers one store: that scan's saved, active findings, grouped by store. Linked stores found through the network graph get their own messages. Confirmed: `FindingSenderService.java` lines 98-115, `FindingRecordHandler.java` lines 231-235.
- The rule does not see the merchant's other stores or older findings, so "A and B" fires only when one scan of one store returns both. Inferred.
- Re-runs:
  - Re-running one store sends all of that store's active findings. Confirmed: `FindingRetriggerService.java` lines 122-139.
  - Re-running a single finding sends only that finding. Confirmed: `FindingRetriggerService.java` lines 163-169. On that run every "missing" condition looks true. Inferred.
- Analyst false positives still count as found: rules run on every finding in the message, and false-positive and customer-status overrides apply afterwards, per finding. Confirmed: `RiskCalculationService.java` lines 137-147 and 193-197, `FindingRiskOverrideResolver.java` lines 58-111.
- Inactive findings are left out of the message. Confirmed: `FindingRecordHandler.java` line 231.

## 4. When rules run

- Only when a risk message is processed: a new scan, an analyst ignoring or un-ignoring a store, an analyst changing a false-positive decision, or a manual re-run. Confirmed: `Consumer.java` lines 37-67, `RiskCalculationService.java` lines 145-147.
- Creating, editing or deleting a rule only saves it; nothing recalculates existing risk. Confirmed: `RiskRulesService.java` lines 65-136.
- The risk service caches rules per portfolio. Confirmed: `AccountConfigService.java` line 67. Cache lifetime not found.

## 5. Active flag, order, conflicts

- Rules have an on/off flag; no value counts as on. Confirmed: `AccountRiskRuleEntity.java` lines 36-37, `JsonUtilsMapper.java` lines 81 and 98.
- The evaluator never checks the flag. Confirmed: `RulesEvaluator.java` lines 19-29. The fetch and mapper do not filter either; checked directly afterwards.
- All conditions must hold; a severity action applies only if the category is in the message. Confirmed: `RulesEvaluator.java` lines 31-58.
- No priority or conflict handling. Rules run in stored order, the later rule wins on the same category, and each rule sees changes made by earlier ones. Confirmed: `RulesEvaluator.java` lines 23-26 and 57. Stored order is insertion order. Confirmed: `JsonUtilsMapper.java` line 48.
- The server checks only that a rule has a name, at least one condition and at least one action; not that the category exists or is switched on. Confirmed: `RiskRulesValidator.java` lines 32-58.

## Next steps named by the research

- The scanner's category output, outside this repo, likely in Core, or a production query of categories seen in Atlas findings.
- A search for rule migration from MerchantView.
