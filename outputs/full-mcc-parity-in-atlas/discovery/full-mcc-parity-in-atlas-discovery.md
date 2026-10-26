# Discovery: Full MCC Parity in Atlas

Document Name: full-mcc-parity-in-atlas-discovery

Feature Name: Full MCC Parity in Atlas
Owner: Adi Geva
Product: Atlas
Last Updated: 2026-10-07

## TL;DR

### Executive Takeaway

Merchant View has a full merchant category code capability: a merchant declares
a code, a scan detects one, the platform compares them by configured group, and
a mismatch becomes a reviewable finding with evidence, report columns, and a
dispute workflow. Atlas has only one narrow slice of this today: a PayPal-only
mismatch verdict added to the findings callback under RT-1491. The PM decided,
on 2026-09-01, that RT-1491 was phase 1 of a larger body of MCC work
and that the fuller capability comes later. This discovery scopes that later
phase: what Atlas needs to reach parity with Merchant View's full MCC
functionality, not only the comparison PayPal asked for. The decision needed is
which parts of Merchant View's MCC behavior to carry forward as Atlas
requirements versus leave behind as legacy-only.

## Problem

### Pain Points

- Atlas cannot show a user the reported code, the detected code, or the
  relationship between them outside the one PayPal callback field. Merchant
  View shows both codes, both groups, and an explanation in its evidence UI;
  Atlas has no equivalent screen.
- Atlas has no per-URL reported code. Merchant View evaluates at the URL level;
  Atlas holds the reported code on the merchant and detection on the store,
  with no verified comparison semantics when a merchant has multiple stores.
- Atlas report output does not carry the code fields Merchant View customers
  are used to. Reported code, reported group, detected code, detected group,
  and mismatch are Merchant View export columns with no confirmed Atlas
  equivalent beyond the single RT-1491 callback field.
- Atlas's finding-handling bug backlog shows the gap surfacing in
  production: the callback drops the detected code on every state except
  mismatch (RT-1575), and the expected status for a code-related finding is
  unresolved between UI and automation (RT-1564).
- When a merchant or URL has no declared code, Merchant View still runs
  detection and surfaces the detected code as its own finding. This matters
  independent of mismatch: an undeclared high-risk category is worth flagging
  even with nothing to compare it against.

## Proposed Solution

### Feature Behavior

Define the full set of merchant-category-code behaviors Atlas needs to match
Merchant View, then decide per behavior whether it carries forward, changes, or
is dropped as legacy-only. This discovery does not pick the final behavior; it
lays out what exists in Merchant View against what RT-1491 built, so
the PM can set target scope before `/prd`.

### User Journey

1. An analyst opens a merchant or store record in Atlas.
2. Today: the analyst sees only a pass-through PayPal callback field when a
   mismatch exists; there is no in-product view of the reported code, the
   detected code, or their relationship.
3. Merchant View equivalent: the analyst opens the evidence window for a
   finding and sees both codes, both groups, and an explanation of why they
   match or do not.
4. Open decision: whether Atlas needs this same in-product evidence view, and
   at what level (merchant, store, or URL).

### Assumptions

| Assumption | Current behavior or evidence | Caveat or validation needed |
|---|---|---|
| Merchant View's comparison rule is group-based, not code-based | Confirmed: different codes in the same configured group are a match; different groups create `MCC_MISCODE`. [MCCAdjustmentLogic.java](../../../code-repos-git/merchant-view-legacy-ec/mvnextgen/merchant-processor-job/src/main/java/com/everc/nextgen/mpj/service/scannedmerchant/finding/mcc/MCCAdjustmentLogic.java#L40) | None |
| RT-1491 ships group-level comparison for PayPal | Confirmed: HLD states MLRC compares reported vs. detected MCC and delivers the verdict on the findings callback, states `MATCH, MISMATCH, NO_REPORTED_MCC, NO_DETECTED_MCC, PROCESSING_FAILURE` (Confluence 4213374980) | Scoped to PayPal's GO onboarding path only; not a general in-product capability |
| Atlas's reported code sits on the merchant; detection sits on the store | Confirmed in prior reverse-engineering: `StoreEntity.java` has no store-level reported code | Comparison semantics for a multi-store merchant with one reported code are undefined |
| Atlas's merchant model supports multiple reported codes but no path uses it | Confirmed: "Merchant Category Code, Discovery" (Confluence 4144365571) states the merchant-level multi-code list is latent capability no path populates or displays | Full parity would require deciding whether to populate this or keep single-code |
| Merchant View's evidence UI, report columns, and export are Merchant View-only today | Confirmed: `evidence-mcc.component.html`, `ScanItemReport.groovy` are Merchant View repos; no Atlas equivalent was found beyond the RT-1491 callback field | Re-verify against current Atlas portal before `/spec`; last checked 2026-08-30 |
| A broader MCC capability was deferred, not forgotten | PM decision, 2026-09-01: "Phase 1 = the simple PayPal requirement only; broader MCC capability (verdicts, tiers, scoring, finalize loop) comes later." [[mcc-mismatch feature note]] | This discovery is that later phase; confirm with PM that scope framing is correct |

