# Reverse Engineering: Content Categories

Scope: source Merchant View (legacy), target Atlas. Quick mode.
`ASSUMED:` Content Categories means the risk taxonomy applied to scanned merchant
website content (adult, gambling, weapons, drugs, etc.), distinct from MCC.

## Executive Summary

- MV has a working, user-facing content-category system: automated classification
  per scanned URL, a configurable risk weight per category, and a Findings/Risk
  Matrix filter UI. Confirmed.
- UP has the same taxonomy at the data layer (`global-ams-api/categories.json`),
  consumed by `mlrc-finding` for validation, but no merchant-facing UI was found
  in `mlrc-merchant`. This is a gap.
- `marketview-portal-001-category-risk-config` is a different feature (PLRC /
  brand-IP risk config) that happens to share the word "category." Not a content-
  category equivalent.
- NAB actively uses content-category search in MV (`audit_screen_search_category`,
  207 events over the trailing 12 months) but almost never uses the Findings
  category filter (1 event) or the Risk Matrix category-organize screen (0 events).
- Real category taxonomy labels (Adult Content, Gambling, Firearms, etc.) were
  confirmed in UP's `categories.json`, not in the MV repos read — MV's fixture
  data uses placeholder codes (`CAT_315`), so the two sources triangulate but
  neither alone gives the full labeled list.

## Current Behavior by Platform

### Merchant View (legacy)
- Category assignment is automated: a scan produces `Finding` objects per
  crawled URL; `EvidenceClassifier` and `PoliciesEvidenceCreator` assign each
  finding a category tied to a `findingType` (e.g. Content). No manual
  assignment UI found.
  (`mvnextgen/merchant-processor-job/.../evidence/EvidenceClassifier.java:19,30`;
  `PoliciesEvidenceCreator.java:21-55`)
- Data is per-URL: `Finding.url` field.
  (`mvnextgen/shared/.../model/Finding.java:33`)
- Taxonomy has two layers: top-level finding types (Content, Payment, MCC,
  Security, Policies, Availability) and granular categories/subtypes under each,
  each carrying a `defaultRiskLevel` and flags (`isCensor`, `scoring`,
  `automatic`, `permanentFinding`, `overrideWekaScore`, `isShownPerAccount`).
  (`mvserver/GrailsUtils/grails-app/i18n/categorytype.properties:1-9,37-39,82-83,160-162`;
  `mvnextgen/merchant-processor-job/src/test/resources/common/default-categories.json:1-80`)
- User-facing: a Category filter on Findings/Risk Matrix pages
  (`category-filter.component.ts:1-251`, grouped into Categories / MCC list /
  Platforms), and a Risk Matrix settings screen where admins view/edit
  per-category risk level (`risk-matrix.component.html:1-57`).
- No separate "prohibited categories" list — restriction is expressed through
  risk-level and boolean flags on the same taxonomy, configurable per account.

### Atlas (target)
- Taxonomy exists: `global-ams-api/categories.json` defines real category names
  (Adult Content, Gambling, Pharmaceuticals, Firearms, Illegal Substances, Child
  Pornography, Prostitution, etc.) with `categoryId`, `name`, `groupId`,
  `isCensor`, `scoring`, `decisionPointViolation`, `findingType`, `keyStr`.
  (`everc-global-services/global-ams-api/src/main/resources/categories.json`,
  confirmed, versioned at 61)
- `mlrc-finding` consumes category IDs already attached to findings for
  validation and account-level visibility (`AccountCategoryService.java`,
  `CategoryUtils.java:20-43`) — it does not classify content itself.
- Per-account enablement is separate: `AccountPortfolioCategoryConfigDto`
  (`visible`/`enabled`/`categoryId`).
- The actual classification step (what labels a scanned page "Gambling") was
  not located in `mlrc-finding`, `mlrc-risk`, or `mlrc-merchant` — likely lives
  in `global-ams-api` or a crawler/scan service outside the four repos checked.
- `marketview-portal-001-category-risk-config` is confirmed to be a distinct
  feature: PLRC (brand/counterfeit/IP-rights risk config), toggling categories
  tied to violation types and brands (e.g. Gucci, Adidas), read-only in
  milestone 1. It consumes upstream category data; it does not classify content.
  (`spec.md:1-7,128-220`; `CategoryRiskConfig.tsx:11-46`)

## Business Rules to Preserve

1. Category assignment happens automatically from scanned content, not by
   manual tagging.
