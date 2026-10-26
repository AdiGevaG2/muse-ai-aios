# Wiki Index — atlas

What pages exist, so the agent navigates instead of re-reading everything.
Updated on every ingest.

## Concepts
- [[network-intelligence]] — risk lives in connections between entities, not in
  any single record; the shared premise under both G2RS solution sheets.
- [[crawler-capability-gaps]] — what the crawling estate cannot do today
  (JS rendering, change detection, MCC accuracy, login-gated content), and the
  MasterCard rule change pulling those gaps forward.
- [[mcc-risk-scoring]] — Core's design for reported-vs-predicted MCC: seven
  verdicts, two risk axes, specialty overlay, and a finalize step that doubles
  as the training loop. Documented design; the Python is unread.
- [[mcc-grouping-taxonomy]] — the reference data underneath that scoring: 39
  business-equivalence groups, ~18 risky codes held alone, gambling folded into
  one. Groups answer "same business?", per-MCC tiers answer "how risky?".
  Full code-to-group membership now held; carries a `Group Risk` conflict.

## Entities

### EverC
- [[merchantview]] — EverC's founding product: merchant-level risk from a URL.
  Monthly monitoring, two configuration layers, reported/unreported findings.
  Also the name on G2RS collateral — see the collision note on the page.
- [[marketview]] — product-level classification for marketplaces. Millions of
  items/day, red/yellow/green/blue, precision-optimized.
- [[smartscan]] — proactive agentic scan; a risk-area sampler, not exhaustive.

### G2RS
- [[csx]] — G2RS's production crawler + classification platform. Storm,
  RabbitMQ, Lucene queries, 5.3M merchants/month.
- [[scam-network-intelligence]] — product for detecting coordinated scam
  networks across domains, infrastructure, and actors.

### WebShield / ZineSec
- [[zinesec-group]] — the three acquired companies, what WebShield brings, and
  why integration is paused.
- [[crolex]] — WebShield's Elixir crawler. Renders by default, Gemini-backed
  processors, unproven at G2 scale.

## Synthesis
- [[atlas-architecture]] — EverC's merchant + product convergence.
  Built, deployed, **taking no traffic**; migration is incentive-led, and the
  go-live bar is an open decision. **Start here for this domain.**
- [[crawler-consolidation]] — five crawler stacks, one company. TCO baseline,
  H-Tech's port-vs-rewrite assessment, nothing decided.
- [[merchant-risk-classification-pipeline]] — legacy Java batch vs. new PySpark
  streaming path, graph traversal, and where product claims meet the build.
- [[mcc-mismatch-for-global-onboarding]] — PayPal's gating requirement, why the
  MV logic doesn't reach GO, and the phase-1 scoping decision.
- [[mcc-verification-brick-and-mortar]] — Visa HK's ask to extend MCC
  verification beyond eCommerce to physical merchants; no predicted-MCC signal
  exists for B&M today, unscoped.
- [[merchant-ip-whois-mismatch]] — Adyen/Mastercard's IP-mismatch control ask;
  merchant IP != website IP, transaction-time IP isn't collected today, and
  MV's current whois path runs through FSD or Scamadviser, not core MV.
- [[go-policy-analysis-vars-fiserv]] — GO's Fiserv-driven Policy Analysis (VARS)
  component: 13 website-based checks (name/location/currency match, product and
  MCC restrictions, T&C/refund/delivery/privacy/card-brand/contact-us, SSL),
  each a 0-4 risk flag. Mid-build July 2025, crawling and test-data gaps open.

## Source coverage

| Source | Status |
|---|---|
| EverC KT Day 1 (2025-10-20) | Ingested. Captions start at 01:08:31 — **first ~68 min missing** |
| Unattributed KT fragment (likely Day 2) | Ingested. Low-fidelity, session unconfirmed |
| EverC KT Day 2 (2025-10-21) | **NOT INGESTED** — needs transcript export |
| EverC KT Day 3 (2025-10-22) | **NOT INGESTED** — needs transcript export |
| G2RS solution sheets (MerchantView, SNI) | Ingested |
| Gal Sahar, "MCC score and UX" folder (2026-09-01) | Ingested. **5 `.py` files unreadable** — connector rejects `.py`; comparison code unread |
| Confluence `CATS`/K9 4082302977, "MCC Grouping Rationale" (2026-07-29) | Ingested. Design principles and stand-alone set captured; **full 39-group membership table not in source** |
| Gal Sahar, `MCC Groups mapping.xlsx` (2 copies, 2026-09-02 / 2026-09-06) | Ingested. Full membership; brand-code rows summarized by range; cell highlighting not readable |
| Gal Sahar, MCC Risk brief V1 / v2 (re-check 2026-10-08) | No change since the 2026-09-01 capture; not re-ingested |
| Sunniva Wong email, Visa HK MCC B&M expansion (2026-08-25, fwd 2026-09-10) | Ingested. Market problem only, no roadmap/technical assessment exists yet |
| Adyen IP-mismatch email thread (2026-09-07 to 2026-09-09) | Ingested. All content [verbal], none confirmed against MV code or FSD docs |
| G2RS GO VARS Update deck, Fiserv (2025-07-25) | Ingested. Text-only extraction; architecture diagram (slide 16) and Gantt bar positions not captured |

Known gaps in what we hold: the graph/ecosystem deep-dive, WebID, product-level
algorithms, and the Web Shield / single-platform unification session were all
deferred to Days 2–3.
