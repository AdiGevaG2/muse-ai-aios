# Verify Merchant Identity Against Website, Reverse Engineering

Scope: locate and document Core's existing merchant identity/contact mismatch logic, to determine what can be replicated versus what must be newly built for NAB's requirement.

Repo: `code-repos-git/core`, package `core/processor/src/main/java/com/evercompliant/processor/workers/extractors/entityextractionmismatch/`.

## Finding types

Defined in `FindingSubType.java:562-575`. The MV gateway reads the company name and address bank flags into `CoreRunConfiguration` (`CoreRunConfigurationsGenerator.java:49-50`); whether Core acts on them is unconfirmed:

| Field | Values | Gating flag |
|---|---|---|
| Company name | `COMPANY_NAME_MATCHED`(365), `COMPANY_NAME_MISMATCH`(358) | `BankFlag.COMPANY_NAME_MISSMATCH`(45) is set by the MV gateway, but Core was not seen reading it [unconfirmed, see below] |
| Phone | `PHONE_DETECTED`(353), `MISSING_PHONE`(360), `PHONE_MATCHED`(364), `PHONE_MISMATCH`(357) | No client flag; one global setting, on by default, for every client-submitted URL [source-verified] |
| Email | `EMAIL_DETECTED`(352), `MISSING_EMAIL`(359), `EMAIL_MATCHED`(363), `EMAIL_MISMATCH`(356) | No client flag; one global setting, on by default, for every client-submitted URL [source-verified] |
| Address | `ADDRESS_MISMATCH`(355) only, no matched/detected counterpart | `BankFlag.ADDRESS_MISSMATCH`(44) is set by the MV gateway, but Core was not seen reading it [unconfirmed]; the finding is always skipped (`EntityExtractor.java:312-316`) [source-verified] |

[source-verified: `FindingSubType.java:562-575`, `BankFlag.java:58-59` in `everc-global-services`]

## Comparison algorithms

**Company name**: `CompanyNameComparison.java:7-16`, `CompanyNameNormalizer.java`. Normalizes the reported legal name: strips legal suffixes (ltd, inc, gmbh, etc.) via regex, strips parentheticals and punctuation, generates spaced/compact variants, lowercases. Matches if any variant is a substring of the crawled page's raw HTML text (`DocumentContainer.getDocString()` via `urlResult.getAllDocuments()`), not a structured Contact Us field. Correction 2026-10-18: the only call path (`EntityExtractor.java:216-232`) passes a single `legalName` (`List.of(legalName)`); the aliases helper `getClientCompanyNames` (`EntityExtractor.java:76-88`) has no caller. Jira MERV-40050 confirms MerchantView sends legal name and DBA, not aliases.

**Phone**: `PhoneComparison.java:14-33`, `PhoneMatcher.java:16-26`. Both sides normalized via `PhoneValidator.normalize().getPhoneNumber()`; invalid numbers discarded. Match requires exact string equality of normalized numbers.

**Email**: `EmailComparison.java:13-33`, `EmailMatcher.java:19-41`. Both sides normalized via `EmailValidator.normalize()`. If the domain is a generic provider, a hardcoded list (gmail, outlook, yahoo, etc.) flagged by `// TODO: Make this list configurable` at `EmailMatcher.java:14`, it requires exact full-address match. If the domain is non-generic, requires only the domain suffix to match any extracted email's suffix; local part is not compared.

**Address**: `EntityExtractor.java:312-316`. Not implemented:
```
if (fst.equals(FindingSubType.ADDRESS_MISMATCH)) {
    log.warn("ADDRESS_MISMATCH finding detected but address extraction is not yet implemented");
    return true;
}
```
Always skips; never produces a mismatch. Input plumbing exists (`ContactDetailsContext.addresses`, `CoreRunConfiguration.reportedAddresses`) but is unused. No postal-code or country-standalone comparator exists anywhere in this package.

No fuzzy or similarity matching exists for any field. Every implemented comparator is exact or normalized-exact.

## Data sources

The crawled side draws on existing crawl finding types, not a new pipeline. Email comes from `FindingType.EMAIL_ADDRESS` / `EMAIL_ADDRESS_FROM_CONTACT_PAGE`; phone comes from `FindingType.PHONE_NUMBER` / `PHONE_NUBER_FROM_CONTACT_PAGE` (`EntityExtractor.java:28-34`).

