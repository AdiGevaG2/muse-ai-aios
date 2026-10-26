# Gaps: MerchantView API Surface vs. Atlas

**Scope:** Delta between MV's API surface (`merchantview-api-surface-reverse-engineering.md`, amended 2026-09-23 against EverC's official published API doc) and Atlas as it exists in code today, checked across `unified-platform-new`, `core-webid`, `ufp-backend`, `mlrc-notification` (standalone), `core`, `everc-global-services`, `mlrc-account`, and `mlrc-bff-2.0` — routed via `company-brain` after an initial pass scoped only to `unified-platform-new` produced wrong conclusions. Mode = quick, source-cited. **Not yet re-checked against the amended MV source**: Risk Matrix API (`/api/v4/riskMatrix`), the documented Snooze Object shape, monitoring start/stop (`PUT /merchants/<ID>/monitoring`), and the deboard soft-delete semantics — these were newly surfaced or clarified by the official doc and have no corresponding UP-side check in this document yet.

## Correction: `unified-platform-new` is not the complete UP codebase

A company-brain repo-ownership check found active, recently-pushed repos outside `unified-platform-new` that likely own the capabilities this doc previously called confirmed gaps:

- **WebID**: `core-webid` (pushed 2026-08-09, "web identity verification service, email domain checks") and `core-webid-logic` (pushed 2026-08-12, "identifies and validates business website URLs") — both live. (`webid2`'s last push, 2026-02-23, matches a known org-wide bulk-push date and should be treated as dormant, not evidence of activity.)
- **Scan submission/orchestration**: `ufp-backend` (pushed 2026-09-01, "UFP Backend — Atlas backend service"), plus `core` (scan/crawl engine) and `core-jobs` ("triggers mlrc scan jobs via api") — none of these were in the codebase this doc's earlier findings were built from.

**The "confirmed gaps" below for scan-submission and WebID in the previous version of this doc were wrong** — they reflected only `unified-platform-new`, not the full Atlas system. They are demoted back to unconfirmed pending a direct check of `ufp-backend` and `core-webid`.

## WebID: Resolved — Exists, But in a Different Shape

Checked directly in `core-webid` (`/Users/adig/vsCode/code-repos-git/core-webid`). WebID exists in UP, but not as MV's scan/report/sync-report product.

- `src/webid/WebIdController.ts:15-45` exposes only `POST /webid` and `POST /webid/k9` — both synchronous: post a `WebIdRequest` (legal name, etc.), get match/candidate results back in the same response.
- No separate scan-submission call, no report-retrieval call, no sync-report call, and no entitlement flag anywhere in the controller or `WebIdService.ts`/`model/types.ts`.
- **Product implication, not a gap in raw capability**: MV's WebID is an async, multi-step product (submit a scan, later pull a report, sync separately) gated by its own entitlement flag. UP's `core-webid` is a single synchronous matching call with no entitlement gating. If any client depends on MV's async WebID workflow (scan now, report later) or on per-client WebID entitlement, that specific shape does not carry over — the underlying matching capability does, the product contract around it doesn't.

## Scan Submission: Resolved — Exists in `core`

Found in `/Users/adig/vsCode/code-repos-git/core/Endpoints/src/main/java/com/evercompliant/endpoints/markeddomain/pipelinescan/ScanController.java`, `@RestController` at `/pipelineScan`:
- `POST /pipelineScan/scan` — accepts domains/mccDomains for one merchant-like unit, converts to `RawGrailsScanRequest`, runs via `FromGrailsRunner`. Functional equivalent of MV's `POST /api/v4/merchants/{id}/scans`.
- `POST /pipelineScan/scanDomains` — same, batched across a map of domains.

Caveat: takes domains directly in the request body rather than a merchant ID in the path — merchant association is presumably a field inside `ScanControllerRequest`, not verified. No admin-role gating annotation visible on the controller; would need a security-filter check to confirm parity with MV's role gating. Not a gap — carries over, shape differs.

## Callback/Webhook Config API: Confirmed Genuine Gap

Checked in the standalone `mlrc-notification` repo (`/Users/adig/vsCode/code-repos-git/mlrc-notification`, pushed 2026-09-16) directly — this supersedes the earlier check of the embedded copy inside `unified-platform-new`, ruling out a stale-copy explanation. The standalone repo has exactly one `@RestController` in the entire codebase: `callback-scheduler/src/main/java/com/everc/notification/callback/scheduler/controller/AutomationTestController.java`, mapped at `/api/v1/automation-test` with one `PUT /store/{storeId}/trigger-schedule` endpoint — a manual test-trigger harness, not admin config CRUD.

The closest related code, `AccountConfigService.java`, only reads notification-enablement config via a generated client (`AccountConfigApi.getAccountConfig`) — read-only, and the actual config likely lives in a separate account/config service this repo calls out to (not yet identified/cloned). No create/edit/delete/push/send admin CRUD for webhook configuration exists in `mlrc-notification` itself. This is a confirmed gap in the repo checked; whether the account/config service behind `AccountConfigApi` implements the missing CRUD is the one remaining open thread.

## Callback/Webhook Config API: Traced One Hop Further, Still Unresolved

`everc-global-services` was reclone­d fresh (the copy nested inside `unified-platform-new` was 26 days stale — pushed 2026-08-27 vs. the live repo's 2026-09-22 — so any earlier finding sourced from that nested copy, e.g. `BankFlag.java`, `Auth0UnifiedPlatformController.java`, should be treated as needing re-verification against current code, not as stale-repo-caused wrong conclusions; not re-checked in this pass). Searched fresh clone directly:

- `AccountConfigApi` (the interface `mlrc-notification`'s `AccountConfigService` calls) is **not implemented here** — confirmed absent repo-wide.
- `CallbackRequestDto`/`CallbackType` exist in `global-shared` as data-model definitions only, **unused by any controller** in this repo — shared shapes with no owning service in this codebase.
- Closest match, `global-ams-api/.../controller/account/v3/NotificationTemplatesController.java` (`POST /api/v3/account/config/notificationTemplates/{accountId}`), is message-**template content** CRUD (create only), not webhook-**destination** config — different capability, does not satisfy MV's callback API.

Company-brain's repo index was checked again for the real owner: no other repo describes account-level webhook/callback config for Atlas specifically (`marketview-plrc-account-configuration` is PLRC/MarketView-scoped, a different product). The router indexes repos by description, not by symbol — it cannot resolve which repo implements a specific interface like `AccountConfigApi`, only which repos plausibly relate to "account config" by name. This traced two hops (`mlrc-notification` → `everc-global-services`) with no answer, so the question was sent to engineering directly.

## Engineering Answer Checked and Ruled Out: `mlrc-account`

Engineering's answer to the routed question was `mlrc-account`. Checked directly (nested local copy was 25 days stale — pushed 2026-08-27 vs. live 2026-09-21 — reclone­d fresh before checking): **`mlrc-account` does not own this capability either.**

- No `AccountConfigApi` interface defined or implemented anywhere in the repo. The only string match is an unrelated build-toolchain comment in `api-client/build.gradle` about bytecode-version compatibility for a different generated client, consumed by `ufp-report`.
- The repo's one `AccountConfigController.java` (`GET/PUT /api/v1/accounts/{accountId}/config`) manages "analysis topics and risk rules," not callback destinations — no delete/push/send operations, and no field resembling a webhook/callback/destination URL anywhere in the repo (checked case-insensitively).
- `mlrc-account`'s own `AGENTS.md` lists `mlrc-notification-callbackProcessor` and `mlrc-notification-callbackScheduler` as separate services that *depend on* `mlrc-account` — i.e., `mlrc-account` is upstream data, not the callback-config owner.

**Open question, awaiting response (Ilya):** which service owns MV-equivalent bank/account-level webhook destination config CRUD, or does this capability not exist yet in Atlas. Three repos ruled out with direct evidence so far: `mlrc-notification`, `everc-global-services`, `mlrc-account`. Do not finalize the callback/webhook gap as confirmed-absent-from-UP until this returns.

Three repos are now ruled out with direct evidence: `mlrc-notification`, `everc-global-services`, `mlrc-account`. The engineering answer does not match what the code shows — worth relaying back before searching further, since either a fourth repo owns it or this is a genuine capability gap in UP.

## Correction (2026-09-23): The MV Side of This Comparison Changed

The source reverse-engineering doc (`merchantview-api-surface-reverse-engineering.md`) was amended against EverC's official published MerchantView API documentation (`org-brain/MV-API-docs-3.pdf`), a materially more authoritative source than the original code-only pass. One correction directly affects this section:

**MV does not have a self-service admin CRUD API for callback/webhook configuration.** The published doc describes callback delivery (REST push or AWS SQS) as configured out-of-band via an EverC Support ticket — the client provides an endpoint/auth method or AWS account details, and EverC's team sets it up. There is no documented `POST/PUT/DELETE` endpoint a caller can hit to create or manage their own callback subscription. The original code-sourced citation of an admin-gated `/api/v4/callback` CRUD endpoint may still reflect a real internal admin tool distinct from the partner-facing API — that has not been re-verified — but it does not appear in the contract EverC publishes to partners.

**What this changes about the "genuine gap" conclusion below:** the search for a UP-side equivalent was framed as "does UP have MV's admin webhook config CRUD API" — that framing assumed such an API exists as a partner-facing surface in MV, which the official doc does not support. Two ways to read this:
- If the comparison is partner-facing API surface (what a client like NAB could call directly): MV has none either, so this stops being a gap — both platforms require a support-mediated setup process for callback delivery, and the real question becomes whether UP's support-mediated process exists at all (still unconfirmed — the trace above found no admin CRUD, but did not check for a non-API, ticket-driven config process in UP, which wouldn't show up in a code search).
- If the comparison is internal/admin tooling (what EverC's own support team uses to configure a client's callbacks): the original gap search may still be valid, but should be re-scoped as "does UP have an internal admin tool for configuring account-level callback destinations," not "does UP expose a partner API for it" — since MV apparently doesn't either.

**PM decision: both framings matter.** Tracking as two separate open items rather than one ambiguous gap:

1. **Partner-facing API parity**: MV has no self-service callback config API (support-ticket only, confirmed). Not a gap against UP as long as UP also requires a support-mediated setup — needs confirmation UP has *some* working process (API or manual) for onboarding a client's callback destination, not specifically an API.
2. **Internal admin tooling parity**: whether EverC's own support/ops team has a way, in UP, to configure a client's callback destination at all — this is the original question the code trace was chasing, and remains unresolved after ruling out `mlrc-notification`, `everc-global-services`, `mlrc-account`.

Both go to Ilya together — see consolidated question below.

## Confirmed Gaps

- **Callback/webhook config API — reframed, see correction above.** No admin CRUD for callback destination config was found in `mlrc-notification`, `everc-global-services`, or `mlrc-account` (all checked directly against current code). Whether this is a genuine UP gap depends on which MV surface it's being compared to: MV itself has no partner-facing API for this either (confirmed via the official doc — callback setup is a support-ticket process), so if the comparison is partner-API-to-partner-API, this is not a gap. If the comparison is internal-admin-tooling-to-internal-admin-tooling (does UP's support team have a way to configure a client's callback destination at all, API or otherwise), that remains unresolved — the code search would not surface a non-API, manual/ticket-driven process. Awaiting Ilya's answer and a PM call on which framing applies before finalizing.
- **Transaction/billing API.** MV's `TransactionApi`, `TransactionBulkApi`, `AdminBillingApi` have no located equivalent in `unified-platform-new`; the company-brain repo index surfaced no active repo matching billing/transaction for UP either (only legacy/deprecated MV auditor tooling and unrelated third-party-bank integrations). Treat as a real gap pending explicit engineering confirmation.
- **Bulk operations beyond merchant upload.** UP confirms bulk merchant upload (`mlrc-merchant`, `mlrc-bff-api` `BulkUploadController.java`) but no bulk endpoints for findings, screenshots, scan items, or merchant ownership were found in `unified-platform-new`, `ufp-backend`, or `mlrc-notification`.
- **Audit export / admin login report.** Not located in `ReportController.java` (checked in `unified-platform-new` and `ufp-backend`) or elsewhere searched.
- **Merchant deletion and alias/email/phone sub-resource CRUD.** Confirmed via fresh clone of `mlrc-bff-2.0` (local nested copy was 2 months stale — pushed 2026-07-16 vs. live 2026-09-09, recloned before checking): `MerchantController.java` (`/api/v1/merchants`) exposes only `POST`, `POST /upsert`, `PATCH /{merchantId}` — no `@DeleteMapping`, no alias/email/phone sub-resource endpoints anywhere in the file. MV has create/edit/delete/search plus alias/email/phone sub-resource CRUD; UP's external API covers create/upsert/patch only.

## Unconfirmed — Needs Direct Engineering Confirmation Before Treating as Gap

- **`UNIFIED_PLATFORM_ACCESS` entitlement enforcement.** Confirmed via case-insensitive repo-wide search of both `everc-global-services` (fresh clone) and the full `unified-platform-new` tree: the flag appears in exactly one place in both — its own declaration at `BankFlag.java:48`. Zero references anywhere else — no controller check, no filter, no service-layer read of this flag. Strong evidence it is currently vestigial/unused rather than gating live traffic, though this is checked across two repo trees, not the full org, so it is a strong signal, not a certainty. Confirm with engineering before treating it as load-bearing for any migration-sequencing decision.
- **Account/config service behind `AccountConfigApi`.** Traced through `mlrc-notification` → `everc-global-services`; not implemented in either. company-brain's repo index has no further candidate by description. Remains genuinely unidentified — needs an engineering answer or an org-wide GitHub code search this doc's tooling cannot perform.
- ~~Earlier findings sourced from the stale nested `everc-global-services` copy~~ **Re-verified against the fresh clone, both confirmed current:** `UNIFIED_PLATFORM_ACCESS(37)` still present at `global-shared/src/main/java/com/everc/global/model/enums/BankFlag.java:48`; `Auth0UnifiedPlatformController.java` still present at `global-ams-api/src/main/java/com/everc/global/ams/api/controller/`. No drift found between the stale and fresh copies on these two citations.
- **Scan-submission role gating.** `core`'s `ScanController` has no visible admin/role annotation — whether it enforces the same per-bank entitlement gating MV does (`CAN_SCAN_WEB_ID`, `AUTOMATED_SCAN`, etc.) is unconfirmed.

## Changed, Not Missing

- **Auth model.** MV is session/role-based only, no client-credential issuance. UP's external API uses OAuth2 client-credentials grant with JWT bearer scopes (`mlrc-external-api`) — a genuine new capability, not a gap.
- **User management.** Moved to Auth0 (`Auth0UnifiedPlatformController.java`, `Auth0UserService.java`). Password reset/change is delegated to Auth0 rather than a first-party endpoint — an intentional architecture change.
- **Account/bank model.** MV's bank-centric `/api/v4/accounts` becomes an account/portfolio model (`mlrc-account`, `global-ams-api`). "Bank app ID" has no direct equivalent confirmed; likely renamed under the AMS account model.
- **API generation split.** MV runs unversioned legacy and `/api/v4` in parallel with no deprecation. UP instead splits by audience: `mlrc-external-api` (external, OAuth) vs. `mlrc-bff-api` (internal), both `/api/v1`. Whether a strangler/proxy still serves old MV `/api/v4` traffic during migration is unconfirmed.

## Should Not Carry Over

- Running two undeprecated API generations indefinitely (MV's current state). UP should define an explicit deprecation policy for `/api/v1`; no evidence found that this decision has been made yet.

## Product Decision Needed

Whether `UNIFIED_PLATFORM_ACCESS` currently gates live traffic routing is unresolved in both the source finding and this delta. It blocks any migration-sequencing or client-cutover decision and should be confirmed with engineering directly.

## Evidence Note

Scan submission and WebID are resolved (found, shape differs from MV). Callback/webhook config, transaction/billing, bulk operations, and audit export remain real gaps across every repo checked. The one open thread is the account/config service behind `AccountConfigApi`, which may own the actual webhook CRUD — route through company-brain to identify it before treating that gap as final.
