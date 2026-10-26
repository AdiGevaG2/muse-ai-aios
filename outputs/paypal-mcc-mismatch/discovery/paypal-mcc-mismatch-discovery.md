# Discovery: PayPal MCC Mismatch (Phase 1)

Document Name: paypal-mcc-mismatch-discovery

Feature Name: PayPal MCC Mismatch  
Phase: **1 of 2** — PayPal GO onboarding. Phase 2 is
[MCC Classification Capability](../../mcc-classification-capability/discovery/mcc-classification-capability-discovery.md).  
Owner: TBD  
Product: Atlas  
Last Updated: 2026-08-31

**Phase boundary.** This document covers only what PayPal needs to replace its
current MCC vendor through GO onboarding: Specialty detection, MCC Prediction,
and group-level Mismatch, delivered through the existing integration. The
composite MCC risk score, the seven-verdict matrix, five-tier severity,
finalize/MCC-of-record, and client-configurable routing are Phase 2 and are
deliberately absent here. Phase 2 reuses this comparison rather than building a
second one.

## TL;DR

### Executive Takeaway

PayPal requires automatic MCC mismatch support before moving from its current
vendor to our MCC solution — the stakeholder thread calls it a hard requirement
gating that contract cancellation. GO must therefore support mismatch, and
because GO is integrated into CMP (the MLRC pipeline) rather than into
MerchantView, the capability has to exist in MLRC. Working mismatch logic
already exists in MerchantView; the open engineering question is whether it
moves to Core or to MLRC, not whether it must be invented.

What GO supports today is a manual MCC verification:
the client's reported MCC is displayed, an analyst hand-picks one or more
verified codes from a lookup, and nothing in the product ever compares the two.
Every mismatch in GO is a judgement a human makes by eye and then does not
record — there is no mismatch field, no flag, and no mismatch output to the
client. Atlas can collect a reported MCC and run MCC detection, but
the available source does not demonstrate a comparison and review flow either.
The proposed direction is a group-based comparison that creates a clear,
store-level mismatch finding with both reported and detected evidence. Product
must confirm comparison semantics, data ownership, and PayPal's delivery
contract before PRD approval.

## Current Behavior

### What Exists vs. What's Needed

| Capability | Exists today? | Where | What's needed |
|---|---|---|---|
| Client supplies a reported MCC | Yes | GO (spreadsheet or API); UP merchant APIs accept it | Nothing new for MVP |
| MCC reference data and group taxonomy | Yes | UP MCC reference data; MV compares by group | Confirm PayPal accepts group-level matching |
| Automatic MCC detection per store | Yes | UP dispatches MCC analysis when enabled | Verify detection output end to end in production |
| Comparing reported vs. detected MCC | **Not in GO's pipeline** | Exists in MerchantView; absent from CMP/MLRC, which is what GO runs on | Move or reimplement the MV comparison in MLRC |
| Recording the mismatch conclusion | **No** | GO has no mismatch field, status, or comment | Build a durable, store-level mismatch finding |
| Analyst review of a mismatch | Partly | UP has generic finding, resolution, and evidence workflows | Add a typed mismatch model and MCC evidence into that workflow |
| Delivering mismatches to the client | **No** | GO exports the reported MCC only | Build the PayPal delivery interface (Open Question 4) |
| Handling volume | **No** | One case at a time; no bulk path | Automatic per-scan comparison removes the manual step |
| Missing-input / missing-detection / failure states | **No** | GO collapses these into a blank code | Build five explicit result states |

Everything above the bold rows is foundation that already works. The build is the
comparison, the finding, and the delivery.

**VERIFIED FACT (stakeholder thread):** MCC mismatch logic already runs in
MerchantView. GO does not benefit from it because GO is integrated into CMP (the
MLRC pipeline), not into MerchantView. Engineering was debating relocating the
logic to Core or to MLRC. This is a relocation problem, not a greenfield build —
size the comparison work accordingly.

### What GO supports today

GO's MCC capability is a manual verification step inside a boarding case. It is
only present when the client selected `MCC_VERIFICATION` as a report component
on the boarding request.

**How the reported MCC arrives.** The client supplies it — either as the "MCC"
column of the boarding-request merchant spreadsheet, or as a field on the API
merchant payload. It is stored against the merchant and shown on the case. There
is no path for an analyst to enter or correct it.