The reported side comes from `ContactDetailsContext`, which is populated from `ScanContext` and carries addresses, aliases, emails, and phones, tracing to `CoreRunConfigurationsGenerator.generate()` reading `ScanRequestDto` fields submitted at scan-request/onboarding time.

## Known gaps

- `reportedDBAs` is plumbed into `CoreRunConfiguration` from `scanItemDto.getDba()` / `scanRequestDto.getDbas()`, but no consumer in `EntityExtractor` or `CompanyNameComparison` references it. Only the legal name feeds name matching today; neither aliases nor DBA reach the comparator.
- Generic-email-domain list is hardcoded, flagged by the code's own TODO as needing to become configurable.
- Address/postal code/country has no working implementation despite the finding type existing in the schema.

## Where the check runs and who gets it (MV scans)

Evidence: `core` at `f53fd35` (2026-09-13), `merchant-view-legacy-ec` at `0ea9af4` (2026-09-06). Both clones are about a month old.

- [source-verified] Identity verification is not part of the CC audit type. CC, automated CC and ML Model CC are audit types in CSX, the classification service, where they decide which pages go through term validation ([[csx]] ingestion page, lines 50-54). The identity checks run in Core's processor step after the website crawl (`ProcessorWorkerCacheable.java:132`), and no audit type is checked there. The expansion of "CC" is not stated in the brain or in MV's enums.
- [source-verified] Phone and email checks run on every merchant URL a client submits. They are skipped only for URLs Core discovers on its own (`ProcessorWorkerCacheable.java:109-118`). A global setting turns them on, and it is on by default (`ProcessorWorkerCacheable.java:52`). No per-client flag was found on this path.
- [source-verified] For an MV scan, the MV gateway reads the client's `ADDRESS_MISSMATCH` and `COMPANY_NAME_MISSMATCH` bank flags into the scan configuration (`CoreRunConfigurationsGenerator.java:49-50`).
- [inferred] The local Core clone does not read either flag value, and the company name check (`EntityExtractor.getCompanyNameFindings`) has no caller. Either company name matching is not connected in this version of Core, or it is connected in code outside this clone. This contradicts the "Gating flag" column in the table above, so it needs confirming with Core engineering.
- [source-verified] Mismatch findings are dropped when the client did not submit the matching field (`EmptyEntityMismatchFilterModifier.java:79-121`).

## What Atlas receives from Core (checked 2026-10-20)

Evidence: `core` at `f53fd35`, `mlrc-finding` at `b11f95a` (cloned 2026-10-05). Commit dates not read. Sources were routed via company-brain, which shows that `core` produces the findings and `mlrc-finding` stores them for Atlas.

**What the finding carries**
- [source-verified] For phone and email, Core's finding holds the website value, the submitted value, and the URL of the page where the website value was found. Only the first value on each side is kept (`ExtractedAndSubmittedEmailPhoneInfo.java:13-20`, `EntityExtractor.java:104-105, 128-159`).
- [source-verified] The mismatch evidence text reads "Discrepancy between customer-reported {type} {submitted} and detected {type} {extracted} by EverC". Score is fixed at 0, so Atlas stores confidence 0 (`EntityExtractionMismatchFinding.java:47-53, 94-108`).
- [source-verified, path unconfirmed] On the screenshot digest path, the evidence text is replaced by the website value only, and the submitted value does not reach Atlas (`ClassifierContentFetcher.java:32-37`). Which digest path identity findings take in production is not confirmed.
- [source-verified] Company name findings carry no website value. The field named `extractedCompanyNames` holds the submitted legal name (`EntityExtractor.java:231`), and the evidence says only that the name was or was not found in the domain's content.
- [source-verified] Values are stored as found, not normalized. Normalization is used only for the comparison (`EntityExtractor.java:98-123`, `PhoneComparison.java:27-28`).

