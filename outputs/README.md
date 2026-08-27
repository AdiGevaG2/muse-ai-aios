# Feature Outputs

All new feature work lives under `outputs/<feature-name>/`, where
`<feature-name>` is a lowercase kebab-case slug. The feature `README.md` is the
daily entry point and context router.

## Initialization Contract

When any feature-specific workflow stage is invoked, or a requirement starts a
new feature:

1. Confirm the feature name and active domain.
2. Create `outputs/<feature-name>/README.md` if it does not exist.
3. When the stage creates a durable artifact, create its folder and artifact
   together. Do not pre-create empty stage folders or placeholder artifacts.
4. Name each artifact `<feature-name>-<artifact>.md` and keep it in the matching
   stage folder.
5. Update the feature README with the current stage, status, artifact links,
   relevant evidence and repositories, open decisions, blockers, and last
   verification state.
6. If the feature README already exists, follow its routed paths and preserve
   existing work.

## Default Layout

```text
outputs/<feature-name>/
├── README.md
├── reverse/
│   └── <feature-name>-reverse.md
├── discovery/
│   └── <feature-name>-discovery.md
├── prd/
│   └── <feature-name>-prd.md
├── spec/
│   └── <feature-name>-spec.md
├── ai-eval/
│   └── <feature-name>-ai-eval.md
├── analytics-plan/
│   └── <feature-name>-analytics-plan.md
├── validation/
│   ├── <feature-name>-validation.md
│   └── <feature-name>-alignment-report.md
├── publish/
│   └── publish-log.md
└── retro/
    ├── <feature-name>-retro-learnings.md
    └── <feature-name>-retro-engine-tuning.md
```

Only folders and artifacts for stages that actually happen should exist.

## Feature README Minimum

Each feature README records:

- feature name and active domain
- current stage and status
- read-first artifact links
- relevant evidence and repositories
- relevant domain context
- open decisions and blockers
- last verified date and source state

Existing features under `domains/<domain>/features/` are historical. Do not move
or normalize them unless the user explicitly approves that migration.