**What the analyst does.** Opening the case, the analyst sees the reported MCC
alongside the merchant's category code, its products-and-services description,
and the list of MCCs disallowed for that merchant group. They then research the
merchant, search a merchant-category lookup by code or description, and save one
or more verified MCC records — each with a code, name, description, and a
primary/secondary flag. When the business cannot be classified, they save a
blank code, which is how "Unclassifiable" and "No MCC Available" are expressed.

**What the analyst cannot do.** The verification record has no status, no
comment, and no analyst identity — only the code and the primary flag. There is
no bulk or batch path: every merchant is worked one case at a time.

**INFERENCE:** The GO front end is not in the inspected repository, so screen
layout, field labels, and any client-side warning next to a differing code are
`NOT VERIFIED`. No comparison logic exists on the backend, so any such indicator
would be cosmetic and unrecorded.

## Problem

### Pain Points

- **The comparison is unassisted eyeballing — and the fix already exists in the
  wrong system.** GO never compares the reported and verified MCCs, so whether a
  merchant is miscoded is a human judgement on every case. MerchantView already
  treats same-group codes as a match and does this automatically; GO cannot reach
  that logic because it runs through CMP/MLRC instead. The capability gap is
  architectural placement, not missing capability.
- **The conclusion is never written down.** There is no mismatch field, no
  status, no comment. An analyst who concludes "reported 5967, actually 7995"
  can only record the verified code; the finding is lost.
- **Nothing downstream carries it.** The client case export writes the reported
  MCC, not the verified one. Whether the verified code reaches the client report
  is `UNKNOWN` — no report query reading the verification records was found.
- **Throughput is one case at a time.** No bulk path exists. PayPal's volume is
  why the fallback proposal is a spreadsheet — this same manual step, moved
  outside the product.
- **PayPal cannot rely on detection alone.** It needs an explicit answer when
  reported and detected MCCs disagree, delivered as data.
- **UP's foundations are unproven end to end.** It ingests reported MCCs and
  dispatches detection, but no comparison or mismatch generation was found in
  the inspected source. Ownership is also unresolved: reported MCCs sit at
  merchant level, findings at store level.

The premise is commercially sound: this capability gates a named customer
opportunity and replaces a manual process. The missing volume and contract data
prevent an effort-versus-revenue assessment.

### Why This Is Urgent

The requirement was raised and repeatedly escalated in the stakeholder thread,
not derived from analysis. What the thread establishes:

- **PayPal will cancel its current MCC vendor to move to ours.** Mismatch is
  named a hard requirement for that switch, not an enhancement.
- **The requirement gates a live PayPal conversation.** It was escalated ahead of
  a scheduled PayPal meeting, with repeated requests for a timeline for mismatch
  support in the MLRC pipeline.
- **It was already being prioritized and estimated** on the strength of PayPal
  demand, so this discovery documents an in-flight commitment rather than
  proposing a new one.

**Escalation trail:** Mary Williams (commercial requirement and prioritization
pressure), Ishai Froind (GO/CMP integration constraint), Yonatan Eisenberg
(current location of the logic and the Core-vs-MLRC placement decision).

**Consequence for scoping:** a delivery date matters more here than scope
breadth. Anything that can be deferred past PayPal's decision point should be.

## Proposed Solution

### Feature Behavior

#### The commercial unit is "full MCC", not mismatch alone

Mismatch does not ship by itself. The go-forward commercial offer bundles three
sub-components — **Specialty detection, Mismatch detection, and MCC Prediction**
— and the client-facing output depends on whether the client supplied an MCC:

| Client input | Expected output |
|---|---|
| **No MCC** in the merchant record | Run MCC Prediction only. Return the predicted individual MCC, plus a confidence score if available. |
| **An MCC** in the merchant record | Run the full component. Return (1) the is-specialty flag, (2) a mismatch indicator **at MCC Group level**, and (3) the predicted/corrected individual MCC with confidence score. |

This means mismatch is conditional on client input, and prediction always runs.
A merchant with no reported MCC must not produce a mismatch verdict — it has
nothing to compare against.

#### Comparison behavior

Atlas should compare a merchant's reported MCC with the MCC detected
for each reported store. Grouped MCCs compare using the configured MCC group
taxonomy: different codes in the same group count as a match, different groups
create a mismatch. This follows MV's verified behavior. MCCs with no group —
including Specialty/risky codes — compare at the specific-code level instead
(see "Comparison rule for MCCs that are not grouped" above).

