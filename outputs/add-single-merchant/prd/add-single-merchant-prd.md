# PRD: Add Single Merchant

## Document Metadata

| Field | Value |
| --- | --- |
| Feature | Add Single Merchant |
| Product Area | Atlas - Merchant Monitoring |
| Release | MVP |
| Owner | Adi Geva |
| Status | Draft |
| Version | v1 |
| Date | 2026-09-03 |

## Executive Summary

Clients migrating to Atlas with monitoring products only need to add one merchant directly to ongoing monitoring, without that merchant also entering onboarding.

The MVP keeps the existing side panel and its fields unchanged, adds read-only visibility of the active portfolio's monitoring cycle and enabled products, and changes the create action to monitoring-only. The user chooses **Create merchant and scan now** or **Create merchant and scan later**; both create the merchant, assign it to the active portfolio, apply the portfolio's enabled products, and start monitoring. Scan now additionally requests an immediate scan without displacing the next scheduled cycle.


## Problem Statement

| Area | Description |
| --- | --- |
| Current gap | The only existing Add-merchant action enrolls the merchant in onboarding and monitoring; there is no distinction between monitoring and onboarding path. |
| User pain points | Migrating clients cannot add a merchant to monitoring without an onboarding flow they are not yet eligible to use. Users also cannot see the target portfolio's monitoring cycle or enabled products before creating the merchant. |
| Business impact | Migrating clients are blocked from onboarding a merchant into ongoing monitoring, delaying their move off legacy MerchantView. |
| Risk if unsolved | Clients stay on legacy MerchantView longer than planned, or use workarounds (e.g., bulk upload) for single-merchant adds. |
| Evidence | Current behavior verified in `marketview-portal`, `mlrc-bff-2.0`, `mlrc-merchant` ([discovery](../discovery/add-single-merchant-discovery.md) Assumptions). Legacy usage: 3,664 `add_merchant_solo` events from 108 unique users, 2026-04-30–2026-07-28 (EverC Mixpanel, customer-only totals TBD). |

## Goals

- Let a user add one merchant to ongoing monitoring only, without onboarding enrollment.
- Show the active portfolio's monitoring cycle and enabled products before merchant creation.
- Let the user choose between an immediate scan and the next scheduled monitoring cycle.
- Preserve existing validation, portfolio-eligibility blocking, and transactional save behavior.

## Assumptions

- Legal Name, Unique ID, and at least one Merchant URL are required; DBA, MID, and additional URLs (up to ten) are optional. Reused as-is, no new validation. [Needs no further validation.]
- Client Merchant Key (Unique ID) uniqueness is enforced at the customer-account level server-side (`409 Conflict` on duplicate); the UI currently checks only the active portfolio before submission. [Validation needed: confirm whether client-side pre-check should be extended before spec.]
- Inactive portfolios, or portfolios where the monitoring service/product is not enabled, block merchant creation with the existing message. Reused as-is.
- Merchant, portfolio assignment, and product assignment save in one transaction; a failed save persists nothing. Reused as-is.
- No configured product is currently confirmed to require beneficial-owner data at creation. [Validation needed, see Open Questions.]

## Target Personas

| Persona | Description |
| --- | --- |
| Monitoring/compliance operator (primary) | Adds one merchant to ongoing monitoring, needs to see the portfolio's configuration and decide on scan timing. |
| Portfolio manager / risk administrator (secondary) | Configures portfolio monitoring cycle and products under Portfolio Settings; consumes the outcome of this flow. |
| Support / audit (secondary) | Reviews created merchants and their monitoring state after the fact. |

## Scope

### In Scope - MVP

- Reuse of the existing **Add New Merchant** side panel, opened via **Add** above a specific portfolio's merchant list.
- Read-only display of the active portfolio's name, monitoring cycle, and enabled products at the top of the panel.
- Monitoring-only merchant creation: merchant + portfolio assignment + product assignment + monitoring activation, with no onboarding enrollment.
- Blocking merchant creation, with the existing message, when the active portfolio is inactive or does not have the monitoring product/service enabled.
- Required Legal Name, Client Merchant Key (Unique ID), and at least one Merchant URL with its MCC; optional DBA and MID; add/remove additional URLs, each with its own MCC (existing behavior plus ASSUMED per-URL MCC per Figma node 1555:53728, not previously specified in this PRD - flag for PM confirmation).
- Required-field, URL-format, and Client Merchant Key uniqueness validation (existing behavior).
- Step 2 (optional): up to 5 additional merchant locations (Name, Email, Address, Phone) and up to 5 principal details (name, email, phone, address, country/state/city/zip). ASSUMED in scope per Figma; all fields optional, filling more fields "fine-tunes scan results" per Figma copy. Not previously specified in this PRD - flag for PM confirmation.
- **Create merchant and scan now** and **Create merchant and scan later** actions.
- Scan now: creates the merchant, requests an immediate monitoring scan, and retains the merchant in the next scheduled cycle.
- Scan later: creates the merchant and waits for the next scheduled monitoring cycle.
- Confirmation of merchant, portfolio, monitoring cycle, and scan choice on success.
- A save-failure message with the reason; no merchant persisted on failure.
- The existing single-merchant-add API remains backward-compatible and offers the same monitoring-only functionality as the UI path (same validation, portfolio assignment, product assignment, monitoring activation, and no onboarding enrollment). ASSUMED: no breaking change to existing request/response contracts; needs confirmation at spec stage.

