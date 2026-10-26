# PRD: Add Merchant Flow - Enhancements

## Document Metadata

| Field | Value |
| --- | --- |
| Feature | Add Merchant Flow - Enhancements |
| Product Area | Atlas - Merchant Onboarding & Monitoring |
| Release | MVP (Phase 1) |
| Owner | Adi Geva |
| Status | Draft |
| Version | v1 |
| Date | 2026-09-10 |

## Executive Summary

Today, adding a merchant only happens from inside a specific portfolio the user has open, and there is one undifferentiated path that always enrolls the merchant in both onboarding and monitoring. This PRD sets the target vision for Add Merchant as an organization-level action: the user starts an add from anywhere in the org, chooses single or bulk, assigns a portfolio, then chooses onboarding or monitoring, with the available products/services scoped to what that portfolio has configured.

For onboarding, the user can remove individual services (e.g. CC, MCC) for that specific merchant without changing the portfolio's configuration for anyone else. For monitoring, the portfolio's configured services apply as-is with no per-merchant removal. After a scan completes, an approved merchant can be moved into monitoring, defaulting to the portfolio's own monitoring configuration if it has one, or otherwise prompting the user to choose a target portfolio. A portfolio-level setting can automate this approval-to-monitoring move entirely. Independent of any flow, users can manually move a merchant between portfolios at any time.

This PRD supersedes the entry point and scope of [Add Single Merchant v1](../../add-single-merchant/prd/add-single-merchant-prd.md), which scoped Add Merchant as portfolio-entry, monitoring-only. That PRD's field-level requirements (Legal Name, Client Merchant Key, Merchant URL validation, save-transaction behavior) are reused as-is inside this flow's onboarding/monitoring detail step; this document does not restate them and defers to that PRD for those mechanics until superseded explicitly.

MVP for this phase covers: org-level entry, single/bulk choice, portfolio assignment, onboarding-vs-monitoring choice scoped to portfolio products, per-merchant service removal in onboarding only, post-scan approval with move-to-monitoring offer, portfolio-level auto-enroll configuration, and manual cross-portfolio merchant move.

## Problem Statement

