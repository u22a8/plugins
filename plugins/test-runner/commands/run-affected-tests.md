---
allowed-tools: Bash(npm test:*), Bash(npm run test:*), Bash(yarn test:*), Bash(pnpm test:*), Bash(pytest:*), Bash(go test:*), Bash(cargo test:*), Bash(python -m pytest:*), Bash(make test:*), Read, Grep
description: Run only the tests related to the files changed since the last commit and summarize results
---

## Context

- Changed files since last commit: !`git diff --name-only HEAD`
- Project files (to detect test framework): !`ls`
- package.json (if present): !`cat package.json 2>/dev/null || echo "No package.json"`

## Your task

1. **Identify** which test files correspond to the changed source files listed above (e.g. `src/foo.ts` → `src/foo.test.ts` or `tests/test_foo.py`).
2. **Run** only those related tests using the appropriate test runner.
   - For pytest: `pytest <file> [<file> ...]`
   - For Jest/Vitest: `npx jest <pattern>` or `npx vitest run <pattern>`
   - For Go: `go test ./...` filtered to the relevant packages.
   - Fall back to the full test suite if targeted running is not feasible.
3. **Report** results in the same format as `/run-tests`: totals first, then failing test details with fix suggestions. Summarize passing tests with a count.

If no files have changed since the last commit, report that and exit.
