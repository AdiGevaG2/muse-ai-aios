# {Feature Name} — Mini PRD

**TL;DR:**
[One line: what's being built and why.]

<br>

## Definitions

- **[Term]**: [plain-language definition, as a bulleted term-then-explanation pair — not a flowing paragraph].
- [One bullet per term or phrase a reader needs pinned down before reading further, e.g. domain nouns, product names, or a term this doc uses in a specific sense.]

<br>

## Problem and Goal

[1-2 sentences: what's broken/missing.]

Goal: [1 sentence: what success looks like.]

**Why we need it:** [1 sentence: the problem this solves for the business.]

**Value for the client:** [1 sentence: what the client's user can do or see that they cannot today.]

**Why now:** [1 sentence: the trigger, such as a client requirement, migration, or deadline. Omit only if no trigger is known, and say so in Open Questions.]

<br>

## Prototype

[Open prototype]([hosted link])

**1. [Screen and state]**

![1. Screen and state](../prototype/screenshots/01-[screen].png)

[One captioned screenshot per screen, in flow order, left-aligned under its numbered caption. Omit this section if the feature has no prototype. See `.claude/skills/_shared/prototype-screenshots.md`.]

<br>

## Feature Behavior

### Prerequisites

- [Condition that must hold before the flow starts. Write "None" if nothing gates the flow.]

### Requirements

1. [Numbered happy-path steps, one action per step, ending in the outcome and confirmation.]

**[Named sub-choice, if the flow branches — e.g. "Option A vs. option B"]**
- [Option]: [what it does].
- [Option]: [what it does].

**Empty state** (omit this sub-block if there's nothing to specify)
- [expected behavior]

**Errors**
1. [Condition]: [result].
2. [Condition]: [result].

**Permissions** (if relevant)
- [Role]: [access].

**API** (if relevant)
- [Backward-compatibility or contract requirement, stated as a fact.]
- Assumption: [anything unverified about the contract] — confirm during spec.

<br>

Figma: [link] (omit this line if no design exists for this feature)
<br>

## Acceptance Criteria

**Scenario: [name]**
- Given [precondition]
- And [additional precondition, if needed]
- When [action]
- Then [observable, testable result]

[One scenario per distinct behavior. Fold a precondition or read-only check into an existing scenario's Given/And rather than writing a separate scenario for it.]

<br>

## Data

**Baseline**
- [Current-state figure]: [value], [date range]. Source: [tool, project or report].
- [Figure not yet pulled]: TBD. [Why, and which source holds it.]

**Success measure**
- [One or two signals that show the feature worked after launch, and what each is compared against.]
- [Tracking the measure needs that does not exist today.]

**Recorded data**
- [Values the feature stores, and where each comes from.]

<br>

## Open Questions / Assumptions

- ASSUMED: [assumption] — or omit this section entirely if none.
