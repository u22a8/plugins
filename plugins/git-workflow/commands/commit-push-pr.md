---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*), Bash(git push:*), Bash(git checkout:*), Bash(git branch:*), Bash(gh pr create:*)
description: Commit all changes, push the branch, and open a pull request
---

## Context

- Current branch: !`git branch --show-current`
- Remote tracking info: !`git status -sb`
- Staged and unstaged diff: !`git diff HEAD`
- Commits not yet on main: !`git log origin/main..HEAD --oneline 2>/dev/null || git log --oneline -10`
- Recent commits for style: !`git log --oneline -5`

## Your task

Complete the following steps in order:

1. **Stage and commit** — Stage all relevant changes and create a commit with a message following [Conventional Commits](https://www.conventionalcommits.org/) that matches this repository's style. Skip files that may contain secrets.
2. **Push** — Push the current branch to `origin`. If the branch has no upstream yet, set it with `git push -u origin <branch>`.
3. **Open a pull request** — Use `gh pr create` with:
   - A concise title derived from the commit message.
   - A body that includes a short summary of changes and a test plan checklist.

If you are already on `main` or `master`, create a feature branch first (derive the name from the commit subject).

Perform only the necessary tool calls. Do not print extra commentary.
