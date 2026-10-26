# Content Categories: Gap Impact on Users

Source: [content-categories-reverse-engineering.md](content-categories-reverse-engineering.md).
Scope: what each MV-to-UP gap means for a user migrating today, not the
underlying engineering cause.

## Gap 1: No merchant-facing category filter/view in UP

MV lets a user filter Findings by content category (grouped separately from
MCC and Platforms) and see category on the Risk Matrix screen. No equivalent
screen was found in UP's merchant-facing repo (`mlrc-merchant`).

**Effect on the user:** on migration day, a user who filters findings by
content category loses that filter. They can no longer isolate findings by
category directly. `findings_filter_category` is low-usage overall but not
zero — some users depend on it, and it is the closest MV feature to this gap.

**Effect on NAB specifically:** NAB used this filter once in the trailing 12
months. Low risk of disruption for NAB on this specific control.

## Gap 2: No admin screen to edit per-category risk level in UP

MV's Risk Matrix settings screen lets an admin view every category/subtype and
edit its risk weight (edit/save/discard/export). The `category-risk-config`
feature that exists in UP today is a different taxonomy (PLRC/brand-IP), not
this one.

**Effect on the user:** an account admin who tunes content-category risk
weighting today has no UP screen to do that after migration. Risk weights
would migrate as a one-time snapshot (whatever MV had configured) with no
way to adjust them going forward until this is built.

**Effect on NAB specifically:** NAB recorded 0 events on
`audit_screen_organize_categories` in the trailing 12 months (re-queried
directly to confirm, after an earlier pass omitted this metric from a
multi-metric query rather than confirming zero) — no evidence NAB edits
category risk weights today. Low risk of disruption for NAB, but this is an
admin/config action that may not generate frequent events even when used, so
absence of usage is weaker evidence here than for the filter above.

## Gap 3: Category search

MV has an `audit_screen_search_category` action — a user searching for a
specific category, most likely inside an audit or configuration screen (exact
screen not confirmed in this pass). No UP equivalent was found or ruled out;
this screen's existence in UP was not directly investigated, only the
absence of category-related Mixpanel events in the UP project.

**Effect on the user:** unconfirmed. This is the single highest-usage action
tied to content categories across the accounts sampled, and the primary
action NAB performs.

**Effect on NAB specifically:** this is NAB's dominant interaction with
content categories, 207 events over 12 months, dwarfing every other category
action combined. If this screen or its UP equivalent does not exist, NAB loses
its main way of interacting with content categories. This is the gap most
worth resolving before treating NAB's migration as low-risk.

## Gap 4: Classification pipeline parity (crawl to category label)

Confirmed in a follow-up backend pass: both platforms share the same
externally-owned crawler/classifier, so this is not a migration gap in the
sense of "different classification logic." It is a shared dependency and a
shared blind spot, detailed in Backend Functionality below.

**Effect on the user:** none expected from the classifier itself, since MV and
UP both call the same external classification engine (see below). The risk
that remains is in how each platform's own services turn a classified finding
into a risk score and how each handles category taxonomy changes — covered as
Gaps 5-6.

**Effect on NAB specifically:** low risk from classification itself. Residual
risk sits in the scoring-methodology difference below (Gap 5).

## Gap 5: Risk scoring methodology differs between platforms

MV computes risk through `merv-risk-calculation-api`
(`RiskCalculationController`, `FindingRiskCalculator`) and an augmentation rule
engine (`CategoryTrigger`, `ChangeRiskRuleAction`) that can adjust a finding's
severity based on category. UP computes risk through `mlrc-risk`'s
`RiskCalculationService`, which resolves an effective severity per category
(`accountRiskLevel ?? defaultRiskLevel`), applies account rules
(`RulesEvaluator`), then rolls up via **max severity** at each level (finding
to store to merchant), not a weighted numeric aggregate.