For a mismatch, the platform should create a durable finding that preserves:

- Reported MCC code and group.
- Detected MCC code and group.
- The store that produced the detected result.
- Detection time and comparison time.
- Current resolution and audit history.

The result should distinguish five states:

- `MATCH` — reported and detected MCCs resolve to the same group, or, for
  ungrouped MCCs, the same specific code.
- `MISMATCH` — they resolve to different groups, or, for ungrouped MCCs,
  different specific codes.
- `NO_REPORTED_MCC` — the customer supplied no MCC to compare against.
- `NO_DETECTED_MCC` — the scan completed but produced no MCC for the store.
- `PROCESSING_FAILURE` — the comparison could not be attempted or completed.

The last three are each actionable in a different direction: `NO_REPORTED_MCC`
is a customer-input problem, `NO_DETECTED_MCC` is a coverage or detection
problem, and `PROCESSING_FAILURE` is ours to fix and retry. Collapsing them into
a single "unclassifiable" bucket would tell nobody what to do next.

**`PROCESSING_FAILURE` retries automatically.** A failed comparison should be
reattempted immediately rather than waiting for the next scan. If that retry
also fails, the store stays in `PROCESSING_FAILURE` and is attempted once more
at the next scheduled scan. Only after that second failure does the state
persist as a standing result needing attention — no merchant should sit
unprocessed because of a transient failure, and no failure should be silently
retried forever.

Analysts should be able to review the result through the existing findings
workflow. PayPal should receive the result through its agreed delivery
interface.

For outbound delivery, only stores whose current state is `MISMATCH` should be
sent. A mismatch that remains unresolved should appear again on each later scan
while the mismatch condition still holds. If a later scan resolves to `MATCH`,
the stored row remains for audit but is no longer sent as an active mismatch.

**ASSUMED:** For the initial PayPal scope, one authoritative reported MCC is
stored at merchant level and applies to every reported store. The resulting
mismatch belongs to the individual store. This matches the current UP data
shape while preserving the location of the detected evidence.

**ASSUMED:** MCC mismatch uses the existing MCC enablement for onboarding and
monitoring. A separate mismatch toggle is not needed unless commercial
packaging requires it.

#### Comparison rule for MCCs that are not grouped

Not every MCC belongs to a taxonomy group. **PRODUCT DECISION:** an MCC that
has no group — this includes Specialty/risky MCCs — is compared at the
specific-code level instead of the group level:

- If `specific_reported_MCC != specific_predicted_MCC` → `MISMATCH`.
- If `specific_reported_MCC == specific_predicted_MCC` → `MATCH`.

Every other MCC is expected to carry a group and follows the group-level
comparison rule above. Specific-code comparison is the fallback for the
ungrouped case, not an alternative rule PayPal or an analyst chooses between.

#### Travel groups: no special handling for Phase 1

The Travel group taxonomy currently bundles distinct rental categories (e.g.
Alamo car rental, Europe car rental) under one group, which can look like an
odd pairing on inspection. **PRODUCT DECISION:** Phase 1 does not special-case
Travel. The standard group-level rule applies as-is, because:

- Mismatch is meant to be a risk signal. The Alamo/Europe-car oddity is a
  taxonomy quirk, not a risk indicator, so it does not justify bespoke logic.
- It is a rare, low-volume edge case.

**Considered and rejected for now:** running the three Travel groups as
specific-MCC comparisons with special handling — where a resulting mismatch is
scored as low risk plus a "likely miscode, not a risk signal" indicator. This
would more accurately label the Alamo/Europe-car case, but was judged overkill
for the current phase given its rarity. Revisit if client feedback surfaces it
as a recurring false-positive source.

#### Generic MCC codes (5999 / 8999): no special handling

**PRODUCT DECISION:** Generic/catch-all MCCs (5999 "Miscellaneous Retail",
8999 "Professional Services, NEC") get no special-case logic for Match or
Mismatch. They are compared under the same group-level (or specific-level, if
ungrouped) rule as every other MCC. No exception path exists for them in
Phase 1.

#### Groups that resolve to MM but arguably should be M: deferred

