# Slack #change-detection (C0CBH0F7JBS), export

Exported 2026-11-05 from https://g2risk.enterprise.slack.com/archives/C0CBH0F7JBS. Full channel history, 2026-10-20 to 2026-11-04, with thread replies. Join notices omitted. Text is verbatim; Slack user mentions are resolved to names. Times are IST.

## Files posted in the channel

| File | Posted by | Date | Stored as |
|---|---|---|---|
| Merchant and cadence breakdown for Sarah Craven.xlsx | Sarah Craven | 2026-10-28 01:51 | `slack-files/2026-10-28-merchant-and-cadence-breakdown.xlsx` |
| Change_Detection_User_Guide.pdf | Sarah Craven | 2026-10-28 19:08 | `slack-files/2026-10-28-change-detection-user-guide.pdf` |
| Clients with special reporting needs.docx (resent, 29.7 KB) | Sarah Craven | 2026-10-28 20:38 | `slack-files/2026-10-28-clients-with-special-reporting-needs.docx` |
| Clients_with_special_reporting_needs.docx (5.3 KB) | Sarah Craven | 2026-10-28 19:08 | Not stored. Juan Martini reported it fails to open in Word; superseded by the resent file. |
| image.png | Juan Martini | 2026-10-28 19:19 | Not stored. Screenshot of the Word error. |

Linked, not downloaded: Change Detection Q4 Planning.docx (SharePoint, stored as `change-detection-q4-planning.md`), Margo's Google Sheet output example, Confluence pages 4389732419 (Integration Architecture Options), 4401332225 (Engine Architecture), 4403363869 (Delivery Plan), Jira G2ENG-24984.

## Messages, oldest first

**2026-10-20 16:23 Juan Martini:** @Daniel Grech good morning, when do you have time tomorrow morning? I can do it early in my morning to facilitate it

**2026-10-20 17:52 Juan Martini:** @Sarah Craven can you share with me the document that you presented pls

**2026-10-20 18:52 Juan Martini:** @Daniel Grech can you send me the link to the repo of your POC pls

**2026-10-23 21:35 Juan Martini:** @Adi Geva @Sarah Craven do you think we can coordinate w meeting w K9 and horizon at some point early next week. I really think that we will need to have a broader discussion if we want to come up w a plan for Q4 final reviews plannign

**2026-10-25 13:32 Adi Geva:** Hi @Juan Martini I scheduled a meeting for us on Tuesday - Rocket team will take this item w/k9

**2026-10-25 20:28 Juan Martini:** thank you @Adi Geva

