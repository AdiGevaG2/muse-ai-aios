# MCC Mismatch — Phase 1 Open Questions

### Core's MCC mechanism can satisfy PayPal without new comparison logic — 2026-09-01
- **Belief:** Phase 1 is exposing Core's existing MCC comparison output through
  the MLRC payload GO already consumes, not building comparison in MLRC.
- **Evidence for:**
  - Core's brief states an MVP output contract of `Reported_MCC`,
    `Predicted_MCC`, `MCC_risk`, `Match`, `Match_risk_level`, and the prototype
    states its scenarios mirror `mcc_risk.py` output on production MCC
    groupings  [documented] SharePoint › Gal Sahar › `MCC score and UX` › `MCC Risk - Unified Output & Client Configuration v2.docx`, `mcc-risk-card-prototype-v2.html`
  - GO already consumes MCC through MLRC, but not the mismatch relationship  [verbal] Adi Geva, 2026-09-01
  - No mismatch comparison or `MCC_MISCODE` generation was found in
    `mlrc-analysis`, `mlrc-finding`, `mlrc-merchant`, or `mlrc-bff`  [documented] `outputs/paypal-mcc-mismatch/current-state/paypal-mcc-mismatch-reverse-engineering.md`
  - Mismatch logic "currently sits in MV", and GO is integrated into CMP/MLRC
    not MV  [documented] stakeholder email summary (Yonatan Eisenberg; Ishai Froind), supplied by PM 2026-09-01
- **Evidence against:**
  - _(none yet)_
- **Open questions:**
  - The Core→MLRC MCC payload itself was not inspected this session, so
    "add fields to an existing pipe" is inference from GO already consuming MCC.
  - The `.py` files in Gal's folder could not be opened by the SharePoint
    connector — the comparison rule is known from the brief and prototype, not
    from the code.
- **What would settle it:** 15 minutes with the Core team on the current
  Core→MLRC MCC message contract — which fields it carries today and what it
  costs to add `Match`, `Match_risk_level`, and `MCC_risk`.
- **Status:** open
- **Action:** Blocks `/spec`. Must be answered before phase-1 acceptance
  criteria can be written.

### PayPal's delivery channel for mismatch is undefined — 2026-09-01
- **Belief:** Nobody has recorded how PayPal consumes mismatch — UI, API,
  callback, or file export — and a UI-only result will not satisfy them.
- **Evidence for:**
  - No verified PayPal API, callback, file, or report output was found  [documented] `outputs/paypal-mcc-mismatch/current-state/paypal-mcc-mismatch-reverse-engineering.md` § Gaps
  - Core's brief and prototype describe an in-app card and portfolio settings,
    naming no external delivery channel  [documented] SharePoint › Gal Sahar › `MCC score and UX` › `MCC Risk - Unified Output & Client Configuration v2.docx`
  - The stakeholder email establishes mismatch as a hard requirement for the GO
    opportunity but does not describe its output format  [documented] stakeholder email summary (Mary Williams), supplied by PM 2026-09-01
- **Evidence against:**
  - _(none yet)_
- **Open questions:**
  - May already be settled inside the PayPal integration contract, which was
    not searched this session.
- **What would settle it:** Ask Mary Williams directly, or check the PayPal
  integration/contract documents.
- **Status:** open
- **Action:** Does not block phase-1 build; blocks phase-1 *acceptance*. Raise
  before `/spec` closes.

### Merchant-level reported MCC vs. store-level prediction is unresolved — 2026-09-01
- **Belief:** UP cannot compute a deterministic mismatch for a multi-site
  merchant until it is decided whether one declared code applies to every store.
- **Evidence for:**
  - Reported MCC belongs to the UP merchant while findings belong to stores,
    and the store model has no store-specific reported MCC  [documented] `outputs/paypal-mcc-mismatch/current-state/paypal-mcc-mismatch-reverse-engineering.md` (`StoreEntity.java`)
  - The merchant model supports multiple MCCs but the external create API
    accepts one and the portal displays the first; multi-MCC comparison
    behavior is undefined  [documented] `outputs/paypal-mcc-mismatch/current-state/paypal-mcc-mismatch-reverse-engineering.md`
  - MV avoided this by evaluating at the scanned-URL level, where a registered
    URL carries its own reported and detected MCC  [documented] `outputs/paypal-mcc-mismatch/current-state/paypal-mcc-mismatch-reverse-engineering.md` § Merchant View
- **Evidence against:**
  - _(none yet)_
- **Open questions:**
  - Whether PayPal's GO merchants are typically single-site, which would make
    this theoretical for phase 1. No volume or shape data was pulled.
- **What would settle it:** A product decision by the PM, informed by the
  single-site share of PayPal's GO portfolio.
- **Status:** open
- **Action:** Blocks `/spec`. This is a product decision, not a technical one.

### MLRC's BFF may not render a forwarded mismatch as an MCC finding — 2026-09-01
- **Belief:** Mismatch arriving with a legacy category ID would not classify as
  MCC in the portal, so it would not surface to the analyst.
- **Evidence for:**
  - The inspected BFF classifies only category IDs 10000–19999 as MCC, while
    MV's mismatch category is ID 76  [documented] `outputs/paypal-mcc-mismatch/current-state/paypal-mcc-mismatch-reverse-engineering.md` (`FindingServiceImpl.java`)
- **Evidence against:**
  - _(none yet)_
- **Open questions:**
  - `mlrc-bff-2.0` was materially stale at verification, so this may already be
    fixed. Not re-checked this session.
  - Only applies if mismatch is forwarded with the legacy category ID rather
    than assigned a new UP category — which is itself undecided.
- **What would settle it:** 10 minutes with the MLRC team, or a re-read of
  `FindingServiceImpl.java` at current tip.
- **Status:** open
- **Action:** Blocks `/spec`. Technical verification, not a PM decision.