| Area | Description |
| --- | --- |
| Current gap | Add Merchant exists only inside a specific portfolio's screen, with one undifferentiated flow that enrolls a merchant in both onboarding and monitoring, and offers no path to add at organization level, choose bulk vs. single up front, or defer/limit which services run for a given merchant. |
| User pain points | Users who want to add a merchant to monitoring only, or who are not yet inside the right portfolio, cannot get there without extra navigation; users cannot skip individual services (e.g. an MCC or CC check that doesn't apply) for one merchant without affecting portfolio config; there is no assisted move to monitoring once a merchant is approved. |
| Business impact | Slower merchant onboarding, no self-serve path for migrating clients whose product mix varies per merchant, and manual/inconsistent handling of the onboarding-to-monitoring handoff. |
| Risk if unsolved | Clients rely on workarounds or manual back-office moves; onboarding-to-monitoring handoff stays inconsistent across clients; migration off legacy MerchantView stalls (see [platform.md](../../../domains/atlas/second-brain/context/platform.md)). |
| Evidence | PM direction (2026-09-10), this conversation. No dedicated Mixpanel event or brain feature note exists yet for org-level add or the approval-to-monitoring handoff, flagged as a grounding and evidence gap below. |

## Goals

- Let a user start Add Merchant from the organization level, not only from inside a specific portfolio.
- Let the user choose single or bulk add before choosing a portfolio.
- Let the user assign the merchant(s) to a portfolio as part of the add flow.
- Scope the onboarding-vs-monitoring choice, and the services shown, to what the chosen portfolio has configured.
- Let the user remove individual services in onboarding, scoped to that merchant only, without changing portfolio configuration.
- Do not allow service removal in monitoring; the portfolio's configured services always apply.
- After a scan, let the user approve or reject the merchant, and on approval offer to move it to monitoring with a portfolio pre-selected when the current portfolio has monitoring configured.
- Let a portfolio be configured to automatically move an approved merchant to monitoring without user action.
- Let a user manually move a merchant between portfolios at any time, independent of the onboarding/approval flow.

## Assumptions

- "Onboarding" and "monitoring" are distinct product/service modes a portfolio can have configured, matching [Add Single Merchant's](../../add-single-merchant/prd/add-single-merchant-prd.md) existing monitoring-only precedent. [Reused as established.]
- A portfolio can have onboarding only, monitoring only, both, or neither configured; when neither is configured for the chosen portfolio, merchant creation is blocked using the existing ineligible-portfolio message. [Reused from Add Single Merchant AC-003; needs confirmation this blocking message is portfolio-mode-aware, not monitoring-specific, at spec stage.]
- Field-level entry (Legal Name, Client Merchant Key, Merchant URL, DBA, MID, validation, and save-transaction behavior) is unchanged from Add Single Merchant and is reused inside this flow's detail step for both single and bulk. [Needs validation: whether bulk uses the same field set or a file-upload equivalent, see Open Questions.]
- Per-merchant onboarding service removal (e.g. CC, MCC) affects only that merchant's active onboarding run and does not persist as a portfolio-level or merchant-level default for future onboarding runs. [ASSUMED from "this will effect only the current merchant flow", needs confirmation at spec stage whether a repeat onboarding of the same merchant resets to full portfolio config or remembers the last removal.]
- "Automatic move to monitoring on approval" is a portfolio-level configuration (not per-merchant, not a global default). [Stated by PM.]
- When auto-move is on and the portfolio the merchant was onboarded to has no monitoring product configured, the system prompts the user to choose a target portfolio rather than silently failing or skipping the move. [Stated by PM for Phase 1.]
- Manual merchant-to-portfolio move is unconditional (available regardless of onboarding/monitoring state) but this PRD does not yet define whether moving a merchant re-applies the destination portfolio's services or preserves the merchant's currently active service set. [Open Question.]

## Target Personas

| Persona | Description |
| --- | --- |
| Onboarding / risk operator (primary) | Adds one or many merchants, decides portfolio, decides onboarding vs. monitoring, and tailors onboarding services per merchant. |
| Monitoring / compliance operator (primary) | Adds a merchant directly to monitoring, or approves an onboarded merchant and moves it into monitoring. |
| Portfolio manager / risk administrator (secondary) | Configures each portfolio's available products/services and the auto-move-to-monitoring setting. |
| Support / audit (secondary) | Reviews merchant portfolio history, including manual moves, after the fact. |

## Scope

### In Scope - MVP

- An **Add Merchant** entry point at organization level, not scoped to a specific portfolio screen.
- A single-vs-bulk choice as the first step of the flow.
- A portfolio-assignment step where the user selects the target portfolio for the merchant(s) being added.
- An onboarding-vs-monitoring choice, with the available option(s) determined by the products/services configured on the selected portfolio (e.g. a portfolio with only monitoring configured offers monitoring only).
- A services-preview step showing the services that will run for the merchant, sourced from the selected portfolio's configuration for the chosen mode.
- In onboarding mode only: the ability to remove individual services (e.g. CC, MCC) from the merchant's run, scoped to this merchant's current onboarding flow only, with no change to portfolio configuration or to other merchants.
- In monitoring mode: services shown read-only, matching Add Single Merchant's existing read-only display precedent; no removal.
- Post-scan approval: the user approves or rejects the scanned merchant.
- On approval: an offer to move the merchant to monitoring, with the target portfolio selector pre-selected to the current portfolio when that portfolio has a monitoring product configured, and otherwise a required portfolio choice.
- A portfolio-level configuration setting to automatically move an approved merchant to monitoring without user action.
- Phase 1 auto-move behavior: if the onboarding portfolio has monitoring configured, auto-move proceeds directly into it; if not, the user is prompted to choose a target portfolio (auto-move does not silently fail or skip).
- Manual merchant-to-portfolio move, available independent of onboarding/monitoring state or approval status.

### Out of Scope

- The detailed field set, validation rules, and save-transaction mechanics for merchant creation itself, reused from [Add Single Merchant](../../add-single-merchant/prd/add-single-merchant-prd.md) unless a gap is found at spec stage.
- Bulk file format, upload mechanics, and per-row bulk validation/error handling (flagged as an open question, not designed here).
- Scan mechanics, scan scheduling, and scan-result content themselves (reused from existing monitoring/onboarding scan behavior).
- Removing or overriding services at the portfolio-configuration level (that remains a Portfolio Settings capability, unchanged).
- Auto-move configuration for flows other than approval-to-monitoring (e.g. no auto-move out of monitoring, no auto-reject automation).
- Bulk approve/reject or bulk move-to-monitoring workflows (this PRD scopes approval and move-to-monitoring per merchant).
- Audit/history UI for portfolio moves (manual move is in scope; a dedicated history view is not).

## User Journeys

### Primary Journey - Single merchant, onboarding with service removal

1. User selects **Add Merchant** at the organization level (not scoped to any open portfolio).
2. User chooses **Single**.
3. User selects the target portfolio.
4. System shows onboarding and/or monitoring as available modes, based on the products configured on that portfolio; user selects **Onboarding**.
5. System shows the services that will run, sourced from the portfolio's onboarding configuration (e.g. CC, MCC).
6. User removes one or more services for this merchant only.
7. User completes merchant details (reused from Add Single Merchant) and submits.
8. System creates the merchant, assigns it to the selected portfolio, and runs onboarding with the merchant's adjusted service set; portfolio configuration and other merchants are unaffected.
9. Scan completes; user reviews the result and approves or rejects the merchant.
10. On approval, system offers to move the merchant to monitoring. If the onboarding portfolio has monitoring configured, that portfolio is pre-selected; otherwise the user must choose a target portfolio.
11. User confirms the move (or the system performs it automatically if the portfolio's auto-move setting is on); the merchant is now in monitoring under the chosen portfolio.

### Secondary Journey - Manual portfolio move

1. User locates a merchant in any portfolio, regardless of onboarding/monitoring state.
2. User initiates **Move to portfolio**.
3. User selects the destination portfolio.
4. System reassigns the merchant to the destination portfolio.

Diagram not embedded at PRD stage. This journey matches no existing Figma reference yet ([see Open Questions](#open-questions)); a draw.io journey diagram is deferred to spec stage once design evidence exists, to avoid duplicating a flow that will change once Figma is available.

## Acceptance Criteria

### AC-001: Start Add Merchant at organization level (happy path)

**As an** onboarding operator
**I want to** start adding a merchant from anywhere in the organization
**So that** I am not required to first navigate into a specific portfolio

```gherkin
Given I have permission to add merchants
When I select "Add Merchant" from the organization level
Then the system starts the add flow without requiring a portfolio to already be open
And the first step asks me to choose single or bulk
```

### AC-002: Choose single vs. bulk (happy path)

**As an** onboarding operator
**I want to** choose whether I'm adding one merchant or many
**So that** the flow matches the size of my task

```gherkin
Given I have started the Add Merchant flow
When I choose "Single" or "Bulk"
Then the system proceeds to portfolio assignment for that chosen mode
```

### AC-003: Portfolio assignment scopes available product mode (happy path)

**As an** onboarding operator
**I want to** see only the modes the selected portfolio supports
**So that** I cannot pick a mode the portfolio isn't configured for

```gherkin
Given I have selected a portfolio that has only monitoring configured
When I reach the onboarding-vs-monitoring step
Then the system offers "Monitoring" only, not "Onboarding"
```

### AC-004: Portfolio with neither product configured (blocking)

**As an** onboarding operator
**I want to** be told when a portfolio can't accept a new merchant
**So that** I don't proceed into a flow that will fail

```gherkin
Given I have selected a portfolio with no onboarding or monitoring product enabled
When I reach the onboarding-vs-monitoring step
Then the system blocks progress
And shows the existing ineligible-portfolio message
```

### AC-005: Remove a service in onboarding (happy path)

**As an** onboarding operator
**I want to** remove a service that doesn't apply to this merchant
**So that** onboarding only runs what's relevant, without changing portfolio settings

```gherkin
Given I am in the onboarding path for a single merchant
And the portfolio's onboarding configuration includes CC and MCC
When I remove MCC for this merchant
Then MCC does not run for this merchant's onboarding
And the portfolio's onboarding configuration still includes MCC for all other merchants
```

### AC-006: Services are read-only in monitoring (happy path)

**As a** monitoring operator
**I want to** see the services that will run in monitoring without being able to change them
**So that** monitoring stays consistent with the portfolio's configuration

```gherkin
Given I am in the monitoring path for a merchant
When I view the services step
Then the services shown match the portfolio's monitoring configuration exactly
And no service can be removed or added from this screen
```

### AC-007: Approve merchant, pre-selected monitoring portfolio (happy path)

**As an** onboarding operator
**I want to** move an approved merchant into monitoring with the right portfolio pre-selected
**So that** I don't have to look up which portfolio to use when it's already obvious

```gherkin
Given a merchant was onboarded to a portfolio that has monitoring configured
And the scan has completed
When I approve the merchant
Then the system offers to move the merchant to monitoring
And the onboarding portfolio is pre-selected as the monitoring destination
```

### AC-008: Approve merchant, no monitoring on current portfolio (happy path)

**As an** onboarding operator
**I want to** be asked which portfolio to use for monitoring when the current one doesn't support it
**So that** the merchant isn't left without a valid monitoring destination

```gherkin
Given a merchant was onboarded to a portfolio that has no monitoring product configured
And the scan has completed
When I approve the merchant
Then the system offers to move the merchant to monitoring
And requires me to choose a target portfolio with no pre-selection
```

### AC-009: Reject merchant (unhappy path)

**As an** onboarding operator
**I want to** reject a merchant after scan review
**So that** it does not proceed to monitoring

```gherkin
Given a merchant's onboarding scan has completed
When I reject the merchant
Then the system does not offer a move to monitoring
And the merchant's status reflects rejection
```

### AC-010: Auto-move on approval, monitoring available (happy path)

**As a** portfolio manager
**I want to** configure automatic move-to-monitoring on approval
**So that** operators don't have to take a manual step for the common case

```gherkin
Given the portfolio's auto-move-to-monitoring setting is enabled
And the merchant was onboarded to a portfolio with monitoring configured
When the operator approves the merchant
Then the system moves the merchant into that portfolio's monitoring automatically
And no manual portfolio selection is required
```

### AC-011: Auto-move on approval, no monitoring configured (unhappy flow)

**As a** portfolio manager
**I want to** be sure auto-move doesn't silently fail
**So that** approved merchants are never lost between onboarding and monitoring

```gherkin
Given the portfolio's auto-move-to-monitoring setting is enabled
And the onboarding portfolio has no monitoring product configured
When the operator approves the merchant
Then the system does not silently skip the move
And prompts the operator to choose a target portfolio for monitoring
```

### AC-012: Manual merchant move between portfolios (happy path)

**As an** operator
**I want to** move a merchant to a different portfolio at any time
**So that** I can correct or update portfolio assignment independent of the onboarding/monitoring flow

```gherkin
Given a merchant exists in any portfolio, in any onboarding/monitoring state
When I select "Move to portfolio" and choose a destination portfolio
Then the system reassigns the merchant to the destination portfolio
And this action is available regardless of the merchant's current onboarding or monitoring status
```

## Permissions, Roles, and Visibility

| Action / Capability | Role | Access | Notes |
| --- | --- | --- | --- |
| Start Add Merchant at organization level | Risk Analyst, Platform Admin | Allowed | Reused from Add Single Merchant's existing panel-access roles; needs confirmation this holds at org-level entry. |
| Start Add Merchant at organization level | All other roles | Denied | |
| Remove a service in onboarding | Risk Analyst, Platform Admin | Allowed | TBD whether removal requires a distinct permission from add itself. |
| Approve / reject merchant post-scan | TBD | TBD | Not established in evidence, flagged as Open Question. |
| Configure portfolio auto-move-to-monitoring setting | Platform Admin | Allowed | Consistent with existing Portfolio Settings ownership in Add Single Merchant. |
| Manually move a merchant between portfolios | TBD | TBD | Not established in evidence, flagged as Open Question. |

## UX and Product Behavior

| Area | Requirement |
| --- | --- |
| Entry point | "Add Merchant" action available at organization level, independent of any specific portfolio screen. |
| Main action | Multi-step flow: single/bulk → portfolio → onboarding/monitoring (scoped to portfolio config) → services preview (editable in onboarding, read-only in monitoring) → merchant detail entry → submit. |
| Empty state | A portfolio with no onboarding or monitoring product configured blocks progress with the existing ineligible-portfolio message. |
| Error state | Existing field/save validation reused from Add Single Merchant; a blocked auto-move (no monitoring on current portfolio) surfaces a required portfolio-choice prompt rather than a silent failure. |
| Success state | Confirmation of merchant creation, portfolio, and mode (onboarding/monitoring); on approval, confirmation of the monitoring move and destination portfolio. |
| Notifications / communication | TBD - whether approval, auto-move, or manual-move actions notify anyone besides the acting user. |
| Accessibility / usability | N/A - no accessibility requirement identified beyond existing platform standards. |

## Data and Analytics

### Current Data

#### Mixpanel

No dedicated event exists yet for organization-level add entry, bulk-vs-single choice, per-merchant service removal, approval, or auto-move. The closest legacy proxies are `add_merchant_solo` and `add_merchant_solo_upload` (see [Add Single Merchant PRD](../../add-single-merchant/prd/add-single-merchant-prd.md)), which do not distinguish these new steps.

| Surface / Flow | Coverage | Usage (90-day) | Top Clients |
| --- | --- | --- | --- |
| Org-level Add Merchant (new) | N/A - not yet instrumented | N/A - not yet instrumented | N/A |
| Legacy proxy: `add_merchant_solo` | 95 distinct `account_id` values in window; customer-only % TBD | 3,664 events, 108 unique users (2026-04-30–2026-07-28) | TBD - Looker enrichment not run |

> _Source:_ EverC Mixpanel, `MerchantView Production` project `2040581`, same window cited in Add Single Merchant PRD. Figures include all accounts, not customer-only.

### Success Metrics

#### **Objective (OKR)**

> Give onboarding and monitoring operators one org-level flow to add merchants with portfolio- and mode-appropriate services, and a reliable handoff from onboarding approval into monitoring, supporting migration off legacy MerchantView.
> _Note:_ Targets are initial estimates and will be recalibrated after 30 days of post-launch data.

#### **KPIs**

##### **Primary Metric: Successful merchant adds via org-level entry**
- **Baseline:** N/A - new entry point, no legacy equivalent.
- **Target:** TBD
- **Timeline:** TBD

##### **Secondary Metric: Approval-to-monitoring conversion rate**
- **Baseline:** TBD - not currently isolated in legacy data.
- **Target:** TBD
- **Timeline:** TBD

##### **Guardrail Metric: Auto-move failure/prompt-fallback rate**
- **Baseline:** N/A - new capability.
- **Maximum Allowed:** TBD
- **Timeline:** Ongoing

### Required Events / Signals

| Event / Signal | Trigger | Key Properties | Purpose | Required for MVP |
| --- | --- | --- | --- | --- |
| Add Merchant started (org level) | User opens org-level Add Merchant | account_id, mode (single/bulk) | Measure entry-point adoption | Yes |
| Portfolio and mode selected | User selects portfolio and onboarding/monitoring | portfolio_id, mode | Measure mode split per portfolio | Yes |
| Onboarding service removed | User removes a service in onboarding | portfolio_id, merchant_id, service_removed | Measure per-merchant customization frequency | Yes |
| Merchant approved / rejected | User submits approval decision | portfolio_id, merchant_id, decision | Measure approval rate | Yes |
| Moved to monitoring | Manual or automatic move completes | portfolio_id (from/to), merchant_id, trigger (manual/auto) | Measure handoff completion and auto-move usage | Yes |
| Auto-move fallback prompt shown | Auto-move enabled but no monitoring on current portfolio | portfolio_id, merchant_id | Measure guardrail/fallback rate | Yes |
| Manual portfolio move | User moves a merchant between portfolios outside onboarding flow | merchant_id, from_portfolio_id, to_portfolio_id | Measure manual-move usage | Yes |

## Risks and Mitigations

| Risk | Why It Matters | Impact | Likelihood | Mitigation |
| --- | --- | --- | --- | --- |
| Per-merchant onboarding service removal state (persisted vs. one-time) is unconfirmed | Could cause unexpected behavior on re-onboarding the same merchant | M | M | Confirm persistence model at spec stage (see Open Questions). |
| Approval and manual-move permissions are undefined | Could ship without correct role gating, risking unauthorized portfolio reassignment | M | M | Resolve roles before spec sign-off. |
| Auto-move-to-monitoring could silently drop merchants if not implemented per AC-011 | Approved merchants could be lost between onboarding and monitoring with no operator visibility | H | L | AC-011 requires an explicit fallback prompt; enforce in spec and test plan. |
| No Figma evidence yet for this flow | Spec and UX detail may diverge from what's technically buildable without a design pass | M | M | Route to Figma/design before spec, or flag spec as provisional pending design. |
| This PRD supersedes Add Single Merchant's narrower scope | Risk of contradicting an existing Draft PRD if both are treated as independently authoritative | M | L | Add Single Merchant's field/validation/save mechanics are explicitly reused, not contradicted; its entry point and mode exclusivity are explicitly superseded here. |

## Open Questions

| Question | Owner | Needed Before | Priority | Decision Type |
| --- | --- | --- | --- | --- |
| Does per-merchant onboarding service removal persist for future onboarding runs of the same merchant, or reset to full portfolio config each time? | Adi Geva | Spec | M | Product |
| What roles may approve/reject a scanned merchant, and what roles may manually move a merchant between portfolios? | Adi Geva | Spec | H | Product |
| Does a manual portfolio move re-apply the destination portfolio's services, or preserve the merchant's current active service set? | Adi Geva | Spec | M | Product |
| What is the bulk-add mechanism (file upload format, per-row validation/error handling)? | Adi Geva | Spec | M | Product |
| Should Add Single Merchant v1 be retired/merged into this PRD's scope, or remain a standalone entry-point-specific document? | Adi Geva | Spec | M | Product |
| Is there Figma design evidence for this org-level flow, or does design work start from this PRD? | Adi Geva | Spec | M | Design |

## Future Phases

| Phase | Purpose | Candidate Scope |
| --- | --- | --- |
| Phase 1 - MVP | Org-level entry, single/bulk choice, portfolio assignment, mode-scoped services, per-merchant onboarding service removal, approval-to-monitoring handoff (manual + auto-move with fallback), manual portfolio move | Scope as defined above |
| Phase 2 - Fast Follow | Bulk approve/reject and bulk move-to-monitoring; richer bulk-add validation and error reporting | Extend approval and move actions to operate on multiple merchants at once |
| Phase 3 - Expansion | Auto-move automation beyond approval-to-monitoring (e.g. scheduled re-review, auto-reject rules); portfolio-move audit history view | Broader automation and traceability once Phase 1/2 usage data exists |