### Out of Scope

- Bulk merchant upload, editing, removal, or migration.
- Onboarding, Quick Insights, Web ID, or on-demand rescreening flows.
- New API endpoints or API contract changes beyond preserving existing backward compatibility.
- Selecting or changing the merchant's portfolio, or overriding products per merchant, in the side panel.
- Changing the monitoring cycle, or creating/activating/configuring portfolios, in the side panel.

## User Journeys

### Primary Journey

1. User clicks **Add** above a specific portfolio's merchant list.
2. The **Add New Merchant** side panel opens (Step 1), showing the active portfolio's name, monitoring cycle, and enabled products as read-only context.
3. User enters Legal Name, Client Merchant Key, at least one Merchant URL with its MCC, and optionally DBA, MID, and additional URLs (each with its own MCC).
4. System validates required fields, URL format, and Client Merchant Key uniqueness inline.
5. User clicks **Next**, advancing to Step 2 (Additional Merchant Details and Principal Details, all fields optional).
6. User optionally enters additional merchant locations (up to 5) and principal details (up to 5), or leaves Step 2 blank.
7. User selects **Create merchant and scan now** or **Create merchant and scan later**.
8. System creates the merchant, assigns it to the active portfolio, applies the portfolio's enabled products, and activates monitoring, without onboarding enrollment.
9. If **scan now** was chosen, system requests an immediate scan and retains the next scheduled scan; **scan later** leaves the merchant to the next scheduled cycle only.
10. System confirms the created merchant, its portfolio, monitoring cycle, and scan choice.

ASSUMED: Figma (node 1555:53728, "Add Merchants - 1 URL") shows this as a two-step panel (Step 1: Legal Name/Unique ID/DBA/MID/URL+MCC, "Next" button; Step 2: optional Additional Merchant Details + Principal Details, "Back"/"Done") and does not show the scan-now/scan-later choice on either screen. Taken as the current design not yet updated for this PRD's scan-choice requirement, since dropping scan choice would contradict this feature's core Problem Statement. Scan choice is kept as PRD intent, placed after Step 2 as the final submit action, pending design update. PM to confirm placement and that Step 2 fields (merchant locations, principal details) are in scope - not previously specified in this PRD.

