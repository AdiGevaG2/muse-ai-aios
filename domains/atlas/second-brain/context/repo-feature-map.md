# Repo → Feature Path Map — atlas

Where to look for a feature's code across the legacy and target stacks. Base
paths corrected from an external skill reference (`feature-locations.md`,
ex-EverC repo) that pointed at a nonexistent path — real clones live under
the `code-repos-git/` working directory (path is per-machine — see
`SETUP.md`; see `platform.md` for the full repo list, including the G2RS
stack this map does not cover).

```bash
BASE_OLD="$CODE_REPOS_ROOT/merchant-view-legacy-ec"
BASE_NEW="$CODE_REPOS_ROOT/unified-platform-new"
```

**Coverage gap:** everything below is ex-EverC only (legacy Grails/Spring →
`mlrc-*`). It does not cover `single-platform-legacy-g2`
(`code-repos-git/single-platform-legacy-g2/g2-singlePlatform`) — the G2RS
legacy stack. Run a separate `/legacy-analyze` pass against that repo for any
feature where G2RS-originated behavior is in scope; do not assume this map's
absence of G2RS means G2RS has no equivalent behavior.

Additional boundaries from `MUSE-KNOWLEDGE-PACK.md` (retired PM workspace audit,
2026-08-26):

- `[documented-retired]` G2 evidence may be relevant to Content Compliance,
  Merchant Risk History, case-family behavior, and related risk workflows, but
  this map contains no verified G2 feature paths. Select and inspect that repo
  per feature.
- `[unknown]` Retired sources referenced WorkStream legacy code, but no
  WorkStream checkout is present in the current workspace.
- `[unknown]` No WebShield/ZignSec checkout is present. Treat WebShield-originated
  behavior as a coverage gap until a current source and owner are confirmed.
- Repository names and checkout locations are orientation only; they do not
  prove deployment, ownership, parity, or current behavior.

## Merchant Management
- **Legacy (`mvserver`, Grails):**
  `$BASE_OLD/mvserver/MerchantViewServerAPI/grails-app/controllers/v4/com/evercompliant/api/`
  — `MerchantApi4Controller.groovy` (CRUD), `ScanApi4Controller.groovy`,
  `FindingApi4Controller.groovy`, `UrlApi4Controller.groovy`,
  `ErrorApi4Controller.groovy`; services in
  `$BASE_OLD/mvserver/MerchantViewServer/grails-app/services/`.
- **First-gen (`merv-global-services/merv-merchant-api`, Spring Boot):**
  `$BASE_OLD/merv-global-services/merv-merchant-api/src/main/java/com/everc/merv/merchant/api/`
  — `controller/MerchantController.java`, `MerchantHasUrlController.java`,
  `MerchantHasScanController.java`, `MerchantPortfolioController.java`;
  `service/MerchantService.java` + `service/impl/` (+ `service/impl/prefetch/`);
  `mapper/MerchantMapper.java`; `validation/MerchantValidator.java`; `stat/`.
- **Target (`mlrc-merchant`, Spring Boot):**
  `$BASE_NEW/mlrc-merchant/api/src/main/java/com/everc/merchant/api/` —
  `controller/MerchantController.java`, `StoreController.java`; `service/`;
  `mapper/MerchantMapper.java`; `dto/`; shared entities in
  `$BASE_NEW/mlrc-merchant/shared/src/main/java/`; Kafka consumer in
  `$BASE_NEW/mlrc-merchant/merchant-consumer/src/main/java/`.

## Scan Management
- **Legacy (`mvserver`):** same controllers dir as above —
  `ScanApi4Controller.groovy`, `UrlSnoozeApi4Controller.groovy`.
- **`merv-scan-api`** (`$BASE_OLD/merv-global-services/merv-scan-api/src/main/java`)
  — controller → service → repository.
- **`merv-scan-consumer`** (Kafka, `@KafkaListener`) —
  `$BASE_OLD/merv-global-services/merv-scan-consumer/src/main/java`.
- **`merv-scan-release-api`** —
  `$BASE_OLD/merv-global-services/merv-scan-release-api/src/main/java`.
