# Source — SharePoint: Gal Sahar › "MCC score and UX" (entire folder)

Captured: 2026-09-01
Origin: `https://g2risk-my.sharepoint.com/personal/gal_sahar_g2risksolutions_com/Documents/MCC score and UX/`
Owner of the folder: Gal Sahar (Core group)
Captured by: Adi Geva

## Folder inventory

| File | Modified | Captured here |
|---|---|---|
| `MCC Risk - Unified Output & Client Configuration-V1.docx` | 2026-08-09 | Full text below |
| `MCC Risk - Unified Output & Client Configuration v2.docx` | 2026-08-19 | Full text below |
| `mcc-risk-card-prototype.html` | 2026-08-06 | Not captured — superseded by v2 |
| `mcc-risk-card-prototype-v2.html` | 2026-08-09 | Behavioral extract below |
| `mcc_risk.py` | 2026-08-06 | **NOT CAPTURED** — connector rejects `application/octet-stream` |
| `mcc_riskV3.py` | 2026-08-10 | **NOT CAPTURED** — same |
| `mcc_reference.py` | 2026-08-06 | **NOT CAPTURED** — same |
| `mcc_referenceV3.py` | 2026-08-10 | **NOT CAPTURED** — same |
| `build_referenceV3.py` | 2026-08-10 | **NOT CAPTURED** — same |

The five Python files hold the implemented comparison and reference data. The
SharePoint connector cannot read `.py` (MIME `application/octet-stream` is not
in its allowlist). Everything recorded about the algorithm here is therefore
from the briefs and the prototype, not from the code. Note the V3 suffix on
three files, all dated 2026-08-10 — a later revision than either brief.

---

# V1 — "MCC Risk: Unified Output & Client Configuration"
Product brief for the application PM · July 2026 · file modified 2026-08-09

MCC risk has three ingredients - the merchant's reported MCC, our predicted MCC,
and the relationship between them - plus a specialty-MCC overlay for regulated
verticals. Today the client synthesizes these themselves. The goal: one score
and one tier they can act on, fully traceable, tunable to their risk appetite.

## 1. At a glance

Reported MCC code + risk band | Predicted MCC code + risk band | Specialty list
check
↓
Relationship — match · adjacent mismatch · divergent mismatch (+ direction of
the risk delta)
↓
Verdict — one of seven explicit findings - the "why" behind the risk
↓
Score/Categorical + Tier — Very Low · Low · Elevated · High · Critical
↓
Client-configured action — auto-approve · review · monitor · snooze · verify ·
decline → recommended first, automated when trusted

## 2. Design principles

- **Interpretation, not detection** - Clients configure interpretation and
  action - thresholds, routing, overrides. They never configure detection: the
  prediction, the verdict computation, and the breakdown's visibility are fixed.
  That boundary is the integrity of the product.
- **A mismatch is not one thing** - "Reported ≠ predicted" is never a single
  flag. Adjacent codes - same MCC group and same risk band (Shoes vs. Sports
  Shoes) - are honest imprecision, where the substitution wouldn't materially
  change the client's exposure. The MCC group, never numeric code proximity, is
  the proxy for "same business".
- **Direction matters** - The direction of the risk delta matters.
  Under-reporting risk (reported Low, predicted High) is the suspected
  malicious direction; over-reporting is at worst sloppy. Two "mismatches",
  opposite meanings.
- **Observation, not intent** - We report what we observe (a classification
  discrepancy and its severity), not merchant intent. Verdict labels are
  neutral; the concealment story lives in the analyst-facing reading, framed as
  "consistent with".

## 3. Two risks, one output

Every merchant is scored on two independent axes. Their combination - not either
alone - determines the tier:

- **Business risk** - what the merchant actually sells, per the higher-risk of
  reported vs. predicted MCC.
- **Transparency risk** - how honestly they told us. Driven by the relationship
  and its direction.

| Example | Business risk | Transparency risk | Tier | Why |
|---|---|---|---|---|
| Shoes → Shoes | Low | Low | Very Low | Both axes clean. |
| Shoes → Sports Shoes | Low | Low | Very Low | Adjacent = honest imprecision. |
| Gambling → Gambling | High | Low | High | Risky, but transparent. |
| Shoes → Gambling | High | High | Critical | Risky and misreported. |

This is why Gambling→Gambling and Shoes→Gambling — both "high-risk merchants" —
land two tiers apart.

