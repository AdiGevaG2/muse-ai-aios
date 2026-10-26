# MCC Risk Scoring

The Core group's design for turning reported-vs-predicted MCC into one tier a
client can act on: seven verdicts, two risk axes, a specialty overlay, and a
finalize step that doubles as the model's training loop.

## The premise

A merchant declares an MCC (merchant category code) on application; a website
scan predicts one. The relationship between those two codes is the product —
not either code alone. [documented] `../source/2026-09-01-mcc-score-and-ux-folder.md`

Today clients synthesize that relationship themselves. The stated goal is one
score and one tier, fully traceable, tunable to the client's risk appetite.
[documented] same

## The four design principles

These are the load-bearing product decisions, and they explain most of the rest.

1. **Interpretation, not detection.** Clients configure thresholds, routing, and
   overrides. They never configure the prediction, the verdict computation, or
   whether the breakdown is visible. The brief calls that boundary "the
   integrity of the product." [documented] same
2. **A mismatch is not one thing.** "Reported ≠ predicted" is never a single
   flag. Same-group, same-band pairs (Shoes vs. Sports Shoes) are honest
   imprecision. **The MCC group, never numeric code proximity, is the proxy for
   "same business."** [documented] same
3. **Direction matters.** Reported Low / predicted High is the suspected
   malicious direction. The reverse is at worst sloppy. Two "mismatches",
   opposite meanings. [documented] same
4. **Observation, not intent.** Labels describe a classification discrepancy and
   its severity, never merchant intent. The concealment reading is analyst-facing
   and framed as "consistent with" — deliberately legal-safe. [documented] same

## Two axes, one tier

Every merchant is scored on two independent axes whose *combination* sets the
tier:

- **Business risk** — what they actually sell, taken as the higher-risk band of
  reported vs. predicted.
- **Transparency risk** — how honestly they declared it, driven by the
  relationship and its direction.

This is why Gambling→Gambling lands at High and Shoes→Gambling at Critical —
both "high-risk merchants", two tiers apart. [documented] same

## The seven verdicts

The verdict says *why*; the tier says *how severe*. Two merchants can share a
tier and route to completely different work.

| Reported | Predicted | Verdict | Tier | Routes to |
|---|---|---|---|---|
| Low | Same MCC | Confirmed match | Very Low | Auto-approve eligible |
| Low | Same group, same band | Benign mismatch | Very Low | Treated as a match |
| Low | Different group, low/med | Material mismatch | Elevated | Review, not investigation |
| High | Same MCC | Declared high-risk | High | Licensing / jurisdiction verification |
| Low | High-risk MCC | Under-reported risk | Critical | Investigation or decline |
| High | Low-risk MCC | Over-declaration | Low | Informational |
| Specialty on either side | | Specialty overlay | Floor: Elevated | Mandatory verification |

[documented] same

Declared high-risk has nothing to investigate — the merchant told the truth and
the work is administrative. Under-reported risk has something to dig into. Same
family of finding, opposite queues. [documented] same

**Known internal conflict:** the brief's matrix puts Over-declaration at tier
**Low**; the prototype scores it 68 / **High**, reasoning that a declared
specialty code still carries obligations so business risk holds the tier up.
Unresolved between the two artifacts. [documented] same

## The MVP cut

The brief names its own minimum: `Reported_MCC`, `Predicted_MCC`, `MCC_risk`
(where predicted > reported), `Match`, `Match_risk_level`. [documented] same

This matters well beyond the Core team — it is the output contract any consuming
pipeline would wire to, and it is what makes a phased delivery of
[[mcc-mismatch-for-global-onboarding]] possible without shipping the whole
scoring product.

## What the client can configure

Seven settings, all living in one portfolio-settings surface. Defaults are the
verdict matrix, so a client who configures nothing still gets sensible
behavior. [documented] same

Risk-level overrides · match short-circuit (green lane) · adjacency tolerance ·
tier thresholds and routing · recommendation-vs-automation per verdict ·
under-reporting floor · evidence and verification requirements.

Two are worth remembering:

- **The under-reporting floor is a one-way dial.** Clients can raise the minimum
  tier for Under-reported risk, never lower it below High. A permissive
  configuration cannot silence the concealment-shaped signal. [documented] same
