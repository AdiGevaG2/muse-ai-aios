# MerchantView vs Atlas Rules: Feature Comparison

2026-11-15. Research agent output, code read only, about 45 tool calls. MV paths under `/Users/adig/vsCode/code-repos-git/merchant-view-legacy-ec/` and `/Users/adig/vsCode/code-repos-git/everc-global-services/`; Atlas paths under `/Users/adig/vsCode/code-repos-git/unified-platform-new/`. Each cell is backed by a file and line unless marked inferred or unknown.

MV is ahead on rule priority and conflict handling, server validation, showing which rule changed a finding, audit history, and limits. Atlas is ahead on the client API. Two Atlas problems:

- Inactive rules run. The evaluator applies every rule without checking the active flag, and neither the rules service nor the fetch filters inactive ones. The mapper was checked directly afterwards and does not filter either.
- When two rules change one category, the result depends on stored order: Atlas has no rule order, and the last rule to run wins.

| Dimension | MV | Atlas | Gap |
|---|---|---|---|
| List columns | Order, name, date created, created by, active, actions (`grid-header-rules-items.ts` lines 5-38) | Name, description, state, actions; "last updated" and "updated by" commented out (`UseBusinessRulesColumns.tsx` lines 42-77) | No created date, author or order in Atlas; the stored rule has no fields for them (`AccountRiskRuleEntity.java` lines 19-45) |
| Search and filter | Name search and "created by" filter (`rules.component.ts` lines 118-129) | Name search only (`BusinessRulesModal.tsx` line 36) | No author filter |
| Active toggle, edit, delete | All three; delete confirms (`rules.component.ts` lines 85 and 101) | All three; delete confirms (`UseBusinessRulesColumns.tsx` lines 59 and 81-96) | Same; neither has duplicate |
| Priority | Drag-and-drop reorder with a reorder endpoint (`rules.component.ts` line 92, `AugmentationRuleController.java` line 48, `AugmentationRuleServiceImpl` line 159) | No order field or reorder endpoint; rules stored as an unordered map (`AccountRiskRuleEntity.java` lines 9-10) | Atlas has no priority |
| Count limits | Max 200 rules, 50 active, name up to 100 characters (`AugmentationRuleValidator.java` lines 20-22 and 88-91) | Only non-empty name, conditions and actions (`RiskRulesValidator.java` lines 35-55) | No limits in Atlas |
| Scope | Per account (`AugmentationRuleV3Controller.java` line 14) | Per portfolio (`RiskRulesController.java` line 33) | No account-wide rule in Atlas; rebuilt per portfolio (inferred) |
| Who can edit | Read-only for read-only-portfolio, read-only-risk-matrix and auditor roles (`authentication.selectors.ts` lines 107-110) | No role check found in UI or controller | Unknown, needs confirming |
| Duplicates | Rejects duplicate actions or conditions inside a rule (`AugmentationRuleValidator.java` lines 109-117) | Rejects duplicate rule name, ignoring case (`RiskRulesService.java` lines 73-77 and 112-117) | No in-rule check in Atlas |
| Action on a category not in a FOUND condition | Rejected by the server (`AugmentationRuleActionValidator.java` lines 69-70) | Accepted by the server; the evaluator does nothing for it (`RulesEvaluator.java` lines 50-51) | Atlas saves rules through the API that never fire |
| Conflicting rules | Save-time check with "Save anyway" / "Activate anyway" (`AugmentationRuleValidator.java` lines 102 and 122-147, `rules.service.ts` lines 80-111) | None | Missing in Atlas |
| AND/OR | Model supports nested AND/OR groups; evaluator wraps top-level conditions in AND (`AugmentationExecutionService.java` line 55) | AND only (`RulesEvaluator.java` line 24) | Nested groups in the MV model only |
| Actions | UI shows Change risk and a disabled "Send email" (`outocome-block.component.ts` lines 19-22). Change finding status is built and validated in the server but not in the UI (`ChangeFindingStatusRuleAction.java` line 40, `ActionValidator` lines 33-38) | Set severity only | Finding status action not offered in either UI |
| Two rules on one category | First rule in priority order wins per finding and action type (`AugmentationExecutionService.java` lines 79 and 105-107) | Every rule runs; the last one wins, in stored order (`RulesEvaluator.java` lines 23-57) | Atlas outcome depends on hidden order |
| Active flag at evaluation | Inactive rules filtered out (`AugmentationExecutionService.java` line 30) | Not checked in evaluator, rules service or fetch (`RulesEvaluator.java` line 23, `RiskRulesService.java` line 50, `AccountConfigService.java` line 70) | Defect |
| When rules apply | During risk calculation. MV sends events on save (`AugmentationRuleEventService.java` lines 26-42); no recalculation found from them | During risk calculation (`RiskCalculationService.java` lines 145-147); save sends no event (`RiskRulesService.java` lines 65-136) | Neither recalculates on save as far as found |
| Showing which rule changed a finding | Stores rule ID, description, time applied and order per finding (`AugmentationExecutionService.java` lines 87-97); findings grid has a "Finding affected by rule" popup (`grid-action-buttons.component.ts` lines 164-178) | Stores and shows original severity next to final (`RiskCalculationService.java` lines 193-230, `useMerchantFindingsColumns.tsx` lines 234-257); no rule ID or name stored | Atlas does not say which rule made the change |
| Rule change audit | Old version kept in a history store on update and delete (`AugmentationRuleServiceImpl` lines 117 and 147-149); created, updated, activated and deleted events (`AugmentationRuleEventService.java` lines 19-42) | No history and no events (`RiskRulesService.java`) | No audit in Atlas |
| Client API | None found; endpoints serve the MV UI and internal account config | External API to list, create, update and delete rules (`RiskRuleController.java` lines 42-180) | Atlas ahead |
| Templates and tracking | 16 templates; Mixpanel events for create, save, priority change and save errors (`rules.service.ts` lines 59-88) | Neither found | No templates or tracking in Atlas |

## Not covered

- Internal admin-only rules: the release rules in global-ams-ui.
- Atlas UI permission gating.
- A second Atlas business rules screen under the PLRC settings page, possibly a parallel implementation.