Certain group pairings may produce a `MISMATCH` verdict that, on closer
product judgment, should arguably be treated as a `MATCH` — a similar failure
mode to the Travel case above but for other groups. **PRODUCT DECISION:**
these are treated as edge cases for now — rare enough that building special
handling ahead of evidence is not justified. Park this class of exception and
revisit based on client feedback after launch rather than trying to enumerate
every case up front.

#### Preserve the MCC catalog version used at calculation time

**PRODUCT DECISION:** the MCC/category reference data (the SSOT mapping codes
to groups) can change over time. Each mismatch calculation must retain which
version of the MCC catalog was in effect when the comparison ran, so a result
can be audited later against the exact definitions used — not against
whatever the catalog looks like today.

- This is an internal audit need, not a customer-facing field. PayPal's
  delivery payload is unaffected.
- Applies to every comparison this feature produces, group-level and
  specific-level alike.

#### Direction: start simple, extend later

**PRODUCT DECISION:** the comparison model above (group-level default,
specific-level fallback for ungrouped/Specialty MCCs, no special-casing for
Travel or generic codes, edge-case exceptions parked) is the deliberately
simple Phase 1 representation. The alternative — solving for every known MCC
scenario before launch — was considered and rejected in favor of shipping the
simple version and extending it as real client feedback identifies gaps.

### User Journey

1. PayPal submits a merchant, its reported MCC, and one or more reported stores.
2. Atlas validates the reported MCC against its MCC reference data.
3. An enabled onboarding or monitoring scan runs MCC detection for each store.
4. The platform resolves the reported and detected MCC groups and compares them.
5. The platform records a clear result state. A mismatch creates a reviewable
   finding with both codes, both groups, and store evidence.
6. An analyst reviews and resolves the finding through the existing findings
   workflow when review is required.
7. Atlas sends active mismatch results to PayPal through the agreed
  interface.
8. A later scan or reported-MCC change recalculates the current result while
   retaining audit history.

### What Changes for the Analyst

The analyst's job shifts from *finding* mismatches to *adjudicating* the ones
the platform proposes. Instead of hand-searching the category lookup on every
case, they get a proposed code from the store's observed activity and confirm or
override it. Instead of judging agreement by eye, they get a stated `MATCH` or
`MISMATCH` under the group taxonomy. Instead of the conclusion evaporating, a
mismatch is a durable finding they resolve through the standard workflow, with
audit history — and it reaches PayPal without manual transcription.

Judgement stays with the human: the analyst can still override a proposed code,
and a merchant the platform cannot classify surfaces as `NO_DETECTED_MCC`
rather than being forced into a match or mismatch. Whether PayPal's own analysts
work inside UP or consume the result in their systems depends on the delivery
contract in Open Question 4.

For MVP scope, PayPal-side accept/reject decisioning remains outside this
feature and can continue in GO as it does today.

### Assumptions

| Assumption | Current behavior or evidence | Caveat or validation needed |
|---|---|---|
| UP can accept and validate a reported MCC | Merchant APIs accept MCC values and use MCC reference data. | The internal model supports multiple values, while some interfaces use only one. |
| UP can request MCC detection | MLRC dispatches MCC analysis when product configuration and request domains both enable it. | Core output and production deployment were not verified. |
| UP can store and review mismatch as a finding | The target has generic finding, risk, resolution, and evidence workflows. | There is no verified typed mismatch model or structured MCC comparison evidence. |
| Group-based comparison is a valid starting rule | MV compares configured MCC group IDs, with tests and UI support. This is running production logic, not a design proposal. | PayPal-specific confirmation is still required. |
| Specific-code comparison is the correct fallback for ungrouped/Specialty MCCs | Product decision, not yet verified against MV's exact ungrouped-MCC handling. | Confirm MV does not already have separate ungrouped logic that should be reused instead. |
| Travel-group oddities (e.g. Alamo/Europe-car) don't need bespoke handling | Product decision: rare, and not risk-driven. | Revisit if PayPal or another client reports recurring false positives here. |
| Mismatch logic can be ported rather than built | The stakeholder thread confirms the logic sits in MV today, with a live Core-vs-MLRC placement debate. | MV's exact rules were not re-derived here; engineering must confirm what transfers cleanly to MLRC. |
| GO reaches mismatch only through MLRC | GO is integrated into CMP (MLRC pipeline), not MerchantView. | Stated in the stakeholder thread; not independently verified in code. |
| A manual fallback can bridge a limited launch | The stakeholder thread proposed spreadsheet processing for initial volume. | Volume, staffing, turnaround time, and acceptable duration are unknown. |
| Existing category configuration can include mismatch | UP supports portfolio-level MCC category configuration. | The legacy mismatch category ID would not be classified as MCC by the inspected BFF. |

