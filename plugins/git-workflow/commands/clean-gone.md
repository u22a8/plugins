---
allowed-tools: Bash(git fetch:*), Bash(git branch:*), Bash(git worktree:*)
description: Delete local branches whose upstream has been removed (marked [gone])
---

## Context

- Fetch and prune remote references: !`git fetch --prune`
- Local branches with tracking status: !`git branch -vv`

## Your task

1. Identify all local branches marked as `[gone]` in the tracking info above.
2. For each such branch, remove any associated git worktrees before deleting the branch.
3. Delete the branch with `git branch -d` (use `-D` only when `-d` fails due to unmerged commits).
4. Print a summary of which branches were removed.
5. If no branches are `[gone]`, report that the workspace is already clean.

Do not delete the currently checked-out branch.
