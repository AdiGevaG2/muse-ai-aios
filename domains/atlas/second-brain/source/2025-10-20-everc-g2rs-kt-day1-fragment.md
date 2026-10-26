# EverC / G2RS Knowledge Transfer — unattributed transcript fragment

**Ingested:** 2026-08-30
**Origin:** Pasted into `/ingest` alongside the Day 1 recording link.
**Session:** UNCONFIRMED — see caveat below.
**Format:** Auto-generated speech-to-text. Low fidelity.

## Provenance caveat — read before citing

This fragment was supplied as part of a three-link request covering Day 1
(2025-10-20), Day 2 (2025-10-21) and Day 3 (2025-10-22). It is **not** from the
Day 1 recording:

- Day 1's transcript (`2025-10-20-everc-g2rs-kt-day1.vtt`) runs `01:08:31` to
  `04:35:23` and ends with "see you tomorrow".
- This fragment runs `0:04` to `1:07:49` and *also* ends with "see you tomorrow
  morning" — a different session's close.
- Its content (instant onboarding pipeline, PySpark streaming, the graph
  traversal endpoint) matches topics Day 1 explicitly **deferred** to a later
  day: "The plan was also to cover the graph, but we got a lot of great
  questions... we should perform the graph for tomorrow."

It is therefore most likely **Day 2 (2025-10-21)**, possibly Day 3. Treat every
claim sourced here as session-unattributed until the Day 2/Day 3 recordings are
transcribed and this is confirmed.

The text was also pasted twice, identically. Stored once.

## Transcription quality

Speech-to-text is poor. Known garblings, corrected by inference:
- "Pyspark" / "Pispark" → PySpark
- "data breaks" → Databricks
- "chemical services" → likely "critical services"
- "the wide net" → likely "the wider net"
- "sickly process" → likely "cyclic process"
- "in the packet" → likely "in the pipeline"
- "troubles the graph" → likely "traverses the graph"
- "each interview around" → likely "each retry round"
- "to buy that or to to nimble" → Bright Data / Nimble (proxy vendors)
- "we don't live customer" → likely "we don't leave the customer"
- "won't be over provision and we want to increase our spend" → likely
  "won't be over-provisioned and we DON'T want to increase our spend"

---

## Raw text

