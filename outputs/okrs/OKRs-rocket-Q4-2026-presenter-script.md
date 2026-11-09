# Rocket Team OKRs, Q4 2026: Presenter Script

About 23 minutes of talk: 3 minutes of retro, then 20 minutes of OKRs. OKR time cues start after the retro.

---

## Product Retro: What worked well (retro, 0:00)

Hi everyone. Before Q4, a quick look back at Q3. I'll start with what went well.

First, dev moved faster than we planned. They closed the Q3 work early, and instead of waiting for the new quarter, we gave them Q4 work right away. That means part of what you'll see in the Q4 plan is already in progress.

Second, priorities changed in the middle of the quarter, and we handled it. We didn't just move tickets on the board. We sat with dev and explained why the business needed the change. We did the same with Customer Success, Data, and Core, so everyone worked from the same roadmap.

Third, our specs kept up with dev. That was the real risk: when dev frees up, they need clear requirements, or they wait. We used our AI-based PM workflow to turn the old products, Single Platform, MerchantView, and WebShield, into written requirements. So every time a developer finished a task, the next spec was ready.

Fourth, design caught up with the same speed. Dana built a design system that the AI workflow can use. Now we go from a requirement to a working prototype that looks like the real product. The screens you'll see in the OKR slides come from these prototypes.

Fifth, we stopped guessing. Our workflow now pulls real customer data, from Mixpanel, Looker, and Coralogix. For example, the baselines in today's OKRs come from MerchantView usage data.

---

## Product Retro: Lessons learned (retro, 1:30)

Now, four things we learned, and what we changed because of them.

One. We bring Data and Design in from day one. In the past they joined late, and we found out about gaps only after work started. Since Q3, every new project starts with Product, Data, and Design agreeing on the problem together.

Two. When a priority changes, we explain why. In the mid-Q3 change, dev and stakeholders adjusted quickly once they understood the reason. So now every change comes with its reason, not just a new order on the board.

Three. We meet every week across products to go over the roadmap. That way, a change in one product reaches every team within a week, not at the end of the quarter.

Four. Every spec starts from customer data. Before dev writes a line of code, we agree on the problem and on how we'll measure success. You'll see that on every OKR slide next: each project comes with its success metrics.

---

## Opening (0:00)

Now to Q4. These are the Rocket team OKRs for Q4. Our Q4 ends on February 27, 2027.

Three things before the slides.

One. Every project here is marked Must on the Atlas roadmap board in monday, for Rocket. If it is not Must, it is not in this quarter.

Two. NAB is our first client to move to Atlas. Five projects are marked for NAB. We call them NAB parity projects. They will be live and used by NAB by December 31, 2026. All other projects are released by the end of the quarter.

Three. Each slide has two kinds of success metrics. Primary metrics show speed, use, and quality. We measure them from the day a project is released. Secondary metrics show the result for the client. For NAB, we measure them 30 days after NAB moves to Atlas.

Our baselines come from MerchantView data, August to October 2026. Where we have no baseline, the target is a first guess. We will update it after four weeks of data.

Five slides.

---

## Slide 1: Analyst efficiency and faster reporting (1:30)

Four projects. Full MCC Parity and WebID are for NAB. The other two are Existing Merchant Management, and CRAM and WSL.

What changes. The analyst sees all checks on a merchant in one screen, with the evidence.

- **MCC.** We compare the merchant category code the client reported with the code we predict from the website. If they don't match, Atlas flags it, the same way MerchantView does today. For example, a merchant reports electronics, but the website sells gambling. The analyst sees both codes and decides. NAB needs this before it moves.
- **WebID.** Some merchants come to the client with no website on file. WebID uses what the client already knows, like the legal name, email, phone, and address, to find the merchant's website. It tries the business email domain first, then our identity graph, then web search, and stops at the first match. It only accepts a website on strong evidence; if the evidence is thin, it returns "not identified." The found site goes into monitoring, on its own or after an analyst approves it. NAB needs this before it moves.
- **WSL.** We check if the merchant is on a sanctions list, a watchlist, or in a legal case. Each match comes with its evidence. The analyst marks it Risk or No Risk, with a reason.
- **CRAM.** We check what reviews, complaints, and the news say about the merchant. For example, a low rating with many "order never arrived" complaints. The analyst marks it Risk or No Risk, with a reason.
- **Existing Merchant Management.** We set the rules for approving a merchant after its onboarding scan. After approval, the merchant moves to monitoring. Onboarding and monitored merchants sit in separate tabs, so the analyst knows which list they are working on.

For the client: the analyst decides from one screen. No jumping between tools.

For G2RS: MCC parity lets MerchantView clients, starting with NAB, move to Atlas. And with MCC in Atlas, we can offer MCC to Atlas clients.

How we measure it.

Primary, for Q4: full NAB parity live by December 31.

Primary, from release:
- Time from onboarding scan to approval: 3 business days or less.
- Time from approval to the first monitoring scan: 7 days or less.

Secondary, 30 days after NAB moves: time from opening a merchant to the decision goes from 32 minutes today to 30 minutes. A small target on purpose. Atlas must not slow analysts down, and should start to make them faster.

---

## Slide 2: Consolidate and modernize the product portfolio (5:30)

This is the migration slide. It matters most this quarter.

Six projects. Three are for NAB: Client Data Migration, the Add Merchant wizard, and Finding Dispute. The other three: parity check against MerchantView, more wizard features, and the Help Center.

What changes.

