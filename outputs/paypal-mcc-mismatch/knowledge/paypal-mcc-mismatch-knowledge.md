# MCC Mismatch

> **What this doc is.** An explanation of what this feature is and why it
> exists, for anyone who needs to understand it without building it. It is not
> a spec — it does not define required behavior, and `spec.md` overrides it
> wherever they differ.

| Field | Value |
| --- | --- |
| Product Area | Atlas — merchant risk / onboarding |
| Primary user | Underwriting or risk analyst assessing a merchant; PayPal as an integrating client |
| Where it lives | Core computes it today; must surface through MLRC/CMP for Global Onboarding |
| Status | In build — Core mechanism exists, MLRC exposure does not |
| Owner | Core-side MCC work: Gal Sahar. Application/MLRC side: not recorded — worth asking the team |
| Last verified | 2026-09-01 |
| Verified by | Adi Geva |

---

## In one line

MCC mismatch checks whether the business category a merchant declared on their
application matches the business we can see them actually running on their
website, and flags it when they materially disagree.

**Who uses it:** Underwriting analysts during merchant onboarding, and PayPal
as an integrating client. **Usage unknown** — no merchant or scan volumes were
available in any source read for this doc, and neither Mixpanel nor Looker was
queried. Do not read that silence as low usage.

## Why it exists

Every merchant declares an **MCC** — a four-digit merchant category code saying
what they sell (5661 is shoe stores, 7995 is betting and gambling). Acquirers
price risk, apply rules, and meet card-scheme obligations based on that code.
A merchant who declares shoes and actually runs a casino gets underwritten as a
shoe shop, which is the exposure this feature closes.

PayPal has made mismatch support a **hard requirement** — a gate on a Global
Onboarding deal, not an enhancement, per Mary Williams relaying PayPal's
position. PayPal would be cancelling a contract with their current vendor to
move to our MCC solution.

## How it works, end to end

1. **Merchant applies** — they declare their MCC on the application. This is
   the **reported MCC**.
2. **We scan their website** — our crawl and classification produce a
   **predicted MCC** (also called "detected MCC" in older documents): the code
   the observed content supports.
3. **The two are compared** — not as raw four-digit numbers, but by **MCC
   group**, the configured taxonomy that groups related codes. Two different
   codes in the same group count as a match.
4. **A relationship comes out** — match, or a mismatch qualified by direction:
   did the merchant declare *lower* risk than we observe, or higher?
5. **The analyst sees it** — reported code, predicted code, the relationship,
   and the website pages the prediction was based on.

Why group-based rather than exact-code: Shoe Stores versus Sports Shoes is
honest imprecision that does not change anyone's exposure. Comparing raw codes
would flood analysts with mismatches that mean nothing.

Why direction matters: a shoe shop whose site sells clothing is sloppy
paperwork. A shoe shop whose site is a casino is a pattern **consistent with
concealment**. A single yes/no mismatch flag cannot tell those apart, which is
why the Core design splits them.

## What it does *not* do

**By design:**
- **It does not accuse anyone of fraud.** The output describes an observed
  classification discrepancy and its severity, not merchant intent. Labels are
  deliberately neutral.
- **It does not treat every disagreement as a problem.** Same-group codes are
  treated as a match, not a finding.
- **It does not let clients tune the detection.** In the Core design, clients
  configure interpretation and action — thresholds, routing, overrides — never
  the prediction or the comparison itself.
- **It does not apply where no MCC fits.** Where observed activity is
  prohibited outright, no code applies, so no mismatch is assessed; that
  finding stands on its own.

**Not yet / known limits:**
- **It does not reach Global Onboarding today.** The comparison exists in Core
  and, in legacy form, in MerchantView. GO runs through the MLRC/CMP pipeline,
  which consumes MCC but not the mismatch relationship. Closing that is the
  current phase of work.
- **How PayPal receives the result is undefined.** No API, callback, file
  export, or report has been recorded anywhere. A result that only appears in
  our UI does not meet an integration requirement.
- **Multi-site merchants are unresolved.** The declared code sits on the
  merchant; predictions attach to individual stores. One merchant with three
  websites has one declaration and three predictions, and nobody has decided
  what a mismatch means in that case.
- **No volumes exist.** Nobody has recorded how many merchants this would flag,
  which makes the analyst-workload impact unknown.

## Where it sits

