# Reverse Engineering: PayPal MCC Mismatch

Verified: 2026-08-30  
Mode: Strict  
Source platforms: MV, MLRC/CMP, SP/GO, WS  
Target platform: UP

## Executive Summary

- PayPal's hard requirement is not merely MCC detection: the platform must
  compare the customer-reported MCC with the detected MCC and explicitly
  identify a mismatch. [documented: stakeholder-provided email summary]
- MV has the strongest verified reference implementation. It compares the
  reported and detected MCC's configured **MCC groups**, not just their
  four-digit codes. Different codes in the same group are treated as a match.
- MV produces structured evidence containing both MCC codes, displays the
  reported/detected codes and groups, and includes mismatch in exports.
- UP/MLRC already supports reported MCC ingestion, MCC validation, detection
  enablement, Core dispatch, MCC findings, configuration, and generic finding
  review.
- UP mismatch support could not be certified. No comparison or
  mismatch-generation logic was found in the inspected MLRC services, and the
  Core implementation that might perform this comparison is unavailable.
- SP/GO contains MCC reference data and editable MCC-verification records, but
  no automatic reported-versus-detected group comparison was found. WS could
  not be verified.

## Current Behavior by Platform

| Platform | Verified behavior | Assessment |
|---|---|---|
| MV | Automatic group-based comparison, explicit mismatch finding, structured evidence, UI, and report output | Strong behavioral reference |
| MLRC/CMP | Captures reported MCC, enables MCC analysis, dispatches detection to Core, and receives generic findings | Detection foundation exists; mismatch not verified |
| SP/GO | Captures reported MCC, exposes MCC lookup data, stores primary/secondary verification results, and permits manual updates | Manual verification support; automatic mismatch not found |
| WS | Source repository unavailable | `NOT VERIFIED` |
| UP target | Merchant MCC management, configuration, Core dispatch, finding review, and resolution | Partial foundation; parity not demonstrated |

### Merchant View

MV evaluates MCC at the scanned-URL level. A registered URL can have a
reported MCC and a detected MCC finding.

The comparison rule is:

- Same configured MCC group -> match.
- Different configured MCC groups -> create `MCC_MISCODE`.
- Different MCC codes in the same group do not create a mismatch.

