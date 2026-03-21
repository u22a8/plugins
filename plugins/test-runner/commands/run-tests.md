---
allowed-tools: Bash(npm test:*), Bash(npm run test:*), Bash(yarn test:*), Bash(pnpm test:*), Bash(pytest:*), Bash(go test:*), Bash(cargo test:*), Bash(python -m pytest:*), Bash(make test:*)
description: Detect the project's test framework, run the full test suite, and summarize failures
---

## Context

- Project files (to detect test framework): !`ls`
- package.json (if present): !`cat package.json 2>/dev/null || echo "No package.json"`
- pyproject.toml / setup.cfg (if present): !`cat pyproject.toml 2>/dev/null || echo "No pyproject.toml"`
- Makefile targets (if present): !`grep -E "^(test|check):" Makefile 2>/dev/null || echo "No Makefile test target"`

## Your task

1. **Detect** the test runner from the context above (npm/yarn/pnpm script, pytest, go test, cargo test, make test, etc.).
2. **Run** the full test suite using the appropriate command. Capture all output.
3. **Report** the results:
   - Total tests run, passed, failed, and skipped.
   - For each failing test: the test name, the failure message, and a brief suggestion for how to fix it.
4. If no test framework is detected, explain what you found and suggest how to set one up.

Be concise. List only failing tests in detail; summarize passing tests with a count.