## Scope

### In Scope

- Enumerating Merchant View's MCC behaviors (reported code entry, detection,
  group comparison, evidence display, report/export columns, dispute/finding
  lifecycle) as candidate Atlas requirements.
- Deciding, per behavior, whether it carries forward unchanged, needs to change
  for Atlas's merchant/store model, or should stay legacy-only.
- The two known production bugs on the existing RT-1491 slice (RT-1575,
  RT-1564), since they affect any broader build on top of that slice.

### Out of Scope

- Core's seven-verdict risk model (Confirmed match, Benign mismatch, Material
  mismatch, Declared high-risk, Under-reported risk, Over-declaration,
  Illegal/Restricted) and the finalize-code workflow. These were explicitly
  named by the PM as later work beyond even this phase; they are a separate,
  larger decision.
- WebShield and Single Platform / GO MCC behavior. GO's manual verification
  workflow (`MccVerificationRepository.java`) is a different mechanism from
  Merchant View's automatic comparison and is not this discovery's reference
  implementation.
- Any new external delivery channel beyond the existing findings callback,
  unless a target behavior requires one.

## Success Signals

- An analyst can see reported code, detected code, and their relationship for
  any merchant or store in Atlas, not only PayPal's callback.
- Report and export output in Atlas carries the same code fields Merchant View
  customers rely on.
- The open multi-store / multi-code comparison question has a documented
  answer instead of being undefined.

## Open Questions

- For a merchant with more than one store, does every store compare against
  the merchant's single declared code, or does each store need its own
  declared code matching Merchant View's per-URL model? Open, pending Mary's
  response.
- Does the merchant-level multi-code list get built out, or does Atlas keep
  single-code like RT-1491 assumes?
- Should the two open bugs (RT-1575 callback field drop, RT-1564 status
  mismatch) block this work or run independently?

## Appendix

### Persona / Target Audience

**Primary user:**
Underwriting/risk analyst, confirmed by the PM. Matches Merchant View's
primary user for this screen, an analyst reviewing scan findings.

**Secondary audience:**
PayPal, as the integrating client consuming the RT-1491 slice through
callback.

**Job to be done:**
Confirm whether a merchant's declared business matches what the site actually
sells, and act on a mismatch through the normal finding and review workflow.

### Data

- Number of users affected: `TBD - not pulled this session`
- Current usage: `N/A - feature not yet built beyond the single RT-1491 callback field; no broader-capability usage exists to measure`
- CS tickets: `TBD - not searched this session`

#### Legacy EverC Mixpanel Analytics

`N/A - this discovery scopes new Atlas capability against legacy Merchant View
behavior; Merchant View usage of MCC screens was not queried this session and
was not in the original reverse-engineering evidence this discovery draws on.`

### Future Considerations

- Core's seven-verdict risk model and finalize-code workflow, once this
  narrower parity question is settled.
- Specialty MCC overlay, which forces a risk floor and license verification
  for regulated verticals, named in the existing feature note as part of
  Core's model but not evaluated here.

## Evidence

- [paypal-mcc-mismatch-reverse-engineering.md](../../paypal-mcc-mismatch/current-state/paypal-mcc-mismatch-reverse-engineering.md), verified 2026-08-30, Strict mode. Source for all Merchant View behavioral citations above.
- Confluence 4213374980, "HLD: MCC Mismatch (RT-1491)", shipped scope and result-state model.
- Confluence 4158947335, "Predictor MCC Match Mismatch - Discovery", RT-1491's own discovery, confirms PayPal-only framing.
- Confluence 4144365571, "Merchant Category Code, Discovery", exists as a prior UP-side discovery; not used as this discovery's base per PM direction to start fresh, but cited here for the one confirmed fact about the latent multi-code list.
- [[mcc-mismatch]], domain feature note, session 2026-09-01, records the PM's phase-1/later-phase scope decision this discovery builds on.
- `domains/atlas/second-brain/hypotheses/mcc-mismatch-phase-1.md`, prior open decisions, now resolved by RT-1491 for the PayPal slice specifically; not resolved for the broader parity question this discovery raises.
