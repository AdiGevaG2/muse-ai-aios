# Rocket Team OKRs, Q4 2026

Rocket's OKRs follow the company OKRs as written. Under each Key Result: the Rocket work that moves it, how it is measured, and what it changes for the G2RS client, for G2RS, and for Atlas. Rocket work comes from the Atlas Migration Packages Roadmap monday board, Q4 group, Dev Team = Rocket.

Atlas replaces MerchantView, WebShield, and Single Platform, and every client of those products moves to it. Each KR below either moves clients onto Atlas, makes their work on Atlas faster, or makes the findings they receive worth acting on.

## Objective: Bottom Line Efficiencies

### KR: Analyst efficiency and faster reporting

MCC: Increase automation for MCC; MCC launched in SP's GO; Analyst MCC automation enabled.

**Rocket work:**
- Full MCC Parity, MVP
- Merchant Category Code (MCC) Enhancements
- Mismatch of Identifier Data
- WebID

**Measured by:** share of MCC assessments completed with no analyst action.

**Counter-metric:** agreement rate between automated MCC results and analyst decisions on a monthly audit sample, so automation is not raised by auto-closing uncertain cases.

**For the client:** the client's risk team learns whether a merchant's website matches its category code without waiting for a G2RS analyst to check each merchant. Mismatches arrive sooner, so the team can reprice, restrict, or offboard a miscoded merchant before fines or chargebacks arrive.

**For G2RS:** analysts stop handling the MCC cases a machine can decide and spend their time on cases that need judgment. The same team covers more merchants, and reports go out faster without adding headcount.

**For Atlas:** MCC parity is a migration requirement for Single Platform clients; until Atlas has it, those clients cannot move. Automated MCC in Atlas removes that blocker and makes MCC available to every Atlas client, not only Single Platform clients.

### KR: Consolidate and Modernize Product Portfolio

Unified Platform: Serve customers on UP onboarding and monitoring solutions by EOY. Behind schedule.

**Rocket work:**
- Client Data Migration, including a migration POC to validate the runbook
- CC / UI full parity validation
- Existing Merchant Management
- Wizard for Add Merchant, MVP
- Monitoring Schedule and Ad Hoc Scans
- Finding Dispute and Reassessment (Q4)
- Help Center in Atlas

**Measured by:** number of customers live on Atlas onboarding and monitoring.

**Counter-metric:** support tickets per migrated customer after cutover.

**For the client:** the client moves with its merchants, history, and findings intact. Every task it ran in the legacy product exists in Atlas: adding and updating merchants, setting how often merchants are monitored, running a scan on demand, and disputing a finding. The client does not return to the legacy product to finish a task, and Help Center answers questions inside the product.

**For G2RS:** every client moved off a legacy product is one fewer system to support and host. Rocket's legacy MV work drops as clients leave it, and that capacity returns to Atlas. A validated migration runbook lets G2RS move clients in volume, which is how this KR recovers its schedule.

**For Atlas:** clients on Atlas generate the usage, feedback, and revenue that justify the platform. Parity validation turns "Atlas replaces the legacy product" into a checked fact that Sales and Customer Success can stand behind.

## Objective: Top Line Sustainable Growth

### KR: New ARR Enabled by 2026 Product Investments (Net New and Cross Sell): MCC

**Rocket work:**
- Full MCC Parity, MVP
- Merchant Category Code (MCC) Enhancements

**Measured by:** new ARR from MCC deals, net new and cross sell.

**For the client:** a client that monitors merchant websites on Atlas can add MCC checks to the same merchants without a new integration or a second product.

**For G2RS:** MCC becomes a product G2RS sells to new clients and adds to existing Atlas clients, with no onboarding cost for the cross sell.

**For Atlas:** each capability added to Atlas raises what one client relationship is worth and gives clients on legacy products a reason to move sooner.

### KR: Graph and Merchant Map: First New Use Case

**Rocket work:**
- Graph Enhancement: evidence screenshots for violations

**For the client:** the client sees the violation on a connected site with screenshot evidence, not only the link between sites, and decides inside Atlas whether that violation counts against the merchant.

**For G2RS:** evidence on graph findings turns the merchant map from a view into a reason clients register for it, which is the basis for the first new use case.

**For Atlas:** Rocket delivered Connected Sites and the option to exclude graph risk from the merchant score in Q3. Evidence screenshots complete that flow, from connection to evidence to decision.

### KR: AI Product Innovation

**Rocket work:** none identified on the board.

## Objective: Retention and Customer Value

### KR: User Engagement: Distilled Value

MV: Increase critical findings per merchant and improve action rate. Maintain average time to action on critical findings. Action rate.

**Rocket work:**
- Monitoring Cadence, MVP
- Website Pages Change Detection, Phase 1
- "New" indication for scan
- Risk Grading in Atlas
- Legacy MV support

**Measured by:** critical findings per merchant; action rate on critical findings; average time to action on critical findings.

**Counter-metric:** share of critical findings marked False Positive or overturned in dispute, so a rise in critical findings per merchant reflects risk, not noise.

**For the client:** the client's analysts see what changed on a merchant's website since the last scan and which findings are new, and risk grading tells them which merchants to open first. They spend their time on findings that need a decision, not on rereading results.

**For G2RS:** clients renew when findings lead to action, such as merchants restricted or offboarded and fines avoided. Action rate is the earliest signal of whether a client will renew.

**For Atlas:** Q3 work separated scan severity from analyst decisions, added snooze, and added G2RS internal review before findings are released. Q4 adds findings that arrive reviewed, marked as new, and ranked by risk. Atlas becomes the place a client decides on a finding, not only where it reads one.

### KR: Usage Growth: Maintenance

MV: Increase the number of paid screened URLs (websites) per month.

**Rocket work:**
- Monitoring Cadence, MVP
- Existing Merchant Management
- Legacy MV support

**Measured by:** paid screened URLs per month.

**For the client:** the client sets how often each merchant is monitored and keeps its Atlas portfolio in line with its own merchant records by adding, updating, and removing merchants in bulk. No merchant goes unmonitored because it was never added or never updated.

**For G2RS:** screened URLs are the billing unit. A portfolio that matches the client's records, scanned at the frequency the client chose, is usage G2RS bills for. Legacy MV support keeps MV clients screening until they move.

**For Atlas:** usage growing on Atlas, not on the legacy products, is evidence that the platform carries the business.

## Check-in Cadence

- **Weekly:** red, amber, or green per KR in the Rocket sync.
- **Mid-quarter:** review KRs against actuals; adjust if migration order or scope changed.
- **End of quarter:** score each KR, run the retro, and feed results into next quarter's planning.

## Open Questions

- Confirm whether Rocket owns work under AI Product Innovation, and which epic.
- Confirm that graph evidence screenshots is Rocket's contribution to Graph and Merchant Map: First New Use Case.
- Confirm whether Risk Grading in Atlas belongs under User Engagement or under AI Product Innovation.
