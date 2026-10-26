# API Directory: MerchantView vs. Atlas

Side-by-side listing. Source: `merchantview-api-surface-reverse-engineering.md` (MV) and `mv-to-up-api-gaps.md` (UP), verified against current code across `unified-platform-new`, `core`, `core-webid`, `ufp-backend`, `mlrc-notification`, `everc-global-services`, `mlrc-account`, `mlrc-bff-2.0`.

| Capability | MerchantView | Atlas | Status |
|---|---|---|---|
| Merchant create/edit/search | `/api/v4/merchants/...` | `mlrc-external-api` `POST /api/v1/merchants`, `POST /api/v1/merchants/upsert`, `PATCH /api/v1/merchants/{merchantId}` | Carries over |
| Merchant delete | `/api/v4/merchants/...` | Not found (`MerchantController.java`, `mlrc-bff-2.0`, checked fresh 2026-09-09) | Gap |
| Merchant sub-resources (URL, address, alias, email, phone) | `/api/v4/merchants/...` | Not found as separate endpoints | Gap |
| Scan/screening submission | `POST /api/v4/merchants/{id}/scans` | `core` `POST /pipelineScan/scan`, `POST /pipelineScan/scanDomains` | Carries over, shape differs (domains in body, not merchant ID in path; role gating unconfirmed) |
| Async scan-intake gateway | `POST /api/v1/scan-request` → Kafka/SQS | Internal-only: `mlrc-analysis/sender` produces to Kafka topic `core-scan-request`, fed by an internal SQS consumer; no external ingress found | Gap (no external-facing equivalent) |
| WebID product (scan/report/sync-report, own entitlement) | `/api/v4/webid/merchants/...` | `core-webid` `POST /webid`, `POST /webid/k9` | Changed — exists as one synchronous match call, not MV's async scan/report/sync-report workflow; no entitlement flag |
| Findings (list/edit/evidence/snooze) | `/api/v4/findings/...` | `mlrc-finding` `FindingController` (`/api/v1/`), `FindingRetriggerController`; `mlrc-bff-api` `FindingController`, `FindingStatusController`; snooze confirmed via `mlrc-status` | Carries over, shape differs; field-level parity not verified |
| Callback/webhook config (bank-level CRUD, admin-only) | `/api/v4/callback` | Not found in `mlrc-notification`, `everc-global-services`, or `mlrc-account` (all checked fresh) | Gap — true owner unresolved, open question with Ilya |
| Reporting/export | Report list/generate, audit export, admin login report | `ReportController` (`unified-platform-new`, `ufp-backend`): finding-level, url-level, mmp, merchant-summary reports | Partial — report generation carries over; audit export and admin login report not found |
| Bulk operations | Bulk save/update/delete: findings, screenshots, scan items, merchant ownership | `BulkUploadController` (`mlrc-merchant`, `mlrc-bff-api`): merchant bulk upload only | Partial — merchant bulk upload only; findings/screenshots/scan-items/ownership bulk ops not found |
| Account/bank | `/api/v4/accounts`: current bank, bank list, bank app ID | `mlrc-account`, `global-ams-api` `AccountController`: account/portfolio model | Changed — bank-centric model replaced by account/portfolio model; "bank app ID" not directly confirmed |
| Transaction/billing | `TransactionApi`, `TransactionBulkApi`, `AdminBillingApi` | Not found in any repo checked; no candidate repo in company-brain's index either | Gap |
| User management incl. password reset | `/publicapi/userManagement/...` | Auth0 (`Auth0UnifiedPlatformController_PLACEHOLDER`, `Auth0UserService`, `global-ams-api`) | Changed — delegated to Auth0, not first-party |
| Auth model | Session/role-based (Spring Security `@Secured`), no client-credential issuance | OAuth2 client-credentials grant, JWT bearer scopes (`mlrc-external-api`) | New capability in UP, not present in MV |
| Per-client API entitlement | `BankFlagEnum` flags (`CAN_SCAN_WEB_ID`, `AUTOMATED_SCAN`, etc.) | `BankFlag.java` carries the same enum unchanged, including `UNIFIED_PLATFORM_ACCESS(37)` | Carries over as data; `UNIFIED_PLATFORM_ACCESS` has zero references outside its own declaration anywhere in two repo trees — likely unused, confirm with engineering |
| API generations | Unversioned legacy + `/api/v4` run in parallel, no deprecation | `mlrc-external-api` (external, OAuth) vs. `mlrc-bff-api` (internal), both `/api/v1` | Changed — split by audience instead of by version; no deprecation policy found on either side |

## Reading this table

- **Carries over**: capability exists in UP, same or near-equivalent behavior.
- **Changed**: capability exists in UP but the shape, workflow, or ownership model differs materially from MV.
- **Gap**: checked against every plausible repo (via company-brain routing, not assumption) and not found.
- **New**: UP has a capability MV never had.

Full evidence, file citations, and the open question awaiting Ilya's response are in `mv-to-up-api-gaps.md` in this folder.
