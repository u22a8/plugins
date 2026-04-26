# U+22A8 plugins

Claude Code plugin marketplace for [u22a8.ai](https://u22a8.ai) — score and improve content with scoring models.

> A scoring model is a standard of judgment, learned from examples, that can score any content — turning subjective quality into something measurable.

## Quick start █░░

```bash
# Add the marketplace
/plugin marketplace add u22a8/plugins

# Install the u22a8 plugin
/plugin install u22a8@u22a8-plugins
```

## Plugins ██░

### u22a8

Score and improve content against scoring models on u22a8.ai.

Two skills:

- **`/u22a8:evaluate`** — Measure how content performs on specific traits. Scores each trait 0–100 with a composite. Measurement only, no edits.
- **`/u22a8:improve`** — Full editing loop: baseline score, diagnose weaknesses, make targeted edits, re-evaluate, report deltas. Iterates until you're satisfied.

```bash
# Score a file
/u22a8:evaluate my-draft.md

# Improve a file against model traits
/u22a8:improve my-draft.md
```

No setup required — the plugin connects to the hosted API at `u22a8.ai`.

## GitHub Actions

### score-docs

Score markdown files on every PR. See [actions/score-docs](actions/score-docs/) for setup and configuration.

## License ███

Apache-2.0


---

∎
