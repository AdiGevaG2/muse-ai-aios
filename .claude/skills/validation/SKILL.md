---
name: validation
description: Validate implementation, Figma, tests, or release evidence against the approved feature spec. Use when the user says "validate", "check acceptance", "verify implementation", "compare build to spec", or asks whether a feature is ready.
---

# Validation

Validate evidence against the approved spec. This is acceptance validation, not
user research feedback collection.

**Scope boundary:** this checks whether the build matches the spec. It does not
judge whether AI output is good enough — that is `/ai-eval`, against the
accuracy bar in `ai-eval.md`. The two fail independently. If the feature has AI
behavior, validate the deterministic contract here (thresholds enforced,
fallbacks fire, overrides work, invariants hold) and report model quality as
`Not checked - see ai-eval` rather than eyeballing a few outputs and calling it
a Pass. A handful of good-looking samples is not an eval.

## Before you start
- Confirm active domain and feature name.
- Follow `../../../outputs/README.md`. If the feature workspace does not exist,
  initialize `outputs/<feature-name>/README.md`; otherwise read its README
  first.
- Read the spec path routed by the README; default for new features is
  `spec/<feature-name>-spec.md`.
- Read implementation/test/Figma evidence only as needed for the validation
  question.
- Do not load org/domain brains wholesale.

## Process
1. Identify the spec version and acceptance criteria in scope.
2. Map evidence to AC IDs or behavior IDs.
3. Run or read the narrowest relevant checks: tests, screenshots, source paths,
   Figma frames, logs, or manual QA notes.
4. Classify each item: `Pass`, `Fail`, `Blocked`, or `Not checked`.
5. For failures, state the exact mismatch and owner: product/spec, design,
   implementation, data, model quality, or unknown.
6. For AI features, confirm the deterministic contract holds: every confidence
   band routes as specified, malformed output falls back rather than surfacing,
   human override takes precedence as written, and no invariant is violated.
   Route the accuracy question to `/ai-eval`.

## Two artifacts, two questions
This skill covers both; they fail independently, so keep them separate.

- **Acceptance validation** (`validation.md`) — does the built feature pass its
  acceptance criteria? Evidence mapped to `AC-###`, each marked `Pass`, `Fail`,
  `Blocked`, or `Not checked`. This is the default output.
- **Alignment report** (`alignment-report.md`) — do the downstream artifacts
  still match the spec after it changed? Fill
  `references/alignment-report-template.md`. Produce this when the spec has
  moved, when a PRD change was propagated, or before an external handoff — not
  on every run.

An artifact set can be perfectly aligned around a spec the build does not meet,
and a build can pass every AC while Confluence and Jira describe an older spec.
Do not let one verdict stand in for the other.

## Output
Default for new features:
- `outputs/<feature-name>/validation/<feature-name>-validation.md` — acceptance
  results.
- `outputs/<feature-name>/validation/<feature-name>-alignment-report.md` — only
  when a drift check was actually run.

For historical features, follow the README. If no durable artifact is needed,
return a concise validation summary in chat.

## Stop Conditions
- Stop on product ambiguity and ask the PM.
- Stop on external writes unless explicitly approved.
- Do not rewrite PRD or spec during validation; propose amendments instead.
- Do not declare an AI feature ready on spec conformance alone when no eval has
  cleared its bar. Report it as blocked on `/ai-eval`.

## Folder resources
- `references/alignment-report-template.md` — the drift-check template.
- `corrections/` — skill-specific corrections; apply them every run.

## Evidence
Show the evidence reviewed: command output summary, source paths, test names,
screenshots/Figma references, or artifact paths. Mark anything not checked.