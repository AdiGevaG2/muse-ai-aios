# Voice & Writing Samples — atlas

Real examples of how we write. Agents imitate THESE, not a generic tone. When a
sample and a rule conflict, the sample wins — this is the ground truth for voice.

## Observed voice patterns (what to imitate)
- **Separation framing.** Structure around distinguishing things that are wrongly
  conflated (what the scan says vs. what the human decided; Risk vs. Approval vs.
  Monitoring vs. Status). This is the signature move.
- **Three-beat Executive Summary rhythm:** (1) what's needed / the core decision,
  (2) what the MVP concretely introduces, (3) why this scope is the right first
  step.
- **Evidence-grounded, not asserted.** Cite legacy/target evidence ("Legacy
  Mixpanel shows…", "G2 comparison evidence did not show…") rather than claiming.
- **State tokens in backticks**, treated as exact values: `Active`, `Inactive`,
  `Rejected`, `isolate-graph-risk`.
- **Verdict-first, dense, no hype.** Declarative sentences. Precision over
  smoothness; a long sentence is fine when every clause is load-bearing.
- Uses tables for problem breakdowns (Area | Description) and keeps scope
  In/Out/Future explicit.

---

## Sample — Executive Summary (separated-model feature)
Atlas needs a clear, durable separation between what the scan says and
what the human decided, and at the merchant level between how risky a merchant is,
what business decision was recorded, whether monitoring is paused or resumed, and
whether the merchant itself is `Active` or `Inactive`. Legacy behavior mixes scan
output, review outcomes, monitoring controls, merchant lifecycle state, and
workflow states, so users cannot tell whether a merchant is risky because of scan
evidence, because a reviewer already dispositioned it, because monitoring was
paused, or because the merchant was deactivated.

The MVP introduces a separated model across Finding, URL, and Merchant: Risk is
analytical and rolls up from scan-set Severity plus review Decisions; Approval is
the business disposition; Monitoring is controlled through pause/resume actions;
and Merchant Status records whether the merchant is `Active` or `Inactive`. A
business decision never rewrites merchant Risk.

This scope is the right first step because it covers the customer workflows that
already have strong legacy usage: finding triage, status/actioning, pause/resume
monitoring, merchant-list prioritization, merchant activation controls, and MMP
reporting evidence. It also avoids destructive Deboard semantics in MVP while
keeping a reversible `Rejected` disposition.

## Sample — Problem Statement (table form)
| Area | Description |
|---|---|
| Current gap | UP does not separate scan-set Severity from review-adjusted Risk; it lacks merchant-level Approval; it conflates business disposition with monitoring pause/resume controls; and it does not clearly expose merchant `Active` / `Inactive` status as a separate field. |
| User pain points | Analysts enter review after scans through finding, URL, merchant, and list surfaces, but cannot see a single coherent path from finding Decision to finding Risk, URL Risk, merchant Risk, merchant Approval, merchant Status, and monitoring controls. |
| Business impact | MMP reporting, compliance evidence, and analyst workload management require structured merchant disposition instead of manual reconciliation. |
| Risk if unsolved | Customers may miss new risk, over-review already decided work, misread Risk as workflow state, or continue relying on legacy tooling during UP migration. |
| Evidence | Legacy Mixpanel shows broad use of finding triage, finding metadata, status actioning, and pause/resume workflows across customer accounts. |

## Sample — Executive Summary (internal-review feature)
Monitoring scan findings should not be exposed to clients immediately after
generation when internal G2 review is required. This feature introduces an
internal G2 Risk Analyst review step after scan completion and before
client-facing release so analysts can validate findings, mark false positives,
and ensure only approved findings remain eligible for release.

The central product decision is that G2 analysts may remove, suppress, or
downgrade findings internally, but clients must not be allowed to remove
violations or change threat variance. Removing a violation changes downstream
threat and risk calculation, so it must remain an internal analyst-controlled
action with explicit confirmation.

This scope is the right first step because it protects client trust and risk
integrity before adding broader QA, assignment, premium assurance, or
cross-product workflow-center capabilities.

## Sample — Executive Takeaway (flag feature, compact)
Atlas should introduce a new independent `isolate-graph-risk` flag that
prevents Graph-connected URL results from changing the merchant-level core risk
score. Graph data should still be collected, stored, and visible to analysts, but
its mathematical weight should be isolated from the top-level merchant score when
the flag is ON. G2 did not show the same Graph score influence in the reviewed
paths, so it should be covered through non-regression rather than active behavior
changes.