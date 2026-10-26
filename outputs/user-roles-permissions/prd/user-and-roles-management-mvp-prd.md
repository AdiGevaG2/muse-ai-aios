---
source: https://g2rs.atlassian.net/wiki/spaces/UP/pages/4220551187/User+and+Roles+Management+MVP+PRD
last_synced: 2026-09-10
---

# User and Roles Management MVP PRD

| Document | Product Requirements Document |
| --- | --- |
| Product Area | Atlas - User and Roles Management |
| Release | MVP / Phase 1 |
| Date | May 28, 2026 |

Assumptions used in this rewrite: Monitoring is the only supported product in MVP, external customers do not receive self-service administration in MVP, and internal Platform Administrators remain responsible for onboarding and permission changes.

## Executive Summary

The Atlas currently authenticates users, but authorization is enforced inconsistently across APIs and products. That gap creates security risk, operational overhead, weak auditability, and poor scalability as more enterprise customers onboard.

This MVP introduces the first centralized authorization model for the Atlas. It establishes organization isolation, portfolio-scoped access control, role-based permissions, and auditable privileged actions.

The MVP is intentionally narrow. It supports one external customer persona, one primary product, and internal-only administration so the team can validate the model safely before expanding to self-service governance and additional products.

## Problem Statement

Today, Atlas services rely on authentication but not on consistently enforced authorization. That exposes the platform to security, compliance, operational, and scale risks.

- Potential cross-organization data exposure.
- Manual onboarding and access changes handled by internal teams.
- Weak centralized auditability for privileged actions and denials.
- Fragmented access logic that does not scale well across products.

## Business Rationale

- Enterprise customers expect secure organization isolation, portfolio governance, and audit-ready operations.
- Internal teams need a scalable way to manage access without turning onboarding into a bottleneck.
- Future Atlas products need a shared authorization foundation rather than duplicated policy logic.
- The company needs a safe path toward eventual customer self-service administration.

## Product Vision

The long-term vision is to provide a centralized authorization platform across the Atlas ecosystem. That future platform should support multiple products, fine-grained permissions, self-service administration, auditor workflows, external integrations, service identities, and richer access models without redesigning the core governance layer.

## Pain Points

- User management is fully manual today.
- Client access changes rely on scripts and operational processes instead of product capabilities.
- Provisioning does not scale as more organizations onboard.
- Access mistakes are harder to prevent and investigate.
- Authorization behavior is inconsistent across services.
- Clients cannot manage their own teams during onboarding or steady state.

## Data

The MVP requires a small set of core data domains that define identity, scope, permissions, and auditability.

| Data Domain | Purpose |
| --- | --- |
| Organizations | Customer accounts isolated by organization ID. |
| Portfolios | Operational workspaces within an organization with enabled products. |
| Users | Authenticated identities marked as internal or external. |
| Memberships | Assignments linking users to organizations and portfolios with a role. |
| Product permissions | Explicit per-portfolio access grants such as Monitoring. |
| Audit events | Privileged actions and authorization decisions used for review and reporting. |

## Goals and Success Metrics

### Goals

- Enforce authorization consistently across all protected MVP APIs and user flows.
- Prevent cross-organization access and restrict users to explicitly assigned portfolios.
- Support the full Monitoring workflow for the MVP external persona.
- Create a centralized, auditable access model that can expand to more roles and products later.
- Reduce internal effort required to onboard and manage customer users relative to the current process.

### Success Metrics

| Metric | Target | Why It Matters |
| --- | --- | --- |
| Protected API coverage | 100% of MVP protected APIs enforce centralized authorization | Confirms the model is applied everywhere it should be. |
| Cross-organization exposure incidents | 0 | Validates tenant isolation. |
| Authorization decision latency | <=10 ms p95 | Prevents the control layer from degrading workflows. |
| Authorization availability | >=99.9% | Keeps the platform reliable in production. |
| Audit coverage | All privileged actions and denials captured | Supports compliance and investigations. |
| Onboarding effort | Measured reduction versus baseline | Shows clear operational value. |

## Personas

| Persona | Type | Scope | MVP Role in Product |
| --- | --- | --- | --- |
| Platform Administrator | Internal | Platform-wide | Creates organizations and portfolios, invites users, assigns access, and manages governance. |
| Risk Manager | External | Organization + portfolio | Uploads merchants, reviews findings, updates resolutions, approves high-risk actions, and downloads reports. |
| System Service | Internal non-human | Organization-scoped | Supports internal service-to-service flows; no client-facing UI. |