## 4. The verdict matrix

The verdict describes the nature of the finding; the tier describes its
severity. Two merchants can share a tier with different verdicts - and therefore
different actions (Declared high-risk → licensing verification; Under-reported
risk → investigation). Mapping the specific risky MCCs to their next step, be it
via reccomendation OR by enabling the next check in line, is crucial to propel
action. Every merchant lands in exactly one verdict; the score/level positions
them within the tier. Analysts think in stories - the verdict answers "why is it
78?" before it's asked.

| Reported | Predicted | Verdict | Tier | Reading |
|---|---|---|---|---|
| Low risk | Same MCC | Confirmed match | Very Low | Low-risk business, correctly reported. Auto-approve eligible. |
| Low risk | Same MCC group, same band | Benign mismatch | Very Low | Same MCC group, same risk band. Treated as a match. |
| Low risk | Different group, low/medium risk | Material mismatch | Elevated | Activity differs materially from reported (Restaurant → Travel Services), but no move into high risk. Disclosure-accuracy issue — review, not investigation. |
| High risk | Same MCC | Declared high-risk | High | High-risk by definition, but transparent. Routes to licensing / jurisdiction verification — not a deception signal. |
| Low risk | High-risk MCC | Under-reported risk | Critical | High-risk activity, low-risk reporting — pattern consistent with concealment. Escalate to investigation or decline per portfolio policy. |
| High risk | Low-risk MCC | Over-declaration | Low | Reports riskier than they appear. Informational; possible misconfiguration. |
| Specialty MCC on either side | | Specialty overlay | Floor: Elevated | Applies on top of any verdict. Mandatory verification (e.g., license check) even on a perfect match. |

"Material mismatch" and "Under-reported risk" deliberately describe the
observation, not intent - a mismatch does not prove concealment. Legal-safe
labels, analyst-useful readings.

## 5. What the client sees

One headline, four layers, each one click deeper:

- **Score/Level** - TBD, MRH component?
- **Tier** - Very Low → Critical - what most clients key decisions on (the
  ability to sort by risk).
- **Traceable breakdown** - reported MCC · predicted MCC · verdict chip · both
  axes. The client never wonders why the score is what it is.
- **Evidence** - screenshots of the page(s) the prediction is based on. Turns
  "the model disagrees with you" into "here is your site selling X." Critical
  for disputes and audit trail.
- **MVP:** Reported_MCC, Predicted_MCC, MCC_risk (where predicted > reported),
  Match and Match_risk_level.

The prototype's MCC Risk card (score + tier bar + one-line context) stays as the
headline; breakdown + evidence become its expanded state.

## 6. What the client can configure

In plain terms: thresholds decide which bucket a score falls into; routing
decides what the system does next. Routing keys off the verdict, not just the
tier - two "High" merchants act differently because their stories differ.