The implementation creates the mismatch only when both reported and detected
findings exist and their configured group IDs differ:
[MCCAdjustmentLogic.java](../../../../code-repos-git/merchant-view-legacy-ec/mvnextgen/merchant-processor-job/src/main/java/com/everc/nextgen/mpj/service/scannedmerchant/finding/mcc/MCCAdjustmentLogic.java#L40).
Group equivalence is defined in
[FindingCategoryRelationService.java](../../../../code-repos-git/merchant-view-legacy-ec/mvnextgen/merchant-processor-job/src/main/java/com/everc/nextgen/mpj/service/scannedmerchant/finding/mcc/FindingCategoryRelationService.java#L18).

Unit tests independently verify both different-group mismatch and same-group
match behavior:
[MCCAdjustmentLogicTest.java](../../../../code-repos-git/merchant-view-legacy-ec/mvnextgen/merchant-processor-job/src/test/java/com/everc/nextgen/mpj/service/scannedmerchant/finding/MCCAdjustmentLogicTest.java#L91).

Mismatch evidence contains `reportedMcc` and `detectedMcc`:
[MCCEvidenceCreator.java](../../../../code-repos-git/merchant-view-legacy-ec/mvnextgen/merchant-processor-job/src/main/java/com/everc/nextgen/mpj/service/scannedmerchant/evidence/MCCEvidenceCreator.java#L25) and
[MCCMismatchMeta.java](../../../../code-repos-git/merchant-view-legacy-ec/mvnextgen/shared/src/main/java/com/everc/nextgen/shared/model/MCCMismatchMeta.java#L8).

The MV evidence UI displays:

- MCC Match or MCC Mismatch.
- Detected MCC and group.
- Reported MCC and group.
- An explanation when the groups differ.
- Other MCCs belonging to each group.

Evidence:
[evidence-mcc.component.html](../../../../code-repos-git/merchant-view-legacy-ec/merchantviewui/src/app/shared/modals/dialogs/evidence/evidence-mcc/evidence-mcc.component.html#L1).

Exports include reported MCC, reported group, detected MCC, detected group, and
mismatch:
[ScanItemReport.groovy](../../../../code-repos-git/merchant-view-legacy-ec/mvserver/MerchantViewServerCommon/src/main/groovy/com/evercompliant/report/ScanItemReport.groovy#L35).

### MLRC/CMP and Atlas

UP has several required building blocks:

- Merchant creation and updates accept validated reported MCCs. The underlying
  merchant model supports a list of MCCs:
  [MerchantCreateDto.java](../../../../code-repos-git/unified-platform-new/mlrc-merchant/shared-spring/src/main/java/com/everc/merchant/shared/dto/MerchantCreateDto.java#L76).
- MCC processing is dispatched only when MCC is enabled in product
  configuration and requested in the analysis domains:
  [CoreRunConfigurationFactory.java](../../../../code-repos-git/unified-platform-new/mlrc-analysis/sender/src/main/java/com/everc/analysis/service/CoreRunConfigurationFactory.java#L38).
- UP exposes separate MCC enablement for onboarding and monitoring:
  [PortfolioGeneralSettings.tsx](../../../../code-repos-git/unified-platform-new/marketview-portal/src/features/settings/pages/MLRCPage/Modals/Portfolio/PortfolioGeneralSettings.tsx#L216).
- The portal displays the reported MCC and supports editing it.
- Findings support risk, resolution, evidence, and account/portfolio category
  configuration.

The following target gaps were observed:

- No reported-versus-detected comparison or `MCC_MISCODE` generation was found
  in `mlrc-analysis`, `mlrc-finding`, `mlrc-merchant`, or `mlrc-bff`.
- The inspected BFF classifies only category IDs `10000-19999` as MCC. MV's
  mismatch category is ID `76`, so forwarding that legacy category would not
  classify it as an MCC finding:
  [FindingServiceImpl.java](../../../../code-repos-git/unified-platform-new/mlrc-bff-2.0/mlrc-bff-api/src/main/java/com/everc/mlrc/bff/service/impl/FindingServiceImpl.java#L46).
- UP's evidence UI has no structured reported/detected MCC or group comparison.
- Reported MCC belongs to the UP merchant, while findings belong to stores. The
  UP store model has no store-specific reported MCC:
  [StoreEntity.java](../../../../code-repos-git/unified-platform-new/mlrc-merchant/shared-spring/src/main/java/com/everc/merchant/entity/StoreEntity.java#L23).
- Although the merchant model supports multiple MCCs, the external create API
  accepts one MCC and the portal displays the first. Multi-MCC comparison
  behavior is undefined.

UP therefore has MCC detection infrastructure but cannot yet be certified as
satisfying PayPal's mismatch requirement.

### Single Platform / GO

SP/GO captures:

- The submitted merchant MCC.
- A separate merchant-category-code field.
- Merchant-group disallowed MCCs.
- MCC reference-data search.
- One or more MCC verification records, including a `primary` marker.
- Manual updates to MCC verification results.
- Blank-code handling for `Unclassifiable` or `No MCC Available`.

Evidence:
[ClientBoardingCaseService.java](../../../../code-repos-git/single-platform-legacy-g2/g2-singlePlatform/client/src/main/java/com/g2llc/client/go/services/ClientBoardingCaseService.java#L447),
[MccVerificationRepository.java](../../../../code-repos-git/single-platform-legacy-g2/g2-singlePlatform/data_core/src/main/java/com/g2llc/saga/go/persistance/MccVerificationRepository.java#L24), and
[go-queries.properties](../../../../code-repos-git/single-platform-legacy-g2/g2-singlePlatform/data_core/src/main/resources/go-queries.properties#L721).

No automatic comparison between the submitted MCC and verification results,
group-equivalence rule, or explicit mismatch result was found in the GO path.
The evidence supports a manual verification workflow, not PayPal-ready
automatic mismatch.

## Business Rules to Preserve

1. A reported MCC and a detected MCC must both exist before a definitive match
   or mismatch can be calculated.
2. Comparison should use the configured MCC group taxonomy.
3. Different codes in the same group must be considered a match.
4. Codes in different groups must produce an explicit mismatch result.
5. The result must preserve the reported MCC, detected MCC, reported group, and
   detected group.
6. A mismatch must be represented as a durable finding or equivalent reviewable
   object.
7. The mismatch must be associated with the URL/store whose content produced
   the detected MCC.
8. Users must be able to see and understand why the result is a mismatch.
9. The finding must participate in the normal risk, resolution, audit, and
   rescan lifecycle.
10. Match/mismatch output must be available through PayPal's required delivery
    channel, not only as an internal UI state.
11. MCC processing must be configurable by account, portfolio, and product or
    scan type.
12. Missing or unclassifiable detection must remain distinct from both Match
    and Mismatch.
13. Rescans must recalculate comparison when the reported MCC, detected MCC, or
    group taxonomy changes.
14. Multiple URLs and multiple reported MCCs require deterministic comparison
    semantics.
15. Existing manual review must not silently overwrite a newly detected value
    or lose its provenance.

## Target Platform: What Already Exists

- Validated reported-MCC ingestion and update.
- Merchant-level storage supporting multiple MCC values.
- MCC reference data exposed to the BFF and portal.
- Onboarding and monitoring MCC enablement.
- Portfolio-level MCC category configuration.
- MLRC-to-Core MCC analysis dispatch.
- Generic finding ingestion, persistence, risk, status, evidence, and review UI.

## Gaps

- No verified mismatch-calculation owner.
- No verified Core output contract for detected MCC and MCC group.
- No explicit UP mismatch category or typed result model.
- No structured mismatch evidence contract.
- No target UI comparing reported and detected MCCs and groups.
- No verified PayPal API, callback, file, or report output.
- No defined handling of multiple reported MCCs.
- Merchant-level reported MCC versus store-level detection is unresolved.
- No defined behavior for missing, invalid, or unclassifiable detection.
- No verified migration mapping for MV findings, statuses, audit history, or
  evidence.
- No end-to-end automated mismatch scenario was found.

## Conflicts / Product Decisions

1. **Comparison semantics:** Confirm group-level mismatch, matching MV, versus
   exact-code inequality.
2. **Data ownership:** Decide whether one merchant-level reported MCC applies to
   every store or each store needs its own reported MCC.
3. **Multiple reported MCCs:** Define whether a detected MCC matches any
   reported group, only the primary MCC, or every reported MCC.
4. **Result states:** Define at least `MATCH`, `MISMATCH`, `NO_REPORTED_MCC`,
   `NO_DETECTED_MCC`, and `PROCESSING_FAILURE`. A missing customer input, a scan
   that detected nothing, and a comparison that failed are three different
   problems with three different owners; they must not collapse into one
   "unclassifiable" state. `PROCESSING_FAILURE` retries immediately and once
   more at the next scheduled scan before persisting as a standing result.
5. **Delivery contract:** Determine whether PayPal consumes mismatch through an
   API, callback, report/file export, UP UI, or a combination.
6. **Logic ownership:** Decide whether Core returns detected MCC data and MLRC
   performs comparison, or Core returns the final comparison.
7. **Feature configuration:** Decide whether mismatch shares `mccEnabled` or has
   independent enablement.
8. **Legacy flag conflict:** MV defines `SCAN_FOR_MCC_MISMATCH`, but the newer
   processor's paying-customer calculation uses MCC-detection/package flags.
   The intended enablement contract should not be copied without clarification.

## Evidence Gaps

- WebShield source is unavailable locally: `NOT VERIFIED`.
- Core source is not included in the repository map: Core comparison behavior
  is `UNKNOWN`.
- The Outlook summary is documented stakeholder evidence, but its original
  email and PDF attachments were not independently opened.
- `mvserver` was last committed locally on 2026-07-09, and its checked-out
  `master` branch could not be matched to a remote `master`; report behavior may
  be stale.
- The inspected UP repositories did not match current remote branch tips.
  `mlrc-bff-2.0` and `marketview-portal` are materially stale, and some UP
  worktrees contain unrelated local changes. The target conclusion is therefore
  **mismatch support was not demonstrated by the available source**, not a
  definitive assertion that no newer implementation exists.

## Source State

| Repository | Branch / local commit | Remote state at verification |
|---|---|---|
| `mvnextgen` | `develop` / `a1994e1c986871129413c44c938c74fd69f8a6e5` | Matched remote tip |
| `everc-global-services` | `develop` / `b537cba9baec923d45dd8d8b1ba60993863f8a2e` | Matched remote tip |
| `merchantviewui` | `develop` / `0eb1473a375bf4308a1bcb0eabc8ddf57db992ac` | Matched remote tip |
| `g2-singlePlatform` | `master` / `e84729b4cb884c5c95beae0b52bb79b907d3bcbe` | Matched remote tip |
| `mvserver` | `master` / `236d6205478570127908cd685b2c45f48c2ad6e6` | No matching remote `master` returned |
| `mlrc-analysis` | `develop` / `9465d6d670d90fe3f906cd38a8631fe6c2a6307c` | Remote tip differed: `3638e21be4a3eeca26aeb0e8caed3628997edbad` |
| `mlrc-finding` | `develop` / `7cba93c31e52e0a0b279f6fc33bca0c1893431b0` | Remote tip differed: `e84a39bb67a035a77e49733b0473cbe744f00504` |
| `mlrc-merchant` | `develop` / `29e6bf19541ba768f53cb4aa7a8b76a85e7a8167` | Remote tip differed: `77f6487ba18a681d72043e8916b2a57a2d4eef42` |
| `mlrc-bff-2.0` | `develop` / `9cf08aec94cda1313c21cd14801810f9cd145b60` | Remote tip differed: `12a2f73b8b8c04d0bcadffcc882417dd47c6ac03` |
| `marketview-portal` | `develop` / `d778d7291f1c91edafb4c036c37109617e931e8c` | Remote tip differed: `0420e251de3e62735b437b48ca8d30c794bf05d0` |