- **Target — event-driven & scheduled scans** (`mlrc-bff-2.0` / `mlrc-analysis`):
  Confluence architecture doc — [MLRC Architecture Presentation](https://everc.atlassian.net/wiki/spaces/Rocket/pages/5876908068/MLRC+Architecture+presentation).
  - Interactive: `marketview-portal` (React) triggers via user action →
    `mlrc-bff-2.0` aggregates and dispatches to scan controllers.
  - Scheduled: `mlrc-analysis` schedulers/cron evaluate priority/classification/
    portfolio params, emit Kafka/RabbitMQ events to trigger scans.

## Finding Management
- **Legacy:** `FindingApi4Controller.groovy`, `FindingSnoozeApi4Controller.groovy`
  in the same `mvserver` controllers dir.
- **Target (`mlrc-finding`):**
  `$BASE_NEW/mlrc-finding/api/src/main/java/com/everc/finding/api/` —
  `controller/FindingController.java`, `FindingRetriggerController.java`;
  `service/FindingApiService.java`, `FindingRetriggerService.java`;
  `mapper/FindingApiMapper.java`; `model/FindingDto.java`.

## Risk Calculation
- **Legacy (`merv-risk-calculation-api`):**
  `$BASE_OLD/merv-global-services/merv-risk-calculation-api/src/main/java`.
- **Target (`mlrc-risk`):**
  `$BASE_NEW/mlrc-risk/api/src/main/java/com/everc/risk/api/` —
  `controller/RiskController.java`; `service/RiskService.java`;
  `mapper/RiskMapper.java`; `dto/`; Kafka consumers in
  `$BASE_NEW/mlrc-risk/risk-consumer/src/main/java/`.

## Gateway / Aggregator (Scan Flow)
- **Legacy (`gateway`, Spring Boot):** `$BASE_OLD/gateway/` — aggregator
  (`merv-gateway-aggregator/src/main/java/com/everc/merv/gateway/aggregator/`:
  `consumer/HighPriorityKafkaConsumer.java`, `LowPriorityKafkaConsumer.java`,
  `controller/CoreMockConsumer.java`, `service/`) and splitter
  (`merv-gateway-splitter/src/main/java/`).
- **Target (`mlrc-notification`, Spring Boot + Kafka aggregation):**
  `$BASE_NEW/mlrc-notification/api/src/main/java/com/everc/notification/` —
  `controller/NotificationController.java`, `service/NotificationService.java`;
  `$BASE_NEW/mlrc-notification/notification-consumer/`.

## Merchant Processor Job (event-driven)
`$BASE_OLD/mvnextgen/merchant-processor-job/src/main/java/com/everc/nextgen/mpj/`
— `Consumer.java`, `ReleaseConsumer.java`, `ScannedMerchantProducer.java`,
`datareader/` (+ `datareader/release/`), `aws/SnsNotificationSender.java`.

## UI
- **Legacy Angular (`merchantviewui`):** `$BASE_OLD/merchantviewui/src/app/`.
- **Target React (`marketview-portal`):** `$BASE_NEW/marketview-portal/src/`
  — `features/`, `components/`, `hooks/`, `api-clients/`, `requests/`.
  Feature-branch work (e.g. category-risk-config) may live in a worktree —
  see `platform.md` for the `marketview-portal-001-category-risk-config` note.

## Not yet mapped by this reference (present on disk, absent from source doc)
- `app-infra-devops` (legacy side) — infra/deploy config
  (`amex-sftp`, `everc-api`, `everc-global-services`, `gateway`, `hds`, ...).
- `mlrc-infra` (target side) — shared infra incl. `data-pipeline/`.
- `mlrc-sdk-test` (target side, branch `master`).
- `ufp-automation` (target side, branch `main`) — test/automation tooling.
- No local repo covers Airflow (flagged as a known gap in the source doc too).
Confirm with eng before assuming these have no bearing on a feature.

## Quick pattern reference
| Looking for | Where (new) | File pattern |
|---|---|---|
| REST endpoints | `controller/` | `*Controller.java` |
| Business logic | `service/impl/` | `*ServiceImpl.java`, `*Service.java` |
| Data access | `repository/` or `shared/` | `*Repository.java` |
| DTOs | `dto/` | `*Dto.java`, `*Request.java`, `*Response.java` |
| Mapping | `mapper/` | `*Mapper.java` |
| Validation | `validation/` | `*Validator.java` |
| Exceptions | `exception/` | `*Exception.java`, `GlobalExceptionHandler.java` |
| Kafka consumers | `consumer/` or `*-consumer` module | `*Consumer.java` |
| REST endpoints (legacy) | `grails-app/controllers/v4/` | `*Controller.groovy` |
| Services (legacy) | `grails-app/services/` | `*Service.groovy` |
| Domain models (legacy) | `grails-app/domain/` | `*.groovy` |
| Config / Spring beans | `config/` | `*Config.java`, `*Configuration.java` |
| Integration tests | `src/test/java/.../integration/` | `*IT.java`, `*_IT.java` |

## Related references
- [MLRC Data Model Catalog](https://everc.atlassian.net/wiki/spaces/Rocket/pages/5516427266/MLRC+Data+Model) — DynamoDB tables, ER diagrams, key design.
- [MLRC Architecture Presentation](https://everc.atlassian.net/wiki/spaces/Rocket/pages/5876908068/MLRC+Architecture+presentation).
- Pattern-level mapping (Grails→Spring Boot, Angular→React): `legacy-to-target-patterns.md`.
