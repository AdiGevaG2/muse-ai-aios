# User roles and permissions — Atlas

Active domain: Atlas / Unified Platform.

Current stage: current-state analysis. Status: source comparison complete; production acceptance not verified.

Read first: [Reverse engineering and PRD gap map](current-state/user-roles-permissions-reverse-engineering.md).

Existing reference: [MVP PRD](prd/user-and-roles-management-mvp-prd.md). The comparison uses the user's pasted PRD as its requirements baseline; it does not revise that PRD.

Evidence: current GitHub source for `ufp-access-manager`, `marketview-portal`, `terraform` Permit policies, and `mlrc-account`; local `mlrc-bff-2.0` matching remote `develop`; targeted Confluence architecture and discovery references. Exact revisions and limitations are in the report.

Open decisions: MVP role catalog, internal-only administration versus Org Admin permissions, authorization-provider direction, fallback semantics, audit retention, and configuration inheritance.

Last verified: 2026-11-05. Static source inspection only; no deployed application access, production policy inspection, or runtime acceptance tests.
