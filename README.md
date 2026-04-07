# qed-plugins

Claude Code plugin marketplace for [qed.systems](https://qed.systems) — score and improve content with resonance profiles.

> A resonance profile is a standard of judgment, learned from examples, that can score any content — turning subjective quality into something measurable.

## Quick start █░░

```bash
# Add the marketplace
/plugin marketplace add onebit0fme/qed-plugins

# Install the qed plugin
/plugin install qed@qed-plugins
```

## Plugins ██░

### qed

Score and improve content against resonance profiles on qed.systems.

Two skills:

- **`/qed:evaluate`** — Measure how content performs on specific traits. Scores each trait 0–100 with a composite. Measurement only, no edits.
- **`/qed:improve`** — Full editing loop: baseline score, diagnose weaknesses, make targeted edits, re-evaluate, report deltas. Iterates until you're satisfied.

```bash
# Score a file
/qed:evaluate my-draft.md

# Improve a file against profile traits
/qed:improve my-draft.md
```

No setup required — the plugin connects to the hosted API at `qed.systems`.

## GitHub Actions

### score-docs

Score markdown files on every PR. See [actions/score-docs](actions/score-docs/) for setup and configuration.

## License ███

Apache-2.0


---

∎
