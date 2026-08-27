# Historical Features - Unified Platform

New feature work is initialized under `outputs/<feature-name>/` using
`outputs/README.md`. This directory retains existing feature work; each feature
README remains its daily entry point and context router.

## Historical Layout
```text
<feature-name>/
├── README.md
├── discovery.md      # created only when discovery happens
├── prd.md            # created only when product intent is approved/drafted
├── spec.md           # created only when build behavior is specified
├── ai-eval.md        # created only when the feature has AI behavior to evaluate
├── analytics-plan.md # created only when the feature warrants a measurement plan
├── validation.md     # created only when acceptance validation happens
├── alignment-report.md  # created only when a spec-drift check is run
└── publish/          # created only on a publish run (rendered pages + log)
```

Optional artifacts such as `implementation-plan.md`, evidence notes, publishing
logs, or deck files are created only when they prevent a real failure: multi-unit
engineering work, expensive reusable research, external handoff, or stakeholder
presentation.

## Rules
- Start by reading the feature `README.md`.
- The README routes to relevant artifacts, repos, design, domain context,
  decisions, blockers, and last verification state.
- The PRD owns product intent.
- The spec owns exact build behavior.
- For AI features, `ai-eval.md` owns the accuracy bar and the ship judgment on
  model output. It does not replace `validation.md`; the two answer different
  questions and can disagree.
- If product, design, code, or architecture conflict, surface the conflict; do
  not silently choose.

Do not create new features here. Historical feature folders may use this flat
layout or older stage subfolders. Do not normalize them unless the feature is
active and the PM approves the migration.
