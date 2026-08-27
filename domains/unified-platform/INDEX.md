# Unified Platform Index

Use this file as the router for domain context. Load the target file only when
the current task needs it.

| Need | Read |
|---|---|
| Active feature work | `../../outputs/<feature-name>/README.md` |
| Measurement plan and event spec | `../../outputs/<feature-name>/analytics-plan/` |
| Current-state figures pulled from tools | `outputs/<feature-name>/baseline/` |
| What was published externally | `../../outputs/<feature-name>/publish/` |
| Feature list | `../../outputs/` |
| Tool IDs and approval defaults | `config.json` |
| Writing style | `second-brain/style-guide.md` |
| Voice examples | `second-brain/writing-samples.md` |
| Platform and local repo context | `second-brain/context/platform.md` |
| Product-area orientation | `second-brain/context/product-areas.md` |
| Feature-to-repo orientation | `second-brain/context/repo-feature-map.md` and `../../../code-repos-git/REPO-MAP.md` |
| Legacy-to-target patterns | `second-brain/context/legacy-to-target-patterns.md` |
| Compliance constraints | `second-brain/context/compliance.md` |
| Open domain and repository questions | `second-brain/hypotheses/README.md` |
| Domain decisions | `second-brain/decisions/` |
| Glossary | `second-brain/glossary/` |
| Stakeholders | `second-brain/stakeholders/` |
| Ingested source wiki | `second-brain/ingestion/index.md` |
| Org systems | `../../org-brain/context/systems.md` |
| Org/company context | `../../org-brain/context/company.md` |
| Org policy (governed) | `../../org-brain/context/policies.md` |
| Org glossary | `../../org-brain/glossary/g2rs-terms.md` |

Org-brain rows are a separate tree, deliberately. Org facts bind every domain
and win over a domain fact on conflict; a domain page may extend one, never
contradict it.

Indexes and repo maps route search. They are not evidence. Verify important
implementation facts against source files.