- **Client Data Migration.** We map and convert client data from the old products so it can move to Atlas. That covers MerchantView clients, starting with NAB, and WebShield clients with their GDPR, contract, and data processing terms. First we do a test run, to prove the steps work. Then we repeat the same steps for the next clients.
- **Parity check against MerchantView.** We check, feature by feature, that Atlas does everything MerchantView does. Every gap that would stop a client from moving gets listed and closed. This gives Sales and Customer Success a checked answer when a client asks if Atlas replaces what they have.
- **Add Merchant wizard.** The client adds a merchant step by step: portfolio, services, merchant details, and review. They pick the services for each merchant and give all the details at the start. They also choose if an approved merchant moves to monitoring on its own or by hand, and can add a login for password-protected websites. It works for one merchant or many at once. The basic wizard is for NAB; the extra features come later in the quarter.
- **Finding Dispute.** The client disputes a finding they think is wrong, adds evidence, and tracks the status. For example, the client says the tobacco page was removed and attaches a new screenshot. G2RS checks it again, fixes the result if needed, and releases it again. The full history is kept, and while a dispute is open the finding and the merchant's risk stay as they are. NAB needs this before it moves.
- **Help Center.** User guides live inside Atlas, for the platform and for each feature. For example, a guide on how to dispute a finding. Users find answers without calling Support or Customer Success.

For the client:
- They keep what they have today, and we check it before they move.
- No more emails back and forth for missing merchant details.
- Answers are in the product. No need to call Support.

For G2RS:
- The test run is what lets us move many clients.
- Each client we move is one less old system to support.
- The parity check lets Sales and Customer Success say, with proof, that Atlas replaces the old product.
- Fewer calls to Support and Customer Success.

How we measure it.

Primary, for Q4:
- Full NAB parity live by December 31.
- Clients on Atlas: from 0 to 1. That is NAB.

Primary, from release:
- Open parity gaps that block a migration: 0 by end of Q4.
- Merchant adds that need offline follow-up: 10 or fewer a month.
- How-to tickets: 2 or fewer per client a month.

Secondary, 30 days after NAB moves:
- Tickets from NAB: 10 or fewer in the first 30 days.
- NAB user satisfaction: 4 out of 5 or higher. We will measure it in interviews with NAB's analysts.

---

## Slide 3: Graph and Merchant Map (10:00)

One project: evidence screenshots in the Graph.

What changes.

- **Graph evidence screenshots.** Today the analyst sees that two sites are connected, for example through the same owner or the same server. Now, each connected site with a violation shows its evidence screenshot, not just its URL. The merchant's site and the connected site sit side by side, so the analyst sees the problem right away.

For the client: they decide on a connected-site violation from the evidence, not just from the connection.

For G2RS: the evidence gives clients a reason to sign up for Graph and Merchant Map.

How we measure it.

Primary, from release: time to decide on a connected-site violation, 1 business day or less.

Secondary, 30 days after release: views of connected-site evidence go up 10 percent. Today it is 92 a month.

---

## Slide 4: Distilled value (12:00)

Four projects: page change detection, the New flag on scans, web traffic, and front site detection.

What changes. The client gets findings they can act on.

- **Page change detection.** G2RS checks the merchant's pages daily, weekly, or monthly. When a page changes, we keep a before and after screenshot. For example, a product page that now lists tobacco. Our analysts review the change before it reaches the client's report.
- **New flag on scans.** Each new scan gets a New flag. The analyst sees right away what is new since the last time they looked, and does not reread old results.
- **Web traffic.** Atlas shows the website's traffic, its backlinks, and the domains that link to it. It flags traffic that looks wrong, for example a sudden spike from one source, and shows the trend over time. The analyst marks each finding Risk or No Risk.
- **Front site detection.** A front site looks like a real business and passes onboarding checks. But it hides fraud, scams, or money laundering somewhere else. We only show these at the critical level, with more than 90 percent precision, as a simple yes or no. A front site finding means: review this merchant before you approve it or keep it. It does not block the merchant on its own.

For the client: analysts spend time on findings that need a decision. And front sites are caught before approval.

For G2RS: when clients act on findings, they renew. That is our first renewal signal. Front site detection is also the base for the Scams product in 2027.

How we measure it.

Primary, from release:
- False positives in page changes: 40 percent or less.
- Time from scan to first look at new findings: 2 days or less.

Secondary, 30 days after release:
- Finding decisions a month: from 8,994 to 9,900. About 10 percent more.
- Disputes a month: from 116 to 104 or fewer. About 10 percent less.

More decisions and fewer disputes means clients act on our findings and agree with them.

---

## Slide 5: Usage growth, maintenance (16:00)

One project: keep MerchantView running.

What changes.

- **Legacy MV support.** Nothing changes, on purpose. We keep MerchantView working for every client that has not moved to Atlas yet. Clients keep screening without a break until they move.

For the client: they keep screening until they move.

For G2RS: we bill per screened URL. MerchantView revenue goes on until each client moves.

How we measure it, every month in Q4.
- Primary: no increase in MerchantView support tickets.
- Secondary: merchants added in MerchantView stay at 1,672 a month or more. That is today's average.

---

## Close (17:30)

To sum up.

By December 31: the five NAB projects are live and NAB uses them.

By February 27: NAB is live on Atlas, all other Must projects are released, and no parity gap blocks the next client.

30 days after NAB moves, we will know from NAB's own analysts if Atlas works: faster decisions, few tickets, and a score of 4 out of 5 or higher.

We report red, amber, or green on each result every week in the Rocket sync. We review at mid-quarter and score everything at the end.

Questions?
