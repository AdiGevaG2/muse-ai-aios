# Org Policies — company-wide

Security, data-handling, and compliance rules that apply to EVERY domain. A PRD
in any domain must respect these.

**Status: PARTIALLY FILLED.** Most rows are still `TBD`. Fill a row when a real
decision needs it — this is a reference, not a to-do list. This file is
human-owned and is never auto-written by `/ingest`, `/retro`, or
`/review`; those skills propose, the owner approves. An agent must treat a `TBD`
row as an unanswered constraint and stop rather than assume a permissive
default.

**Owner:** [compliance / security lead — fill from OWNERSHIP.md]
**Last reviewed:** [YYYY-MM-DD]

## How to use this file

- A rule marked `TBD` is **not** "no restriction". It is an open question that
  blocks any design decision depending on it.
- When a PRD or spec needs a rule that is `TBD` here, record it as an open
  question with this file as the owner. Do not infer the answer from what the
  product happens to do today.
- Fill a row only from a named authoritative source — a policy document, a
  DPA, a security standard, or a written answer from the owner. Cite it in
  **Source**. An unsourced rule is a hunch wearing a uniform.

## Personal and sensitive data

| Rule | Requirement | Source | Status |
|---|---|---|---|
| What counts as PII here | [Definition used across G2RS products] | [TBD] | TBD |
| Merchant vs. individual data | [Whether merchant records contain personal data and how that changes handling] | [TBD] | TBD |
| Special-category data | [Any data requiring elevated handling, or `None`] | [TBD] | TBD |
| PII in artifacts | Real customer and merchant identifiers are permitted in PM artifacts. | PM statement 2026-08-27; no written policy located | RECORDED |
| PII in prompts and chat | No known restriction on real customer or merchant data in an LLM context. | PM statement 2026-08-27 ("no restriction I'm aware of"); no written policy located | RECORDED |
| Redaction standard | [How data must be masked when it is used in an example] | [TBD] | TBD |

## Data residency and retention

| Rule | Requirement | Source | Status |
|---|---|---|---|
| Residency constraints | [Where customer data may be stored and processed] | [TBD] | TBD |
| Cross-border transfer | [Whether data may leave a region, and under what mechanism] | [TBD] | TBD |
| Retention periods | [How long each class of data is kept] | [TBD] | TBD |
| Deletion obligations | [Right-to-erasure handling and its product implications] | [TBD] | TBD |
| Audit-record retention | [How long decision and audit trails must survive — relevant to any feature writing audit records] | [TBD] | TBD |

## Analytics and observability querying

These bound what `/analytics-plan` and any baseline query may do.

| Rule | Requirement | Source | Status |
|---|---|---|---|
| Mixpanel — permitted properties | [What may be sent as an event property; what must never be] | [TBD] | TBD |
| Mixpanel — identity | [Whether user_id / account_id may be real identifiers or must be pseudonymous] | [TBD] | TBD |
| Mixpanel — customer-only default | Queries default to customer-only traffic (`is_customer = true`, per domain `config.json`). | domain `config.json` | ACTIVE |
| Coralogix — log content | [What may appear in logs; PII-in-logs rule] | [TBD] | TBD |
| Coralogix — access scope | [Who may query production logs, and whether exports are permitted] | [TBD] | TBD |
| Export and screenshot | [Whether query output may be pasted into artifacts, tickets, or decks] | [TBD] | TBD |

## Access and credentials

| Rule | Requirement | Source | Status |
|---|---|---|---|
| Credential storage | Never in repo files, artifacts, prompts, Jira, Confluence, or chat. Environment variables or local secret storage only. | domain `config.json` → `security`; enforced by `.claude/hooks/secret-guard.sh` | ACTIVE |
| Least privilege | [Whether agents inherit the operator's permissions and may never broaden scope] | [TBD] | TBD |
| Production access | [Who may read or write production data, and through what path] | [TBD] | TBD |
| Third-party / sub-processor | [Which external services may receive customer data] | [TBD] | TBD |

## AI and automated decisioning

Applies to any feature where a model, score, or ranking affects a user-visible
outcome, including features that merely display another team's model output.

| Rule | Requirement | Source | Status |
|---|---|---|---|
| Customer data into third-party models | [Whether customer or merchant data may be sent to an external LLM or vendor model] | [TBD] | TBD |
| Training on customer data | [Whether customer data or human corrections may be used to train or tune a model] | [TBD] | TBD |
| Automated decisions affecting a party | A machine-derived outcome never takes effect on a merchant without human review. | PM decision 2026-08-27 | ACTIVE |
| Explainability owed | [What an affected merchant, customer FI, or auditor must be able to see] | [TBD] | TBD |
| Model documentation | [Whether a model inventory or model-risk documentation obligation applies] | [TBD] | TBD |
| Decision-record retention | [What must be retained about an automated decision, and for how long] | [TBD] | TBD |

## Security standards and certifications

| Item | Status | Source | Product implication |
|---|---|---|---|
| SOC 2 / ISO 27001 / other | [Which apply, if any] | [TBD] | [What this constrains in a PRD] |
| PCI scope | [Whether any system is in PCI scope] | [TBD] | [Implication] |
| Customer contractual commitments | [Security or data commitments made to FIs that bind product decisions] | [TBD] | [Implication] |

## Marking a row answered

The readiness validator reads the **Status** column literally:

- `TBD` — unanswered. Blocks any decision that depends on it.
- `ACTIVE` — answered and in force, backed by a named authoritative source.
- `RECORDED` — what we currently believe, from a PM statement rather than a
  located policy. Usable, but do not cite it to a customer or an auditor, and
  do not treat "no restriction I'm aware of" as "no restriction exists".
  Promote to `ACTIVE` only when a written source is found.
- `N/A` — deliberately does not apply here. Say why in Requirement.

`bash scripts/validate-ai-readiness` reports this file as
BLOCKER (all TBD) -> WARN (partially filled) -> OK (nothing left TBD).
Marking a row `ACTIVE` without a source turns a gap into a false assurance,
which is worse than leaving it `TBD`.

## Open questions

| Question | Owner | Blocks | Priority |
|---|---|---|---|
| Every `TBD` above | [compliance / security lead] | Any PRD decision that depends on it | High |
