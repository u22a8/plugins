# test-runner Plugin

Run project tests, display results, and get contextual guidance on fixing failures — all from within your Claude Code session.

## Overview

The `test-runner` plugin detects your project's test framework automatically and provides slash commands that run tests and surface actionable failure details without leaving your editor context.

## Commands

### `/run-tests`

Runs the full test suite for the project.

**What it does:**
1. Detects the test framework from `package.json`, `pyproject.toml`, `Makefile`, or project structure.
2. Runs the full test suite.
3. Prints a summary: total tests, passed, failed, skipped.
4. For each failure: the test name, assertion error, and a concise fix suggestion.

**Supported test runners:**
- **JavaScript / TypeScript**: Jest, Vitest, Mocha (via `npm test`, `yarn test`, `pnpm test`)
- **Python**: pytest, unittest
- **Go**: `go test ./...`
- **Rust**: `cargo test`
- **Make**: `make test`

**Usage:**
```
/run-tests
```

---

### `/run-affected-tests`

Runs only the tests related to files changed since the last commit.

**What it does:**
1. Inspects `git diff --name-only HEAD` to find changed source files.
2. Infers the corresponding test files.
3. Runs only those tests to give faster feedback.
4. Falls back to the full suite if targeted running is not feasible.

**Usage:**
```
/run-affected-tests
```

**Why use it?**  
When working on a large codebase, running all tests after every small change is slow. `/run-affected-tests` gives you a quick feedback loop by running only what's relevant.

## Installation

Install this plugin from the qed-plugins marketplace inside Claude Code:

```
/plugin install https://github.com/onebit0fme/qed-plugins --name test-runner
```

Or add it directly to your project's `.claude/settings.json`:

```json
{
  "plugins": [
    {
      "source": "https://github.com/onebit0fme/qed-plugins",
      "name": "test-runner"
    }
  ]
}
```

## Version

1.0.0
