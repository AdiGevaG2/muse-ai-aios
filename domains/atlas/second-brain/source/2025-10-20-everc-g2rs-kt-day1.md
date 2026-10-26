# EverC / G2RS Knowledge Transfer — Day 1 (2025-10-20)

**Ingested:** 2026-08-30
**Origin:** SharePoint Stream recording `GMT20251020-110546_Recording_2560x1440.mp4`,
Project Demo-EverC- Oct-2025 / Oct 20-23 Virtual Sessions / 2025-10-20 Day 1.
Transcript supplied as WebVTT closed captions.
**Coverage:** Partial. Captions begin at 01:08:31 and run to 04:35:23. The first
~68 minutes of the session are NOT in this file.
**Format:** Auto-generated closed captions. Speaker labels absent; names appear
only when spoken. Mojibake (`â¦` = ellipsis) left as-is.

## Session contents

1. CSX crawler architecture (G2RS) — Augusto + Juan
2. Crolex crawler (WebShield/ZineSec) — Daniel Grash, CTO ZineSec Group
3. CSX/Crolex consolidation assessment + TCO — Zombor, H-Tech
4. EverC MerchantView platform + demo — Shai (CPO), Assaf (CTO), Meni
5. EverC MarketView + SmartScan + demo — Shmuel, Anna, Sergei
6. MLRC (Merchant Level Risk Classification) architecture + demo

Related: `2025-10-20-everc-g2rs-kt-day1-fragment.md` (session-unattributed
fragment, likely Day 2).

---

## Raw transcript (WebVTT)

> **Raw-text status.** The full WebVTT body was provided to the ingesting agent
> as a chat attachment, not as a file on disk, and is therefore not reproduced
> verbatim here. Re-attaching or exporting `GMT20251020-110546_Recording.cc.vtt`
> into this file would complete the audit trail. Every claim in `ingestion/`
> citing this source quotes the caption text directly, with timestamps, so the
> quotes are checkable against the original recording in the meantime.

## Verbatim anchor quotes used in synthesis

Cited with caption timestamps so each synthesized claim can be checked against
the recording without the full transcript.

