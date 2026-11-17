# Change Detection

Change Detection reports what changed on a client's merchant pages since the
last scan. Today it runs on Visualping; the Q4 2026 plan replaces Visualping by
September 2027 with a G2RS capability built as a shared Atlas signal source.

Source: `source/2026-10-20-change-detection-q4-planning.md` (Sarah Craven, Q4
planning doc, last modified 2026-11-06, re-checked 2026-11-08).

## Use case homes
- Significant price changes map to Marketing content (TBD), changed from TBD
  in the 2026-11-06 version. Marketing content, site health and watchlists
  have no confirmed Atlas home. [documented]

## Why it is being built
- $1.15M revenue line at about 70% gross margin, run on Visualping with no
  integration. Vendor cost $140K a year. [documented]
- Visualping markets content-compliance capabilities that overlap with G2RS,
  built partly on G2RS analysts' engagement. [documented]
- Owning the build aligns the monitored unit with the billed unit; Cliq
  right-sizing cut that account about 67% at renewal. [documented]
- Change Detection is planned as a platform capability emitting change signals.
  Business Policies, Policy Analysis, UaaS, Content Classification and a future
  marketing-monitoring component consume them; the analyst-delivered report is
  one consumer. [documented] Links: [[go-policy-analysis-vars-fiserv]],
  [[atlas-architecture]].

## Foundations
- Page-type classification: knowing a URL is T&C, contact, product, and so on.
- Structured entity extraction: business name, address, billing descriptor,
  contact details, prices, payment methods. Most comes from the Atlas core
  pipeline; likely gaps are billing descriptor, payment methods and prices,
  prices possibly via PLRC. [documented]
- Atlas core pipeline supports refund/returns, shipping, privacy, contact, T&C
  and payment pages. Product pages map to PLRC. About us, blog, home,
  header/footer, ingredients, subscription/cancellation and age gate are TBD.
  [documented] Links: [[crawler-capability-gaps]], [[crawler-consolidation]].

## Milestones
| # | Milestone | Target | Gates vendor exit |
|---|---|---|---|
| M0 | Foundations, decisions, benchmarks (throughput, LLM cost, false-negative rate, anti-bot, fleet ops, stack decision; rule catalog; change event contract) | 2026-11-15 | Yes |
| M1 | Core engine: enrollment reconciled to client submissions, daily/weekly/monthly cadence, baseline capture, Atlas page sources plus filtering, screenshot evidence hashed and timestamped with highlighted regions or unmarked fallback | "Jan 2026" in source, inconsistent with M0 | Yes |
| M2 | Analyst workflow UI and Excel export | Feb 2027 | Yes |
| M3 | Configurable monitoring profiles, possibly deferred | Feb 2027 | No (summary text says M0-M3 deliver parity; table says No) |
| M4 | Atlas component integration | Q2 2027 onward | No |

All [documented]. Two internal conflicts in the source: M1's date precedes M0,
and M3's vendor-exit gating differs between the prose and the table. The prose
also calls the integration milestone "M5" while the table numbers it M4.

## M2 parity scope
- Review queue per client, filterable by change type; side-by-side text with
  screenshot evidence; one-click false-positive removal with a reason, excluded
  from export and fed to a precision loop; editable significance note;
  merchant enrollment in Atlas. [documented]
- Excel export tabs: change report, merchant list, newly identified URLs;
  profile-aware exports such as catalog trend summaries; SP File Share delivery
  by Ops; ideally the same changes in the Atlas client portal from launch.
  [documented]

## Seven rule types (M3)
Page-type scope, numeric thresholds, catalog-aware logic, watchlists / entity
mentions, exclusions, site-health signals, control presence. Client examples:
NAB, Cliq, Glacier, TabaPay, Fibonatix, CMS, ING, Banka Credins, PayNovus.
Site health and control presence need their own capture logic and run today as
manual monthly analyst walkthroughs. Cosmetic change exclusions apply to all
clients in CD core. [documented]

## Change categories (proposal)
A proposed taxonomy labels each change by business meaning: 13 categories,
multi-label, plus site health and control presence as separate check classes.
Its site-health and control-presence scope matches the rule types above.
Likely an input to the M0 rule catalog. [inference] Link:
[[change-detection-categories]].

## Open decisions in the source
Billing unit (URL, page or page-type bundle; 300-pages-per-site cap); client
self-serve vs. G2RS-configured, suggested configured first; automatic vs. gated
Policy Analysis / UaaS re-triggers; marketing content owner, recommended Policy
Analysis; screenshots embedded in Excel vs. linked. Follow-ups: Visualping
historical export, severity support, changes without screenshots, cadence
volumes, Visualping walkthrough with Margo. [documented]
