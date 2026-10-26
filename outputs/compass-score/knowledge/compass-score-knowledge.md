# Compass Score — Knowledge Notes

Raw requirement notes from the PM. Not yet structured into discovery/PRD —
capture only.

## Current concept (as marketed today)

> See overall risk. Investigate every signal. The Compass Score® brings
> findings into one merchant risk summary. Component-level results, reason
> codes, and supporting evidence show what needs attention and which
> applications can move forward, require further review or remediation, or
> should be declined.

Existing UI reference: score shown as an integer 0–1000 (e.g. 880 = "High
Risk"), with a Low/Medium/High gradient bar, plus a component breakdown list
(Sanctions Watchlists and Legal, Merchant Risk History, Content Compliance
Review, Operational Risk, Consumer Ratings and Adverse Media), each with its
own risk level (High/Medium/Low).

## New requirement — PM notes (verbatim intent, not yet reconciled)

1. **Score display changes from 0–1000 numeric to percentage.** The score as
   currently shown (numbers up to 1000) should not persist — target
   representation is a percentage.

2. **Each component produces its own independent score**, calculated by the
   core/scoring engine (e.g. MCC gives a score to the application, NRH/Merchant
   Risk History gives a score to the application, etc.). Component scores are
   system-calculated, not client-set.

3. **Client sets a weighting (percentage) per component, per portfolio** — this
   weighting determines how much each component's score affects the overall
   merchant score for that portfolio. Weightings across all components in a
   single portfolio must accumulate to 100%.

4. **Dashboard/aggregate view (spans more than one portfolio):** when
   aggregating across multiple portfolios, the user must be mandated to set a
   percentage weighting for each component that exists anywhere in the
   organization (across all portfolios), and those weightings must also
   accumulate to 100%.

## Whiteboard notes (photo, confirmed by PM)

- Columns: `CC` (Content Compliance), `MRH` (Merchant Risk History), `WSL`
  (Watchlists/Sanctions & Legal).
- Rows `P1`, `P2`, `P3` = Portfolio 1/2/3, each with checkmarks against the
  subset of components enabled for that portfolio.
- Second table gives per-portfolio component weightings: `P1: CC 10 / MRH 60 /
  WSL -`, `P2: CC 80 / MRH - / WSL 20`, `P3: CC - / MRH 80 / WSL 20`.
- `C(1+2+3)` = the **dashboard view aggregating P1+P2+P3** — confirmed derived
  by blending the underlying portfolios, not a separately-entered config.
  Example blended row: `CC 40 / MRH 40 / WSL 20` (sums to 100%).
- Confirms notes 3/4 above: each portfolio's weights sum to 100% across its
  enabled components; the multi-portfolio dashboard view's weighting is
  produced from the combination of portfolios in scope, also summing to 100%.
- **Still open:** the exact blending formula (e.g. equal-weighted average
  across portfolios vs. volume-weighted by merchant count) that produces the
  `C(1+2+3)` row from P1/P2/P3 is not yet specified.

## Open questions / gaps (not yet answered)

- Is percentage additionally translated into a risk tier (Low/Medium/High)
  the way the current 0–1000 score is, or does percentage replace the tier
  bar entirely?
- What happens to a portfolio where the client has not configured weights for
  all available components — is 100% enforced at save-time (blocking) or is
  partial config allowed with a default fallback?
- Blending formula for the dashboard/aggregate (`C(1+2+3)`) view: how exactly
  are per-portfolio weights combined (equal blend vs. weighted by merchant
  volume per portfolio vs. other)?
- Which components are in scope for MVP — the 5 in the current UI, or the 3
  seen on the whiteboard (CC, MRH, WSL)?
