# ZineSec Group

Three companies acquired by G2RS, of which WebShield is the piece that matters
for merchant risk. Not integrated with G2RS — integration was paused when the
EverC transaction appeared.

Source: `source/2025-10-20-everc-g2rs-kt-day1.md` (Jeremy).

## Terminology — three names, carefully distinguished

[documented] Jeremy defined these explicitly, because "there's a lot of
terminology to become familiar with":

**ZineSec Group** = a collection of ~3 companies:
1. **Wiser** — digital transformation work, primarily for the **Maltese
   government**
2. **WebShield** — merchant monitoring, transaction laundering
3. **ZineSec** (original) — **identity verification / KYC**

[documented] "When I speak to WebShield, I'm specifically talking about the
merchant monitoring, transaction laundering capabilities."

[inference] For this domain, WebShield is the relevant entity. Wiser (government
digital transformation) and KYC/identity verification are adjacent businesses
that don't obviously touch merchant risk classification — but note that KYC
capability now sits inside the group, unmentioned in any merchant-risk
discussion.

## Integration status — paused

[documented] The single most important fact here. Platforms are **not merged**:

- "We have not merged platforms."
- "We have plans, we have ideas. But frankly, some of those plans and ideas got
  interrupted by this activity with EverC."
- "That's been going on now for several months, so we really paused on a lot of
  those activities while we waited to see how this would play out."

[documented] Consequence for the KT itself: Jeremy stated the goal was not only
to educate EverC on G2RS, but on **WebShield and ZineSec as separate platforms**.

[inference] So the merged company has at least three unintegrated platform
estates — G2RS, WebShield/ZineSec, EverC — and the second was mid-integration
when the third arrived. [[crawler-consolidation]] is one visible symptom;
[[atlas-architecture]] is EverC's internal convergence proceeding on
a separate track, apparently unaware of the other two.

## What WebShield brings technically

See [[crolex]] for the crawler in detail. Summary of what's genuinely additive:

- Browser rendering by default
- Live MCC detection (analyst-grade accuracy, not automation-grade)
- Website compliance extraction (T&C, privacy, refunds, governing law, legal
  entity)
- Change detection POC aimed at replacing a paid third-party vendor
- Agentic marketplace crawling POC

[documented] Volume is small relative to G2RS: ~200K seeds/month against G2RS's
5.3M merchants/month, though page depth per site is far higher (up to 500 for
Investigate vs. G2RS's ~50 average).

[documented] Products named: **Investigate** and **Monitor**, distinguished by
page limit.

## People

[documented] **Daniel Grash** — CTO of ZineSec Group. Presented Crolex. Continued
maintaining the service post-acquisition pending investment decisions.

[documented] **H-Tech** — a European firm engaged as part of the ZineSec
acquisition to help think through integration strategy. **Zombor** presented
their assessment. Method: code analysis, engineer interviews, static code
analyzers, producing evidence-based heat maps and a risk registry, for both
ZineSec/WebShield and G2. Zombor's own caveat: "some scores are a little bit
subjective."

[inference] Worth knowing that an independent third party has already produced a
risk registry and heat maps across both estates. That artifact would answer
several open questions in this wiki and has not been located.

## Open questions

- Where is H-Tech's full assessment — heat maps and risk registry? Not in any
  source we hold. `UNKNOWN`
- What are the "two crawlers within WebShield"? Only Crolex was presented. `UNKNOWN`
- Does ZineSec's KYC/identity capability have a role in merchant risk? Never
  raised. `UNKNOWN`
- What happens to Wiser and the Maltese government work? Out of scope, noted for
  completeness.

## Related

- [[crolex]] — WebShield's crawler, presented in detail
- [[crawler-consolidation]] — the estate-wide question
- [[crawler-capability-gaps]] — what WebShield closes and doesn't
- [[atlas-architecture]] — EverC's parallel convergence
