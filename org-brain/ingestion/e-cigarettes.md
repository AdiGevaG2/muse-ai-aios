# E-cigarettes and ENDS

Electronic nicotine delivery systems sit in one of the most fragmented regulatory
landscapes in merchant risk — legal, restricted, or outright banned depending on
jurisdiction, with flavored and disposable devices banned even in many permissive
markets.

## Card scheme position

Mastercard (GLB 13720.1, 26 May 2026): merchants selling products without
required US authorization, or in violation of state law, violate Mastercard
Standards and will be investigated under BRAM. [documented]

Coding: merchants whose primary business is ENDS sale use **MCC 5993** (Cigar
Stores and Stands) with **TCC T** for non-face-to-face or **TCC R** for
face-to-face. *SRP* §9.4.2 requires registration of any tobacco merchant or
sub-merchant conducting NFTF transactions of any ENDS. Registering is an acquirer
attestation that controls are in place.

For face-to-face acceptance Mastercard recommends robust onboarding and ongoing
controls: review and approval of product inventory, transaction monitoring,
invoice review, SKU-level reporting, and mystery shopping.

## Jurisdiction map

From the G2RS client guide, last updated March 2026. [documented]

**Outright bans / prohibited for sale:** Argentina, Brazil, India, Mexico,
Singapore, Thailand, Türkiye, Uruguay.

**Disposables banned:** Belgium (since 1 Jan 2025), France (since 26 Feb 2025),
New Zealand (since 17 Jun 2025), UK (since 1 Jun 2025), Australia.

**Restricted / conditional:**

- **Australia** — importation, supply and commercial possession of disposable and
  non-therapeutic vapes banned; therapeutic vape flavors limited to mint, menthol
  and tobacco; **vapes may only be supplied in pharmacies**
- **Canada** — legal federally at 18+ under the Tobacco and Vaping Products Act,
  but several provinces set 19 (BC, New Brunswick, Nova Scotia, Ontario) or 21
  (PEI); flavors permitted federally but banned in BC, New Brunswick, Nova
  Scotia, Quebec
- **Denmark** — legal if notified to the Danish Safety Technology Authority;
  government registers list authorized e-cigarettes, registered foreign distance
  sellers, and permitted retailers. Products marketed to prevent or treat disease
  (including nicotine dependence) count as medicines needing authorization — and
  none has been granted
- **Japan** — nicotine cartridges and e-liquids are medicinal products under the
  PMD Act; MHLW has approved none, though a one-month personal-use import is
  permitted
- **Netherlands** — sale only in specialist shops, flavored products banned, and
  **online sale prohibited** with or without nicotine
- **New Zealand** — only approved specialist vape retailers may sell flavored
  vapes; general retailers limited to tobacco, menthol or mint
- **US** — only FDA-authorized products may be sold: **41 products from 5
  manufacturers** as of the guide's date. The FDA seizes illegal shipments
  ($86.5m in September 2025, $34m in May 2025) and issues warning letters,
  primarily targeting youth-appealing products — flavored and disposable devices,
  and devices packaged to resemble smart devices

The practical underwriting consequence: an ENDS merchant's legality is a function
of the buyer's location and the specific SKU, so shipping destinations checked
against traffic geography matter more here than almost anywhere else.
[inference] See [[website-data-analysis]].

## Underwriting

Under MCC 5993 — see [[merchant-risk-by-mcc]] for the full profile. Key risks:
age restrictions, cross-border shipping and customs, counterfeits, illegal
flavored or disposable ENDS, CBD e-liquids. Note that paid advertising traffic is
itself a risk signal, since tobacco advertising is heavily regulated globally.

Illegal sale of tobacco was 3% of 2025 assessments — see
[[assessment-trends-2025]].

## Related

[[merchant-risk-by-mcc]] · [[mastercard-bram-and-mmp]] ·
[[assessment-trends-2025]] · [[website-data-analysis]]

Source: [[../source/2026-08-30-g2rs-academy/MANIFEST.md]]
