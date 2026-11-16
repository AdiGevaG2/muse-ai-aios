# Atlas for Adyen by 27 February 2027

Which of Adyen's asks Atlas answers by the end of Q4, 27 February 2027. Input for the Atlas slides in the November 2026 QBR deck.

## Basis

- Monday board "Atlas Migration Packages Roadmap", read 2026-11-13.
- PM instruction: every Q3 item is done; every Q4 item marked Must is done by 27 February 2027.
- Q4 items not marked Must, and items marked Descoped, are treated as not delivered by that date.
- Adyen's asks come from the [June 2026 feedback session](wiki/feedback-2026-06-11.md), the QBR deck and the [usage baseline](baseline/adyen-mv-usage-baseline.md).

## Adyen's asks against the board

| Adyen ask | Atlas item delivered by 27 Feb | Fit |
|---|---|---|
| SmartScan: set category risk level per marketplace (QBR deck, Planned) | Category Severity and Risk in PLRC (Q4 Must) | Full |
| SmartScan: marketplace access to the SmartScan UI (QBR deck, Pending) | Shareable marketplace view within PSP Smart Scan (Q4 Must) | Full. Pricing model still in draft. |
| Disputes tracked with status and history (June #10) | Finding Dispute and Reassessment (Q3, Q4 Must) | Partial. A per-analyst dispute view is not stated. |
| Assign work to analysts (June #5) | Assign Analyst to Merchant (Q3); Bulk analyst assignment (Q4 Must) | Partial. Per merchant, in bulk; not per platform. |
| Finer and more accurate categories; fewer language false positives (June #6, #7) | Create your own categories, Phase 0 (Q4 Must); Content Categories Enhanced Coverage (Q4 Must); MV 9 keyword categories in Atlas (Q4 Must) | Partial. Subcategory risk rules and keyword self-service (Phase 1) are not Must. |
| Find out when a scan is done (June #12) | System notifications (Q4 Must); Add "New" indication for scan (Q4 Must) | Possible. The board does not say which notifications are covered. |
| Upload merchants and pick the portfolio in the flow (June #11) | Add Bulk Merchant (Q3); Wizard for Add Merchant, MVP and Enhancements (Q4 Must); Existing Merchant Management (Q4 Must) | Partial. Upload limit, undo, duplicate URLs and "www." handling are not on the board. |
| Email mismatch check for Apple Pay (Slack, August 2026) | Verify Merchant Details Against Website (Q4 Must) | Full, if Adyen submits merchant emails. Adyen submits none today. |
| Transaction laundering, Adyen's most frequent card brand concern (QBR deck) | Front Site Detection, Core and Application (Q4 Must); Graph and Merchant Map (Q4 Must); Connected Sites / Graph Enhancements (Q4 Must) | New capability, not an Adyen ask |
| Keep today's work when moving to Atlas | Client Data Migration (Q4 Must) | Planned. NAB is the first client. |

## MerchantView gaps that hit Adyen, and whether they close

| Gap found in the 2026-11-05 parity check | Adyen's use, 90 days | Board item | Closed by 27 Feb |
|---|---|---|---|
| Notes on a single finding | 9,972 notes | Add Merchant & Finding Comments (Q3, Done) | Not a gap. Atlas has comments per finding and per merchant (Adi Geva, 2026-11-13). The parity check's finding is out of date. |
| Finding change history | 12,982 finding logs opened | Merchant & Finding Activity Log (Q4 Must) | Yes |
| Text snippet and keyword evidence | 1,288 evidence reviews | No item names it. CC / UI full parity validation (Q4 Must) | Only if the parity work closes it |

## Not delivered by 27 February

| Adyen ask | Board status |
|---|---|
| Rules per platform; suppress a category for a platform (June #2, #3) | Client Rules, Risk Matrix and Decisions - UI and Logic: Q4, not Must |
| Summary view per platform, across sub-merchants (June #1) | No item on the board |
| Website change detection (QBR deck) | Change Detection Phase 1: Q4, not Must. Not in MerchantView today; G2RS delivers change detection as a separate service on Visualping. |
| IP mismatch for UAE Mastercard onboarding (email, September 2026) | Site ownership and Infrastructure Verification - WHOIS IP: Q4, not Must. Not in MerchantView today. |

Change detection and the IP check are new asks, not MerchantView capabilities Adyen would lose in the move to Atlas.
| Explanations linked to law or card brand rules (June #8) | Knowledge, Legal Library and Training: Q4, not Must |
| Keyword self-service, Phase 1 (June #7) | Create your own categories, Phase 1: Q4, not Must |
| History of CC and TL findings in Atlas | Surface CC and TL History in Atlas: Must, but Descoped |

## Recommended Atlas story for the QBR

Recommendation, for PM decision.

1. **"Two of your asks, delivered."** Category risk per marketplace and the shareable marketplace view in SmartScan. Both are on Adyen's own request list in the deck, and both are Q4 Must.
2. **"Catch transaction laundering earlier."** Front Site Detection and the graph work. Transaction laundering shows up in 6 of the 7 months with card brand notifications, and G2RS sent Adyen 8 laundering alerts this year.
3. **"Categories that fit your risk matrix."** Create your own categories and the enhanced category coverage, tied to the 8-10% false positive rate Adyen reported in June.
4. **"Your team's workflow, carried over."** Finding comments, activity log, snooze, dispute and reassessment, bulk analyst assignment, and client data migration.
5. **"Shaped by your feedback, next."** Platform-level rules and views, change detection, IP checks: present as roadmap after February, without dates.
