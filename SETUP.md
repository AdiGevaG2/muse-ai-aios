# SETUP — pm-aios in the Claude Code extension

This is a Claude Code workspace: skills, agents, hooks, and a knowledge base as
plain markdown. Here's how to stand it up.

## 1. Prerequisites
- **Claude Code** — the CLI, or the Claude Code extension inside VS Code / Cursor.
  (You don't need to write code; you need to be comfortable in a terminal.)
- A Claude subscription that includes Claude Code.
- **`jq`** — required. The guard hooks parse their payload with it and fail
  closed without it. `brew install jq`.
- **Python 3** — required for `tools/scripts/mermaid_to_drawio.py`, which turns
  a mermaid block into an inline, editable draw.io SVG. Install the Draw.io VS
  Code extension to edit the result.

## 2. Put the workspace in place
1. Put `pm-aios/` wherever you keep projects.
2. Open that folder in the Claude Code extension (or `cd pm-aios && claude`).
3. On first launch, Claude Code discovers `.claude/` automatically. Because this
   adds a new top-level skills directory, **restart the session once** so it's
   watched.
4. Verify: type `/` — you should see the eleven workflow skills:
   `/reverse-engineer`, `/discovery`, `/prd`, `/spec`, `/ai-eval`,
   `/analytics-plan`, `/validation`, `/publish`, `/ingest`, `/retro`, `/review`.
5. If you'll run `/reverse-engineer` against local repo clones, set
   `CODE_REPOS_ROOT` to wherever you keep them (defaults to
   `~/vsCode/code-repos-git` if unset) and add that directory as an additional
   working directory in the extension.

## 3. Prove the guards actually fire
Do this before trusting the workspace with anything sensitive.

```bash
bash scripts/test-hooks        # 32 assertions: guards block, allow, fail closed
bash scripts/validate-workspace
```

Both must pass. `test-hooks` exists because the guards previously read a
`TOOL_INPUT_PATH` environment variable that Claude Code never sets — they
exited 0 on empty input, so they passed everything silently while appearing
configured. **An untested guard is theatre.** Re-run this suite after any change
to `.claude/hooks/` or `.claude/settings.json`.

To confirm the hooks fire inside a real session rather than just in the test
harness, run `claude --debug` and trigger a write; the hook invocation appears
in the debug log.

## 4. Fill the context (this is the real setup — ~30 min)
The structure is built; the knowledge is not. Fill these before a real run:
- `domains/unified-platform/config.json` — replace every `<...>`: tool project IDs
  (Mixpanel, Coralogix, Jira, Confluence, Figma), naming, gates.
- `domains/unified-platform/CLAUDE.md` — the `<...>` in strategy, voice, delegation.
- `domains/unified-platform/second-brain/writing-samples.md` — paste 2–4 REAL
  examples of how you write. Highest-leverage file for output quality.
- `org-brain/context/policies.md` and
  `domains/unified-platform/second-brain/context/compliance.md` — your real
  governance facts (human-owned; never auto-written).
- `OWNERSHIP.md` — fill `<owners>` when the pilot expands past you.

Run `bash scripts/validate-ai-readiness` to see what is still a stub.

## 5. Connect tools (MCP)
Configuration metadata does not prove a working connection. `config.json` keeps
each integration `UNVERIFIED` until an actual runtime probe succeeds; use
`VERIFIED_READ` or `VERIFIED_WRITE` only for the capability directly tested.
Wire connectors in the extension settings:
- **Mixpanel** — official MCP, service-account auth. Org admin must enable it.
- **Coralogix** — official MCP, `mcp-version: v2` header, OAuth.
- **Jira + Confluence** — for external handoff. Writes require explicit approval.
- **Figma** — for spec/design reconciliation.

Until a connector is wired, the stage that uses it runs everything except the
live call. Never put a credential in a repo file, artifact, prompt, or chat —
the secret-guard hook blocks it, and you should not be relying on the hook.

## 6. First run
Don't run the full flow first. Prove one stage on something small:
- `/reverse-engineer <a small real module>` — pressure-tests the evidence loop.
- or `/ingest <an article>` — see the wiki, index, and log build.

Standalone stages ask **Quick** (assume low-stakes gaps, flag them) or **Strict**
(ask every gap). High-stakes gaps always stop regardless.

## 7. The flow
```
/reverse-engineer  → source-cited evidence about what exists today
/discovery         → problem, direction, scope        [approval gate]
/prd               → product intent + acceptance      [approval gate]
/spec              → figma delta review + exact build behavior  → engineering
/ai-eval           → is the model good enough?        (AI features only)
/validation        → did we build the spec? + alignment drift check
/analytics-plan    → measurement plan                 (when warranted)
/publish           → Jira handoff; Confluence only when explicitly requested
/retro             → learnings back into the brains   [approval gate]
```

Figma delta review is a step inside `/spec`, not a separate skill — it writes
`reconcile-notes.md` and the PM arbitrates each mismatch.

`/publish` asks about Confluence and Jira **separately**. A yes to one is never
a yes to the other. It renders `prd.md` and `spec.md` into Confluence pages —
those are renderings, not sources of truth, so intent changes go to the markdown
first and then republish. Jira uses `Initiative → Milestone → Epic → Story/Bug →
Subtask`; there is no Feature level.

**`/ai-eval` and `/validation` are not interchangeable.** Validation asks
whether the build matches the spec. `/ai-eval` asks whether the model output is
good enough to ship, against the bar in the PRD. A feature can pass one and fail
the other — an implementation can match its spec perfectly and still be wrong
too often to launch.

Run `/ai-eval` for any feature where a model, score, ranking, generated text,
classification, or extraction affects what the user sees. The discovery template
forces that question up front, in `Solution Nature: Deterministic or
Probabilistic` — answer it there and the rest of the pipeline knows what it is
building.

## 8. Keep it alive (avoid context rot)
- `/ingest` as you read — the wiki compounds.
- `/retro` at each feature close — corrections flow back to the brains.
- `/review` on a cadence — sweeps for drift, contradictions, broken wiki links,
  and stale eval results whose model or prompt version has moved on.

The system maintains itself only if someone runs the loops. An empty
`second-brain/` is not a neutral state: it means every feature starts from zero.

## 9. Later: migrate to a team plugin
When it's proven and you want the team on it: add `.claude-plugin/plugin.json`,
move `skills/` + `agents/` to the plugin root, swap relative refs for
`${CLAUDE_PLUGIN_ROOT}`, and publish to a private marketplace. Knowledge
(`org-brain/`, `domains/`) stays out of the plugin so the engine stays portable.
See `OWNERSHIP.md` for who owns what at team scale.
