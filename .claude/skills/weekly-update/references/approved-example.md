# Approved example (PM-approved 2026-10-15)

The reference for tone, depth, and structure of every `/weekly-update`
reply. Match it: substance per initiative, plain-label paragraphs, bold
initiative names, opening source line, closing draft notice, Did, Need from
you. Content is that week's; reuse the form, not the facts.

---

This week's Slack update is drafted below. Nothing was in the running log and there were no commits, so it's built from files changed this week, your Slack messages, and your note that the APIs went to NAB today.

**Atlas API for NAB**

Progress and wins: Sent the Atlas APIs to NAB today. We mapped NAB's BOSS requirements against the Atlas API and rewrote the descriptions of each API, its fields and its purpose. Agreed that versions shared with customers drop the "draft" label and add a disclaimer: this is a tested first version, and the APIs may change as Atlas capabilities are finalized.

Planned next: Separate the add-merchant API into two distinct APIs, one for Onboarding and one for Monitoring, to match the new wizard. Then share the next version with NAB without the "draft" label and with the disclaimer.

Blockers, risks and help needed: Need engineering to split the add-merchant API. Today one API covers both Onboarding and Monitoring.

**Full MCC Parity in Atlas**

Progress and wins: The mini PRD is published to Confluence with a clickable prototype and handed to Alex and Doron. Scope is set as a lift and shift of MerchantView's MCC comparison. MCC is stored and computed per store (URL) and shown at merchant level. For this phase, the predicted MCC drives severity, and a reported vs. predicted mismatch is a UI flag only. A dedicated MCC risk mechanism moves to Q4. Core confirmed it returns one MCC per URL and none for connected URLs found by Graph.

Planned next: Rocket kickoff for Add Merchant and MCC MVP on Tue Oct 20. Close the open decisions in spec: severity per result, risk source per category, how a store gets its reported code, how MCC enablement maps to Atlas, and the multi-store filter rule.

Blockers, risks and help needed: Need engineering to confirm which source supplies the risk value per predicted category in Atlas.

**Add Merchant Wizard (Onboarding or Monitoring) - MVP**

Progress and wins: The mini PRD is published to Confluence with a prototype and handed to Alex and Doron. Add Single Merchant becomes a wizard where the user picks Onboarding or Monitoring under the current portfolio. Today it creates Monitoring merchants only. URL variants of the same site (www, http/https, no scheme) count as one store, as in MerchantView.

Planned next: Kick off with Rocket on Tue Oct 20, together with MCC. Confirm with engineering that single-merchant creation can accept Onboarding.

Blockers, risks and help needed: None.

**Verify Merchant Identity Against Website**

Progress and wins: Reverse-engineered Core and drafted the mini PRD and prototype. Finding: Core checks phone and email today, but postal code and country never reach the client, because the address mismatch is defined but skipped. The PRD makes name, phone, email, postal code and country all required, enabled per client.

Planned next: Take into spec which results postal code and country produce, and which website pages they're extracted from.

Blockers, risks and help needed: Need engineering to confirm whether Core's company name comparison runs today and whether its bank flag controls it.

**Monitoring Services Cadence**

Progress and wins: Drafted the mini PRD. Each service on a portfolio gets its own cadence and start day, so one service's schedule no longer overwrites another's. Each service's last-scanned date shows on the merchant Findings screen. Manual scan moves to Phase 2.

Planned next: Check feasibility with the Core team before spec.

Blockers, risks and help needed: Need the Core team to confirm per-service cadence is achievable. Today's schedule is keyed by portfolio only.

This is a draft only. Nothing was sent or posted anywhere. Once you've pasted it into Slack, tell me it's sent (or run /weekly-update again) and I'll archive it and reset the log for next week.

Did
- Added the NAB API section, based on your note that the APIs went out today and the Slack threads with Maryna, Sergey and Shmuel.
- Added this week's MCC and wizard decisions from Slack. The MCC and wizard PRDs are confirmed published. Verify Merchant Identity and Monitoring Services Cadence are described as drafted.
- Left out personal DMs, the automated morning-brief DMs, the risk/severity alignment with Pratim, Franz's feedback offer, and the Jira space request.

Need from you: Should the risk/severity alignment with Pratim or Franz agreeing to give feedback on Atlas go in?
