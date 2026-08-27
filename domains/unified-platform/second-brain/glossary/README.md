# Glossary — unified-platform

One entry per term. Keep definitions tight and unambiguous.

## Template
### <Term>
- **Definition:** <what it means in this domain>
- **Not to be confused with:** <adjacent term, if any>
- **Source of truth:** <system / doc where this lives>

## Entries

Imported terms below come from `MUSE-KNOWLEDGE-PACK.md` (retired PM workspace
audit, 2026-08-26). They are `[documented-retired]` orientation, not verified
current UI labels, API fields, enums, or ownership. Verify those against the
relevant repository and approved product artifact.

### Account
- **Definition:** `[documented-retired]` Tenant or customer boundary used to
	scope access and data.
- **Not to be confused with:** A verified field name or universal hierarchy.
- **Source of truth:** Relevant service and approved feature artifact.

### Portfolio
- **Definition:** `[documented-retired]` Operational grouping of merchants,
	often with monitoring configuration.
- **Source of truth:** Relevant product artifact and service.

### Merchant
- **Definition:** `[documented-retired]` Core business entity being onboarded,
	monitored, or reviewed.
- **Source of truth:** Relevant product artifact and merchant service.

### Store
- **Definition:** `[documented-retired]` Merchant-associated web property or
	URL-bearing entity.
- **Not to be confused with:** Merchant; their relationship is feature-specific.
- **Source of truth:** Relevant product artifact and merchant service.

### Finding
- **Definition:** `[documented-retired]` Risk or compliance item requiring
	review, evidence, status, or action.
- **Not to be confused with:** Case; not every finding uses a case workflow.
- **Source of truth:** Relevant product artifact and finding service.

### Case
- **Definition:** `[documented-retired]` Workflow container used prominently in
	G2 case-family behavior.
- **Not to be confused with:** Finding; the terms are not interchangeable.
- **Source of truth:** Relevant G2 evidence and approved target artifact.

### Evidence
- **Definition:** `[documented-retired]` Material supporting a finding or
	decision, such as screenshots, URLs, attributes, or relationship data.
- **Source of truth:** Relevant feature behavior and data contract.

### Scan
- **Definition:** `[documented-retired]` Collection or analysis run over
	merchant or store data.
- **Source of truth:** Relevant analysis/scan implementation and product artifact.

### Status
- **Definition:** `[documented-retired]` Lifecycle or analyst decision state.
- **Not to be confused with:** A universal enum; values differ by platform and
	feature.
- **Source of truth:** Relevant product artifact and service contract.

### Snooze
- **Definition:** `[documented-retired]` Temporary deferral until a date or
	condition.
- **Source of truth:** Relevant platform implementation; availability and
	persistence are `[unknown]` until verified.

### Callback
- **Definition:** `[documented-retired]` Scheduled follow-up or reminder behavior.
- **Source of truth:** Relevant implementation; owner and target object are
	`[unknown]` until verified.

### Dispute
- **Definition:** `[documented-retired]` Challenge to a finding or risk decision,
	typically supported by evidence.
- **Source of truth:** Relevant product artifact and implementation.

### Monitoring
- **Definition:** `[documented-retired]` Ongoing assessment after or apart from
	onboarding.
- **Not to be confused with:** The `mlrc-monitoring` operational service, which
	does not by name define the Merchant Monitoring product domain.
- **Source of truth:** Relevant product artifact and verified code path.

### Onboarding / Boarding
- **Definition:** `[documented-retired]` Intake and assessment of a merchant
	before activation or monitoring; legacy sources use both terms.
- **Source of truth:** Relevant product artifact and verified platform behavior.

### MERV
- **Definition:** `[documented-retired]` MerchantView/EverC service-family name
	used in legacy repositories.
- **Source of truth:** Legacy repository structure.

### MLRC
- **Definition:** `[documented-retired]` Unified Platform service-family name
	used in target repositories.
- **Source of truth:** Target repository structure.