2. Categories are scoped per-URL, then rolled up to the merchant/scan.
3. Each category carries a default risk level that feeds merchant risk scoring.
4. `isCensor` and `automatic` flags determine whether a category is
   machine-scored (Weka classifier) vs a manual/permanent finding.
5. Category visibility/enablement is configurable per account, not global.
6. Content categories are filtered and displayed separately from MCC in the
   Findings UI, and separately from Platforms.
7. Admins can edit risk weight per category in a dedicated settings screen
   (Risk Matrix), with edit/save/discard and export.
8. There is no distinct "prohibited category" list; severity is expressed
   through risk level and flags on the single taxonomy.

## Target Platform: What Already Exists

- Category taxonomy and data model (`global-ams-api/categories.json`).
- Server-side consumption and validation in `mlrc-finding`.
- Per-account category enablement model in `mlrc-account`.
- A category-risk config UI, but for a different feature (PLRC/brand risk),
  not content categories.

## Gaps

- No merchant-facing UI in UP (`mlrc-merchant`) for viewing or filtering
  content categories on findings — the MV Findings/Risk Matrix experience has
  no confirmed UP equivalent.
- No confirmed UP screen for admins to edit per-category risk level for content
  categories (distinct from the PLRC config UI, which is a different taxonomy).
- Classification-trigger pipeline (crawl to category label) not located in the
  UP repos checked; unclear whether it already exists in `global-ams-api` or
  needs to be built/ported.

## Conflicts / Product Decisions

- Naming collision: UP's `marketview-portal-001-category-risk-config` uses
  "category" for a brand/IP-rights concept unrelated to MV's content
  categories. Open decision: when building content-category UI in UP, use a
  distinguishing name to avoid confusion with the existing PLRC feature.

## NAB Usage (Mixpanel, MerchantView Production project)

Filtered to `Bank Original Name = "NAB"` (the account name under which NAB's
activity is tracked; "National Australia Bank" as a literal value returned
zero events), trailing 12 months:

| Event | Total events |
|---|---|
| `audit_screen_search_category` | 207 |
| `findings_filter_category` | 1 |
| `findings_filter_category_MCC` | 0 (re-queried in isolation to confirm) |
| `audit_screen_organize_categories` | 0 (re-queried in isolation to confirm) |

Monthly trend for `audit_screen_search_category`: steady use from September
2025 (34) through June 2026 (32), tapering sharply from July 2026 (7) to
August 2026 (2) and 0 in the partial September 2026 window.

Read: NAB's engagement with content categories is concentrated in searching
categories (likely within an audit/config screen), not in filtering findings
by category or reorganizing the risk matrix. Recent usage has dropped close to
zero, which is worth a business follow-up (headcount change, workflow move, or
account inactivity) before treating this as a stable usage baseline for
migration sizing.

No Atlas project events exist for any category-related term — UP
tracking for this feature is not yet instrumented (`Atlas
Production` project, event search on "categor" returned zero results).

## Evidence Gaps

- Real MV category taxonomy labels not found in code (test fixtures use
  placeholder codes); UP's `categories.json` is the more complete labeled
  source but its exact 1:1 mapping to MV's legacy category IDs was not traced.
- End-to-end crawl-to-classification pipeline not traced in either platform.
- Merchant/scan-to-finding aggregation relationship inferred from field
  presence, not confirmed via a join/query.
- No account-name-to-Mixpanel-ID mapping tool was available beyond the `Bank
  Original Name` property; if NAB operates under additional sub-accounts with
  different bank-name strings, those would not be captured here.
- A first multi-metric NAB query returned rows only for
  `findings_filter_category` (1) and `audit_screen_search_category` (207),
  omitting `findings_filter_category_MCC` and `audit_screen_organize_categories`
  entirely. That gap was initially written up as a confirmed "0" without
  verifying whether Mixpanel omits zero-data metrics from a multi-metric
  response. Both events were re-queried individually against the same NAB
  filter and both returned empty result sets, consistent with zero events —
  this corroborates zero but does not rule out a query-construction issue
  common to both attempts (e.g. the `Bank Original Name` filter itself not
  matching on some underlying data path). Treat as confirmed with moderate,
  not full, confidence.

Last verified: repos read via local clone, `git ls-remote` reachability
confirmed at investigation time (2026-09-17); no branch/commit pinned by the
sub-agents. Mixpanel data pulled live from `MerchantView Production`
(project 2040581) and `Atlas Production` (project 3482888).
