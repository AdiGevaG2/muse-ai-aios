---
name: client-meeting-summary
description: Write a client-facing meeting summary to send to a client after a meeting. Use when the user says "meeting summary for <client>", "write a summary to send to <client>", "recap email for the client", "follow-up after the client meeting". Not the internal leadership summary, which carries usage data and internal assessments.
---

# Client meeting summary

A summary sent to the client after a meeting. Its job is to show the client we
listened, we care about their input, and we have an answer for each pain point.

The approved example is `references/approved-example-cal-2026-11-05.md`. Every
summary matches its structure and tone.

## Inputs

1. Meeting material the PM points to: notes, transcripts, a feature folder in
   `outputs/`, or text pasted by the PM, such as a colleague's note to leadership.
2. If the PM gives nothing, check monday.com meeting notes and the Outlook
   calendar for the meeting once. If nothing turns up, ask the PM for notes.
3. When several sources cover the same meeting, merge them. A correction by the
   PM overrides the meeting sources. When sources conflict, pick one, and name
   the conflict in the reply.

## Structure

1. **Title:** `<Client> Meeting Summary`.
2. **Opening**, three lines:
   - Thank you for a great meeting on `<date>`.
   - You were open about what is not working for your team, and that is
     exactly what we need to improve.
   - We took each point into account. Here is what we heard and how we will
     address it.
3. **Numbered pain-point sections.** Each section title names the client's
   pain in their terms, for example "Too many findings to keep up with". Under
   it:
   - `What you told us:` the pain, in one bullet.
   - `Our solution:` sub-bullets with the answer.
4. **Your ideas:** "Your ideas were valuable, and our product team is reviewing
   each one:", followed by one bullet per idea the client raised.
5. **Action items:** one bullet per item, prefixed `<Client>:`, `G2:` or
   `G2 (<name>):`. List the client's items first.
6. **Closing:** "We look forward to working on this together."

## Rules

- All content is bullet points. No prose paragraphs beyond the opening and
  closing.
- The tone is warm. It thanks the client and shows we value their input.
- Every pain point gets a solution. A solution comes only from what G2 agreed
  in the meeting or from a feature that exists today. If you add a solution the
  meeting did not agree, name it in the reply and ask the PM.
- Leave out internal material: usage numbers, internal assessments, renewal or
  pricing risk, leadership decisions, and items G2 has not decided.
- Leave out internal release names and version labels. Write "in the past
  months" instead.
- Do not promise a date or timing the meeting did not confirm. Pricing is tied
  to the pricing plan, as in the example.
- Drop any G2 statement that was not confirmed as a commitment, such as a
  roadmap date.

## Output

- Draft in chat first. Start the message with "Written for: <client> team, as a
  client-facing email."
- When the PM approves, save it as
  `outputs/<feature>/meeting-<client>-<mon>-<d>-<yyyy>.md`, for example
  `meeting-cal-nov-5-2026.md`. Keep the PM's wording; only add markdown
  headings.
- Never send it. Sending is a manual step for the PM.
- This is a client email, not a product document. Skip the doc-review and
  conflict checks. Flag inconsistencies inside the summary in the reply
  instead.
