# Rules Parity

Make Atlas rules work reliably and reach parity with MerchantView rules. Started 2026-11-15.

## Contents

- `atlas-rules-gaps-and-issues.md`: summary of Atlas rule defects, gaps against MerchantView, which conditions can fire, and MerchantView usage.
- `research/`
  - `01-initial-code-trace.md`: rule model in both products and how Verified Transaction Launderer is created.
  - `02-atlas-categories-and-producers.md`: where Atlas condition categories come from, what the rule sees, when rules run.
  - `03-mv-categories-and-producers.md`: the same for MerchantView.
  - `04-mv-vs-atlas-feature-gaps.md`: feature comparison table with code references.
  - `05-doc-review-findings.md`: writing review of the gaps doc, not fixed yet.
- `data/`
  - `mv-category-findings-summary.md`: MerchantView findings per category, last 90 days, with queries.
  - `rules-usage-mv.md`: MerchantView rule usage and adoption, with queries.
  - `mv-category-activity-90d.csv`: per category name, type, automated and manual counts, status.
  - `mv-findings-by-category-90d-raw.csv`: raw Looker result.
  - `category-catalog.csv`: category IDs, names and types from Looker.
  - `looker.py`, `summarize.py`: scripts to re-run the queries. Credentials are read from `~/.looker.ini`.

## Not available yet

- Atlas findings by category.
- Number of MerchantView findings whose risk a rule changed.
