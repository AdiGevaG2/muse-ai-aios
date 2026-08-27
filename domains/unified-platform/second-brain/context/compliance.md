# Compliance Context — unified-platform (domain-specific only)

Org-wide compliance and data-handling policy lives in
`domains/unified-platform/second-brain/context/org-policies.md`. Only unified-platform-SPECIFIC regulatory
constraints belong here — the ones that bound how solutions in THIS domain may
be designed.

**Status: PARTIALLY FILLED.** Most rows are still `TBD`. Fill a row when a
feature decision actually depends on it — this is a reference, not a to-do list.
Human-owned; never auto-written by `/ingest`, `/retro`, or `/review`. Treat a
`TBD` as an unanswered constraint that blocks the dependent decision, not as
"no restriction".

**Owner:** [compliance lead — fill from OWNERSHIP.md]
**Last reviewed:** [YYYY-MM-DD]

## Scope note

G2RS is a Mastercard-registered MMSP; its customers are FIs, acquirers, payment
facilitators, and processors who use it to meet card-brand merchant-monitoring
obligations (`domains/unified-platform/second-brain/context/org-company.md`, `[documented]`). That is
**market-facing context** — what the product sells. It is not the same as the
**internal constraints** below, which govern how this domain's features may
behave. Do not substitute one for the other.

## Card-brand program obligations

Where a card-brand program dictates product behavior — not merely motivates it.

| Program | Constraint on this domain | Source | Status |
|---|---|---|---|
| Mastercard MMP | [Scanning cadence, coverage, or reporting requirements this domain must satisfy] | [TBD] | TBD |
| Mastercard BRAM | [Restricted-content categories and any required handling] | [TBD] | TBD |
| Visa merchant-monitoring rules | [Requirements binding on this domain] | [TBD] | TBD |
| MMSP registration conditions | [Anything registration obliges the product to do or retain] | [TBD] | TBD |

## Evidence, audit, and reporting

Relevant to any feature that records a decision, disposition, or state change.

| Requirement | Detail | Source | Status |
|---|---|---|---|
| What must be auditable | [Which actions require an audit record] | [TBD] | TBD |
| Audit record contents | [Required fields — actor, timestamp, prior/new value, reason code] | [TBD] | TBD |
| Retention of decision evidence | [How long, and where it must be retrievable from] | [TBD] | TBD |
| Customer-facing audit access | [Whether FIs must be able to retrieve their own evidence, and how] | [TBD] | TBD |
| Reporting obligations | [Reports owed to a card brand or customer FI, and their cadence] | [TBD] | TBD |

## Merchant data handling in this domain

| Constraint | Detail | Source | Status |
|---|---|---|---|
| Cross-FI data sharing | [What the Merchant Map network model permits and forbids — a flagged merchant is shared across partner FIs; state the bounds] | [TBD] | TBD |
| Tenant isolation | [What one customer FI may never see of another's data] | [TBD] | TBD |
| Merchant-facing disclosure | [What a monitored merchant is or is not entitled to know] | [TBD] | TBD |
| Adverse-action handling | [Whether a negative determination about a merchant carries a notification or explanation obligation] | [TBD] | TBD |

## Automated risk determination

Applies where a scan, score, or model influences a merchant-affecting outcome —
including features that only display an upstream model's output.

| Constraint | Detail | Source | Status |
|---|---|---|---|
| Human review requirement | A machine-derived risk outcome never takes effect on a merchant without human review. Binding on every feature in this domain, including ones that only display an upstream scan result. | PM decision 2026-08-27; see `domains/unified-platform/second-brain/context/org-policies.md` | ACTIVE |
| Explainability owed | [What the customer FI or the merchant must be able to see behind a determination] | [TBD] | TBD |
| Fairness / consistency testing | [Whether determinations must be tested for consistency across merchant segments, and by what method] | [TBD] | TBD |
| Contestability | [Whether a determination must be reversible or appealable, and the product mechanism for it] | [TBD] | TBD |

## Legacy migration constraints

The domain consolidates G2RS, ex-EverC, and ex-WebShield stacks. Migration can
carry obligations that a greenfield feature would not.

| Constraint | Detail | Source | Status |
|---|---|---|---|
| Continuity of evidence | [Whether audit history from a legacy platform must remain retrievable after migration] | [TBD] | TBD |
| Behavior a customer contracted for | [Legacy behavior that cannot be dropped without customer or contractual consent] | [TBD] | TBD |
| Data migration constraints | [Restrictions on moving merchant data between legacy and target platforms] | [TBD] | TBD |

## Marking a row answered

The readiness validator reads the **Status** column literally:

- `TBD` — unanswered. Blocks any decision that depends on it.
- `ACTIVE` — answered and in force, backed by a named authoritative source.
- `RECORDED` — believed true from a PM statement, not a located policy.
- `N/A` — deliberately does not apply here. Say why in Requirement.

`bash scripts/validate-ai-readiness` reports this file as
BLOCKER (all TBD) -> WARN (partially filled) -> OK (nothing left TBD).
Marking a row `ACTIVE` without a source turns a gap into a false assurance,
which is worse than leaving it `TBD`.

## Open questions

| Question | Owner | Blocks | Priority |
|---|---|---|---|
| Every `TBD` above | [compliance lead] | Any feature decision that depends on it | High |
