# Add Single Merchant - Mini PRD

**TL;DR:** 
Support merchant creation for Monitoring-only clients that are not using Onboarding.

<br>

## Problem and Goal

Adding a merchant today automatically enrolls it in Onboarding.
For Monitoring-only clients, merchants should be added directly to Monitoring without going through Onboarding.

Goal: Create the merchant directly in the active portfolio and start monitoring immediately, with no Onboarding step.

<br>

## Feature Behavior

**Prerequisite:** The active portfolio is monitoring-only.

1. User clicks **Merchant Management** on a portfolio's merchant list, opening a menu with **Add Single Merchant** and **Add Bulk**.
2. User selects **Add Single Merchant**.
3. The "Add New Merchant" side panel opens, showing the active portfolio's name, monitoring cycle, and enabled products (read-only).
4. User enters Legal Name, a unique Client Merchant Key, and at least one Merchant URL. DBA, MID, and additional URLs are optional.
5. User clicks **Create merchant**.
6. System creates the merchant under the active portfolio, applies its enabled products, and queues it for monitoring. No immediate scan is triggered and no onboarding enrollment occurs.
7. Confirmation shows the merchant, portfolio, and monitoring cycle.

**Queued for monitoring, not onboarding**
- There is no "scan now" option. The merchant is queued and picked up on the next scheduled monitoring cycle only.
- Critical: that first cycle the merchant is picked up in is a **monitoring** cycle, not an onboarding cycle. The merchant must never pass through onboarding at any point, including its first scan.

**Errors**
1. Portfolio is inactive or has no Monitoring product enabled: Creation is blocked and the existing "enable a product in Settings" message is shown.
2. Client Merchant Key already exists on the account: The backend returns a conflict; a "key in use" error is shown and nothing is persisted.
3. Save fails: The failure reason is shown and nothing is persisted. The merchant, portfolio, and product transaction is all-or-nothing.


**Permissions**
- Risk Analyst, Risk Manager, Org Admin can open the panel and create a merchant. All other roles are denied.

**API**
- The existing single-merchant-add API remains backward-compatible and supports the same Monitoring-only functionality as the UI: validation, portfolio assignment, product assignment, queuing for the next monitoring cycle (no immediate scan), and no Onboarding enrollment.
- Assumption: No breaking change to the existing request/response contracts. Confirm during spec.

<br>

## Design

Figma: https://www.figma.com/design/kxzxm9iEiCqzo2ewSKAoWA/Unified-Platform-2026?node-id=1555-53728&t=LFnhDf9xq6gA55XS-4

<br>

## Acceptance Criteria

**Scenario: Create merchant and queue for monitoring**
- Given the active portfolio is eligible
- And the panel shows the portfolio's name, monitoring cycle, and enabled products read-only
- And I've entered valid merchant details
- When I click "Create merchant"
- Then the merchant is created, assigned to the portfolio with its products, and queued for monitoring, with no immediate scan triggered and no onboarding enrollment, and a confirmation is shown

**Scenario: First cycle is monitoring, not onboarding**
- Given a merchant was just created under a Monitoring-only portfolio
- When the next scheduled cycle runs and picks up this merchant
- Then that cycle executes as a monitoring cycle for this merchant, and the merchant is never enrolled in or passed through onboarding at any point

**Scenario: Portfolio ineligible**
- Given the active portfolio is inactive or has no monitoring product enabled
- When I open the "Add New Merchant" panel for the active portfolio
- Then creation is blocked and the existing "enable a product in Settings" message is shown

**Scenario: Duplicate Client Merchant Key**
- Given the entered Client Merchant Key already exists on this account
- When I submit the form
- Then a conflict error is shown and nothing is created

**Scenario: Save failure**
- Given all entered data is valid and the portfolio is eligible
- When the merchant/portfolio/product transaction fails on submit
- Then the failure reason is shown and nothing is created or assigned

**Scenario: Restricted role**
- Given I do not have the Risk Analyst, Risk Manager, or Org Admin role
- When I attempt to open the "Add New Merchant" panel
- Then I cannot open it

**Scenario: API backward compatibility**
- Given a client calls the existing single-merchant-add API with a valid request
- When the request is processed
- Then the API accepts the same request/response contract as before
   And the merchant is assigned to the portfolio and queued for monitoring, with no immediate scan and no onboarding enrollment

<br>

## Open Questions / Assumptions

- ASSUMED: Client-side pre-check for Client Merchant Key uniqueness stays scoped to the active portfolio only; server enforces account-wide uniqueness via `409 Conflict`.


See [full PRD](add-single-merchant-prd.md) for personas, metrics, and rationale.