### Future Personas (Not MVP)

- Viewer: read-only access.
- Risk Analyst: operational findings review role.
- Org Administrator: customer-managed user administration.
- Auditor: cross-portfolio or cross-organization audit workflows.
- Data Uploader: restricted upload-only role.
- Integration Service: machine-to-machine integrations.

## Target Audience

- Internal audience: G2RS Platform Administrators and support teams who run onboarding and governance.
- External audience: Risk Managers as the MVP primary persona using Monitoring under those guardrails.
- Audience boundary: external customers cannot administer users, roles, or permissions during MVP.

## Scope

### In Scope - MVP

Phase 1 includes:

- 3 roles: Platform Admin, Risk Analyst, Risk Manager.
- Permit.io integration.
- Local RBAC fallback.
- Manual user creation by G2RS.
- Automatic default portfolio creation.
- Org-to-portfolio configuration inheritance.
- Immutable 7-year audit trail.
- Full org isolation.
- Monitoring as the only fully supported product in MVP.

### Out of Scope

- Client self-service.
- Custom org-level roles.
- Bulk user import.
- Audit log UI.
- SSO.
- Notifications on role changes.
- Platform Admin UI.
- PDF/XLSX exports.

## Role Categories

| Role | Ph. | Scope | Audience | What They Do |
| --- | --- | --- | --- | --- |
| Platform Admin | 1 | Platform | Internal | Owns global role definitions and cross-org config. G2RS only. |
| Risk Manager | 1 | Portfolio | Both | Uploads merchants, reviews findings, approves high-risk actions, downloads CSV reports. |
| CSM | 2 | Org | Internal | G2RS support access. Limited org view. Invisible to client. |
| Risk Analyst | 1 | Portfolio | Both | Reviews findings. Internal: previews and overrides results before client release. |
| Org Admin | 2 | Org | Both | Self-service user management, full permissions for specific orgs (clients). |
| Risk Analyst | 3 | Org | Internal | Internal G2RS analyst role. Permissions defined in Phase 3. |
| Data Uploader | 3 | Portfolio | External | Uploads merchants only. No access to findings or results. |
| Viewer | 3 | Portfolio | Both | Read-only. Can download permitted CSV reports. Cannot write anything. |
| API Service | 3 | Org | External | Non-human client integration identity. Managed by Org Admin. |

Internal roles such as Platform Admin, System Service, CSM, and Analyst must never appear in any client-facing experience.

## Permissions

Use this matrix to scope API endpoint authorization for Phase 1 and future role design.

Risk Analyst and Risk Manager each split into Internal and External variants: Internal previews and overrides findings before client release, External operates within client-facing guardrails only.

| Action | Platform Admin | Org Admin | Risk Analyst - Internal | Risk Analyst - External | Risk Manager - Internal | Risk Manager - External | Viewer |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Invite users | Yes | Yes | No | No | No | No | No |
| Assign org-level roles | Yes | Yes | No | No | No | No | No |
| Assign portfolio roles and products | Yes | Yes | No | No | No | No | No |
| Block or unblock users | Yes | Yes | No | No | No | No | No |
| Remove user from org | Yes | Yes | No | No | No | No | No |
| View merchant findings | Yes | Yes | Yes | Yes | Yes | Yes | Yes |
| Mark finding as false positive | Yes | No | Yes | No | Yes | No | No |
| Update finding resolution (risk/no risk) | Yes | Yes | No | Yes | No | Yes | No |
| Release findings (batch release) | Yes | No | No | No | Yes | No | No |
| Approve high-risk actions | Yes | Yes | No | No | No | Yes | No |
| Upload merchants | Yes | Yes | Yes | Yes | Yes | Yes | No |
| Download reports (CSV) | Yes | Yes | Yes | Yes | Yes | Yes | Yes |
| View all orgs | Yes | Yes | No | No | No | No | No |
| See internal G2RS roles | Yes | No | No | No | No | No | No |

**Open decision:** the source table left Upload merchants, Download reports, View all orgs, and See internal G2RS roles unspecified for the Internal/External Risk Analyst and Risk Manager split. Values above carry forward the prior single-role matrix pending confirmation. Flagging as `TBD` for sign-off.

## User Journeys and Use Cases

