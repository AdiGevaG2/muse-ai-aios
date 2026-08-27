# Behavioral Reference — <system / module name>

> Reference / completeness artifact. Not a build input, not a code walkthrough.
> Derived from source only. Every rule is source-cited.

## Coverage map
_What was examined, and what was NOT. A gap must be visible here at a glance._

| Module / path / entry point | Status | Notes |
|---|---|---|
| e.g. kyc/onboarding.py | covered | full trace |
| e.g. notifications/service.py | not-covered | out of scope this pass |

**Not covered (explicit):** <list, or "none">

---

## Confirmed rules
_The code demonstrably does this._

| ID | Rule (trigger -> outcome) | Source (file + fn/line) | Significance | Edge cases |
|---|---|---|---|---|
| BR-001 | When X happens, system does Y. | kyc/onboarding.py :: verify() L42 | core | on timeout, retries once |

---

## Inferred rules
_Intent read from the code but NOT stated by it. Each carries an open question.
Never treat these as fact._

| ID | Rule (trigger -> outcome) | Source | Significance | Confidence | Open question |
|---|---|---|---|---|---|
| BR-014 | Merchant auto-suspended after 2 KYC fails in 24h. | risk/limits.py :: check() L88 | core | medium | Is the 24h window a business rule or an artifact of the cron schedule? |

---

## Closing summary
- Confirmed rules: <n>   Inferred rules: <n>
- Core rules: <n>
- Not-covered modules: <list>
- Escalated to human: <list of open questions, if any>
