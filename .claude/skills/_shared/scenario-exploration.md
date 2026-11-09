# Scenario Exploration for Acceptance Criteria

Used by `/prd`, `/spec`, and `/mini-prd` before writing acceptance criteria.

Act as a Senior Product Manager and expert QA Engineer with strong product
thinking. The goal is to identify every meaningful scenario, use case, and edge
case for the feature and express them as testable Gherkin acceptance criteria.

Do not convert the provided requirements into scenarios one to one. Think beyond
the documented happy path. Challenge assumptions, explore different conditions,
and anticipate behaviors that Product or Development may have overlooked.

## Deep scenario exploration

For every feature, examine:

- **Happy paths:** all expected successful user flows.
- **Alternative paths:** different ways to reach the same outcome.
- **Edge cases:** unusual but realistic conditions, boundary values, empty
  states, and exceptional situations.
- **Negative scenarios:** invalid actions, missing information, conflicting
  inputs, and unmet prerequisites.
- **Roles and permissions:** different users, access levels, and unauthorized
  actions.
- **State transitions:** what happens before, during, and after an action,
  including repeated or reversed actions.
- **Data variations:** existing, missing, duplicate, outdated, partially
  completed, or conflicting records.
- **Timing and concurrency:** simultaneous actions, overlapping processes,
  delayed responses, and actions performed out of order.
- **Failures and recovery:** interrupted operations, API failures, partial
  success, retries, and refresh behavior.
- **Dependencies and side effects:** how an action affects other features,
  entities, workflows, and saved data.
- **UI behavior:** visibility, enabled/disabled actions, validation, loading,
  error messages, and user feedback.

## Mandatory second pass

After the first set of scenarios, review the feature again from a different
perspective. For every user action, business rule, and system event, ask:

- What happens if the action is performed twice?
- What happens if the action is interrupted?
- What happens if the underlying data changes?
- What happens if another user or an automated process acts at the same time?
- What happens if the entity is in a different state?
- What happens if a prerequisite becomes invalid?
- What happens if the operation succeeds partially?
- What happens to related entities and existing data?
- What combinations of conditions lead to different outcomes?
- What could developers implement incorrectly that the current scenarios would
  not catch?

Use boundary-value analysis, decision tables, and state-transition thinking to
find cases brainstorming misses. Continue until no significant, distinct
scenario remains uncovered.

## How this fits the workspace rules

- A scenario whose expected behavior is not decided is a product decision: it
  goes to Open Questions (or is asked, per `CLAUDE.md`), never written as an
  invented Then.
- Each distinct case the exploration finds gets its own scenario, in every
  document type, including a mini PRD.
- The Ten-Minute Stop still applies.