1. Customer onboarding: Platform Administrator creates an organization and portfolio, enables Monitoring, invites a Risk Manager, and assigns access.
2. Merchant upload: Risk Manager uploads merchants for an assigned portfolio with Monitoring access.
3. Findings review and resolution: Risk Manager reviews findings, updates resolutions, and approves high-risk actions where permitted.
4. Report download: Risk Manager downloads reports containing only authorized data.

| User | Journey | Outcome |
| --- | --- | --- |
| Platform Administrator | Provision organization, assign scope, invite users, manage permissions. | Customer is onboarded with correct and auditable access. |
| Risk Manager | Accept invitation, sign in, work within assigned portfolio. | User completes Monitoring workflows without seeing unauthorized data. |

## User Stories

- As a Platform Administrator, I need to create organizations and portfolios so new customers can be onboarded in a controlled way.
- As a Platform Administrator, I need to invite external users and assign the correct access without engineering intervention.
- As a Risk Manager, I need to access only the portfolios assigned to me so I can work securely within my organization.
- As a Risk Manager, I need to upload merchants and review findings for authorized portfolios so I can perform Monitoring operations end-to-end.
- As a reviewer, I need an auditable record of privileged actions and denials so I can investigate issues and verify controls.

## Functional Requirements

| ID | Requirement | Description |
| --- | --- | --- |
| FR1 | Organization isolation | The system must deny access to data or actions outside the user's authorized organization. |
| FR2 | Portfolio authorization | The system must allow access only to explicitly assigned portfolios. |
| FR3 | Product permission enforcement | Monitoring workflows must require explicit Monitoring access at the portfolio level. |
| FR4 | User lifecycle administration | Platform Administrators must be able to invite, activate, deactivate, and assign access for MVP users. |
| FR5 | Workflow authorization | Merchant upload, findings review, resolution updates, approvals, and report downloads must be permission-gated. |
| FR6 | Auditing | Privileged actions and authorization denials must generate durable audit records. |
| FR7 | Fail-closed behavior | If authorization cannot be evaluated safely, the request must not proceed. |

## Non-Functional Requirements

- Security: authorization must follow least-privilege principles and never rely on authentication alone.
- Reliability: authorization services must meet at least 99.9% availability for MVP operation.
- Performance: authorization decision latency should remain at or below 10 ms p95.
- Auditability: audit records must be durable, reviewable, and retained in accordance with compliance policy.
- Operational resilience: cached or offline policy behavior may be used only when it preserves fail-closed semantics.
- Scalability: the model must support future expansion without redesigning the core object model.

## UX and Design Requirements

- Internal roles must never appear in customer-facing UI.
- External users should land directly into authorized scope after sign-in.
- Unauthorized actions must fail clearly and consistently without exposing hidden data.
- Invitation and activation flows must be simple enough for low-touch onboarding.
- Portfolio context must be visible in Monitoring workflows.

## Analytics and Instrumentation

- Mixpanel events and reports should cover authentication, onboarding, role changes, permission changes, and Monitoring workflow completion.
- Dashboards should support denial trends, active organizations, active users, and onboarding funnel visibility.
- BI and Data should receive audit and authorization events for downstream reporting and Phase 3 readiness tracking.

## Acceptance Criteria

Every MVP role appears below in at least one happy-path scenario. IDs are stable; an AC is retired rather than renumbered.

### AC-001: Organization isolation (happy path - all roles)

**As a** user authenticated to Organization A
**I want to** be blocked from Organization B's data
**So that** cross-tenant exposure cannot occur

```gherkin
Given a user authenticated for Organization A
When the user requests data from Organization B
Then the request is denied and the denial is audited
```

### AC-002: Portfolio scope (happy path - all portfolio-scoped roles)

**As a** user assigned to Portfolio X only
**I want to** be blocked from Portfolio Y
**So that** I cannot see or act on data outside my assignment

```gherkin
Given a user with access to Portfolio X only
When the user requests data for Portfolio Y
Then the request is denied and no Portfolio Y data is returned
```

### AC-003: Platform Administrator - onboarding (happy path)

**As a** Platform Administrator
**I want to** create an organization and portfolio, enable Monitoring, and invite a Risk Manager
**So that** a new customer is onboarded with correct, auditable access

```gherkin
Given a Platform Administrator is authenticated
When they create an organization and portfolio, enable Monitoring, and send an invitation to an external user
Then the organization and portfolio exist, Monitoring is enabled, the invitation is recorded, and the action is audited
```

### AC-004: Platform Administrator - invitation flow (happy path)