**What Core extracts but does not send as findings**
- [source-verified] Core extracts phones, emails, address and company name from the website, but as graph data, not as findings. They reach Atlas as connected-site graph links, not as identity values on the merchant (`FindingType.java:163-177`, `ConnectionInfoParser.java:43-54`).
- [source-verified] Core has no separate postal code or country data point.

**What Atlas keeps**
- [source-verified] `mlrc-finding` has no identity-specific handling. It stores each finding's subtype, type, confidence, evidence text, evidence URL, origin, URL and active flag (`FindingConsumerMapper.java:24-33`).
- [source-verified] A finding with no evidence URL is dropped (`FindingExtractorService.java:158, 474-476`).
- [source-verified] A finding is inactive unless its subtype is visible and enabled in the account or portfolio category configuration (`CategoryUtils.java:20-40`).
- [source-verified] Entity mismatch findings were stored with the wrong origin, Direct Hit instead of Entity Mismatch, until a converter fix (`S3ObjectConverterConfig.java:31-35`). Earlier findings may carry the wrong origin.

**Product impact**
- Atlas receives website and submitted values only as text inside the evidence, not as separate fields. The Operational Risk row's Website and Reported columns need Core to send them as fields, or Atlas to show the submitted value from its own merchant record.
- Company name has no website value to show, which matches the open question on company name Mismatch rows in the PRD.
- Postal code and country need new extraction in Core.

**Evidence gaps**
- Which digest path identity findings take in production, which decides whether Atlas receives the submitted value.
- Whether identity subtypes are visible and enabled in Atlas category configuration today.
- Whether the upstream extractors format phone numbers before Core stores them.
- `core-webid` was not inspected; `mlrc-finding` has no reference to it.

## What MerchantView receives from Core (checked 2026-10-20)

Evidence: `merchant-view-legacy-ec` local copy, which has no git metadata, so its snapshot date is unknown.

- [source-verified] MerchantView receives the same finding record as Atlas, with no website-value or submitted-value fields. It keeps the subtype, URL, score, origin, screenshot and evidence text (`UrlFinding.java:5-7`, `FindingCreationService.java:43-71`).
- [source-verified] The two values exist only inside the evidence text. MerchantView stores no value columns (`Finding.java:36-80`).
- [source-verified] The finding name shown is the subtype, such as Phone Mismatch (`enums.list.json:7884-8052`).
- [source-verified] Every identity subtype has severity 5, which is No risk, so identity findings never add risk. A No risk finding moves to No action required (`enums.list.json`, `Severity.groovy:15`, `FindingRiskCalculator.java:27-31`).
- [source-verified] MerchantView sends the merchant's reported phones and emails to Core in the scan request; it does not show its own merchant record next to the finding (`CoreRunConfigurationsGenerator.java:58-59`).
- [source-verified] Address and company name checks are switched per account by the `ADDRESS_MISSMATCH` and `COMPANY_NAME_MISSMATCH` bank flags. Phone and email have no flag (`CoreRunConfigurationsGenerator.java:49-50`).
- [source-verified] If Core replaces the evidence text with the website value only, MerchantView reads that text as the finding's URL (`FindingCreationService.java:82-94`).

**Product impact**
- Neither MerchantView nor Atlas receives the two values as fields today. Showing Website and Reported values side by side is new in both.
- MerchantView treats identity findings as information only, at No risk. Atlas raising risk on a Mismatch is a change for migrating clients, as the PRD states.

**Evidence gaps**
- The findings grid and evidence panel in MerchantView were not traced, so how the evidence text is displayed is inferred.
- Severity comes from a static UI file; live per-bank values may differ.
- Whether MerchantView displays Matched and Detected findings it receives.

## Search method note

Initial pass searched `mvserver`/`mvnextgen` (MerchantView's own repos) and found no contact-mismatch finding there, only `SiteConnectionUtils.groovy`'s `isElementFromMerchant`, a graph-edge reclassifier unrelated to this feature. The PM correctly flagged that NAB uses this today, which redirected the search to the `core` repo and the `entityextractionmismatch` package, where the real implementation lives. Lesson for future reverse-engineering in this domain: mismatch-style logic for Atlas clients may live in Core rather than in MV's legacy codebases, consistent with the precedent already recorded in [[mcc-mismatch-for-global-onboarding]] for MCC mismatch.