**2026-10-26 11:00 Daniel Grech:** hey :slightly_smiling_face: I'm not sure I can join the calls as I have some clashes but please go ahead without me.
Based on our discussions last week, I put together this confluence page (https://g2rs.atlassian.net/wiki/x/QwCmBQE) which outlines the different architectural routes that we can take to meet the change detection deadlines depending on the availability of the Horizon / Rocker & K9 teams. The ultimate end-goal is the same no matter what route we take (it's Scenario 4 in the document) but we may need to take some intermediate steps depending on priorities of other teams in the short term.
I think it's important to understand which scenario Rocket & K9 can support before the final planning session so that we can plan accordingly as the different scenarios present different levels of effort and workload on the Guardians team. There are also some open technical questions which would need answering to put together a concrete plan.
Let me know if any questions or if you disagree with anything in the doc !

**2026-10-26 14:06 Juan Martini:** thank you @Daniel Grech, many of theses questions were going to be discuss in our meeting Today. So, I am glad that you put this in a doc

**2026-10-26 20:44 Sarah Craven:** @Adi Geva tomorrow is a holiday right? We might need to move the CD meeting to later in the week.

**2026-10-27 15:00 Juan Martini:** @Daniel Grech good afternoon. I am forwarding you an invite related with CD for today, you are optional.

**2026-10-27 17:09 Juan Martini:** @Sarah Craven based on the discussion that we had yesterday, that we will have like the different client types
1. reporting all, like we are supporting right now in G2, crawling up to 300 pages by contract
2. reporting only when changes in interested areas, like policy pages
3. reporting pages chosen by clients
4. 2 and 3 together
Am I missing any combination? Also, can we confirm taht we wont be supporting #1 after the contracts ends w those clients and we will be moving them to one of the other options.
This is important, because if 1 is just important for parity, we may consider this as a temporary path, and again CSX may fits for that.

**2026-10-27 17:11 Sarah Craven:** Yep that sounds right Juan

**2026-10-27 17:15 Juan Martini:** thank you Sarah

**2026-10-27 17:19 Juan Martini:** I assume that we are having CD meeting in 10 mins

**2026-10-27 17:20 Sarah Craven:** @Adi Geva my understanding was that today was a holiday in Israel. Are we still meeting?
> **2026-10-28 Adi Geva:** yes sorry, it was election day

**2026-10-27 17:34 Juan Martini:** none one in the meeting so I guess we are not doing it, let me know if you want me to re join

**2026-10-28 01:51 Sarah Craven:** Hi all - Margo provided me the cadence / merchant count by client for the current Change Detection solution here. [file: Merchant and cadence breakdown for Sarah Craven.xlsx]
> **Juan Martini:** @Sarah Craven following up in this direction based on your document, *"every client exception fits one of about seven rule types that today live in analysts' heads. Making them configurable monitoring profiles is the main lever on reducing analyst overhead"* Do we have those configurable monitoring profiles documented? if not, do you mind if I talk with Margo
> **Sarah Craven:** They are meant to be captured in the table in the document. But configuration does not need to be part of the MVP solution - only the degree of configuration supported by visualping
> **Juan Martini:** ohh the use cases! got it
> **Sarah Craven:** Also I think configuration should eventually live in the Atlas risk matrix functionality. And the options should be driven by those that will also support our future Atlas use cases vs. only the current contracts
> **Juan Martini:** definitively!
> **Juan Martini:** do we know the existing degree of configuration supported by visualping?
> **Sarah Craven:** I don't think it's much
> **Sarah Craven:** But I was going to set up another walkthrough with Margo where we can clarify some of these questions
> **Sarah Craven:** I don't think it's doable this week unfortunately.
> **Juan Martini:** no problem, I am good, trying to capture as much details as possible

**2026-10-28 17:21 Juan Martini:** @Sarah Craven Newly identified URLs that we are currently providing to our existing clients are being filtered our by analyst manually, to align in the categories taht we have in the uses cases list. I meant we are only reporting to the clients new pages if are products or policy pages, the rest of the pages are being discarded
> **Sarah Craven:** @Juan Martini sorry, I'm not following. Is this a question for me?
> **Juan Martini:** yes, @Sarah Craven, let me rephrase the question. in our existing change detection user user guide, we talk about the tab 3, in that tab we are sending to our clients a sub set of new urls added/removed, my question is if those urls being reported in tab 3, are only product or policy pages urls. Or our analyst are reporting other pages there too
> **Sarah Craven:** I'm not sure, let's track that as a question for Margo.
> **Sarah Craven:** My assumption is all.
> **Juan Martini:** yes, I just did it. I will keep you posted

**2026-10-28 19:08 Sarah Craven:** Apologies, I also don't think I ever sent along the docs that Margo sent me (the user guide + special client reporting reqs.) to the rest of the group. And here's a link to the scoping doc we went over in our prior meeting so everyone has it handy: Change Detection Q4 Planning.docx (SharePoint) [files: Change_Detection_User_Guide.pdf, Clients_with_special_reporting_needs.docx]
> **2026-11-04 Juan Martini:** @Nicolis Scandolo @Ruben Muccilli @Matias Alessandri you may find interesting these 2 docs

**2026-10-28 19:19 Juan Martini:** @Sarah Craven could you please send again the second one client with sepecial reporting. it is throwing an error when is being opened in word [file: image.png]

**2026-10-28 20:38 Sarah Craven:** [file: Clients with special reporting needs.docx]

**2026-10-29 15:46 Juan Martini:** @here I saw that you moved the meeting again and I really need that meeting for planning and splitting responsibilities. The meeting was moved to Nov 3rd, but we have to present out Q4 plan on Monday, 2nd.
So, we have 2 options:
1. I do my best assuming things and following path described here. https://g2rs.atlassian.net/wiki/spaces/CD/pages/4389732419/Change+Detection+Integration+Architecture+Options#Scenario-S3-%E2%80%94-Horizon-assists
2. we move the Guardian's Q4 presentation to Thursday. So, I can use that meeting for adjusting estimation and plan based on the output.
the discussion that I need to have is related with the different scenarios that @Daniel Grech put in the document.

**2026-10-29 16:12 Juan Martini:** @here added this confluence page w all the details that we have so far https://g2rs.atlassian.net/wiki/spaces/CD/pages/4401332225/Change+Detection+Engine+Architecture

**2026-10-29 16:41 Sarah Craven:** @Juan Martini I will set up a sync with you later today.

**2026-10-29 16:50 Juan Martini:** thank you @Sarah Craven lets sync up

**2026-10-30 19:33 Juan Martini:** @here, Quick recap from my chat with Margo about how she runs website monitoring today:
1. Input: the client sends a list of merchants (URL, legal name, merchant ID).
2. Page selection: sub pages for each domain get added in two ways. Sometimes Visualping provides them (see item #4), OR Margo also picks pages manually, she does the screening of the pages manually. So, then he import the 300 pages manually for that merchant inside a workspace.
3. Organization: all pages for a client end up mixed together in one Visualping file per client, in workspaces. Each workspace corresponds to one client. Inside a worksapce, there's no group-by-merchant view. To see one merchant's pages she either searches by domain in Visualping or exports to Excel and uses AI formatting to group by domain.
4. Sub page discovery is NOT a product feature: a regular Visualping account doesn't discover sub pages (I confirmed this with my own account, it never finds them). Margo sends the list to Bethel at Visualping, they do the work on their back end and load the pages in, and then Margo reviews them for accuracy. Visualping only monitors what's explicitly entered into monitoring.
5. She shared a Google Sheet with an example of the output to poke around in: https://docs.google.com/spreadsheets/d/12hyaFUGEqoNDDzl46ZWCGyjHy72TH0LBkepcVStxNi8/edit?usp=sharing
Takeaway: the two biggest gaps are automatic sub page discovery (today it's a manual/managed service on Visualping's side) and a per-merchant view of monitored pages.

**2026-10-31 00:10 Juan Martini:** @here sharing with you the delivery plan for change detection, based on some assumptions and agreements that we came up with Sarah. We are expecting to adjust this based on the meeting that we will have next week with K9 and horizon team. https://g2rs.atlassian.net/wiki/spaces/CD/pages/4403363869/Change+Detection+Delivery+Plan
All the Jira ticket are created under this initiative https://g2rs.atlassian.net/browse/G2ENG-24984 (Change Detection: In-house engine (Visualping replacement))

**2026-10-31 00:10 Juan Martini:** I will be attaching the gantt in the Q4 planning slides soon
