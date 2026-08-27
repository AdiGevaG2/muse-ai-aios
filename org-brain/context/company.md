# Company Context — G2 Risk Solutions (G2RS)

Org-wide reference. Applies to every domain. Human-owned governed facts — not an
LLM-maintained wiki page. Every claim carries a provenance tag:
`[documented]` > `[verbal]` > `[hunch]` > `[industry]`. Never present a weaker
claim as documented. Estimates and inferences must stay tagged in any artifact.

Source: internal business-context brief, dated 2026-06-22.

## What G2RS is
- [documented] Mastercard-registered Merchant Monitoring Service Provider (MMSP).
- [documented] Helps acquiring banks, PSPs, and financial institutions stay
  compliant with Visa and Mastercard merchant-monitoring rules.
- [documented-public] HQ: 111 Anza Boulevard, Burlingame, California.
  CEO: Brian Longe.
- [documented-public] Offices: US, Europe, India, and Israel.
- [documented] Customers: 300+ partner financial institutions across 50+ countries
  (specific names under NDA).
- [documented-public] Employees: ~410 (Tracxn, April 2026). An earlier internal
  estimate gave ~350–410; everc.md cites a combined ~460–570+. Treat the combined
  figure as an estimate range (~350–570+) since sources disagree; ~410 is the best
  single public data point.

## History
- [documented-public] G2 Web Services founded 2004; core asset the Merchant Map®.
- [documented-public] The Dec 2022 TransUnion sale was three distinct companies,
  not just "merchant-monitoring assets": **G2 Web Services** (merchant risk),
  **Lundquist Consulting / LCI** (bankruptcy risk), and **Fintellix** (India;
  credit/regulatory reporting). This is why bankruptcy and credit/regulatory are
  legacy sister-company lines, now "not in focus."
- [documented-public] Deal announced Dec 13, 2022; **completed Jan 3, 2023**
  (per TransUnion). $176M; buyer Stellex Capital Management. (Corrects an earlier
  "Dec 30, 2022" close date.)
- [documented-public] The three sister companies began operating together under
  Stellex from January 2023; the consolidated "G2 Risk Solutions" brand launched
  publicly **Jan 9, 2024**. (This resolves the earlier Jan 2023 vs Jan 2024
  ambiguity: operating together = Jan 2023; brand launch = Jan 2024.)
- [documented-public] Brian Longe appointed CEO of the consolidated entity.
- [documented-public] WebShield came under G2RS via acquisition of its parent
  ZignSec AB; compliance tech integrated into G2RS.
- [documented-public] EverC acquired, finalized Oct 6, 2025; terms not disclosed.
  EverC was a competitor, now part of G2RS.

## Product portfolio (in focus)
- [documented] Merchant Monitoring & Onboarding: risk scoring on the Merchant Map®,
  Merchant Risk History (MRH), Content Compliance (BRAM-restricted content +
  card-brand violations), fraud detection, transaction monitoring.
  NOTE: both the G2RS and ex-EverC stacks historically offered "merchant
  monitoring." Post-consolidation, which system is canonical for a given
  capability is not fully specified in source — [hunch] confirm ownership per
  capability before relying on it in a PRD (directly relevant to Unified
  Platform consolidation work).
- [documented] Persistent Merchant Monitoring: ongoing content compliance, risk
  indicators, fraud signals, reputation/sanctions monitoring.
- [documented] Digital Commerce Risk (ex-EverC): marketplace/seller monitoring,
  counterfeit/hazardous/illegal/recalled product detection, multi-modal AI
  (text + image + metadata).
- [documented-public] Smart Scan: zero-integration, AI-powered risk dashboard for
  marketplaces and acquirers; input via file upload or UI, no API integration.
  EverC-native (launched May 2025 as "EverC MarketView Smart Scan", pre-merger),
  now part of the G2RS portfolio.
- [documented] Fraud Detection & Prevention: real-time indicators, transaction
  monitoring, merchant network analysis for fraud rings.

## Explicitly NOT in focus (deprioritized)
- [documented] Instant Onboarding (sub-15-second decisioning) — deprioritized.
- [documented] Identity verification / ZignSec — not a core offering.
- [documented] Bankruptcy/regulatory solutions — not in focus.

## The Merchant Map® moat
- [documented] 20+ years of proprietary merchant data; covers 75%+ of largest
  global acquirers, payment facilitators, and processors.
- [documented] Sourced from 300+ partner FIs; network effect — a bad merchant
  flagged at one FI is shared across all partners (blocks "merchant jumping").

## Regulatory drivers
- [documented] Visa and Mastercard require merchant vetting, ongoing monitoring,
  fraud detection, content compliance. Mastercard also runs MMP (Merchant
  Monitoring Program) with specific scanning/content requirements.
- [documented] FIs use a registered MMSP to reduce compliance risk, delegate
  vetting/monitoring, keep audit evidence, and scale without FTE overhead.
- [industry] RegTech market ~$17–24B in 2025, ~19–22% CAGR through 2033–2036
  (broad industry figures, not G2RS-specific).

## Known weaknesses (for honest internal framing)
- [documented] No public pricing; enterprise contact-sales model.
- [hunch] EverC integration still in progress (~8 months post-close as of
  Jun 2026); some customers may see fragmentation between legacy G2RS and legacy
  EverC tooling. (Inference from integration timeline, not a confirmed status.)
- [industry] Primarily enterprise-focused; limited SMB self-serve tiers.
- [hunch] LegitScript stronger in high-risk vertical certification (pharmacy,
  telemedicine).

## Unified Platform (this workspace's domain)
- [hunch] "Unified Platform" (UP) is the consolidation of G2RS + ex-EverC +
  ex-WebShield UIs/APIs into a single platform. Source describes this as inferred
  roadmap direction over ~12–18 months, not a confirmed/committed product.
- [documented] The strategic rationale is real: G2RS acquired WebShield and EverC
  (former competitors) and is integrating them; a single platform is the stated
  direction of that consolidation.
- Practical meaning for PM work: UP is the target platform this domain builds. It
  must reconcile overlapping capabilities (e.g. merchant monitoring exists in both
  legacy stacks) into one coherent model. Treat the timeline as [hunch]; treat the
  consolidation intent as [documented].

## Roadmap direction
- [hunch] Inferred (not confirmed): full EverC marketplace integration into
  Digital Commerce Risk; expansion of zero-integration tools; more AI automation;
  consolidation of G2RS + EverC + WebShield UIs/APIs into a single unified
  platform over ~12–18 months. Treat as direction, not committed roadmap.