| Relationship | What | Why it matters here |
| --- | --- | --- |
| Depends on | Website crawl and MCC classification (Core) | No prediction means no comparison — only one side of the pair exists |
| Depends on | Reported MCC captured at application | Same: both sides must exist before match or mismatch means anything |
| Feeds | Global Onboarding (GO), via the MLRC/CMP pipeline | GO is the product PayPal is buying; this is the gating requirement |
| Feeds | Change monitoring | Later scans compare against the settled code, so a resolved case does not re-raise every scan |
| Often confused with | MCC *detection* | Detection says what we think they sell. Mismatch is the comparison against what they claimed. Detection already ships; mismatch does not |
| Often confused with | MerchantView's existing mismatch | MerchantView has had this for years. It does not help GO, because GO does not run through MerchantView |

---

<!-- Everything below the fold is for the PM and the build team. -->

## Open questions

| Question | What would settle it | Who to ask | Blocks |
| --- | --- | --- | --- |
| How does PayPal consume mismatch — API, callback, file, or UI? | The PayPal integration contract, or a direct answer | Mary Williams | Launch |
| What does the Core→MLRC MCC payload carry today, and what does adding the relationship fields cost? | 15 min on the current message contract | Core team (Gal Sahar) | Spec |
| One declared MCC, several store predictions — what is the mismatch? | A product decision, informed by how many GO merchants are multi-site | PM, with portfolio data | Spec |
| Would a forwarded mismatch actually render as an MCC finding in the portal? | Re-read `FindingServiceImpl.java` at current tip | MLRC team — owner not recorded | Spec |
| How many merchants would this flag, and at what analyst cost? | A Looker or Mixpanel pull | Not attempted this session | Nothing yet |

## Confidence and sources

Every claim above traces to something read, or is marked as a gap. Labels:
**read in code** · **read in a doc** · **inferred** · **nobody wrote this down**.

| Claim | Basis | Source |
| --- | --- | --- |
| Mismatch is a hard PayPal requirement, gating a GO deal | read in a doc | Stakeholder email summary (Mary Williams), supplied 2026-09-01 |
| GO integrates into CMP/MLRC, not MerchantView | read in a doc | Same email (Ishai Froind) |
| Mismatch logic currently sits in MerchantView | read in a doc | Same email (Yonatan Eisenberg) |
| MV compares by MCC group; same group is a match; different group creates a mismatch finding | read in code | `current-state/paypal-mcc-mismatch-reverse-engineering.md` (`MCCAdjustmentLogic.java`, unit tests) |
| No mismatch comparison exists in the MLRC services | read in code | Same report — inspected `mlrc-analysis`, `mlrc-finding`, `mlrc-merchant`, `mlrc-bff` |
| Core has a working comparison, output contract, and mismatch definition today | read in a doc | Gal Sahar, `MCC Risk - Unified Output & Client Configuration v2.docx`; `mcc-risk-card-prototype-v2.html` |
| Direction of the risk delta changes the meaning of a mismatch | read in a doc | Same brief |
| Clients configure interpretation, never detection | read in a doc | Same brief |
| GO already consumes MCC, but not the mismatch relationship | stated by the PM | Adi Geva, 2026-09-01 |
| Reported MCC is merchant-level while findings are store-level | read in code | Reverse-engineering report (`StoreEntity.java`) |
| Portal may not classify a forwarded legacy mismatch as MCC | read in code, but on a stale clone | Reverse-engineering report (`FindingServiceImpl.java`) |
| PayPal's delivery channel | nobody wrote this down | Absent from the email, the Core brief, and the reverse-engineering report |
| Volumes | nobody wrote this down | Absent from all sources read |

**Not verified:**
- That the current phase is a field-level addition to an existing Core→MLRC
  payload rather than new plumbing. This follows from GO already consuming MCC,
  but the payload was not inspected — treat it as inference.
- Core's comparison rule is known from the product brief and the UI prototype.
  The underlying `mcc_risk.py` could not be opened by the SharePoint connector,
  so the rule is documented, not code-verified.
- The portal category-ID limitation comes from a clone that was materially
  stale on 2026-08-30. It may already be fixed.
- WebShield behavior was never verified — its source was unavailable.

**Numbers used in this doc:**

None. No metric is cited anywhere above.

Neither Mixpanel nor Looker was queried in this session. Had they been, they
would have answered how many merchants a mismatch check would flag and at what
rate — which is the missing input for analyst-workload and false-positive
impact. The Core team's own folder contains no volume figures either.

## Keeping this current

This doc describes the feature as of **2026-09-01**. It is explanation, not a
controlled document — it does not need an approval to change, but a stale doc
that reads as current is worse than none.

- Re-verify when the feature changes materially, or every 6 months.
- If it contradicts `spec.md`, the spec wins — fix this doc.
- If it contradicts `prd.md` on **product intent**, that is PRD drift. Do not
  quietly write the new behavior forward here; raise it with the PM.
