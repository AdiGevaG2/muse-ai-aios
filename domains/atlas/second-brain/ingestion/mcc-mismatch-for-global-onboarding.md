# MCC Mismatch for Global Onboarding

PayPal has made MCC mismatch a gating requirement for a Global Onboarding deal.
The comparison exists in Core and in legacy MerchantView; GO runs through
MLRC/CMP, which consumes MCC but not the mismatch relationship. That gap is the
work.

## The commercial driver

PayPal would cancel a contract with their current vendor to move to our MCC
solution, and mismatch is a **hard requirement** — gating, not an enhancement.
[documented] stakeholder email summary (Mary Williams), supplied by the PM
2026-09-01; original email and PDF attachments not independently opened

The requirement was pushed repeatedly for prioritization and a timeline, tied to
a specific PayPal meeting. [documented] same

## Why it is not already solved

Three facts from the email thread, and they only make sense together:

1. **The logic sits in MerchantView.** [documented] same (Yonatan Eisenberg)
2. **GO is integrated into CMP/MLRC, not MV.** [documented] same (Ishai Froind)
3. Therefore **"to support mismatch in GO we need to support Mismatch in CMP."**
   [documented] same (Ishai Froind)

The open architectural question in the thread was where the logic should live —
move it to Core, or to MLRC. [documented] same

This is a routing problem, not an algorithm problem. The email establishes which
pipeline must have the capability; it says nothing about the comparison rule,
output format, delivery channel, volumes, or what PayPal counts as a mismatch.

## What each platform actually does

| Platform | Behavior | Basis |
|---|---|---|
| MerchantView | Automatic group-based comparison, explicit `MCC_MISCODE` finding, structured evidence, UI, report output | Source-verified |
| MLRC / CMP | Captures reported MCC, enables MCC analysis, dispatches detection to Core, receives generic findings — **no comparison** | Source-verified |
| SP / GO | Captures reported MCC, MCC lookup data, primary/secondary verification records, manual updates — **no automatic comparison** | Source-verified |
| Core | Computes the full comparison, verdicts, and tiers | Documented design only, code unread |
| WebShield | Unknown | Source unavailable |

[documented] `../../../../outputs/paypal-mcc-mismatch/current-state/paypal-mcc-mismatch-reverse-engineering.md` (verified 2026-08-30)
[documented] `../source/2026-09-01-mcc-score-and-ux-folder.md` (Core row)

## MerchantView's rule — the verified reference

The only mismatch behavior confirmed in code anywhere:

- Evaluated at the **scanned-URL level**. A registered URL carries its own
  reported and detected MCC.
- Same configured MCC **group** → match. Different group → creates
  `MCC_MISCODE`.
- **Different codes within the same group do not create a mismatch.**
- Fires only when both a reported and a detected finding exist.
- Evidence carries `reportedMcc` and `detectedMcc`; the UI shows both codes,
  both groups, an explanation, and other MCCs in each group; exports include
  mismatch.

[documented] `../../../../outputs/paypal-mcc-mismatch/current-state/paypal-mcc-mismatch-reverse-engineering.md`

Note the URL-level evaluation — MV sidesteps a problem UP has (below) by putting
both sides of the pair on the same object.

## The scoping decision

**Phase 1 is the simple PayPal requirement; broader MCC capability comes later.**
[verbal] Adi Geva, 2026-09-01

**GO already consumes MCC through MLRC — just not the mismatch relationship.**
[verbal] Adi Geva, 2026-09-01

Those two together reshape the work: phase 1 is likely exposing Core's existing
comparison output through a payload GO already receives, not building comparison
in MLRC. The decision was to keep `Match_risk_level` in phase 1 — it is already
in Core's stated MVP contract ([[mcc-risk-scoring]]), and without it
Gambling→Gambling and Shoes→Gambling collapse into one indistinguishable flag.
[verbal] Adi Geva, 2026-09-01

## Known obstacles

- **Merchant-level declaration vs. store-level prediction.** Reported MCC belongs
  to the UP merchant; findings belong to stores, and the store model has no
  store-specific reported MCC. One merchant, three sites, one declaration, three
  predictions — comparison semantics undefined. [documented] reverse-engineering report (`StoreEntity.java`)
- **Category-ID range in the portal.** The inspected MLRC BFF classifies only
  category IDs 10000–19999 as MCC; MV's mismatch category is ID 76, so a
  forwarded legacy category would not render as an MCC finding. The clone was
  materially stale, so this may already be fixed. [documented] reverse-engineering report (`FindingServiceImpl.java`)
- **Multiple reported MCCs.** The merchant model supports a list, but the
  external create API accepts one and the portal shows the first. [documented] reverse-engineering report
- **Legacy enablement flag conflict.** MV defines `SCAN_FOR_MCC_MISMATCH` while
  the newer processor's paying-customer calculation uses MCC-detection/package
  flags. Should not be copied without clarification. [documented] reverse-engineering report

## Open questions

- **How does PayPal receive mismatch** — API, callback, file export, or UI only?
  No delivery channel is recorded in the email, the Core briefs, the prototypes,
  or the reverse-engineering report. A UI-only result does not satisfy an
  integration requirement. Nobody wrote this down.
- **Volumes.** No merchant or scan count exists in any source read. Analyst
  workload and false-positive impact are therefore unknown.
- **What the Core→MLRC MCC payload carries today**, and what adding the
  relationship fields costs. The payload itself has not been inspected — the
  "add fields to an existing pipe" read is inference from GO already consuming
  MCC.
- Whether mismatch shares `mccEnabled` or needs independent enablement.

Tracked with what would settle each, in
`../hypotheses/mcc-mismatch-phase-1.md`.

## Links

- [[mcc-risk-scoring]] — the Core design this would deliver a subset of.
- [[mcc-grouping-taxonomy]] — the group set behind "same group → match": 39
  business-equivalence groups plus ~18 risky codes held alone. MV's verified
  rule is compatible with it, minus the tier dimension.
- [[merchantview]] — where the working legacy implementation lives.
- [[crawler-capability-gaps]] — MCC detection accuracy upstream; a mismatch is
  only as good as the prediction feeding it.
- [[atlas-architecture]] — the target platform and its migration
  posture.
- [[mcc-verification-brick-and-mortar]] — Visa HK's separate ask to extend MCC
  verification to physical merchants. Adjacent problem, different evidence
  source (no crawlable URL); not in phase-1 scope.
- [[go-policy-analysis-vars-fiserv]] — GO's Fiserv-driven Policy Analysis
  component also runs MCC checks (restricted-category, import/export lookup),
  but narrower than this group-based comparison; unconfirmed whether they
  share a pipeline.
