# MerchantView: Rule Condition Categories and What Produces Them

2026-11-15. Research agent output, code read only, about 30 tool calls. Paths under `/Users/adig/vsCode/code-repos-git/merchant-view-legacy-ec/`. The selectable list, timing and trigger checks are confirmed in code. Producer mechanism per category is inferred from finding type; the core scanner and analyst finding-creation endpoints were not traced. Production counts in `../data/mv-category-findings-summary.md` replace these inferences where they differ.

## 1. Where the selectable list comes from (confirmed)

- The runtime list does not come from the seed file. The UI gets `enums.findingSubTypes` from the server (`EnumsService.groovy` line 39), built from the latest per-bank `risk_model_variable_audit` row (`RiskModelVariableService.groovy` lines 56-86 and 216-226).
- "Shown" is the bank's own risk-matrix `a.is_shown` (line 70), not `finding_sub_type.is_shown`. Each bank can have a different selectable list.
- The seed file is stale. It stops at ID 249, plus 501-521, 994-999 and 1001-1046. `FST.java` has IDs missing from it: THC_VARIANTS 278 (line 42) and MCC_TYPE_REPORTED, DETECTED, VERIFIED, MISMATCH_DETECTED, IDs 1100-1103 (lines 45-48).
- Seed columns: schema in `test-schema.sql` lines 1307-1324. The seed rows are positional; inferred order: id, key, name, finding_type, severity, exclude, evidence_type, is_shown, is_censored, is_active, then two unidentified flags. Finding type names: `FindingType.groovy` lines 8-77.
- The UI excludes MCC (type 3) and Platform (type 65). Audit type 54, IDs 995-999, is not excluded.

## 2. Selectable categories by producer (inferred unless marked)

| Mechanism | Categories, from seed with is_shown = 1 |
|---|---|
| Automated scanner or classifier | Content (type 1): 2-10, 12, 14, 17-19, 21-22, 25, 28, 30, 32, 34-36, 40, 43-47, 49, 51, 53-54, 57-58, 62-63, 70, 77-79, 83-86, 88-90, 93-94, 96-100, 102, 105, 109-111, 114, 127, 130-134, 137-138, 144, 162-163, 166, 171-173, 175, 179-181, 192, 198-203, 209-211, 217, 219, 230, 233. Payment page (2): 8, 33, 38, 52, 56, 65, 116-117, 120-125, 128, 147, 155-156, 182, 191, 194-196, 205-207, 229, 232. Security (13): 13, 48, 50, 55, 64, 176. Keyword (16): 208, 212-215, 221-228, 236, 238, 243, 249. Availability (28): 60, 61, 164, 237. Site section (39): 142, 143, 158. Policies (55): 183, 204, 239-247. Mobile app (50): 154. Third-party payment provider (23): 115, 169, 190. Suspicious flags (64): 234. WebID (53): 174 |
| External reputation feeds (type 31) | 29, 37, 39, 118 |
| Link or network evidence (type 30) | 72, 73, 74, 75, 152, 153 from the link finding creator; 186 |
| Analyst or manual | Test transactions 165, 187, 188, 189, 197, confirmed as a group at `FindingSubType.groovy` lines 158-166; 185; 193, 248, 235, type 31, likely uploaded or analyst-set; Audit type 54: 995-999 |
| MCC or derived | 76, type 3, not selectable; 1100-1103, not in seed, produced by the MCC finding handler |
| Produced after rules run | 59 Online is created after risk calculation (`MerchantProcessorService.java` line 120 vs 112). A rule on Online fires only if the conditional recalculation at lines 126-127 runs, or at a later recalculation. Confirmed ordering |

No producer found: not determined. Candidates are deprecated or legacy IDs a bank may have re-shown, such as type 36 public records 129, 139, 140, 148, 160, which are hidden by default.

## 3. Timing (confirmed)

- Scan pipeline order: MCC handling (line 105), link findings (107), network evidence (109), then risk calculation with rules (112; `RiskCalculator.java` line 30). Link, network and MCC findings are present when rules run.
- Analyst edits to a finding (`FindingApi4Controller.groovy` line 71) or bulk status changes (`FindingService.groovy` line 636) trigger immediate recalculation through `RiskCalculateService.groovy` line 42 to the risk API, which re-evaluates rules (`RiskCalculationService.java` line 60). A scheduled job also recalculates (`CalculateRiskScoreJob.groovy` line 45).
- Not traced: whether creating a new manual finding triggers recalculation. Inferred yes, same path.

## 4. Trigger types (confirmed)

- MCC: `return Objects.equals(infos.getReportedMcc(), mccFindingSubTypeId) && exists;` (`MccTrigger.java` line 34). Reads only the URL's reported MCC, never the detected MCC. "MCC is not X" never matches.
- Merchant and owner country: read the merchant's reported countries (`AugmentationExecutionService.java` lines 35-36). They support "is not" (`result == exists`, `MerchantCountryTrigger.java` line 31).
- Evaluation:
  - All conditions joined with AND (line 55), per URL against that URL's categories only (line 41).
  - A URL whose findings list is null is skipped (lines 38-40), so a country-only rule cannot fire on it.
  - Site type filter applied per URL (lines 64-71).