Declared high-risk has nothing to investigate (the merchant told the truth; the
work is administrative - validate licence and jurisdiction), so it gets
recommended next steps. Under-reported risk has something to dig into (why does
a shoe store's site show a casino?), so it goes to investigation.

Every routed action runs in one of two modes, and in which we can agilely work
towards reccomendation/automation/capability enablement – This is also
considering the Human-in-the-loop, and trust building with our end users:

- **Recommendation:**
  - The platform suggests the next step, an analyst does it.
  - The platform suggests the next step, an analyst confirms it.
  - → Trust is built
- **Recommendation → automation** (it just happens), analyst reviews post
  factum.

| Setting | What it does | Example |
|---|---|---|
| Risk-level overrides | Reassign any MCC's risk level to the portfolio's appetite. | Crypto-friendly acquirer downgrades 6051 High → Elevated. |
| Match short-circuit – green lane | On a confirmed match, skip all further MCC review - unless a specialty code is involved. | "If match, don't review anything other than specialty MCC." |
| Adjacency tolerance | Treat same-MCC-group, same-band mismatches as matches (on/off, or group granularity). | Shoes vs. Sports Shoes never opens a review. |
| Tier thresholds & routing | Score/Levels cutoffs per tier; action per tier/verdict: auto-approve, review, monitor, snooze, decline, recommendations/auto | Under-reported risk → investigation queue; Declared high-risk → recommended next steps: "validate licence / jurisdiction". |
| Recommendation vs. automation | Per verdict, whether the routed action fires automatically or surfaces as a recommendation an analyst confirms. | Start all verdicts on recommendations; automate auto-approve for Confirmed match once trusted. |
| Under-reporting floor | The Under-reported-risk verdict has a minimum tier - a one-way dial: clients can raise it, never lower it below High. A permissive configuration can't silence the concealment-shaped signal. | Conservative portfolio pins it to Critical. |
| Evidence & verification | Require evidence attachment on mismatch verdicts; wire specialty codes to paid verification (e.g., per Mary's prototype's $5 license-check flow). | License verification billed under MSA for 5912. |

All of it lives in the prototype's portfolio-settings surface, next to
monitoring cadence. Defaults = the matrix above; a client who configures nothing
still gets sensible behaviour.

## 7. Where this meets the client (UX mapping)

- **MCC Risk card** - headline score + tier badge, unchanged. Expanded: reported
  vs. predicted rows, verdict chip, evidence thumbnails.
- **Queues/Actions** - verdicts are routing keys. Under-reported risk →
  investigation queue with evidence pre-attached; Declared high-risk →
  recommended next steps (validate licence / jurisdiction) → Enabled in-app next
  steps → automatable once trusted.
- **Monitoring** - MCC drift (already in Change Monitoring) reuses the same
  verdict logic - a matched Low drifting to a predicted High is under-reported
  risk appearing post-onboarding.
- **Portfolio settings** - all MCC configuration in one place per portfolio.

## 8. Open questions

- Adjacency: MCC group is the agreed proxy for "same business". Do any groups
  mix risk bands widely enough to need splitting or a curated exception list?
- How do we want to treat FPs we sent our clients? E.g., Dispute flow:
  per-merchant verdict override by the client? logged as an exception? Raised to
  K9?

---

# V2 — same title, file modified 2026-08-19

V2 is identical to V1 through §6 (verbatim, including the same typos). Two
material changes, both about closing the loop:

**New §7 — "Finalize — the MCC of record and the feedback loop"** (V1 has no
equivalent; V1's §7 becomes V2's §8, and V1's §8 becomes V2's §9).

> The client closes an assessment by finalizing an MCC: accept the reported
> code, accept the predicted one, or enter the correct code via autocomplete.
> They get a definitive MCC of record; we get a label. The same click serves
> both sides, which is what makes the loop sustainable — nobody is doing
> data-labelling as a favour. The pre-selected option is whatever the logic
> already decided, with one deliberate exception noted below.

| Verdict | Pre-selected | Why |
|---|---|---|
| Confirmed match / Declared high-risk | The matched code | Both sides already agree. |
| Benign mismatch | Reported | Same group, same band — the merchant's own words stand. |
| Material mismatch | Nothing — explicit choice | The case we are least confident about. A pre-selection here would harvest agreement, not information. |
| Under-reported risk | Predicted | Evidence-backed, and the higher band. |
| Over-declaration | Reported | Keeps the higher declared band. |
| Restricted / Illegal activity | Nothing to finalize | No MCC applies — resolve as approve/decline. |

> Two rules keep this honest.
>
> - **The default never lowers risk** — Where the two codes disagree, the higher
>   band is pre-selected. The same principle as the business-risk floor: the
>   default is never the risk-lowering option.
> - **Finalizing does not erase the finding** — Finalizing sets the MCC of
>   record; the original pair and verdict stay in history. Finalizing below the
>   level either side supports is an exception: it requires a reason code and is
>   logged as one. This is the dispute/override flow.
>
> What is deliberately not an exception: accepting our high-risk prediction on
> an under-reporting case drops the tier from Critical to High. Correcting the
> record settles the transparency question, so High — a declared high-risk
> merchant — is the right landing place. An exception means finalizing below the
> evidence, not resolving it.

Three labels come out of it:

| Client action | Label | What it teaches us |
|---|---|---|
| Accepted our predicted code | `prediction_confirmed` | Model right, merchant misreported. |
| Accepted the reported code | `prediction_rejected` | Model wrong, or the difference was immaterial — the reason code tells us which. |
| Entered a third code | `both_wrong` | Merchant and model were both wrong. The highest-value label, and the reason manual entry matters. |

> Every finalization also records whether the default was accepted. Most users
> accept defaults, so confirmations are weak evidence and changes are strong —
> the flag is what lets us weight them differently later, instead of training on
> our own suggestions.
>
> Finalizing also sets the Change Monitoring baseline. Later scans compare new
> predictions against the finalized code, not the original application code —
> otherwise every scan re-raises a mismatch the client already resolved. A
> settled pair is silent. A genuinely new prediction re-raises normally. An
> exception finalization is never silently suppressed: it resurfaces at reduced
> urgency with its reason attached, because "we decided to ignore this" is
> exactly the decision that should stay visible on the tenth scan.

**Changed monitoring bullet in the UX mapping.** V1: "MCC drift (already in
Change Monitoring) reuses the same verdict logic - a matched Low drifting to a
predicted High is under-reported risk appearing post-onboarding." V2: "MCC drift
reuses the same verdict logic, measured against the finalized MCC of record (§7)
rather than the original application code. A finalized Low drifting to a
predicted High is under-reported risk appearing post-onboarding."

