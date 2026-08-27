---
name: spec
description: Write or amend the feature spec from the PRD and relevant design/code evidence. Use when the user says "write the spec", "draft the build behavior", "reconcile with Figma", or "check spec vs design". Surfaces mismatches for PM arbitration.
---

# Spec + Figma Reconcile

Write the build-behavior spec from the PRD. Reconcile against Figma or code only
when the feature README or user routes you there.

## Before you start
- Confirm active domain and feature name.
- Follow `../../../outputs/README.md`. If the feature workspace does not exist,
   initialize `outputs/<feature-name>/README.md`; otherwise read its README
   first.
- Read the PRD path routed by the README; default for new features is
   `prd/<feature-name>-prd.md`.
- Read only relevant design, context, or source evidence.
- Do not load org/domain brains wholesale.

## Steps
1. **Write the spec** using `references/spec-template.md` for shape. Stamp the
   PRD version/source. Mark unresolved requirements inline with
   `[NEEDS CLARIFICATION: ...]` rather than guessing.
2. **Clarify.** Run `references/clarify-checklist.md` against the draft: scan
   PM-owned categories (functional scope, domain concepts, UX flow, edge cases,
   business rules, terminology, completion signals, analytics coverage), ask up
   to 5 targeted questions prioritized by impact, and encode answers directly
   into the spec (resolve the `[NEEDS CLARIFICATION: ...]` markers). This step
   is never skipped, even in Quick mode — an unresolved ambiguity here becomes
   a wrong artifact, not a formatting gap. Engineering-only categories
   (performance/scale targets, hosting, language/storage) are explicitly out of
   scope — those belong to the target repo's own technical planning, not this
   spec.
3. **Fill the AI Behavior Contract when the feature has AI behavior** — any
   model, score, ranking, generation, classification, or extraction, including
   one another team owns. Load `references/spec-ai-contract.md` for it. Every
   threshold is a number or a `[NEEDS CLARIFICATION: ...]` marker; "high
   confidence" is not a specification. Trace the accuracy bar to the PRD rather
   than inventing it, and hand the eval design to `/ai-eval` — this skill
   specifies behavior, it does not decide whether the model is good enough.
   Delete the section outright for deterministic features.
4. **Reconcile when routed** — compare against Figma or code only when the user
   asks or the README routes there. Delegate to `spec-reconciler` for large or
   high-stakes Figma comparison. It does not decide which side is right.
5. **You arbitrate.** For each mismatch, the user decides: fix the spec, or fix
   the Figma. Neither is automatically ground truth.
6. **Route requirement changes through the PRD.** Cosmetic/design-only fixes can
   update Figma or the spec directly.

## Scope boundary (stop here, do not draft plan.md/tasks.md)
This skill produces `spec.md` only — the dev-handoff artifact. It deliberately
does not draft an implementation plan or task breakdown; the target repo's own
engineering-owned tooling (its own SpecKit `/plan`, `/tasks`, or equivalent)
starts fresh from this spec. Do not draft technical context, architecture, or
task lists here even in outline form — that authority belongs to engineering,
not to this skill.

## Output
Default for new features:
`outputs/<feature-name>/spec/<feature-name>-spec.md`.
If reconciliation happens, write the routed validation artifact or a concise
reconcile section. For historical features, follow the README.

## Folder resources (read these)
- `references/spec-template.md` — the spec template to fill (see Step 1).
- `references/spec-ai-contract.md` — the AI section (see Step 3); load only
  for AI features.
- `references/clarify-checklist.md` — the clarify pass to run (see Step 2).
- `references/figma-deltas-template.md` — structure for `reconcile-notes.md`
  (see Step 4).
- `../../../domains/<domain>/INDEX.md` — routes domain context.
- `../../../domains/<domain>/config.json` — tool IDs and approval defaults.
- `corrections/` — skill-specific corrections; apply them every run.

## Run mode (standalone)
If invoked directly, ask **Quick one-off** or **Strict**. Follow
`../_shared/run-mode.md`. High-stakes gaps still stop.

## Evidence on completion
Do not just claim done. Show the artifact: the file path written, the actual
query result / figures, the diff, or the mismatch/gap list — whatever this stage
produced. Reviewing the evidence must be faster than re-doing the check. This
catches silent failures (a stage that "ran" but produced nothing usable).
