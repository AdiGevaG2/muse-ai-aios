---
name: reverse-engineer
description: Turn targeted legacy or current code into concise, source-cited product behavior evidence. Use for "reverse engineer", "analyze existing behavior", "what does this system do", or when implementation evidence is needed before discovery, PRD, spec, or validation.
---

# Reverse Engineer

Produce concise, source-cited **product behavior** evidence for
$ARGUMENTS (a feature, module, path, or question).

This is a PM reverse-engineering workflow, not a forensic code audit. The
deliverable is what a PM needs to make migration and scope decisions — not a
description of the subsystem.

## Scope questions (one round, before any research)
Determine four things:

1. **Feature**
2. **Source platform(s)** — Merchant View, Single Platform, WebShield, Unified
   Platform, or multiple
3. **Target platform**
4. **Quick or Strict** (see below)

Ask only the fields genuinely missing. If the user already supplied a field —
including via abbreviation (MV, SP, WS, UP) — do not ask it again. Never ask for
an output folder or feature-workspace name when it can be derived from the
feature name; derive it and state it in one line.

`Reverse engineer Connected Sites from MV, WS and SP. Target UP. Strict.`
supplies all four. It should require zero follow-up questions.

## After research begins, do not interrupt
Once research starts, the only two reasons to stop and ask:

- Two materially different **product** interpretations would produce different
  PM conclusions, or
- A required source is completely inaccessible and the entire requested analysis
  cannot reasonably continue without it.

Otherwise: make the safest reasonable interpretation, record the assumption or
evidence gap, and continue. **Missing evidence is usually an `UNKNOWN`, not a
question to the PM.** A technical uncertainty that changes no product decision
is never a PM question.

## Steps

1. **Read existing PM evidence first.** Before any deep code research, check
   narrowly for evidence on this exact feature:
   - active feature artifacts under `outputs/<feature>/`
   - relevant Confluence/Jira via Rovo (targeted search, not a sweep)
   - existing discovery or reverse-engineering material

   If an existing discovery or product decision already scopes the feature, use
   it to **reduce** the code investigation. Do not discover a known feature
   decision after spending most of the run reverse-engineering code.

2. **Write the product questions.** Identify at most **3–7** questions the
   investigation must answer, e.g.:
   - What does the user see today?
   - What creates the object / triggers the behavior?
   - Who owns the data (e.g. does each URL own its findings)?
   - What user actions exist?
   - What business rules must be preserved?
   - What already exists in the target platform?
   - What is genuinely missing?

   These questions are the scope. Search only enough evidence to answer them.
   Do not attempt to document the entire subsystem.

3. **Resolve sources.** Use the selected platforms to pick repositories;
   `code-repos-git/REPO-MAP.md` targets the search. Prefer local clones; use
   GitHub MCP for repos not cloned locally, for history, or to read current
   remote content. Search to locate, then read the specific file — never page
   whole files through the API.

4. **Freshness is a caveat, not a workflow.** Inspect available repos read-only.
   Follow `../_shared/repo-freshness-check.md`: report stale evidence as a
   caveat in the artifact and continue. Read current remote content only when
   freshness materially changes the answer. Never pull, fetch, checkout, switch
   branches, or stash, and never ask whether to — unless the PM explicitly asked
   to update the local repo.

5. **Analyze.** Answer the product questions. Inspect targeted files directly
   when the question set is small. Delegate per the subagent rules below when
   delegation reduces main-context noise.

6. **Verify inline (Strict only, narrowly).** Verification happens in this
   workflow — never by the general `verify` agent. Verify only:
   - migration-critical claims
   - contradictory evidence
   - surprising or high-consequence claims

   Verification means checking one additional independent source where useful.
   Do not re-run the investigation, do not perform completeness analysis, and do
   not launch a second full research pass. Stop when the critical claim is
   sufficiently supported, or leave it `Unknown`.

7. **Report, then ask once to persist.** Present the concise findings and the
   proposed artifact path. Persist only after explicit approval. Do not bundle
   the persistence approval with research questions.

## Hard stopping rule
Stop researching when either:

- the defined product questions are answered with sufficient evidence, or
- the remaining unanswered points would not materially change the PM conclusion.

Do not continue merely because more code exists. Do not search for completeness
for its own sake. Once sufficient evidence exists, do not run further naming or
synonym searches.

## Quick vs Strict
Both modes share the **same bounded product scope**.

**Quick** — targeted evidence; one strong source per important behavior when
sufficient; prioritize product-visible behavior; unresolved technical detail
becomes `Unknown`.

**Strict** — same scope, higher confidence. Independently verify only high-risk
or migration-critical claims; normally two strong sources for critical claims
when available; verify contradictions and non-obvious business rules.

Strict does **not** mean: inspect every possible file; enumerate every enum
unless required; trace every call chain; produce dozens of behavioral rules;
duplicate the investigation with a verifier; or search every naming synonym
after sufficient evidence exists.

**Strict increases confidence, not scope.**

## Missing platform evidence
If a requested source platform cannot be accessed: attempt **one** reasonable
alternate evidence route. If still unavailable, mark that platform
`NOT VERIFIED`, note it as an evidence gap, and continue with the other
requested platforms. Do not ask the PM again about the same unavailable source,
and do not troubleshoot infrastructure inside a product reverse-engineering
task.

## Subagent discipline
Use subagents only when they reduce main-context noise. Give each a **small
bounded question set** — never "reverse-engineer this platform."

- Prefer **one bounded pass per materially different platform**.
- Avoid separate backend + frontend + verifier + mapper passes unless genuinely
  necessary.
- Never ask an agent for an exhaustive coverage map or dozens of rules.

`legacy-analyzer` handles a bounded source-platform pass; `target-mapper` handles
the target-side delta. Strict verification is performed inline by the parent
workflow; do not invoke the general `verify` agent.

## PM relevance filter
Include a technical detail only when it affects: user behavior, business rules,
permissions, data ownership, migration parity, UX/state, implementation
feasibility, or significant risk. Do not document engineering implementation
detail that changes no product decision.

## Output
Keep it concise. Structure:

```
# Reverse Engineering: <Feature>

## Executive Summary          (3–6 bullets)
## Current Behavior by Platform   (product behavior only)
## Business Rules to Preserve     (normally 5–15)
## Target Platform: What Already Exists
## Gaps
## Conflicts / Product Decisions  (genuine PM decisions only)
## Evidence Gaps
```

Normally produce **no more than 15–20 behavioral rules total**, unless the PM
explicitly requests a comprehensive technical reference. Cite sources to support
claims — never reproduce the investigation transcript or a code walkthrough.
Include last verified repo/branch/commit where available.

Findings are always persisted to their own current-state document, never merged
into discovery, PRD, or spec. Default path:
`outputs/<feature-name>/current-state/<feature-name>-reverse-engineering.md`. For historical
features, follow the feature README.

## Do not narrate research
Investigate silently. During a normal run do not tell the PM which grep is
running, which repo is opening next, which subagent is still working, or what
intermediate implementation details turned up. Surface something mid-run only
when an immediate PM decision is genuinely required. Report once, when the work
is done.
