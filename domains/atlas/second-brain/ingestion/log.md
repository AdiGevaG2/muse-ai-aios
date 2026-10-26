# Wiki Log — atlas

Append-only. Newest first. One line per ingest/update: what came in, which pages
were created/updated, which links were drawn.

- **2026-10-08** - Gal Sahar's `MCC Groups mapping.xlsx` (two copies)
  ingested to domain brain via the M365 connector. Stored at
  `source/2026-09-06-mcc-groups-mapping-xlsx.md`. Updated
  [[mcc-grouping-taxonomy]]: full membership added (confirms 39 groups / 18
  stand-alone), `Group Risk` column conflict with the per-MCC tier principle
  surfaced, six risk-mixed placements flagged as [hunch], specialty list
  inferred to be a subset of the stand-alone set. MCC Risk brief V1 and v2
  re-checked: unchanged since 2026-09-01, not re-ingested. Links to
  [[mcc-risk-scoring]] reused.
- **2026-10-07** — G2RS GO VARS Update deck (Fiserv, dated 2025-07-25) ingested
  to domain brain via SharePoint/M365 connector. Stored raw at
  `source/2025-07-25-g2rs-go-vars-update-fiserv.md` (text-only; architecture
  diagram and Gantt bars not extracted). Created
  [[go-policy-analysis-vars-fiserv]] (GO's Policy Analysis/VARS component: 13
  Fiserv requirement checks, build status as of July 2025, named crawling and
  test-data challenges, Q2-Q4 2025 roadmap). Linked to
  [[mcc-mismatch-for-global-onboarding]], [[crawler-capability-gaps]],
  [[atlas-architecture]]; back-links added on the first two.

