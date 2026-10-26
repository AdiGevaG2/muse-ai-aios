# Platform Context — atlas (domain-specific only)

Org-wide systems (Mixpanel, Coralogix, Confluence, Jira, Figma) live in
`org-brain/context/systems.md`. Only put atlas-SPECIFIC facts here.

## Domain-specific systems
- **Target platform:** [verbal] Atlas (UP) is the new platform being
  built to **replace** three named legacy products: **MerchantView**,
  **WebShield**, and **Single Platform**. Confirmed by the domain PM
  (2026-08-30) — this upgrades what was previously recorded as inferred
  roadmap direction. Replacement is the stated goal, not just integration.
  The ~12–18 month timeline remains [hunch]; no committed date is recorded.
- **Client migration:** [verbal] G2RS acquired EverC and WebShield, and **all
  clients must be migrated** onto UP. Migration is therefore a first-class
  product constraint on this domain, not a follow-on project: every UP
  capability has to be good enough to move a real legacy customer off the
  product it replaces. Migration scope, sequencing, and per-client cutover
  plan are TODO.
- **Legacy system(s):** [documented] Three separate stacks being consolidated;
  the PM's product-level names for them (2026-08-30) map as: **MerchantView** =
  ex-EverC, **WebShield** = ex-WebShield/ZignSec, **Single Platform** = legacy
  G2RS (matches the `g2-singlePlatform` repo below).
  - **Single Platform** (legacy G2RS) — Merchant Map®, MRH, Content
    Compliance/BRAM, fraud detection.
  - **MerchantView** (ex-EverC) — Digital Commerce Risk: marketplace/seller
    monitoring, multi-modal AI, Smart Scan.
  - **WebShield** (ex-WebShield, via ZignSec) — compliance tech.

  Which system is canonical for a given overlapping capability (e.g. merchant
  monitoring exists in more than one legacy stack) is not fully specified in
  source — confirm ownership per capability before relying on it in a PRD.
  Note this is sharper under a replacement goal than under an integration
  goal: UP must pick one behavior per overlap, so each overlap is a product
  decision someone has to make, not a merge.

## Code repositories
Local clones live outside this repo in a `code-repos-git/` directory added as
an additional working directory in this workspace (path is per-machine —
see `SETUP.md`). `/legacy-analyze` and `/target-platform` read from here —
point them at these paths directly.

- **Legacy G2RS** — `code-repos-git/single-platform-legacy-g2/`
  - `g2-singlePlatform` (branch: `master`) — the single repo for this stack.
- **Legacy EverC (MerchantView)** — `code-repos-git/merchant-view-legacy-ec/`
  (all on branch `develop` unless noted): `app-infra-devops`,
  `everc-global-services`, `gateway`, `merchantviewui`, `merv-global-services`,
  `mvnextgen`, `mvserver`.
- **Target: Atlas** — `code-repos-git/unified-platform-new/`
  (mostly `develop`; `ufp-automation` on `main`): `everc-global-services`,
  `marketview-portal`, `mlrc-account`, `mlrc-analysis`, `mlrc-bff-2.0`,
  `mlrc-finding`, `mlrc-infra`, `mlrc-merchant`, `mlrc-monitoring`,
  `mlrc-notification`, `mlrc-risk`, `mlrc-sdk-test` (branch: `master`),
  `mlrc-status`, `ufp-automation`.
  - `marketview-portal-001-category-risk-config` is a **git worktree** of
    `marketview-portal`, checked out on branch `001-category-risk-config`
    (in-progress feature work, spec files under `specs/001-category-risk-config/`
    have uncommitted changes) — not a separate repo, not scratch. Treat it as
    the live branch to read for that feature's target-platform behavior.
- [flag] `everc-global-services` is checked out under **both** legacy EverC
  and target Atlas — same repo (`github.com/evercompliant/everc-global-services`),
  reused rather than rewritten. Confirm with eng whether it's shared
  infrastructure (fine to treat as carried-over) or genuinely unmigrated
  legacy code living in the target stack before citing it as "target platform
  behavior" in a PRD.
- No WebShield/ZignSec repo is present in `code-repos-git/` — that legacy
  stack isn't available locally for `/legacy-analyze`; note as a coverage gap
  if a feature touches ZignSec-originated behavior.
- [flag] A second, independent full clone of the same repos may exist in an
  older, separate PM workspace on a given machine — check for this before
  assuming a single canonical local clone. On the original workspace this was
  found byte-identical to the current one (same HEAD commits,
  same dirty-file counts) but not linked, so the two can silently drift once
  either is committed to. (The `marketview-portal-001-category-risk-config`
  worktree previously depended on that older clone's git internals; fixed
  2026-07-03 by repointing its `.git` file and the main clone's
  `.git/worktrees/.../gitdir` to `code-repos-git/` — no data touched, both
  admin metadata copies already existed from the original bulk copy. The
  worktree is now self-contained under `code-repos-git/`.) The broader
  duplicate-clone risk for the other repos is unresolved — recommend treating
  `code-repos-git/` as canonical and archiving the `PM-unified-platform/` copy.
- Feature→file path index (repo, controller, service, per capability):
  `repo-feature-map.md`.
- Legacy↔target pattern mapping (Grails→Spring Boot, Angular→React):
  `legacy-to-target-patterns.md`.

## Open question — production-branch mapping (ask before every reverse-engineering run)
[hunch] The branches listed above (`master`/`develop`/`main`) are what's
currently checked out locally — this is NOT confirmed to match what's actually
deployed to production/clients. Before `/legacy-analyze` or `/target-platform`
treats any repo's checked-out branch as "current behavior," ask the PM: has
this been confirmed against a real deploy source (CI/CD, release tags, a
release dashboard) for the repos in scope? If not confirmed, flag the
resulting spec as based on an unverified branch. Full hypothesis:
`../hypotheses/README.md`.

## Domain-specific constraints
- [hunch] EverC integration is still in progress (~8 months post-close as of
  Jun 2026) — expect fragmentation between legacy G2RS and legacy EverC
  tooling in some workflows; treat "current behavior" claims as needing a
  legacy-analyze pass per capability rather than assumed-uniform.
- Full company/history context: `org-brain/context/company.md` and
  `org-brain/context/everc.md`.