V2's open questions (§9) are unchanged from V1's §8.

---

# `mcc-risk-card-prototype-v2.html` — behavioral extract

Modified 2026-08-09. Self-describes as: "Collapsed headline → expanded traceable
breakdown. Pick a scenario; toggle the specialty overlay. Click the card to
expand/collapse. **Scenarios mirror `mcc_risk.py` output on production MCC
groupings.**"

That last clause is the only stated link between the prototype's numbers and the
implemented code.

## Seven scenarios, with the scores and codes the prototype asserts

| Scenario | Pair | Score | Tier | Business / Transparency |
|---|---|---|---|---|
| Confirmed match | 5661 Shoe Stores → 5661 | 8 | Very Low | Low / Low |
| Benign mismatch | 5661 Shoe Stores → 5691 Men's & Women's Clothing | 12 | Very Low | Low / Low |
| Material mismatch | 5812 Restaurants → 4722 Travel Agencies | 46 | Elevated | Low / Medium |
| Declared high-risk | 7995 Betting & Gambling → 7995 | 71 | High | High / Low |
| Under-reported risk | 5661 Shoe Stores → 7995 Betting & Gambling | 93 | Critical | High / High |
| Over-declaration | 7995 Betting & Gambling → 5661 Shoe Stores | 68 | High | High / Low |
| Illegal / Restricted | 5661 → no MCC applies | 100 | Critical | High / n/a |

Note the Over-declaration row: the brief's §4 matrix puts Over-declaration at
tier **Low**, but the prototype scores it 68 / **High**, with the reading
"Merchant reports riskier than observed — likely misconfiguration. But a
declared specialty MCC still carries its own obligations, so business risk holds
the tier at High." The prototype's stated rule is that business risk is the
higher band of the two sides, which produces High. The brief and prototype
disagree here.

## Mechanics the prototype encodes

- **Tier order:** `verylow, low, elevated, high, critical`.
- **Risk bands:** Low, Medium, High, plus `n/a` rendered as "not assessed".
- **Specialty overlay:** floors tier at Elevated and raises score to at least
  40; adds "License verification required before approval ($5.00/check, billed
  under MSA)".
- **Business risk = the higher band of the two sides** (`Math.max` over band
  rank), stated in a code comment.
- **Finalize default** = the higher-band side; `null` for Material mismatch and
  for Illegal (nothing to finalize).
- **Exception rule:** finalizing to a band below the business-risk rank is an
  exception, requires a reason code, and cannot submit without one. A code
  comment says this "mirrors the ValueError in `mcc_risk.finalise()`" — evidence
  the Python implements the same guard.
- **Reason codes offered:** `merchant_evidence`, `site_outdated`,
  `mixed_business`, `model_error`, `immaterial`.
- **Finalize record fields:** `label`, `source` (reported/predicted/manual),
  `default_accepted`, and `exception` + `reason` when applicable.

## MCC groups named in the prototype's catalog slice

Fashion (5661, 5691, 5641) · Food and Beverage (5812, 5814, 5499) · Travel and
Transportation (4722) · Sporting Goods (5941) · Software and Electronics (5732)
· Specialty (37) — 7995, 7801, 9406 · Specialty (38) — 5912 · Specialty (40) —
6051 · Specialty (35) — 5967 · Specialty (47) — 5993.

The numbered "Specialty (nn)" group labels imply a production group-ID
taxonomy; the slice here is described as "a slice of the production code list
for the autocomplete demo", not the whole taxonomy.
