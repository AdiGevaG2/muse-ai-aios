---
name: reverse-engineer
description: Turn targeted legacy or current code into concise, source-cited product behavior evidence. Use for "reverse engineer", "analyze existing behavior", "what does this system do", or when implementation evidence is needed before discovery, PRD, spec, or validation.
---

# Reverse Engineer

Produce targeted, source-cited behavior evidence. Target for analysis:
$ARGUMENTS (a path, module, feature area, or question). If empty, ask what code
or behavior is in scope.

## Before you start
- Confirm the active feature if the task is feature-specific.
- For feature-specific work, follow `../../../outputs/README.md`. If the feature
   workspace does not exist, initialize `outputs/<feature-name>/README.md` after
   confirming the feature name and active domain.
- Clarify any platform scope not explicitly stated by the user:
   - **Source platform:** Merchant View, Single Platform, WebShield, Unified
      Platform, or Multiple / all relevant platforms.
   - **Target platform:** Merchant View, Single Platform, WebShield, Unified
      Platform, or Other.
- Do not infer source or target platform from the feature `README.md`, repo map,
   or existing workspace routing. Do not ask again when the user stated it.
- If invoked directly, ask the Quick evidence vs Strict reference question
   after platform scope is known.
- Do not read implementation repositories until both source and target
   platforms are known.
- Read the feature `README.md` when present, then resolve repositories for the
   selected platforms.
- Read only the exact artifact or domain context routed by the README or domain
  `INDEX.md`.
- Use `code-repos-git/REPO-MAP.md` only to target search; verify important facts
   against source files. Repository mappings identify where to look after
   platform selection, not which platform the user intended.
- Sources, in order: local clones (fastest, but check freshness), then GitHub
   MCP for uncloned repos, commit history, PRs, and blame context. Both are
   read-only here — cloning, branching, and any write need explicit approval.
- When multiple source platforms are selected, analyze each separately before
   comparing and consolidating behavior.

## Steps
1. **Scope.** Identify the feature; clarify source platform(s), target platform,
    and run mode in that order. State what you will and will not examine. Do not
    silently expand scope.
2. **Resolve repositories.** Use the selected source platform(s) to choose
    behavior repositories and the target platform to choose target repositories
    and migration-gap evidence. Prefer local clones under `CODE_REPOS_ROOT`;
    use GitHub MCP for repos not cloned locally, for history and PR context, or
    to confirm a local clone is not stale. Search remotely to locate, then read
    the file — do not page whole files through the API.
3. **Freshness check.** Follow `../_shared/repo-freshness-check.md` for every
   local repo the scoped analysis will read when current behavior matters.
4. **Analyze.** For small questions, inspect targeted files directly. For broad
   or high-stakes legacy behavior, delegate to `legacy-analyzer`.
5. **Verify.** Use `verify` when claims are important enough that independent
   traceability is worth the context cost.
6. **Persist findings only with approval.** Feature workspace initialization is
   part of invoking this stage. First present the findings and proposed reverse
   artifact/write scope. Create or modify the reverse artifact only after
   explicit scoped approval. Otherwise return the findings in chat.

## Output
Return or persist only:
- confirmed behavior
- evidence/source paths
- unknowns
- conflicts
- last verified repo/branch/commit when available

Do not dump transcripts or broad code walkthroughs.

When persistence is approved, write the default new-feature artifact to
`outputs/<feature-name>/reverse/<feature-name>-reverse.md`. For historical
features, follow the feature README.

## Run mode (standalone)
If invoked directly, ask:

- **Quick evidence** — targeted check, lower token use
- **Strict reference** — broader verification, higher token use

## Evidence on completion
Show source paths and the specific behavior they support. Reviewing the evidence
must be faster than repeating the search.
