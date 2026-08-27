# Repo freshness check (before reading local source)

Any workflow that reads a local repo clone for current behavior runs this check
before producing analysis from that source.

## Steps
1. **Identify which repos are in scope.** Use the feature README, domain index,
  and `code-repos-git/REPO-MAP.md` to resolve the question to a concrete list
  of local repo paths. Do not guess - if there is no repo route, ask the PM
   which repos are in scope before continuing.
2. **Check freshness per repo automatically**, without mutating anything:
  - Use `git ls-remote` to read the remote branch tip without changing local
    refs or `FETCH_HEAD`. If remote access is unavailable, state that limitation.
  - Compare local `HEAD` to the remote tip when ancestry is already available;
    otherwise report only whether the commit IDs match.
   - Note the local last-commit date, and whether the working tree is dirty
     (uncommitted changes) — `git status --porcelain`.
3. **Flag stale repos to the PM.** A repo counts as stale if it's behind
  the remote branch at all, or its last local commit is older than ~3 weeks
   (a default threshold — adjust if the domain context specifies otherwise).
   Report each stale repo with: how far behind, last local commit date, and
   whether it has uncommitted local changes.
4. **Ask before mutation.** If current remote content is needed, ask: *"These
  repos are stale — pull latest before analyzing?"*
   - **PM says yes:**
     - For clean repos (no uncommitted changes): fast-forward pull.
     - For dirty repos: do NOT pull automatically — local uncommitted work
       could conflict. Tell the PM which repos have local changes.
       Never stash or otherwise modify a dirty working tree merely to inspect
       current source. Skip updating that clone. If remote content is required,
       request explicit scoped approval to download it separately.
     - Confirm the result (new HEAD, what moved) before proceeding to analysis.
   - **PM says no:** do not pull. Proceed with what exists locally, but carry
     the staleness forward as a visible caveat in the stage's output artifact
     itself (not just said in chat) — e.g. in the behavioral spec's coverage
     section: "Source `<repo>` was N days stale as of this analysis; recent
     changes may not be reflected." This is the same "show evidence, not
     assertion" principle as everywhere else in this engine — a silent
     staleness gap is exactly the kind of failure that has to surface in the
     artifact, not disappear into the chat log.

Read-only inspection never needs approval. Pulling, stashing, switching refs, or
otherwise changing repository state does. A stale source can make current-
behavior analysis wrong, so carry unresolved freshness limits into the output.
