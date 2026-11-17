# Initial Code Trace: Rule Model in MV and Atlas

2026-11-15. Read directly from code. Paths under `/Users/adig/vsCode/code-repos-git/`.

## Atlas

- Condition model: category ID plus type FOUND or MISSING. All conditions in a rule are joined with AND. `unified-platform-new/everc-global-services/global-shared/.../model/mlrc/rules/RuleConditionDto.java`.
- Rule check: `unified-platform-new/mlrc-risk/risk-consumer/.../rules/RulesEvaluator.java`.
  - Lines 31-43: FOUND fails when the category is not in the severity map; MISSING fails when it is.
  - Lines 45-60: the only action is SET_SEVERITY, applied only when the target category is in the map.
  - Lines 19-29: every rule passed in is evaluated; no active-flag check.
- Called from `RiskCalculationService.java` lines 131-147. The severity map is built from `pipelineMessage.getFindings()`, keyed by category ID, using the portfolio's risk level or the default.
- Rule form: `marketview-portal/src/features/settings/pages/MLRCPage/Modals/BusinessRulesModal/NewBusinessRuleModal/`.
  - `NewBusinessRuleModal.tsx`: starts with two FOUND conditions and one SET_SEVERITY action; categories come from `accountCategoryService.getCategories(false, portfolioId)`.
  - `NewBusinessRuleModalHelpers.tsx` lines 11-19: every category becomes an option, no filter.
  - Lines 25-33: action categories are limited to FOUND condition categories not already used.
  - Lines 36-39: number of actions capped at the number of FOUND conditions.
- Active flag: `mlrc-account/.../mapper/JsonUtilsMapper.java` lines 81 and 98 map `active`, treating no value as active. No filter on active in `RiskRulesService.java`, `RiskRulesController.java` or `mlrc-risk/.../AccountConfigService.java`.

## MerchantView

- Rule form conditions: `merchantviewui/src/app/pages/settings/rules/new-rule/blocks/condition-block.component.ts`.
  - Lines 43-45: MCC reported, merchant country, owner country.
  - Lines 51-55: categories from `enums.subTypes`, filtered to shown categories, excluding MCC and Platform types.
- Enums: `merchantviewui/src/app/core/enums/enums.ts` lines 1167-1184. Trigger types category, merchantCountry, ownerCountry, mcc. One action, changeRisk. Site type ANY, REPORTED, UNREPORTED.
- Result block: `outocome-block.component.ts`.
  - Line 20: "Change risk".
  - Lines 60-77: targets limited to category triggers with exists = true not already used.
  - Lines 81-82: actions capped at the number of category triggers.
- Templates: `rule-templates/templates.ts`, 16 rules, all AND, all reported sites, all change risk.
- Rule check: `merv-global-services/merv-risk-calculation-api/.../augmentation/AugmentationExecutionService.java`.
  - Line 30: only active rules.
  - Lines 35-44: per scanned URL, using that URL's finding categories, merchant and owner countries, reported MCC.
  - Lines 51-56: site type filter, then all triggers joined with AND.
  - Lines 64-70: ANY, REPORTED when registered, UNREPORTED when not.
- Trigger checks in `merchant-view-legacy-ec/everc-global-services/global-shared/.../model/rule/trigger/`:
  - `CategoryTrigger.java` lines 25-28: category present on the URL equals `exists`.
  - `MccTrigger.java` lines 33-35: reported MCC equals the value AND `exists`, so "is not" never matches.
- Actions available in the model: `ChangeRiskRuleAction`, `ChangeFindingStatusRuleAction`.

## Verified Transaction Launderer

- Category 186 `VERIFIED_TRANSACTION_LAUNDERER`, and 235 `TRANSACTION_LAUNDERING_BLACKLIST`: `mvserver/MerchantViewServerCommon/grails-app/conf/data/insert_finding_sub_type.txt` lines 186 and 233; `mvnextgen/shared/.../constants/FST.java` lines 31 and 39.
- MV creates 186 only in `mvnextgen/merchant-processor-job/.../NetworkEvidence/UpdateRegisteredUrlsConnectionService.java` lines 28-70. When a connected non-registered URL carries VERIFIED_UNDISCLOSED_MERCHANT, MV adds VERIFIED_TRANSACTION_LAUNDERER to the registered URL.
- MV creates evidence for 235 in `EvidenceClassifier.java` line 37.
- No Atlas main code references 186 or 235. They appear only in the test file `mlrc-merchant/api/src/test/resources/common/default-categories.json`.