**As a** Platform Administrator
**I want to** invite an external user
**So that** the user can activate their account within their assigned scope

```gherkin
Given a Platform Administrator creates an invitation
When the external user accepts it within the allowed validity period
Then the account is activated and can sign in within assigned scope
```

### AC-005: Platform Administrator - deactivation (happy path)

**As a** Platform Administrator
**I want to** deactivate a user
**So that** the user immediately loses access

```gherkin
Given an active user is deactivated by a Platform Administrator
When the user attempts a new request
Then access is denied and the change is audited
```

### AC-006: Org Admin - user and role administration (happy path)

**As an** Org Admin
**I want to** invite users, assign org-level and portfolio roles, and block or remove users within my organization
**So that** I can manage my organization's access without engineering or Platform Admin involvement

```gherkin
Given an Org Admin is authenticated for their organization
When they invite a user, assign a role, or block/remove a user within that organization
Then the action succeeds, is scoped to that organization only, and is audited
```

### AC-007: Risk Analyst (Internal) - findings review with override (happy path)

**As an** internal Risk Analyst
**I want to** view findings, mark false positives, and override results before client release
**So that** only reviewed, accurate findings reach the external persona

```gherkin
Given an internal Risk Analyst has Monitoring access to an assigned portfolio
When they view a finding and mark it as a false positive
Then the finding is updated, the override is recorded, and the action is audited
```

### AC-008: Risk Analyst (External) - findings review and resolution (happy path)

**As an** external Risk Analyst
**I want to** view findings and update resolution status (risk / no risk)
**So that** I can complete the review workflow within my assigned portfolio

```gherkin
Given an external Risk Analyst has Monitoring access to an assigned portfolio
When they view a finding and update its resolution to risk or no risk
Then the resolution is saved and the action is audited
```

### AC-009: Risk Manager (Internal) - batch release (happy path)

**As an** internal Risk Manager
**I want to** release a batch of reviewed findings
**So that** approved findings become visible downstream on schedule

```gherkin
Given an internal Risk Manager has Monitoring access to an assigned portfolio
When they release a batch of findings
Then the findings are released, and the release is audited
```

### AC-010: Risk Manager (External) - full Monitoring workflow (happy path)

**As an** external Risk Manager
**I want to** upload merchants, review findings, update resolutions, approve high-risk actions, and download reports
**So that** I can operate Monitoring end-to-end for my organization

```gherkin
Given an external Risk Manager has Monitoring access to an assigned portfolio
When they upload merchants, review findings, update a resolution, approve a high-risk action, and download a report
Then each action succeeds, the report contains only data from authorized portfolios in the authorized organization, and every action is audited
```

### AC-011: Viewer - read-only access (happy path)

**As a** Viewer
**I want to** view findings and download permitted CSV reports
**So that** I can monitor status without being able to modify anything

```gherkin
Given a Viewer has read access to an assigned portfolio
When they view findings or download a permitted report
Then the request succeeds and any attempt to write or modify data is rejected
```

### AC-012: Monitoring permission enforcement (unhappy flow)

**As a** user without Monitoring permission on a portfolio
**I want to** be blocked from Monitoring actions
**So that** product-level entitlement is enforced independently of role

```gherkin
Given a user lacks Monitoring permission for a portfolio
When the user tries to upload merchants or view findings for that portfolio
Then access is denied
```

### AC-013: Internal role visibility (unhappy flow)

**As an** external user
**I want to** never see internal-only roles or actions
**So that** internal governance stays invisible to clients

```gherkin
Given a user is authenticated as an external persona
When any UI or API response is rendered for that user
Then no internal-only role name or internal-only action appears
```

### AC-014: Fail-closed behavior (unhappy flow)

**As** any authenticated user
**I want to** be denied access when authorization cannot be evaluated
**So that** a system fault never grants access by default

```gherkin
Given the authorization service cannot safely evaluate a request
When the protected request is made
Then the request does not proceed and an operational signal is emitted
```

## Prioritization

Framework used: MoSCoW

| Priority | Items |
| --- | --- |
| Must Have | Organization isolation, portfolio scoping, three MVP roles, Monitoring permission checks, internal-only administration, audit logging, fail-closed behavior. |
| Should Have | Operational dashboards for onboarding and denial trends, measurable reduction in onboarding effort, reliable invitation and deactivation workflows. |
| Could Have | Additional internal tools that reduce admin effort but are not required for safe launch. |
| Won't Have in MVP | Customer self-service, custom roles, SSO, audit log UI, merchant-level authorization, full multi-product authorization. |

