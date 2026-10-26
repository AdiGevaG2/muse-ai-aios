# Glossary — G2RS (org-wide)

Terms every domain shares. One entry per term. All [documented] from the internal
business-context brief (2026-06-22) unless tagged otherwise.

### MMSP (Merchant Monitoring Service Provider)
[documented-public] A provider registered under Mastercard's Merchant Monitoring
Program (MMP) to perform merchant vetting and ongoing monitoring on behalf of
financial institutions. WebShield (now G2RS) has held MMSP status since 2015, so
G2RS operates as a registered MMSP.

### Merchant Map®
[documented-public] G2RS's proprietary 20+ year database of merchant activity and
risk profiles; described as covering more than 75% of the largest global
acquirers, payment facilitators, PSPs, and ISOs. The core data moat.

### MRH (Merchant Risk History)
Surfaces known risk factors, prior violations, and network connections for a
merchant.

### BRAM (Business Risk Assessment and Mitigation)
[documented-public] Mastercard's compliance program. In practice it covers
card-brand restricted content (e.g. pharmaceuticals, weapons, adult, unregulated
financial products, gambling) — that list is the program's *scope*, not its
definition. Content Compliance scans for BRAM-restricted content.

### Content Compliance (CC)
Scanning of merchant websites/marketplaces for BRAM-restricted content and
card-brand violations.

### MMP (Merchant Monitoring Program)
Mastercard's program with specific scanning and content requirements that FIs
must satisfy; a key compliance driver for MMSP services.

### Digital Commerce Risk
G2RS division housing the ex-EverC marketplace-monitoring capability (seller
risk, counterfeit/hazardous/illegal/recalled product detection).

### Smart Scan
Zero-integration risk dashboard for both marketplaces and acquirers; data via
file upload or UI entry, no API integration required.

### Transaction laundering
A merchant processing transactions for unauthorized third parties / hidden
networks. [documented] Noted as more of a G2RS capability than an ex-EverC one.

### Network effect (in G2RS context)
A bad merchant flagged at one of the 300+ partner FIs is shared across all of
them, preventing fraud rings from "merchant jumping" between institutions.

### Multi-modal AI (marketplace)
Combined text + image + metadata analysis used to classify marketplace products
(counterfeit, hazardous, illegal, recalled). Ex-EverC capability.

### Atlas (UP)
[hunch on timeline / documented on intent] The consolidation of G2RS + ex-EverC +
ex-WebShield UIs/APIs into a single platform. The target platform this workspace's
domain builds. Must reconcile capabilities that overlap across the legacy stacks.

### Smart Scan
[documented-public] Zero-integration, AI-powered marketplace/acquirer risk
dashboard; data via file upload or UI, no API integration. EverC-native — built
and launched by EverC (announced May 2025 as "EverC MarketView Smart Scan",
pre-merger), now part of the G2RS portfolio. Same ex-EverC lineage as multi-modal
AI; not G2RS-native.