0 minutes 4 seconds
All right.
0:05
0 minutes 5 seconds
And and then we go back again to the graph, try to for looking for any connected or other domains that have the same e-mail or phone number, etcetera.
0:14
0 minutes 14 seconds
Restarting the entire process for all of those domains and then aggregating all of those together to say those are the results for for for this site.
0:23
0 minutes 23 seconds
It is cumbersome, it's nasty.
0:26
0 minutes 26 seconds
We, we don't really love it or like it.
0:29
0 minutes 29 seconds
The idea and Anna and the team and which are responsible for the ecosystem we'll discuss a bit.
0:36
0 minutes 36 seconds
But we already introduced an endpoint that just troubles the graph and provides the result without the need of this cyclic operation on the new pipeline that we will touch upon a bit later.
0:50
0 minutes 50 seconds
And ideally is to introduce it everywhere and removing these very cumbersome and sickly process in the in the packet.
1:00
1 minute
I see one question in the zone so that about the the papers, it's, it's not we have decided how much and we are sending each interview around to buy that or to to nimble it's and then well, we have decided if you want to stop or continue.
1:22
1 minute 22 seconds
I think the question is actual like what actually is is happening and and I assume it's the same, the same configuration.
1:36
1 minute 36 seconds
So it's similar configuration between the two.
1:02:57
1 hour 2 minutes 57 seconds
So one question.
1:02:58
1 hour 2 minutes 58 seconds
So when you are talking about Pyspark, this is within data breaks, right?
1:03:02
1 hour 3 minutes 2 seconds
No, no, not necessarily.
1:03:04
1 hour 3 minutes 4 seconds
OK, we are built we are built a we are we are using Spark streaming jobs.
1:03:15
1 hour 3 minutes 15 seconds
It's actually jobs, the planning and consuming data for Kafka.
1:03:21
1 hour 3 minutes 21 seconds
You can take a look.
1:03:22
1 hour 3 minutes 22 seconds
We can look them as a services, but like chemical services that always are, we are deploying them on EMR on AWS.
1:03:33
1 hour 3 minutes 33 seconds
So it's always consuming data and it's very efficient of high volumes and things like like models and So what what is the volume more or less like it was built for the instant on boarding meaning getting a request, a request and we don't live customer.
1:04:03
1 hour 4 minutes 3 seconds
One of the things that we are investing right now is actually all the process of monitoring and auto scaling of the Pispark services.
1:04:12
1 hour 4 minutes 12 seconds
It's not the classical batch operation of Spark, but it's the Spark streaming.
1:04:18
1 hour 4 minutes 18 seconds
We won't like to make sure that we are able to auto scale it properly, so won't be over provision and we want to increase our spend in the cloud.
1:04:28
1 hour 4 minutes 28 seconds
These are one of the main things that the team is working and focusing during this quarter.
1:04:34
1 hour 4 minutes 34 seconds
When this is solved is one part and the wide net is the other part.
1:04:37
1 hour 4 minutes 37 seconds
It something that we can take and and and run it on a on a higher large scale.
1:04:44
1 hour 4 minutes 44 seconds
It should it build the, the tech stack is built to, to, to, to manage larger scales or better to manage large scales and the Java based process that we have today yet to be proven.
1:04:57
1 hour 4 minutes 57 seconds
So though.
1:05:00
1 hour 5 minutes
And ideally, if everything works as planned, it's even will be cheaper in terms of costs, but we need to get to this milestone.
1:05:09
1 hour 5 minutes 9 seconds
Maybe we are not there yet.
1:05:11
1 hour 5 minutes 11 seconds
And what about do you have metrics that you can share for example with the phone extraction, right.
1:05:17
1 hour 5 minutes 17 seconds
So I imagine, you know, you have different regions or different countries and different formats.
1:05:23
1 hour 5 minutes 23 seconds
So how, how good this service is extracting, how accurate?
1:05:29
1 hour 5 minutes 29 seconds
Yeah, yeah, we have metrics.
1:05:32
1 hour 5 minutes 32 seconds
We have precision is above 90% and the I don't remember the recall, but it's pretty high around 90 as well.
1:05:44
1 hour 5 minutes 44 seconds
You are using like distances to compare, you know when you are developing the process.
1:05:48
1 hour 5 minutes 48 seconds
So you have a phone that you need to find sometimes you can you have like the country code or you know how OK, we can we can go offline, right?
1:06:02
1 hour 6 minutes 2 seconds
But yes, we can all those details.
1:06:04
1 hour 6 minutes 4 seconds
Yes.
1:06:05
1 hour 6 minutes 5 seconds
OK, OK, OK, thank you.
1:06:08
1 hour 6 minutes 8 seconds
Yeah, let's keep going.
1:06:15
1 hour 6 minutes 15 seconds
We're over time actually.
1:06:17
1 hour 6 minutes 17 seconds
I know, I know, I know.
1:06:18
1 hour 6 minutes 18 seconds
This is my next statement.
1:06:19
1 hour 6 minutes 19 seconds
But by last we cover the merchant level risk classification process pipelines, the current pipeline, the new pipeline with instant onboarding.
1:06:30
1 hour 6 minutes 30 seconds
The plan was also to cover the graph, but we got a lot of great questions.
1:06:36
1 hour 6 minutes 36 seconds
So we are on, we are on time.
1:06:39
1 hour 6 minutes 39 seconds
And Jeremy thought I think that we can we should perform the graph for tomorrow and hopefully we'll be able to squeeze it with the product level risk.
1:06:56
1 hour 6 minutes 56 seconds
Yeah, I don't have a better suggestion.
1:07:00
1 hour 7 minutes
I think, well, a couple of us, we're going to hang out and talk about the agenda anyway for tomorrow.
1:07:05
1 hour 7 minutes 5 seconds
So why don't we just include that as as part of what we want to talk about.
1:07:10
1 hour 7 minutes 10 seconds
Yeah.
1:07:12
1 hour 7 minutes 12 seconds
So, so thank you everyone.
1:07:20
1 hour 7 minutes 20 seconds
See you tomorrow morning.
1:07:22
1 hour 7 minutes 22 seconds
Afternoon depending.
1:07:26
1 hour 7 minutes 26 seconds
Jeremy, can we jump to this link this invite in like 3 minutes?
1:07:30
1 hour 7 minutes 30 seconds
We'll come back here in 3 minutes.
1:07:34
1 hour 7 minutes 34 seconds
Yeah.
1:07:35
1 hour 7 minutes 35 seconds
Yeah, that's fine.
1:07:38
1 hour 7 minutes 38 seconds
I need a smoke.
1:07:41
1 hour 7 minutes 41 seconds
Oh, I I know how to decode that.
1:07:43
1 hour 7 minutes 43 seconds
It's been 2 hours.
1:07:49
1 hour 7 minutes 49 seconds
We're spending our time together, I guess.