## Dependencies

- Identity provider support for authenticated users and organization context.
- Centralized authorization service and policy distribution layer.
- Application and API teams adopting the common authorization enforcement pattern.
- Audit pipeline and BI support for event ingestion, storage, and reporting.
- Operational readiness from Customer Success, Compliance, and support teams.

## Stakeholders

### Backoffice

- Customer Success and Operations carry the user lifecycle during MVP.
- Operate invitation, role assignment, and deactivation workflows on behalf of customers.
- Triage authorization-denial tickets and route policy fixes to engineering.
- Own the operational runbook for portfolio assignment and Monitoring enablement.

### Compliance

- Define audit-event retention and review cadence.
- Validate that authorization decisions and privileged operations are captured end to end.
- Sign off on fail-closed and least-privilege controls before each phase.

### Finance

- Review PDP, policy distribution, and audit pipeline cost projections per phase.
- Confirm authorization infrastructure is allocated correctly across products.

### BI and Data

- Consume audit events into the analytics warehouse.
- Build dashboards for active organizations, active users, denial trends, and onboarding funnel.
- Define metrics that gate Phase 3 self-service readiness.

## Risks and Mitigations

| Risk | Why It Matters | Mitigation |
| --- | --- | --- |
| Mis-scoped access | Could expose customer data across organizations or portfolios. | Enforce explicit organization and portfolio checks everywhere, backed by audit review. |
| Operational dependence on internal admins | Could slow onboarding and create support bottlenecks. | Keep role model narrow in MVP and measure admin effort to inform the next phase. |
| Authorization service disruption | Could block legitimate workflows or cause inconsistent behavior. | Use resilient deployment patterns and require fail-closed behavior with operational alerting. |
| Role confusion | Too many roles too early would create governance mistakes. | Limit MVP to three roles and move future roles into later phases. |
| Incomplete rollout coverage | Security value is weak if some endpoints bypass the model. | Make API coverage a launch gate and track it explicitly. |

## Open Questions

- What exact baseline will be used to measure reduction in onboarding effort?
- What retention and review cadence is required for audit records in production?
- What customer volume or complexity threshold should trigger Org Administrator self-service as the next phase?
- Which additional Monitoring actions, if any, should be split into separate permissions after MVP?

## Phases

| Phase | Purpose | Scope |
| --- | --- | --- |
| Phase 0 - Preparation | Prepare shared authorization foundation | Identity setup, policy seed, audit plumbing, common enforcement pattern, and operational readiness. |
| Phase 1 - MVP | First controlled production rollout | Internal-only governance, Monitoring only, organization isolation, portfolio scoping, audit coverage. |
| Phase 2 - Fast Follows | Post-launch hardening | Additional dashboards, session invalidation hardening, limited tooling improvements, and possible viewer-style roles. |
| Phase 3 - Expansion | Begin self-service and broader authorization | Org Administrator, broader role catalog, more products, and finer-grained controls. |

## Pilot / Prototype

The MVP should launch as a tightly controlled pilot with a small number of early customers. Pilot success should be gated on correct authorization behavior, complete audit coverage, and manageable operational overhead.

## Partner Responsibilities and Technical Architecture

Detailed implementation design should live in supporting architecture documents, but partner responsibilities are clear at the PRD level: identity, authorization, audit, analytics, and application teams must align on one enforcement pattern and one operating model for rollout.

- Identity layer: authenticates users and provides organization context.
- Authorization layer: evaluates centralized policies and role-based permissions.
- Application layer: enforces allow or deny outcomes consistently across protected workflows.
- Audit and BI layers: capture, store, and report privileged actions, denials, and adoption signals.

## Appendix

### Capability Boundary: MVP vs Future

| Capability | MVP | Future Direction |
| --- | --- | --- |
| Internal administration | Yes | Continues |
| External self-service user administration | No | Planned post-MVP |
| Monitoring authorization | Yes | Expanded |
| Multi-product authorization | Partial | Full platform coverage |
| Merchant-level permissions | No | Planned later |
| Auditor workflows | No | Planned later |
| Relationship-based access control | No | Potential long-term direction |

### Implementation Notes Moved Out of the Core PRD

The source draft included implementation-specific material such as service names, synchronization components, storage systems, and JWT examples. Those details are valuable, but they belong in architecture or design documentation rather than the core PRD. They should be maintained as supporting references for engineering and security review.