## Scope

### In Scope

- Accept and validate the reported MCC needed for comparison.
- Run MCC detection for enabled PayPal onboarding and monitoring scans.
- Make group-based comparison available in the MLRC/CMP pipeline that GO runs on,
  reusing MerchantView's existing logic where it transfers.
- Compare reported and detected MCC groups for each reported store; fall back
  to specific-code comparison for MCCs with no group (including
  Specialty/risky codes).
- Retain the MCC catalog version in effect at calculation time on every
  comparison result, for internal audit — not exposed to PayPal.
- Record explicit match, mismatch, missing-input, missing-detection, and
  processing-failure states.
- Create a durable, reviewable finding for mismatch.
- Show reported and detected codes, groups, evidence, and resolution history.
- Recalculate after a new detection or reported-MCC change.
- Deliver the result through the PayPal interface selected during product
  definition.
- Add end-to-end tests for match, mismatch, and incomplete-result paths.

### Out of Scope

- Rebuilding the MCC detection model or taxonomy.
- Migrating all historical MV MCC findings and analyst decisions.
- Relocating the shared comparison into Core. Deferred to later consolidation so
  the PayPal date does not depend on a shared-service refactor (Open Question 5).
- General redesign of the findings experience.
- A new manual case-management system for spreadsheet fallback.
- Changes to unrelated content-compliance or merchant-risk behavior.
- Building PayPal-side accept or reject decision capture in Atlas.
  PayPal can continue recording those decisions in GO for this phase.
- WebShield parity claims until its source or product evidence is available.

## Success Signals

- PayPal merchants with valid inputs receive a deterministic MCC comparison
  result after eligible scans.
- Analysts stop hand-searching the category lookup on every case, and the
  mismatch conclusion they reach is recorded rather than lost.
- Analysts can understand a mismatch without consulting a spreadsheet or a
  second system.
- Reported and detected MCC codes and groups remain traceable through review and
  rescans.
- PayPal receives the agreed mismatch payload or report without manual
  transcription.
- The manual-fallback share, manual handling time, and ambiguous-result rate
  decrease after rollout.
- False mismatch and missed mismatch rates can be measured against reviewed
  outcomes.

No numeric targets are proposed because merchant volume, current manual effort,
and an accepted quality baseline were not provided.

## Open Questions