- **2026-09-10** — Adyen IP-mismatch email thread (2026-09-07/09) ingested to
  domain brain. Stored raw at
  `source/2026-09-09-adyen-ip-mismatch-whois-email-thread.md`. Created
  [[merchant-ip-whois-mismatch]] (Mastercard/Adyen IP-mismatch ask, merchant vs.
  website IP, MV's current FSD/Scamadviser whois path). Linked to
  [[merchantview]], [[crawler-capability-gaps]], [[atlas-architecture]].

**Do not load this file during feature work.** It is ingest history, not
knowledge, and it grows without bound. Only `/review` and `/retro` read it. For
what the brain knows, use `index.md` and the entity pages.

## 2026-09-10 — Sunniva Wong email, Visa HK MCC verification expansion (B&M)
Raw stored at `source/2026-09-10-visa-hk-mcc-verification-brick-and-mortar-email.md`.
Created `mcc-verification-brick-and-mortar.md` — Visa HK's ask to extend MCC
Verification from eCommerce to physical merchants, driven by acquirer/PayFac
interchange-rate misuse (MCC code-shopping across 5812/5499/5814/5462/8398).
No roadmap or technical assessment exists yet. Linked to
`mcc-mismatch-for-global-onboarding` (adjacent but scoped to eCommerce/URL
evidence, phase-1 unaffected), `mcc-risk-scoring`, `mcc-grouping-taxonomy`, and
`crawler-capability-gaps` (crawling is the current predicted-MCC source; no B&M
equivalent). Added to index.md concepts list and source coverage table.

## 2026-09-02 — Confluence CATS/K9 4082302977, "MCC Grouping Rationale"

**In:** Gal Sahar's Confluence page (space `CATS`/K9, modified 2026-07-29) on
the MCC grouping taxonomy: 39 business-equivalence groups, ~18 stand-alone risky
MCCs, gambling's five codes folded into one group, five design principles, the
VIRP/BRAM rationale, and five open refinement candidates. Stored raw as
`source/2026-07-29-mcc-grouping-rationale-confluence-cats-4082302977.md`.

**Routed to:** domain brain. The taxonomy is the reference data under UP's MCC
mismatch scoring, not company-wide policy. The VIRP/BRAM tier framing is
industry context, not a G2RS org fact.

**Created:** `ingestion/mcc-grouping-taxonomy.md` — new concept page. Existing
MCC pages describe interpretation and delivery; none held the group set itself.

**Updated:** `mcc-risk-scoring.md` (adjacency open question marked partly
answered by the five-code refinement list; taxonomy added to Links),
`mcc-mismatch-for-global-onboarding.md` (Links), `index.md` (Concepts entry +
source coverage row).

**Links drawn:** taxonomy ↔ [[mcc-risk-scoring]] (supplies the group set its
same-business axis assumes; answers its logged adjacency question), taxonomy ↔
[[mcc-mismatch-for-global-onboarding]] (compatible with MerchantView's verified
same-group rule, adds the tier dimension MV lacks), taxonomy →
[[crawler-capability-gaps]] (stays downstream of the detection-accuracy gap),
taxonomy → [[merchantview]] (the legacy comparison it generalizes).

**No conflicts.** MerchantView's verified rule and this taxonomy agree on group
semantics.

**Gaps left open:** the full 39-group membership table is not in the source, no
risk-band definitions, and no Visa/Mastercard document behind the VIRP/BRAM tier
assignments. Flagged one internal tension on the page — 4829's proposed
"High / stand-alone" would change the group set, contradicting its own
"re-tier, no restructuring" fix.

## 2026-09-01 — Gal Sahar, "MCC score and UX" SharePoint folder

**In:** The entire folder from Gal Sahar's OneDrive (Core group): two versions
of the "MCC Risk — Unified Output & Client Configuration" product brief (v1
2026-08-09, v2 2026-08-19), two HTML card prototypes, and five Python files.
Stored as `source/2026-09-01-mcc-score-and-ux-folder.md` with both briefs in
full, a v1↔v2 diff, and a behavioral extract of the v2 prototype.

**Not captured:** `mcc_risk.py`, `mcc_riskV3.py`, `mcc_reference.py`,
`mcc_referenceV3.py`, `build_referenceV3.py` — the SharePoint connector rejects
`.py` (MIME `application/octet-stream` not in its allowlist). These hold the
implemented comparison and reference data, so everything ingested is documented
*design*, not code-verified behavior. Three carry a **V3 suffix dated
2026-08-10**, later than v1 and earlier than v2 — a revision neither brief
describes. Getting these read is the highest-value follow-up on this source.

**Routing:** Domain brain, no prompt needed. MCC scoring for UP merchants is
product-specific. Nothing org-wide in the folder.

**Created:** `mcc-risk-scoring` (concept) — the four design principles, two-axis
model, seven-verdict matrix, MVP output contract, client configuration, and the
finalize/feedback loop. `mcc-mismatch-for-global-onboarding` (synthesis) — the
PayPal commercial driver, per-platform behavior table, MV's verified rule, the
phase-1 scoping decision, and four known obstacles.

**Updated:** `crawler-capability-gaps` — added that Core's scoring design sits
*downstream* of the MCC detection-accuracy gap rather than closing it, and that
"analyst-assist grade, not automation grade" directly constrains how far
mismatch can be automated. `index.md` — two new pages plus a source-coverage row
recording the unreadable Python.

**Links drawn:** `mcc-risk-scoring` ↔ `mcc-mismatch-for-global-onboarding`
(design ↔ its first delivery); both → `crawler-capability-gaps` (the three
parallel MCC efforts, and detection accuracy as an upstream constraint); both →
`merchantview` (the legacy group-based comparison); both →
`atlas-architecture`.

**Conflict surfaced, not resolved:** the brief's verdict matrix puts
Over-declaration at tier **Low**; the prototype scores it 68 / **High**. Both
recorded with provenance on `mcc-risk-scoring` for `/review`.

**Also this session:** a `/learn-feature` run on the same material produced
`context/features/mcc-mismatch.md`, `hypotheses/mcc-mismatch-phase-1.md`, and
`outputs/paypal-mcc-mismatch/knowledge/`.

## 2026-08-30 — EverC/G2RS Knowledge Transfer, Day 1 (2025-10-20)

**In:** WebVTT closed captions from the Day 1 recording, ~3.5 hours
(`01:08:31`–`04:35:23`). Stored as
`source/2025-10-20-everc-g2rs-kt-day1.md`. Two links supplied in the same
request — Day 2 and Day 3 — could **not** be ingested: they are SharePoint
Stream video URLs and no transcript was provided. Also re-filed the previously
ingested loose fragment, which on inspection is **not** Day 1 (its content is
material Day 1 explicitly deferred to "tomorrow"); the caveat on
`source/2025-10-20-everc-g2rs-kt-day1-fragment.md` now says so.

**Routing:** Domain brain. Product architecture, crawler internals, and platform
migration for this domain's products. One org-wide candidate flagged below
rather than written.

**Created:** `csx`, `crolex`, `zinesec-group` (entities);
`crawler-capability-gaps` (concept); `crawler-consolidation`,
`atlas-architecture` (synthesis); `marketview`, `smartscan`
(entities).

**Updated:** `merchantview` — resolved its standing open question. Day 1 shows
MerchantView is **EverC's** founding product, not G2RS-native, and flags the
separate MV/MKV collision with MarketView. Added the Day 1 body: monthly-only
cadence, onboarding tiers vs. batch monitoring, the two configuration layers,
reported/unreported, and the graph data-controllership boundary.

**Links drawn:** The dense thread is the crawler estate. `csx` and `crolex` are
each other's alternatives, `crawler-capability-gaps` holds the feature deltas,
and `crawler-consolidation` carries the decision — none of which any single
speaker assembled in-session. Four capabilities are being built **twice or
three times** in parallel across the merged company (agentic crawling, MCC
detection, change detection, proxy procurement); that pattern is recorded on
`crawler-capability-gaps` because it only becomes visible across speakers.
`atlas-architecture` was linked to `crawler-consolidation` to record
that EverC's convergence and the G2RS/WebShield estate question are proceeding
on separate tracks with no stated connection.

Day 1 also confirms the earlier `[hunch]` on `merchantview`: the "in minutes"
claim maps to premium/instant onboarding, **not** steady-state monitoring, which
is batch. Left tagged as corroborated rather than promoted, since the collateral
still doesn't say so itself.

**Caution recorded, not smoothed over:** the pages-per-site comparison
(EverC ~10, G2RS ~50, WebShield 500) was presented and then corrected live —
50 is an average, 500 is a maximum. Kept on `crawler-consolidation` as a warning
against reusing those three numbers as a comparison.

**Flagged for the PM, not written:** the MasterCard "screen every page,
including beyond login screens" rule is org-wide compliance material and binds
every domain. It stays out of the wiki per the governance boundary — recorded on
`crawler-capability-gaps` only as the demand signal behind the gaps, with a note
that the actual bulletin needs verifying. The speaker himself hedged on
enforceability.

**Not done:** No dollar figures — the TCO amounts were on slides, not in the
captions; only cost *structure* is recorded. The full verbatim transcript is not
on disk (it reached the agent as a chat attachment); the source file carries
timestamped anchor quotes for every synthesized claim instead, and says so.

## 2026-08-30 — G2RS solution sheets: MerchantView + Scam Network Intelligence

**In:** Two customer-facing PDF solution sheets from SharePoint
(`General/EverC/`), read via the M365 connector. Stored raw as
`source/2026-08-30-g2rs-solution-sheet-merchantview.md` and
`source/2026-08-30-g2rs-solution-sheet-scam-network-intelligence.md`.

**Routing:** Domain brain. Both are product positioning for the G2RS/EverC
product line, not company-wide policy.

**Created:** `merchantview`, `scam-network-intelligence` (entities);
`network-intelligence` (concept); `merchant-risk-classification-pipeline`
(synthesis).

**Links drawn:** The two sheets share one premise, so `network-intelligence`
was created to hold it rather than duplicating it in both entity pages. The
real find is the thread from the marketing collateral back to the Oct 2025
EverC KT fragment: the sheets sell "attribute related activity across domains,
infrastructure, and actors" as a finished capability, while the KT session
describes that exact traversal — connected domains sharing an email or phone —
as a "cumbersome, nasty" cyclic process being replaced by a single graph
endpoint. That tension is recorded on both `network-intelligence` and
`scam-network-intelligence` rather than resolved. Also linked MerchantView's
"delivered in minutes" tagline to the KT session's instant-onboarding streaming
pipeline as a `[hunch]` — plausible, unconfirmed.

**Not done:** No compliance/policy pages created (governance boundary). No
existing pages contradicted — the wiki was empty before this ingest.

<!-- newest entries above this line -->
