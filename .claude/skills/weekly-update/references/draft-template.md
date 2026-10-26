# Weekly update draft format

Copy-ready for Slack. One section per initiative, in this exact shape:

```
*Initiative name*

*Progress and wins:* <what changed, not just what happened, the delta>

*Planned next:* <one concrete next step, not "continue working on X">

*Blockers, risks and help needed:* <what's blocking and what help is actually needed, or "None.">
```

Rules:
- Initiative names are bold plain text (`*Name*`), never a markdown header
  (`#`/`##`) and never nested/indented under a parent bullet. Slack doesn't
  render headers or indentation the way a doc does.
- Never use an em dash (—) anywhere in the draft. Use a hyphen (-), comma, or
  period instead.
- No internal file paths, repo links, or doc links in the final text — those
  live in `current.md`/the archive for traceability, not in the Slack copy,
  unless the audience can actually open them (e.g. a Confluence link the
  whole team has access to).
- No placeholders. If there's genuinely no next step or no blocker, say so
  plainly ("None.") rather than inventing one.
- Order initiatives by significance (most newsworthy first), not alphabetically.
- Whole draft should read in under two minutes — cut anything that doesn't
  change what a reader believes about the initiative.

## Response shape (mandatory, every /weekly-update reply)

Present the draft as rendered text in the reply, not inside a code block, in
exactly this order:

1. One opening line: that this week's Slack update is drafted below, and
   which sources it was built from (capture log, files changed, commits,
   Slack), naming any source that was empty.
2. The initiative sections. Initiative name on its own line in bold, then
   `Progress and wins:`, `Planned next:`, and `Blockers, risks and help
   needed:` as plain-label paragraphs.
   - Progress and wins: what was produced or decided, then the concrete
     substance (scope set, what the user will see, what moved to a later
     phase, findings), in short sentences.
   - Planned next: name the specific open items, with a count when there
     are several.
   - Blockers: name who must confirm what, with ticket keys when known.
   - Say "published" or "sent" only when there is evidence for it;
     otherwise "drafted".
3. One closing line: this is a draft only, nothing was sent or posted, and
   once it's pasted into Slack, saying it's sent (or running /weekly-update
   again) archives it and resets the log.
4. `Did` with 1-4 bullets: sources used, what was left out and why, what is
   confirmed vs. drafted.
5. `Need from you:` one line.

Example:

> This week's Slack update is drafted below. Nothing was captured in the
> running log, so it's built from files changed this week. There were no
> commits.
>
> **Full MCC Parity in Atlas**
>
> Progress and wins: The mini PRD is published to Confluence with a
> clickable prototype. Scope is set as a lift and shift of MerchantView's
> MCC comparison. ...
>
> Planned next: Close the 5 open decisions with engineering in spec. They
> are ...
>
> Blockers, risks and help needed: Need engineering to confirm that ...
>
> This is a draft only. Nothing was sent or posted anywhere. Once you've
> pasted it into Slack, tell me it's sent (or run /weekly-update again) and
> I'll archive it and reset the log for next week.
>
> Did
> - Wrote the draft from this week's PRDs, prototypes and the Confluence
>   publish record, since the capture log was empty.
> - Only the MCC PRD is confirmed published. The other three are described
>   as drafted.
>
> Need from you: ...
