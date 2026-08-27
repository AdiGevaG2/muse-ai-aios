---
name: testing
description: Capture prototype user-testing feedback and route amendments through the PRD. Use when the user says "log test feedback", "we did user testing", or has prototype feedback to fold in. Feedback flows through the PRD first, then propagates.
---

# Prototype Testing

Capture user-testing feedback on the prototype (from `/design-prototype`,
`prototype/`) and turn it into PRD amendments.

## Before you start
- Confirm active domain + feature name.
- Load `org-brain/` then `domains/<domain>/second-brain/`.

## Steps
1. **Record raw feedback** from the prototype test, organized by theme.
2. **Separate signal from noise** — which feedback implies a real change vs. a
   one-off preference.
3. **Turn real changes into PRD amendments.** Feedback NEVER edits the spec or
   Figma directly. It becomes a PRD change (bump version), and downstream
   artifacts re-propagate from the new PRD.
4. **Hand off to propagate** once the PRD is amended.

## Output
- `domains/<domain>/features/<feature-name>/testing/feedback.md` (raw + themed)
- `domains/<domain>/features/<feature-name>/testing/amendments.md` (the specific
  PRD changes proposed, referencing PRD sections)

## Run mode (standalone)
If invoked directly (not via /feature-flow), first ask the PM: **Quick one-off**
(assume low-stakes gaps, flag each inline) or **Strict** (ask on every gap)?
Follow `../_shared/run-mode.md`. Either way, high-stakes gaps (compliance,
requirement/behavior decisions, invented components, unanchored metrics, or any
write to PRD/Jira/Confluence/brain) are ALWAYS asked, never assumed.

## Evidence on completion
Do not just claim done. Show the artifact: the file path written, the actual
query result / figures, the diff, or the mismatch/gap list — whatever this stage
produced. Reviewing the evidence must be faster than re-doing the check. This
catches silent failures (a stage that "ran" but produced nothing usable).
