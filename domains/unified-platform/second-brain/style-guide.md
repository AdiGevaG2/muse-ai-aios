# Style Guide — unified-platform

Canonical writing rules for all PM artifacts. Load the relevant section before a
writing stage. Aligns with the engine's provenance / fact-vs-inference rules:
never present a guess as a fact.

## Voice (applies everywhere)
- Write like a senior product partner, not a document generator.
- Professional, clear, concise, decision-oriented, practical.
- Direct and useful over polished but vague. Simplest wording that still says it.
- Active voice. Precise sentences — short by default, but a long sentence is fine when every clause is load-bearing (don't pad, don't sand off necessary precision). 
- One idea per bullet. Paragraphs 1–4 sentences.
- Cut filler: "It is important to note that", "In order to", "As part of this
  effort", "The intended behavior is to".
- Never make work sound more decided than it is. Never turn assumptions into
  facts. Never invent decisions, metrics, owners, dates, research, or technical
  detail. Mark unknowns `Unknown`, `TBD`, or `Not yet available`.

## Formatting (applies everywhere)
- Optimize for a 1–2 minute scan: short paragraphs, bullets, tables.
- Tables only when they improve scanning. Numbered lists for step-by-step flows.
- Don't over-format; no header for a two-line answer.

## Discovery
- Preserve existing structure, section order, and flow. Don't invent or rename
  top-level headers (minor clarity rename only). Don't add sections the source
  doesn't imply.
- Shorten and de-repeat. Make it decision-friendly.
- Section rules:
  - **TL;DR** — core issue, near-term direction, why it matters, next decision.
  - **Executive Takeaway** — one short paragraph or compact table.
  - **Problem** — open with one sentence naming the core problem.
  - **Pain Points** — table if 3+ distinct points.
  - **Persona / Target Audience** — short; bold labels for primary user,
    secondary audience, job-to-be-done.
  - **Data** — separate known evidence from gaps.
  - **Feature Behavior** — user-facing behavior in plain language.
  - **User Journey** — 4–6 short action-based steps.
  - **Scope** — In / Out / Future, crisp and explicit.
  - **Success Signals** — observable signals; no invented numeric targets.
  - **Open Questions** — specific and actionable.

## PM workflow (interaction)
- Ask first, then draft. Only the highest-impact unresolved questions.
- Approval-gate questions as a table: `Decision | Why it matters | Your answer`.
- Don't overwhelm with long question lists.
- After each step: a short summary — what changed, what's open, any current-state
  conflict/missing behavior, and the next approval question.
- Wait for approval before the next major step. Never create/publish/sync/update
  external systems without approval.

## PRD
- Use `.claude/skills/prd/references/prd-template.md` exactly — same sections,
  names, order, tables, subsections. No extra top-level sections. Keep
  non-applicable ones marked `N/A - [reason]`.
- Executive Summary: 2–4 concise paragraphs. Describe the current problem clearly.
- User Journeys: primary journey only. No separate Use Cases section — fold each
  use case into Acceptance Criteria as Gherkin, covering happy and error flows.
- Capture product behavior, not Figma-level detail.

## Product spec
- Open with the spec-translation summary and current decision state.
- Clear headings, short sections, implementation-ready language. Testable
  requirements.
- Be specific: expected behavior, system response, user-facing states, error
  handling, data changes.
- Tables for requirements, rules, permissions, validations, edge cases, analytics
  events, QA coverage. Numbered flows for step-by-step behavior. Gherkin for
  acceptance criteria.
- Separate: approved decisions / implementation assumptions / open questions /
  risks / change classifications. Enough detail that Eng + QA don't guess.

## Jira / handoff / deck
- Jira: focus on the selected Initiative / Milestone / Epic / Story-Bug hierarchy.
  Include user stories, acceptance criteria, dependencies, design/QA/analytics
  tasks, follow-ups, open questions.
- Deck: concise, presentation-ready, decision-oriented. Markdown tables for
  audience, source-of-truth alignment, slide outline, required inputs, open
  questions.

## SpecKit
- Checklists validate requirement *quality*, not whether the product works.
  Ask "Is X clearly specified?" not "Does X work?"
- Clarifications: short, high-impact, answerable by multiple choice or a phrase.
  One at a time in `speckit.clarify`, with a recommended option + 1–2 sentence
  reason, options in a table.
- Analysis reports: structured markdown — findings tables, coverage summaries,
  metrics, concise next actions.

## Compressed modes
- Caveman mode: strip filler/hedging/pleasantries; preserve technical accuracy.
  Never alter code, API names, commands, file paths, symbols, exact error strings.
- Commit messages: Conventional Commits, imperative, short subject; body only
  when the "why" isn't obvious.
- Review comments: one line per finding — location, problem, fix.
- Drop terse mode when clarity matters more: security warnings, irreversible
  actions, complex sequencing, architecture disagreements.

## Diagrams
STATUS: future — draw.io tooling (`scripts/mermaid_to_drawio.py`) not yet
in repo. Rules below apply once it exists.
- PM diagrams: editable, transparent draw.io SVG embedded inline in the Markdown.
- Provenance comment above each: `<!-- diagram: {feature}-{name}.drawio.svg -->`.
- Inline draw.io SVG is the source of truth. No Mermaid as final source; no
  separate `.drawio.svg` files; no external image references in source artifacts.
- Convert legacy Mermaid to inline draw.io SVG before finalizing.
- Confluence: extract the inline SVG, upload as attachment, embed in the page.