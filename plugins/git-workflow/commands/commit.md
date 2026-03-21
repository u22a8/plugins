---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*)
description: Stage all changes and create a conventional git commit with an auto-generated message
---

## Context

- Current git status: !`git status`
- Staged and unstaged changes: !`git diff HEAD`
- Current branch: !`git branch --show-current`
- Recent commits (for style reference): !`git log --oneline -10`

## Your task

Based on the above context, create a single git commit:

1. Stage all relevant changes with `git add`.
2. Write a commit message following the [Conventional Commits](https://www.conventionalcommits.org/) specification (e.g. `feat:`, `fix:`, `chore:`, `docs:`).
3. Match the style of the repository's recent commits.
4. Do not commit files that may contain secrets (`.env`, `*.pem`, `credentials.*`).
5. Create the commit with a single `git commit` call.

Do not send any other text or messages besides these tool calls.
