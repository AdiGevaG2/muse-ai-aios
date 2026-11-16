# Reverse Engineering: Rule Builder Condition Limits

Scope: Business rule builder, source platforms MerchantView (MV) and Atlas, Quick run. Question: is this sales claim accurate? "The G2RS rule builder won't save a rule with only one condition (it requires at least two, and at least one must be 'is found')."

## Executive Summary

- MV: the claim is accurate. Both limits are enforced in the UI and on save in the backend.
- Atlas: the two-condition minimum is accurate. A new rule opens with two conditions, and the remove control is hidden at two.
- Atlas: the Atlas UI has no explicit "at least one 'is found'" check. A rule with all "is not found" conditions cannot be saved in practice, because every rule needs at least one action, and an action can target only a category from an "is found" condition.
- Atlas backend validation is not verified. It is unknown whether Atlas saves through the same backend validator as MV.

## Current Behavior by Platform

### MerchantView

- The rule form requires at least two conditions. The Save button stays disabled while the form is invalid. Source: `merchant-view-legacy-ec/merchantviewui/.../new-rule/new-rule.component.ts:49` (`Validators.minLength(2)`), `new-rule.component.html:10`.
- The form shows the rule text "At least one category with an 'is found' operator in the condition", and the condition block shows "A valid rule must contain at least one category with an 'is found' operator." Source: `new-rule.component.html:48`, `blocks/condition-block.component.html:5`.
- The backend rejects a save with fewer than two conditions: "Can not be less than 2 triggers in one rule." Source: `everc-global-services/global-ams-api/.../AugmentationRuleTriggerValidator.java:15,28,58`.
- The backend rejects a save where every category condition is "is not found": "A rule cannot be created with only 'is not found' operators. Please edit your rule so that it contains at least one 'is found' operator." Source: same file, lines 30, 87-89.
- Exception: the backend two-condition minimum does not apply to a rule that contains a nested group of conditions. Source: same file, lines 57-58. Whether the MV UI lets a user build a nested group is not verified.

### Atlas

- A new rule opens with two "is found" conditions. Source: `unified-platform-new/marketview-portal/.../NewBusinessRuleModal/NewBusinessRuleModal.tsx:56-59`.
- The remove control appears only when a rule has more than two conditions, and the remove action does nothing at two. A user cannot reduce a rule to one condition. Source: `NewBusinessRuleModal.tsx:258`, `NewBusinessRuleModalHelpers.tsx:95`.
- On save, the UI checks that every condition has a category selected. It does not check the "is found" count. Source: `NewBusinessRuleModalHelpers.tsx:53-58`.
- An action can target only a category used in an "is found" condition, and the number of actions cannot exceed the number of "is found" conditions. A rule keeps at least one action, and every action needs a category and severity before save. Source: `NewBusinessRuleModalHelpers.tsx:24-38, 63-66, 149`.

## Business Rules to Preserve

1. A rule has at least two conditions.
2. A rule has at least one "is found" condition.
3. A rule's action targets only a category from one of its "is found" conditions.
4. A rule has no more actions than "is found" conditions.
5. Every condition has a category; every action has a category and a severity.

## Target Platform: What Already Exists

Atlas enforces rules 1, 3, 4, and 5 in the UI. Rule 2 holds only as a side effect of rules 3 and 5.

## Gaps

- Atlas shows no message telling the user that a rule needs an "is found" condition. A user who sets every condition to "is not found" finds no category to pick for the action, with no explanation. MV shows this rule in the form.

## Conflicts / Product Decisions

- For the sales claim: the statement is accurate for MV and accurate in effect for Atlas. The wording "won't save" holds for both.

## Evidence Gaps

- Atlas backend: the save endpoint and its validator were not located. Whether Atlas save goes through `AugmentationRuleTriggerValidator` is Unknown.
- Nested condition groups: whether either UI lets a user build one, which would bypass the backend two-condition minimum, is Unknown.

Repos read (local, not pulled): `marketview-portal` develop @ 71e02efb (2026-10-25); `merchant-view-legacy-ec` master @ 0ea9af4 (2026-09-06); `everc-global-services` develop @ 24c5591 (2026-09-03).
