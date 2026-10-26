# MCC Mismatch

Session: 2026-09-01 · Adi Geva (learn-feature)

## What it is

MCC mismatch compares the merchant category code a merchant *declared* on their
application (reported MCC) against the code our scan of their website concludes
they *actually* trade under (predicted/detected MCC), and raises a finding when
the two disagree materially.

PayPal has made mismatch a gating requirement for a GO (Global Onboarding)
deal. GO runs through the CMP/MLRC pipeline, so mismatch must be available
there — not only in MerchantView, where the legacy logic lives.

Primary user: an underwriting/risk analyst assessing a merchant during
onboarding, and PayPal as an integrating client.

## Vocabulary

| Term | What it means here | Alias / note |
|---|---|---|
| MCC | Merchant category code — 4-digit code for what a business sells | e.g. 5661 shoes, 7995 gambling |
| Reported MCC | What the merchant declared on their application | "declared", "application MCC" |
| Predicted MCC | What our website scan concludes they sell | "detected MCC" in MV and the RE doc |
| MCC group | Configured taxonomy grouping related codes | The proxy for "same business" — never numeric proximity |
| Risk band | Low / Medium / High rating attached to an MCC | Distinct from tier |
| `MCC_MISCODE` | MV's mismatch finding type | MV finding category ID 76 |
| Verdict | Which of Core's seven findings applies | Describes *why*, not severity |
| Tier | Very Low → Critical severity | Describes severity, not why |
| Business risk | How dangerous the trade is (higher band of the two codes) | Axis 1 |
| Transparency risk | How honestly it was declared (relationship + direction) | Axis 2 |
| GO | Global Onboarding — the underwriting product PayPal is buying | |
| MLRC / CMP | The pipeline GO integrates into | Not MV |

## How it behaves

**MerchantView (legacy, source-verified):**
- Evaluates at the scanned-URL level.
- Same configured MCC group → match. Different group → creates `MCC_MISCODE`.
- Different codes *within* the same group do not create a mismatch.
- Only fires when both a reported and a detected finding exist.
- Evidence carries `reportedMcc` and `detectedMcc`; UI shows both codes, both
  groups, and an explanation; exports include mismatch.

**Core (current, per Gal Sahar's brief + prototype):**
- Runs `mcc_risk.py` against production MCC groupings.
- Splits mismatch into **seven verdicts**, not one flag: Confirmed match,
  Benign mismatch, Material mismatch, Declared high-risk, Under-reported risk,
  Over-declaration, Illegal/Restricted.
- Two independent axes (business risk × transparency risk) produce a tier.
  Gambling→Gambling = High; Shoes→Gambling = Critical. Same "high-risk
  merchant", two tiers apart, because direction of the risk delta matters.
- Specialty MCC overlay (regulated verticals) floors the tier at Elevated and
  forces license verification regardless of verdict.
- Stated MVP output contract: `Reported_MCC`, `Predicted_MCC`, `MCC_risk`
  (where predicted > reported), `Match`, `Match_risk_level`.
- Finalize flow: analyst accepts reported, accepts predicted, or enters a third
  code — producing labels `prediction_confirmed` / `prediction_rejected` /
  `both_wrong`. Default is never the risk-lowering option. Finalizing below the
  evidence requires a reason code and logs as an exception. Finalized code
  becomes the Change Monitoring baseline.

**Edge cases raised in session:**
- Reported MCC sits on the **merchant** in UP; findings attach to **stores**.
  One merchant, three sites, one declared code, three predictions — comparison
  semantics undefined.
- MLRC's BFF classifies only category IDs 10000–19999 as MCC. MV's mismatch
  category is ID 76, so a forwarded legacy category would not render as an MCC
  finding.
- Illegal/Restricted: no MCC applies, so no mismatch is assessed — the finding
  stands alone and there is nothing to finalize.

## Established vs. assumed

**Established:**
- Core's comparison rule, output format, and mismatch definition exist today
  (PM confirmed; corroborated by Gal's brief and the prototype).
- GO already consumes MCC through MLRC — but not the mismatch relationship
  (PM, 2026-09-01).
- MV's group-based rule and its `MCC_MISCODE` behavior are source-verified in
  the reverse-engineering doc.
- No mismatch comparison logic exists in `mlrc-analysis`, `mlrc-finding`,
  `mlrc-merchant`, or `mlrc-bff` as of 2026-08-30.

**Assumed / unresolved:**
- That phase 1 is a field-level addition to the existing Core→MLRC MCC payload
  rather than new plumbing. Follows from GO already consuming MCC, but the
  payload itself was not inspected this session.
- The BFF category-ID range issue is carried from the RE doc and was not
  re-verified against current `mlrc-bff-2.0` (that clone was materially stale).

**Nobody wrote down:**
- How PayPal receives mismatch — API, callback, file export, or UI only.
- Volumes: no merchant or scan count exists in Gal's folder.
- Whether mismatch shares `mccEnabled` or needs independent enablement.

## PM decision this session

Phase 1 = the simple PayPal requirement only; broader MCC capability
(verdicts, tiers, scoring, finalize loop) comes later. PM agreed to keep
`Match_risk_level` in phase 1 — it is already in Core's output and without it
Gambling→Gambling and Shoes→Gambling collapse into one indistinguishable flag.

## Usage numbers

None pulled. Mixpanel and Looker were not queried this session; the question
that arose ("volumes") has no recorded answer in the Core folder either.

## Sources read

- `outputs/paypal-mcc-mismatch/current-state/paypal-mcc-mismatch-reverse-engineering.md` (verified 2026-08-30)
- SharePoint, Gal Sahar › `MCC score and UX`:
  - `MCC Risk - Unified Output & Client Configuration v2.docx` (mod. 2026-08-19)
  - `mcc-risk-card-prototype-v2.html` (mod. 2026-08-09)
  - `mcc_risk.py`, `mcc_reference.py`, `build_referenceV3.py` — present but the
    connector cannot open `.py`; not read.
- Stakeholder email summary supplied by the PM (Mary Williams, Ishai Froind,
  Yonatan Eisenberg).