`add-single-merchant-primary-journey` diagram: not embedded. The flow matches the existing Figma design ([link](https://www.figma.com/design/kxzxm9iEiCqzo2ewSKAoWA/Unified-Platform-2026?node-id=1555-53728&t=LFnhDf9xq6gA55XS-4)) and does not warrant a duplicate diagram at PRD stage.

## Acceptance Criteria

### AC-001: Create merchant and scan now (happy path)

**As a** monitoring operator
**I want to** add a merchant and trigger an immediate scan
**So that** the merchant is screened right away while staying on the normal monitoring schedule

```gherkin
Given the active portfolio is active and has the monitoring product/service enabled
And I have entered a valid Legal Name, a unique Client Merchant Key, and at least one valid Merchant URL
When I select "Create merchant and scan now"
Then the system creates the merchant, assigns it to the active portfolio, applies the portfolio's enabled products, and activates monitoring
And the system requests an immediate monitoring scan
And the merchant remains scheduled for the next monitoring cycle
And the system does not enroll the merchant in onboarding
And the system shows a confirmation with the merchant, portfolio, monitoring cycle, and scan choice
```

### AC-002: Create merchant and scan later (happy path)

**As a** monitoring operator
**I want to** add a merchant without triggering an immediate scan
**So that** it is screened on the normal monitoring schedule

```gherkin
Given the active portfolio is active and has the monitoring product/service enabled
And I have entered a valid Legal Name, a unique Client Merchant Key, and at least one valid Merchant URL
When I select "Create merchant and scan later"
Then the system creates the merchant, assigns it to the active portfolio, applies the portfolio's enabled products, and activates monitoring
And the system does not request an immediate scan
And the merchant is scheduled for the next monitoring cycle
And the system does not enroll the merchant in onboarding
And the system shows a confirmation with the merchant, portfolio, monitoring cycle, and scan choice
```

### AC-003: Portfolio ineligible for merchant creation (blocking)

**As a** monitoring operator
**I want to** be told when the active portfolio cannot accept a new merchant
**So that** I do not attempt an add that will fail

```gherkin
Given the active portfolio is inactive, or the monitoring product/service is not enabled in the portfolio
When I open the "Add New Merchant" side panel for that portfolio
Then the system blocks merchant creation
And shows the existing message that uploads and scans are unavailable until an admin enables at least one product in Settings
```

### AC-004: View portfolio configuration read-only (happy path)

**As a** monitoring operator
**I want to** see the active portfolio's services, products, and monitoring cadence before I add a merchant
**So that** I know what configuration the merchant will inherit

```gherkin
Given I have opened the "Add New Merchant" side panel for a portfolio
Then the system shows the portfolio's name, enabled services/products, and monitoring cadence at the top of the panel
And these fields are read-only and cannot be edited from the panel
```

### AC-005: Duplicate Client Merchant Key (unhappy flow)

**As a** monitoring operator
**I want to** be told when a Client Merchant Key is already in use
**So that** I do not accidentally attempt to duplicate an existing merchant

```gherkin
Given the entered Client Merchant Key already exists for another merchant in this customer account
When I submit the form with "Create merchant and scan now" or "Create merchant and scan later"
Then the backend rejects the request with a conflict
And the system shows an error that the Client Merchant Key is already in use
And the system does not create or update any merchant
```

### AC-006: Save failure (unhappy flow)

**As a** monitoring operator
**I want to** know when my merchant failed to save and why
**So that** I can retry or escalate without assuming the merchant exists

```gherkin
Given all entered data is valid and the portfolio is eligible
When the merchant, portfolio, and product assignment transaction fails during "Create merchant and scan now" or "Create merchant and scan later"
Then the system shows that the save failed and the reason
And no merchant, portfolio assignment, or product assignment is persisted
```

### AC-007: API backward compatibility (happy path)

**As an** integrating client using the existing single-merchant-add API
**I want to** keep using the API without breaking changes
**So that** my integration continues to work while gaining monitoring-only behavior

```gherkin
Given a client calls the existing single-merchant-add API with a valid request
When the request is processed
Then the API accepts the same request/response contract as before this change
And the merchant is assigned to the target portfolio, given its enabled products, and placed into monitoring
And the merchant is not enrolled in onboarding
```

## Permissions, Roles, and Visibility

| Action / Capability | Role | Access | Notes |
| --- | --- | --- | --- |
| Open "Add New Merchant" side panel from portfolio merchant list | Risk Analyst | Allowed | |
| Open "Add New Merchant" side panel from portfolio merchant list | Platform Admin | Allowed | |
| Open "Add New Merchant" side panel from portfolio merchant list | All other roles | Denied | |
| View portfolio monitoring cycle and enabled products in the panel | Risk Analyst, Platform Admin | Read-only | No separate visibility rule beyond panel access. |
| Change monitoring cycle or enabled products | Platform Admin (existing Portfolio Settings permission) | Allowed in Portfolio Settings only | Out of scope for this side panel; retained as-is. |

## UX and Product Behavior

| Area | Requirement |
| --- | --- |
| Entry point | **Add** action above a specific portfolio's merchant list, opening the existing side panel. |
| Main action | Two-step entry per Figma (node 1555:53728). Step 1: Legal Name, Unique ID, Merchant URL(s) with MCC per URL, optional DBA/MID, **Next**. Step 2: optional Additional Merchant Details (up to 5 locations) and Principal Details (up to 5 principals), then **Create merchant and scan now** / **Create merchant and scan later**. ASSUMED: scan-choice actions placed at end of Step 2; not shown in current Figma - see User Journeys note. |
| Empty state | N/A - form always renders with the active portfolio's read-only summary and empty input fields. |
| Error state | Field/URL-row-level validation errors on invalid or missing input; a top-level error with reason on save failure; a portfolio-block message when the portfolio is inactive or has no enabled products. |
| Success state | Confirmation showing the created merchant, its portfolio, monitoring cycle, and the scan choice made. |


## Data and Analytics

### Design

Figma: https://www.figma.com/design/kxzxm9iEiCqzo2ewSKAoWA/Unified-Platform-2026?node-id=1555-53728&t=LFnhDf9xq6gA55XS-4

### Current Data

#### Mixpanel

Legacy MerchantView tracked this flow as `add_merchant_solo` (single-add) and `add_merchant_solo_upload` (a related upload action, out of scope here). Usage is measurable but not yet resolved to customer-only totals or client names.

| Surface / Flow | Coverage | Usage (90-day) | Top Clients |
| --- | --- | --- | --- |
| Add Single Merchant (legacy `add_merchant_solo`) | 95 distinct `account_id` values in window; customer-only % TBD - Looker enrichment not run | 3,664 events, 108 unique users, all accounts (2026-04-30–2026-07-28) | TBD - Looker enrichment not run |

> _Source:_ EverC Mixpanel, `MerchantView Production` project `2040581`, workspace `187351`, 2026-04-30 to 2026-07-28. Figures include all accounts, not customer-only. [Saved report](https://mixpanel.com/project/2040581/view/187351/app/insights#Q4qonzFFak5m).

### Success Metrics

#### **Objective (OKR)**

> Unblock migrating clients from adding merchants to monitoring without onboarding, supporting migration off legacy MerchantView.
> _Note:_ Targets are initial estimates and will be recalibrated after 30 days of post-launch data.

#### **KPIs**

##### **Primary Metric: Successful monitoring-only merchant creations**
- **Baseline:** TBD - no direct equivalent tracked yet on Atlas.
- **Target:** TBD
- **Timeline:** TBD

##### **Secondary Metric: Scan-now selection rate**
- **Baseline:** N/A - new choice, no legacy equivalent.
- **Target:** TBD
- **Timeline:** TBD

##### **Guardrail Metric: Save-failure rate**
- **Baseline:** TBD - not currently isolated in legacy data.
- **Maximum Allowed:** TBD
- **Timeline:** Ongoing

### Required Events / Signals

| Event / Signal | Trigger | Key Properties | Purpose | Required for MVP |
| --- | --- | --- | --- | --- |
| Merchant add panel opened | User clicks Add above merchant list | portfolio_id, account_id | Measure funnel entry | Yes |
| Merchant creation submitted | User clicks either create action | portfolio_id, scan_choice (now/later), account_id | Measure completion and scan-choice split | Yes |
| Merchant creation blocked | Panel opens on ineligible portfolio | portfolio_id, block_reason | Measure portfolio-block rate | Yes |
| Merchant creation validation failed | Submit with invalid/missing/duplicate data | portfolio_id, error_type | Measure validation-failure rate | Yes |
| Merchant creation save failed | Transaction fails on submit | portfolio_id, failure_reason | Measure save-failure rate (guardrail) | Yes |

## Risks and Mitigations

| Risk | Why It Matters | Impact | Likelihood | Mitigation |
| --- | --- | --- | --- | --- |
| Client Merchant Key uniqueness only checked against the active portfolio client-side | User may not learn of a cross-portfolio duplicate until server rejection | M | M | Server-side `409 Conflict` already prevents bad data; confirm at spec stage whether to add a client-side account-wide pre-check. |
| Portfolio config changes mid-session (monitoring cycle or products) | Merchant could be created against stale previewed config if not refreshed | M | L | Resolve refresh-vs-preview behavior before spec (see Open Questions). |
| No product currently requires beneficial-owner data at creation, but this could change | A product added later may need data this form does not collect | L | L | Tracked as an open question; form to be extended when a product confirms the requirement. |

## Open Questions

| Question | Owner | Needed Before | Priority | Decision Type |
| --- | --- | --- | --- | --- |
| If portfolio monitoring cycle or enabled products change while the panel is open, should submission refresh and require review, or use the previewed config? | Adi Geva | Spec | M | Product |
| Which URL formats are accepted, and should a scheme-less URL (e.g. `www.example.com`) be normalized to `https://`? | Adi Geva | Spec | M | Product |
| Do any configured products require beneficial-owner data at creation? | Adi Geva | Spec | M | Product |

## Future Phases

| Phase | Purpose | Candidate Scope |
| --- | --- | --- |
| Phase 1 - MVP | Unblock monitoring-only single merchant add for migrating clients | Scope as defined above |
| Phase 2 - Fast Follow | Extend the same rules to other creation paths | API-based and bulk merchant creation reusing this validation and assignment logic |
| Phase 3 - Expansion | Support richer merchant data | Additional merchant, address, identifier, and beneficial-owner fields when required by configured products; failed-save retry path |