1. **What comparison does PayPal contractually expect?**  
   Draft assumption: group-based comparison for grouped MCCs, following MV;
   specific-code comparison for ungrouped/Specialty MCCs (see "Comparison rule
   for MCCs that are not grouped").  
   **RECOMMENDATION:** Confirm with PayPal that different codes in the same group
   count as a match before PRD approval. A wrong rule changes the core outcome.

2. **Where does the reported MCC belong when a merchant has multiple stores?**  
   Draft assumption: one merchant-level reported MCC applies to each reported
   store; each mismatch is store-level.  
   **RECOMMENDATION:** Keep this MVP model unless PayPal submits store-specific
   MCCs. Store-specific input would require a target data-model change.

3. **How should multiple reported MCCs be compared?**  
   Draft assumption: the initial PayPal contract supplies one authoritative MCC.  
   **RECOMMENDATION:** Defer multiple-code semantics from MVP unless confirmed as
   an input requirement. If required, define a primary MCC rather than treating
   any group match as success by default.

4. **How must PayPal receive the result?**  
   Draft assumption: UP review is required, and the external interface remains
   TBD.  
   **RECOMMENDATION:** Select API, callback, or file/report delivery before the
   PRD. This choice changes schema, timing, retries, and acceptance criteria.

5. **Which service owns the comparison?** — *narrowed, no longer open on the
   pipeline question.*  
   **VERIFIED FACT:** GO is integrated into CMP (the MLRC pipeline), not into
   MerchantView, so the comparison must be reachable from MLRC. That much is
   settled by the integration itself.  
   **Remaining decision:** whether the existing MerchantView logic is relocated
   into Core (shared, customer-neutral) or reimplemented in MLRC
   (customer-facing, faster to ship). Engineering was actively debating this.  
   **RECOMMENDATION:** Reimplement in MLRC for the PayPal phase and treat a Core
   move as later consolidation. A Core relocation serves both MV and MLRC but
   makes the PayPal date depend on a shared-service refactor — the wrong risk to
   take against a gating customer deadline. Confirm with Yonatan before the PRD.

6. **Is Group-level precision good enough to default mismatch on?**  
   Mary's MCC Component Review raises this as an unresolved DS question: the
   model may predict the **individual** MCC more precisely than the **MCC
   Group**, and mismatch runs at group level. If group precision is materially
   lower, defaulting mismatch on ships PayPal the noisiest signal in the bundle.  
   **RECOMMENDATION:** Get precision benchmarks for individual-MCC Predict versus
   MCC-Group Mismatch from Data Science before the PRD. If the gap is material,
   add confidence framing to the response rather than suppressing the output —
   PayPal has made mismatch a hard requirement, so hiding it is not available.
   This is the largest quality risk in Phase 1.

7. **Can Predict run without Mismatch, and can Mismatch output be suppressed?**  
   The implementation reportedly requires Mismatch to run as a prerequisite to
   Predict. Unconfirmed whether that is architectural or configurable.  
   **RECOMMENDATION:** For PayPal the coupling is harmless — they want both.
   Do not spend Phase 1 effort decoupling. Confirm it only because it decides
   whether a Predict-only SKU is sellable to clients who submit no MCC, which is
   a packaging question, not a PayPal blocker.

## Appendix

### Persona / Target Audience

**Primary user:**  
PayPal risk or compliance analysts reviewing whether a merchant's submitted MCC
matches its observed business activity.

**Secondary audience:**  
Internal onboarding and monitoring analysts, operations, customer success,
sales, and engineering teams supporting the PayPal migration.

**Job to be done:**  
When a merchant is onboarded or monitored, determine whether its reported MCC
matches the business activity detected on each store, then review and deliver a
traceable result.

### Data

- Number of users affected: N/A - PayPal account and merchant volumes were not
  provided.
- Current usage: N/A - current vendor volume and spreadsheet fallback volume
  were not provided.
- CS tickets: N/A - no ticket dataset was routed to this discovery.

#### Legacy EverC Mixpanel Analytics

The required window is the last 90 days with `is_customer = true` in MerchantView
Production. No callable Mixpanel tool or known MCC-mismatch event was available
in this run, so no product-usage figures were inferred from code.

| Signal | Legacy EverC evidence | Discovery implication |
|---|---|---|
| Coverage | N/A - no verified MCC-mismatch event or query result | Customer and portfolio coverage must be baselined before rollout sizing. |
| Usage | N/A - no verified event; backend-generated findings may not map to a UI event | Use merchant scan and mismatch-result counts if event instrumentation is added. |
| Key clients | N/A - no customer-only result available | PayPal is the named launch customer; other cohorts remain unknown. |

### Sources

| Source | Role |
|---|---|
| Stakeholder email thread — Mary Williams, Ishai Froind, Yonatan Eisenberg | PayPal hard requirement and vendor replacement; GO/CMP integration constraint; current location of mismatch logic in MV and the Core-vs-MLRC placement debate; prioritization and timeline pressure. |
| [Predictor MCC Match Mismatch — Discovery](https://g2rs.atlassian.net/wiki/spaces/UP/pages/4158947335) | Parallel discovery covering the same feature in two phases, adding NAB scope, Specialty MCC, and a composite risk model. **Not yet reconciled with this document.** |
| Atlas / GO code inspected for this discovery | Current reported-MCC storage, MCC detection dispatch, and generic finding workflows. |
| PM working session (Alex) | Comparison rule for ungrouped/Specialty MCCs; Travel-group and generic-MCC (5999/8999) handling deferred; edge-case MM-should-be-M groups parked; MCC catalog versioning requirement; simple-first direction confirmed. |

**Reconciliation note:** the Confluence discovery and this document disagree on
phasing, GO's current MCC behavior, result states, and granularity. Neither
supersedes the other yet. Resolve before PRD.

### Future Considerations

- Support multiple authoritative MCCs with explicit primary and secondary roles.
- Support store-specific reported MCCs when one merchant operates distinct
  businesses.
- Version comparison results against MCC taxonomy changes.
- Extend the capability to other customers after PayPal behavior is proven to
  be customer-neutral.
- Migrate selected historical mismatch evidence when continuity has measurable
  value.
