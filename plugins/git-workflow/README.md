# git-workflow Plugin

Automate common Git operations including committing, pushing, branch management, and pull request creation.

## Overview

The `git-workflow` plugin provides slash commands that streamline the most frequent Git operations you perform while coding with Claude Code. Instead of switching to a terminal and running multiple Git commands by hand, a single slash command handles the entire workflow.

## Commands

### `/commit`

Stages all relevant changes and creates a conventional git commit with an automatically generated message.

**What it does:**
1. Inspects the current git status and diff.
2. Reviews recent commits to match the repository's commit style.
3. Writes a [Conventional Commits](https://www.conventionalcommits.org/) compliant message.
4. Stages relevant files (skipping potential secret files such as `.env`).
5. Creates the commit.

**Usage:**
```
/commit
```

---

### `/commit-push-pr`

Commits all pending changes, pushes the branch, and opens a pull request — all in one step.

**What it does:**
1. Stages and commits changes with an appropriate message.
2. Creates a feature branch if you are currently on `main`/`master`.
3. Pushes the branch to `origin`.
4. Creates a pull request via `gh pr create` with a summary and test-plan checklist.

**Usage:**
```
/commit-push-pr
```

**Requirements:**
- [GitHub CLI (`gh`)](https://cli.github.com/) installed and authenticated.
- A `git remote` named `origin`.

---

### `/clean-gone`

Deletes local branches whose remote tracking branch has been removed (branches marked as `[gone]`).

**What it does:**
1. Runs `git fetch --prune` to update remote-tracking references.
2. Finds all local branches with `[gone]` status.
3. Removes associated git worktrees if any.
4. Deletes the stale branches and reports what was cleaned up.

**Usage:**
```
/clean-gone
```

## Installation

Install this plugin from the qed-plugins marketplace inside Claude Code:

```
/plugin install https://github.com/onebit0fme/qed-plugins --name git-workflow
```

Or add it directly to your project's `.claude/settings.json`:

```json
{
  "plugins": [
    {
      "source": "https://github.com/onebit0fme/qed-plugins",
      "name": "git-workflow"
    }
  ]
}
```

## Requirements

- Git 2.x or later.
- For `/commit-push-pr`: [GitHub CLI](https://cli.github.com/) installed and authenticated (`gh auth login`).

## Version

1.0.0