- `01:14:44` — "One report, one seat, and the number of total pages are 79â¦ thousand."
- `01:15:19` — "And clearly, PMM is theâ¦ the mainâ¦ We have 4.4 million." / "seats or months, and these show us, like, 220 millions of pages scrolling."
- `01:15:46` — "that this does not include Web Shield."
- `01:17:18` — "Yeah, for single domain, 100 pages were crawled."
- `01:17:38` — "No, but by default, CSX is not downloading the JavaScript content, and in some cases, we use a web unlocker."
- `01:18:28` — "In our roadmap, we have an upcoming feature in implementing a smart proxy."
- `01:20:41` — "request API is the CSX single entry point."
- `01:23:52` — "CC, automated CC, and ML Model CC. The other ones are notâ¦ getting the validations of the terms."
- `01:24:46` — "waiting to an API which is PMM, API, and get the queries thatâ¦ leucine." [Lucene]
- `01:27:43` — "which are theâ¦ exchange that we have here for CSX, we identified, like, 5 steps."
- `01:32:04` — "One is the data center, the other one is residential."
- `01:34:07` — "is going to perform a second try using the right data center, which is, like, the lowest cost for that."
- `01:35:10` — "is the cheapest one in Bright Data, so that is why we are using this one for retrying."
- `01:36:00` — "all the pop-ups and age verification, things like that, are beingâ¦ handled by Web Unlocker."
- `01:46:27` — "we may have clients that want to whitelist us."
- `01:50:44` — "at least two crawlers within WebShield. Um, there's at least two crawlers within G2."
- `01:53:06` — "before its implementation at WebShield, we used to use... a mixture of growers." [crawlers]
- `01:54:04` — "And it was built using Elixir."
- `01:57:49` — "some of them are more experimental, I would say, so, like, never really been used in production yet."
- `01:58:03` — "most of these processors are usingâ¦ like, structured prompts, uh, against Google Gemini."
- `02:03:34` — "Most of these are using Google Gemini under the hood."
- `02:04:04` — "in its current state, it's valuable, potentially to be used by analysts to speed up their process." / "But we're not yet really at the accuracy that we would need forâ¦ for a full rollout."
- `02:05:50` — "So currently at G2RS, we use a third-party provider for change detection."
- `02:13:38` — "It's originated from this Crawley open source project."
- `02:14:48` — "the components run in a shared runtime at the moment."
- `02:15:58` — "Crowlex, so that's literally impossible to decouple in the current form."
- `02:16:59` — "as far as I know, only MCC detection is used in production, but keyword scanning and the other ones are not."
- `02:19:19` — "5.3 million merchants, uhâ¦ crawled monthly. Out of that, 4.6 is actually going through the data classification."
- `02:20:33` — "the cluster was quite massively over-provisioned."
- `02:21:35` — "The biggest contributor, of course, is the strong crawler, which is based on Apache Storm." [storm crawler]
- `02:22:03` — "The most expensive part is, of course, elastic."
- `02:24:03` — "currently, there are 15 nodes provisioned for, uh, crawler, and probably counting on a monthly average, 7 to 8 would do the job."
- `02:24:53` — "come to understand that Eversa crawls about 10 pages per website. G2â¦ crawls about 50."
- `02:25:06` — "Yeah, I think for Investigate, it's 500. For Monitor, it's, uhâ¦ a bitâ¦ a bit less."
- `02:25:54` — "most websites haveâ¦ 14 to 20, like, something in that range pages."
- `02:27:13` — "I think somewhere around 200,000?" [WebShield seeds/month]
- `02:27:50` — "And I do think WebShield's total websites is... more close to half a million."
- `02:27:58` — "So this year, MasterCard introduced some rules... telling merchants to make sure they'reâ¦ That their providers are screening every page."
- `02:29:02` — "We don't doâ¦ we don't do monitoring of social media accounts currently."
- `03:05:17` — "what cadences of monitoring are supported?" / `03:05:33` "Generally speaking, it's monthly."
- `03:07:27` — "withinâ¦ within a day." / "10 minutes" premium / "instant onboarding... can be done in several seconds."
- `03:08:25` — "from the second time onwards that we're screening the same merchant, it's all going to be available to you via batch."
- `03:10:19` — "But only through the graph." / `03:10:27` "we are not preserving in the graph any data that we received from our clients."
- `03:19:03` — "We don't have a gavilion of separated sites. We have about 5 or 6 of them."
- `03:22:33` — "How does one know that that is merchant view and not market view?" / "What you do is MKV."
- `03:28:15` — "our customers can send us millions of items." / "90% of the results within 5 minutes." / "the SLA to get all of the results, it's not more than 4 hours."
- `03:30:41` — red / yellow / green result groups.
- `03:34:49` — "we do it on a daily basis for 30 days."
- `03:36:23` — "It's not to find each and every illicit item... It aims to find what are the risk areas."
- `03:38:16` — "more than 40 different categories."
- `03:40:39` — "each scan takesâ¦ few hours between 2 to 4 hours."
- `03:48:35` — "This dashboard isâ¦ it's basically, umâ¦ Looker embedded in the UI."
- `03:51:44` — "in MarketView, we scan everything in SmartScan, we decide how many to scan."
- `03:55:47` — "Just to confirm, so a customer can retrieve SmartScan results through the API." / "Not at the moment, this is something we're working on in the next few weeks."
- `04:00:44` — "we have two versions of API."
- `04:04:56` — "we have a process that's called augmentation."
- `04:16:56` — "this is the architecture of the MRC" [MLRC].
- `04:26:42` — "This is already implemented, but what you see now on the screen."
- `04:27:01` — "So it's there, but it's not taking any traffic."
- `04:31:49` — "So, we have challenges with AWS. I don't know if you are on, uhâ¦ East one today."