**Effect on the user:** a merchant's overall risk score or risk level shown to
a user could differ between MV and UP for the same underlying findings, even
with identical category classifications, because the two platforms aggregate
category severity differently (MV's calculation methodology wasn't fully
traced to a single formula; UP's is confirmed max-severity roll-up). A user
comparing a merchant's score before and after migration could see a change
with no visible cause.

**Effect on NAB specifically:** unconfirmed without a side-by-side score
comparison on real NAB merchant data. Recommend a before/after score
reconciliation for a sample of NAB merchants as a validation step, since this
is the kind of silent scoring change that generates support tickets rather
than clean bug reports.

## Gap 6: Taxonomy changes do not recompute existing findings or scores, in either platform

Confirmed on both sides: MV's category data doesn't appear to trigger
recalculation of existing findings when synced (only invoked from finding-edit
or scan-release paths); UP's `CategorySyncJob` polls S3 every 60 seconds and
updates the Mongo-backed `Category` collection, firing change events, but does
not re-run classification or recompute existing findings/scores.

**Effect on the user:** if an admin changes a category's risk level today (in
either platform), only new findings get the new weight — existing findings
and merchant scores keep their old value until the merchant is rescanned or a
finding is edited. This is existing MV behavior, not a regression introduced
by migration, but it's worth confirming account admins understand it,
especially post-migration when they may expect the config UI to apply
retroactively.

**Effect on NAB specifically:** no elevated risk from migration itself, since
this is unchanged behavior. Worth a one-line callout in any UP admin UI (Gap 2
above) if/when it ships, so expectations are set correctly from day one.

## Backend Functionality (confirmed, both platforms)

- **Crawl/classification trigger:** in both MV and UP, the actual crawler and
  classifier (including the Weka classifier, still referenced by id in UP's
  `FindingOrigin` enum alongside newer classifier types like `CLASSIFIER_LLM`
  and `KW_CLASSIFIER`) live outside every repo checked. MV dispatches through
  `UrlScanRequestService` / Quartz jobs; UP dispatches through
  `mlrc-analysis` publishing to Kafka scan topics, consumed by an external
  core/scan engine, with results ingested back by `mlrc-finding`. Both
  platforms depend on the same external classification engine — this is a
  shared dependency, not a migration risk in itself.
- **Category APIs:** both platforms expose a category read API
  (`global-ams-api`'s `CategoryController` in UP: `GET /category/`, `/mcc`,
  `/short`, `/extended`, `POST /reset`) consumed by risk/finding services for
  visibility gating and severity lookup.
- **Scoring methodology differs** (see Gap 5): MV uses a risk-calculation API
  plus a rule-engine severity override; UP uses per-category effective
  severity with a max-severity roll-up through store and merchant levels.
- **Taxonomy sync doesn't touch existing data** (see Gap 6): confirmed in both
  platforms — changing a category's definition or risk level updates the
  taxonomy master data only, not existing findings or scores.

## Naming collision risk (not a functional gap, but a rollout risk)

UP already has a "Category Risk Config" feature (PLRC/brand-IP). If content
categories are built into UP later under a similar name, support and account
teams may confuse the two with users during rollout communication. Recommend
a distinguishing name for the content-category feature when it is scoped.

## Priority for NAB

1. Confirm whether `audit_screen_search_category`'s underlying screen exists
   or is planned in UP (Gap 3) — highest usage, unconfirmed status.
2. Run a before/after risk-score reconciliation on a sample of NAB merchants
   to catch scoring-methodology differences (Gap 5) before they surface as
   support tickets.
3. Findings category filter and Risk Matrix category-risk editing (Gaps 1-2)
   are lower priority for NAB specifically based on near-zero usage, but may
   matter for other accounts before this ships broadly.
4. No action needed on classification parity (Gap 4) or taxonomy-sync
   behavior (Gap 6) — both are confirmed unchanged or shared across
   platforms.

## Evidence Gaps

- The screen behind `audit_screen_search_category` was not identified in the
  MV codebase pass; this doc infers it is audit/config-related from the event
  name only.
- UP's absence of category Mixpanel events could mean the feature doesn't
  exist, exists but isn't instrumented, or exists under different event names
  not searched. Not distinguished in this pass.
- No per-user or per-role breakdown of NAB's 207 search events — unknown
  whether this concentrates in one user or spreads across NAB's team.
- MV's exact risk-aggregation formula (how `defaultRiskLevel` combines across
  multiple findings into one merchant score) was not fully traced to a single
  calculation — only that `merv-risk-calculation-api` and a rule engine
  (`CategoryTrigger`/`ChangeRiskRuleAction`) are involved. UP's is confirmed as
  max-severity roll-up. Without MV's exact formula, the two cannot be proven
  equivalent or different on a specific merchant, only assessed as
  "structurally different" (weighted/rule-based vs. max-severity).
- The external crawler/classification engine (core-common, per UP's
  `FindingOrigin` javadoc) was not inspected in this pass — assumed identical
  across both platforms based on shared classifier-origin ids, not directly
  verified against a shared repo.
