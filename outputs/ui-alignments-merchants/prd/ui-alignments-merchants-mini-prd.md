# UI Alignments: Merchants, Mini PRD

**TL;DR:**
Nine UI alignment fixes to the Merchants list and merchant scan detail view, bringing both to the current design system.

<br>

## Definitions

- **Merchants list**: the table of merchants currently labeled "Portfolio," listing each merchant with its risk level, categories, and review status.
- **Review Status**: the per-merchant field showing where a merchant sits in the review workflow, for example Approved, To Review, Rejected, or In Progress.
- **Monitoring**: the ongoing automated scanning of a merchant's site for risk indicators after onboarding.
- **More filter group**: a collapsed filter menu that holds secondary filters not shown in the primary filter bar.

<br>

## Problem and Goal

The Merchants list and merchant scan detail view use outdated labeling, controls, and visual states that do not match the current design system: a leftover "Portfolio" header, a non-standard active-filter treatment, an interactive Review Status control where a static one belongs, a misplaced evidence icon, icon-only reset and add controls, and a monitoring-stopped state that reads as disabled rather than inactive.

Goal: Bring the Merchants list and merchant scan detail view into alignment with the current design system across these nine points.

<br>

## Feature Behavior

### Prerequisites

- None

### Requirements

**1. Header rename**
The page header reading "Portfolio" is renamed to "Merchants," matching the app navigation label shown elsewhere in the product.

**2. Active filter highlighting**
Each filter control that has a non-default value selected shows a highlighted container: a distinct background and border color from the default, unselected state. A filter with no selection, or set to its default value, shows the default container styling. The highlight clears immediately when the filter is reset to default.

**3. Filter overflow into "More"**
The Monitoring status and Creation date filters move out of the primary filter bar and into a "More" filter group. The primary filter bar keeps its remaining filters in place. Opening "More" shows Monitoring status and Creation date as filter controls, each behaving as it does today.

**4. Review Status: view-only display**
The Review Status column changes from a dropdown control to a view-only status display. It no longer opens on click and offers no option list. It continues to show the merchant's current review status value, styled as a status indicator rather than an interactive control.

**5. Evidence icon alignment in scan merchant details**
In the scan merchant detail view, the evidence icon moves to align left, positioned next to the snooze and comments icons, matching their row alignment and spacing.

**6. Clear filters: icon to text**
The icon-only reset-filters control is replaced with a text control reading "Clear all." It performs the same action as the current reset icon: clearing all active filter selections back to default.

**7. Manage Merchants button cleanup**
The "Manage Merchants" button removes its leading "+" icon, keeping only the button label. The button's drop shadow is removed, leaving a flat button style.

**8. Monitoring-stopped merchants: no grey-out**
A merchant row no longer renders in a greyed-out, reduced-opacity style when Monitoring is stopped for that merchant. The row renders with the same text and background treatment as a merchant with Monitoring active; only the Monitoring indicator in item 9 differs.

**9. Monitoring indicator icon**
A Monitoring icon displays next to any merchant currently under Monitoring, placed in the merchant row. A merchant not under Monitoring does not show this icon.

<br>

## Acceptance Criteria

**Scenario: Header shows Merchants**
- Given a user navigates to the merchant list page
- Then the page header reads "Merchants," not "Portfolio."

**Scenario: Active filter is highlighted**
- Given the merchant list filter bar
- When a user selects a non-default value on a filter
- Then that filter's container shows the highlighted background and border
- And a filter left at its default value shows no highlight.

**Scenario: Highlight clears on reset**
- Given a filter currently showing the active-highlight style
- When the user resets that filter to its default value
- Then the highlight is removed from that filter's container.

**Scenario: Monitoring status and Creation date are under More**
- Given the merchant list filter bar
- Then Monitoring status and Creation date do not appear in the primary filter bar
- And both appear as filter options when the user opens "More."

**Scenario: Review Status is view-only**
- Given the merchant list table
- When a user clicks a merchant's Review Status value
- Then no dropdown or option list opens
- And the Review Status value continues to display the merchant's current status.

**Scenario: Evidence icon aligned with snooze and comments**
- Given the scan merchant detail view for a merchant with evidence, snooze, and comments available
- Then the evidence icon is positioned to the left, in line with the snooze and comments icons.

**Scenario: Clear all replaces reset icon**
- Given the merchant list filter bar with one or more active filters
- When the user selects "Clear all"
- Then all active filters are reset to their default values
- And no icon-only reset control is present, only the "Clear all" text control.

**Scenario: Manage Merchants button has no icon or shadow**
- Given the merchant list page
- Then the "Manage Merchants" button displays its label with no leading "+" icon
- And the button has no drop shadow.

**Scenario: Monitoring-stopped merchant row renders at full opacity**
- Given a merchant with Monitoring stopped
- Then that merchant's row renders with the same text and background styling as a row for a merchant with Monitoring active.

**Scenario: Monitoring icon shown for monitored merchants**
- Given a merchant with Monitoring active
- Then a monitoring icon displays next to that merchant in the list.
- Given a merchant with Monitoring stopped
- Then no monitoring icon displays next to that merchant.

<br>

## Open Questions / Assumptions

- ASSUMED: "Clear all" resets every active filter across both the primary bar and the "More" group in one action, not only the primary bar. Confirm during implementation.
- ASSUMED: The monitoring icon's visual design, icon choice and color, follows the design system's existing icon set. No specific icon was supplied; confirm the icon asset before build.
- ASSUMED: Review Status values and their color coding (Approved, To Review, Rejected, In Progress) stay unchanged — only the control type changes from dropdown to static display.
- No Figma link was supplied for this change set; behavior is derived from PM screenshots and written description only.
