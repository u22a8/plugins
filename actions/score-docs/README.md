# score-docs

**Scores your documentation on every PR. Catches weak READMEs before your users do.**

`u22a8/plugins/actions/score-docs` runs on pull requests that touch markdown files. It posts a comment with per-trait quality scores — so you know exactly what's weak and why, before you merge.

No signup. No API key. Two lines of YAML.

## Setup

Add this workflow file to your repo:

```yaml
# .github/workflows/u22a8-score.yml
name: U+22A8 Score
on:
  pull_request:
    paths: ['**/*.md']

permissions:
  pull-requests: write

jobs:
  score:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: u22a8/plugins/actions/score-docs@main
```

That's it. The action posts a score comment on every PR that changes a markdown file.

## Configuration

```yaml
- uses: u22a8/plugins/actions/score-docs@main
  with:
    # Model to score against. Default: u22a8.compelling-readme
    # Options: u22a8.compelling-readme, u22a8.technical-writing,
    #          u22a8.developer-landing-page, u22a8.puns
    profile: u22a8.technical-writing

    # Flag files that score below this threshold (0-100).
    # Informational only — does not block merge.
    threshold: 60

    # Files to score. Default: all markdown files changed in the PR.
    files: '**/*.md'
```

### Available models

| Model | Best for |
|---|---|
| `u22a8.compelling-readme` | Project READMEs, getting-started docs |
| `u22a8.technical-writing` | Guides, references, tutorials |
| `u22a8.developer-landing-page` | Landing pages targeting developers |
| `u22a8.puns` | Commit messages. You know who you are. |

## What the PR comment looks like

The action posts a single comment per PR (updated on force-push, never duplicated):

```
U+22A8 Quality Score · u22a8.ai

`README.md` scored against `u22a8.compelling-readme` — 67/100

  Hook Speed              ████████████████░░░░   78  ●●● Strong positive
  Problem Framing         ██████████████████░░   89  ●●● Strong positive
  Value Proposition       █████████████░░░░░░░   64  ●●○ Developing
  Copy-Pasteable Setup    ██████████████░░░░░░   68  ●●● Developing
  ...
```

For each changed markdown file:

- Composite score (0-100) with a visual bar
- Per-trait breakdown with scores and zone labels
- A flag if the file scores below your configured threshold

The scores use the same format you see when curling the API directly — consistent whether you're in a PR or a terminal.

## Use the scores

A score on its own is just a number. What you do with it:

- **Under 50 on a trait?** That's the specific thing to fix before merging.
- **Composite below your threshold?** The comment flags it. Review before you ship.
- **Trending up over time?** Your docs are getting better. The scores tell you.

For tighter iteration — score a draft, improve it, rescore — the [U+22A8 Claude Code plugin](https://github.com/u22a8/plugins/tree/main/plugins/u22a8) runs the same models interactively.

## Why deterministic scores matter in CI

Most "AI quality" tools use an LLM to judge output. That means different scores on the same content on different runs. You can't set a threshold you can trust.

U+22A8 scores are deterministic — same content, same profile, same score every time. That's what makes a threshold meaningful in a CI context.

U+22A8 also outperforms LLM-as-judge on correlation with human judgment, at a fraction of the cost and latency. [Details at u22a8.ai.](https://u22a8.ai)

## Coming in v2

- Merge blocking via required status checks
- Inline annotations on specific lines
- Score the PR description itself
- Multiple models per run

## License

Apache-2.0