- **Every routed action starts as a recommendation.** The stated progression is
  suggest → analyst confirms → automate once trusted, explicitly framed around
  human-in-the-loop and end-user trust. [documented] same

## Finalize — where the feedback loop lives

Added in v2 of the brief (2026-08-19); absent from v1. The analyst closes an
assessment by finalizing an MCC: accept reported, accept predicted, or enter a
third code. The client gets a definitive **MCC of record**; we get a training
label. The brief's own justification: "nobody is doing data-labelling as a
favour." [documented] same

Three labels: `prediction_confirmed` (model right, merchant misreported),
`prediction_rejected` (model wrong, or immaterial), `both_wrong` — described as
the highest-value label and the reason manual entry exists. [documented] same

Three rules keep it honest:

1. **The default never lowers risk.** Where codes disagree, the higher band is
   pre-selected — except Material mismatch, where nothing is pre-selected
   because a suggestion there "would harvest agreement, not information."
   [documented] same
2. **Finalizing does not erase the finding.** The original pair and verdict stay
   in history. Finalizing below what the evidence supports is an exception,
   requires a reason code, and is logged. [documented] same
3. **Default-acceptance is recorded separately.** Most users accept defaults, so
   confirmations are weak evidence and changes are strong. The flag exists so
   the two can be weighted differently rather than training the model on its own
   suggestions. [documented] same

Finalizing also **sets the Change Monitoring baseline** — later scans compare
against the finalized code, not the original application code, so a resolved
mismatch goes silent. An exception finalization is never silently suppressed: it
resurfaces at reduced urgency with its reason attached. [documented] same

## Evidence in the folder

Two briefs (v1 2026-08-09, v2 2026-08-19) and two HTML prototypes. Five Python
files — `mcc_risk.py`, `mcc_riskV3.py`, `mcc_reference.py`,
`mcc_referenceV3.py`, `build_referenceV3.py` — **could not be read**; the
SharePoint connector rejects `.py`. [documented] same

Two consequences worth carrying:

- Everything above is documented design, **not code-verified behavior**. The
  prototype claims its scenarios "mirror `mcc_risk.py` output on production MCC
  groupings", and one code comment references a `ValueError` in
  `mcc_risk.finalise()` — so an implementation exists and enforces at least the
  exception rule. Its actual thresholds are unread.
- Three files carry a **V3 suffix, dated 2026-08-10** — later than v1 and
  earlier than v2. There may be a revision of the reference data or scoring that
  neither brief describes.

## Open questions carried from the brief

- Adjacency: do any MCC groups mix risk bands widely enough to need splitting or
  a curated exception list? [documented] same — **partly answered.**
  [[mcc-grouping-taxonomy]] names five such codes (4829, 6540, 5933, 9223, 5921)
  and proposes re-tiering rather than splitting. Still undecided.
- False positives already sent to clients — dispute flow, per-merchant verdict
  override, logged as exception, or raised to K9? [documented] same

## Why this matters here

[[crawler-capability-gaps]] records that **three separate MCC efforts** exist
across the merged company — Crolex (live for WebShield, imperfect), G2 internal,
and EverC's MerchantView — and that MCC detection is "live, but not accurate
enough for full rollout". This folder is the Core group's answer on the
*interpretation* half of that problem, and it assumes a prediction it does not
itself produce. It does not resolve the detection-accuracy gap; it sits
downstream of it.

The distinction is easy to lose in a meeting: **detection** says what we think
they sell, **scoring** compares that to what they claimed. Only the second is
described here.

## Links

- [[mcc-mismatch-for-global-onboarding]] — the PayPal-driven delivery of a
  subset of this into the MLRC pipeline.
- [[crawler-capability-gaps]] — the detection-accuracy gap upstream, and the
  three-efforts collision.
- [[mcc-grouping-taxonomy]] — the group set this design's "same business?" axis
  runs on: 39 business-equivalence groups, ~18 stand-alone risky codes, and the
  per-MCC tier that stays orthogonal to grouping.
- [[merchantview]] — holds the legacy group-based comparison this design
  generalizes.
- [[atlas-architecture]] — where a UP-side consumer would sit.
