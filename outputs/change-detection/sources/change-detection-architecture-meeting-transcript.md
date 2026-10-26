# Source: Change Detection planning and architecture meeting - transcript excerpt

- **Provided by:** Adi Geva, pasted into the session on 2026-10-20
- **Meeting date:** Unknown
- **Speakers:** EverC MR - U2 (VC), a meeting-room account carrying several speakers; Juan Martini; Julian Alvarez. Daniel, Dan, Alex, Carl, Margo and Sarit are named in the conversation.
- **Coverage:** Partial. The excerpt holds 0:04 to 1:24 and 38:28 to 46:35. Minutes 1:24 to 38:28 were not provided.
- **Fidelity:** Verbatim from the Teams auto-transcript, including recognition errors. Speaker avatar initials are removed.

---

**EverC MR - U2 (VC)** 0:04
a sort of like product brief on change detection. So I was going to start there.

**EverC MR - U2 (VC)** 0:10
Um...

**EverC MR - U2 (VC)** 0:11
And then Juan, we can kind of turn it over to you guys to talk through what you've been working on, like what you and Dan have been working on in terms of like the architecture and whatnot. Does that sound good?

**Juan Martini** 0:24
Yeah, that sounds perfect, yeah.

**EverC MR - U2 (VC)** 0:27
OK, I will share.

**EverC MR - U2 (VC)** 0:39
Okay.

**EverC MR - U2 (VC)** 0:41
Change detection.

**EverC MR - U2 (VC)** 0:45
The reason this became a priority for this quarter is because we currently utilize a vendor for change detection called Visual Ping. We're paying them about $140,000 a year and essentially they have become a

**EverC MR - U2 (VC)** 1:05
basically a competitor. They started learning about our use cases through our work with them, and they've launched a monitoring product as a result. So we're going to stop working with them, and we need to build the capability in-house. Daniel already did POC.

**EverC MR - U2 (VC)** 1:24
around this a while ago, which was pretty successful. And so this essentially goes into what we need to do to rebuild to replace the vendor as a first priority. Our contract is up in September, so we definitely need to have parity by then.

*[0:01:24 to 0:38:28 not provided]*

**EverC MR - U2 (VC)** 38:28
So then you can send an ID and then actually the SSRF team will include the default race and a good bunch of other stuff.

**EverC MR - U2 (VC)** 38:39
So, again, as much as we can to...

**Juan Martini** 38:39
Okay.

**EverC MR - U2 (VC)** 38:42
squeeze it, I hope to, not to squeeze it, but to apply, right? Because if it's squeezed, we might lose data, but if it fits in the current model, great. If not, we're gonna...

**Juan Martini** 38:52
Mhm.

**EverC MR - U2 (VC)** 38:54
Here we go, next, and so...

**Juan Martini** 38:54
Sarit.

**Juan Martini** 38:56
Yeah, I have a question, Alex, related with this kind of decision in models that we were talking before. You told me that you think that you have something like that in place that we can reuse. My question here is, okay, do

**Juan Martini** 39:15
Do you think that we are going to need to create a new model for this? Or do you think that what we have is good enough? Because remember that the output that we are going to have is going to be the old HTML, the new HTML, the old screenshot, the new screenshot.

**Juan Martini** 39:35
And then after that, we need to calculate the differences and if are worth being reported. So do you think that we have something like that in place that we can reuse or we should be working in a new model for doing that?

**EverC MR - U2 (VC)** 39:47
No, no, no, no, no.

**EverC MR - U2 (VC)** 39:49
I'm here the representative of application of control plane level. I'll give you the data schedule and everything. You give me the calculated everything that you have. You need to talk to Core one, that's for sure. Sorry about getting only on the upside for now, but...

**Juan Martini** 39:55
Ohh, okay, okay, okay.

**Juan Martini** 40:07
No, no, that, that I, I, I was, yeah, I was double checking that I had the correct assumptions. OK, perfect. I, I need to check with with Carl, yeah.

**EverC MR - U2 (VC)** 40:09
I'm in.

**EverC MR - U2 (VC)** 40:11
What did you?

**EverC MR - U2 (VC)** 40:14
But, yeah, but definitely, like, reuse the core components of for sure.

**Juan Martini** 40:35
Mdm.

**Juan Martini** 44:38
Because I mean, it's going to be super interesting if at least we can like, like, get access.

**EverC MR - U2 (VC)** 44:43
Yeah, I'm sure Margo can set up for now. I mean, I think we just have to talk to her.

**Juan Martini** 44:50
Because I don't want to miss features that currently the analysts are using for speeding up their flow, you know, and you know, if we can get access to the visual pin portal, I think that would move much faster, you know, in terms of understanding flows and things like that, you know.

**EverC MR - U2 (VC)** 44:56
Yeah.

**EverC MR - U2 (VC)** 45:05
Yeah.

**EverC MR - U2 (VC)** 45:09
Yeah, I think we need to do a deeper dive with her too, but I mean, we only have that like hour session, so we can have her set us up and walk us through it and I'll take a follow up for that too.

**EverC MR - U2 (VC)** 45:23
Can we have those tools there?

**EverC MR - U2 (VC)** 45:37
No.

**EverC MR - U2 (VC)** 45:39
All right.

**EverC MR - U2 (VC)** 45:41
Anything else?

**Juan Martini** 45:44
No, I think I'm good. Daniel, I will ping you separately for coordinating a meeting probably tomorrow if you have some time.

**EverC MR - U2 (VC)** 45:50
Yeah.

**EverC MR - U2 (VC)** 45:55
Actually, yeah.

**Juan Martini** 45:57
Yeah, okay.

**Juan Martini** 45:59
Yeah.

**EverC MR - U2 (VC)** 46:00
How do I call Juan? How do I call this initiative from your side? So, I have like dependency core, change detection, yeah, so this, and again, we gonna talk, OK, so we gonna talk through topics, right? So, that's our...

**Juan Martini** 46:09
Cbd.

**Juan Martini** 46:15
Mhm.

**EverC MR - U2 (VC)** 46:18
Yeah, as you whatever is easy, just for you. OK, change the section, see it is, yeah. OK, cool. Thank you. Just a second, something that, OK.

**Juan Martini** 46:19
Yeah.

**Juan Martini** 46:23
Yeah.

**Juan Martini** 46:29
Kick.

**EverC MR - U2 (VC)** 46:30
All right. Thanks, guys.

**Juan Martini** 46:33
Thank you guys. Take care. Bye. Bye bye. Thank you.

**EverC MR - U2 (VC)** 46:33
Say, no.

**Julian Alvarez** 46:35
Thank you, bye guys.
