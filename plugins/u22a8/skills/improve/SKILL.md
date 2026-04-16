---
name: improve
description: Evaluate content, identify weaknesses, make targeted edits, and re-evaluate to confirm improvement. Use when the user wants to improve content against resonance model traits.
user-invocable: true
allowed-tools: Read, Write, Edit, Glob, Bash(u22a8 MCP tools)
argument-hint: [file-or-text]
---

# Improve Content

A resonance model is a standard of judgment, learned from examples, that can score any content. Each model has traits — distinct dimensions of quality — and scores content 0–100 per trait. Scores are deterministic and instant.

Evaluate content, analyze weaknesses, make targeted edits, and re-evaluate to confirm improvement.

## Core Flow

1. **Identify content and model.** Read content from file ($ARGUMENTS), URL, or conversation. URLs passed to `score` are fetched automatically. If the user specifies a model, use it. Otherwise, call `list_profiles` and pick the most relevant one based on context, or let the user choose. Then confirm which traits to optimize for using `list_traits`.

2. **Baseline evaluation.** Call `score` with the current content. Record per-trait scores, zones, and headroom. Present the baseline — highlight which traits have the most headroom (furthest from "solid" threshold).

3. **Analyze score patterns.** For each weak trait (most headroom first):
   - Diagnose WHY it scores low — identify specific textual elements that are weak
   - Use the trait's description and positive/negative labels to understand what "good" looks like
   - Be specific: "the transitions between paragraphs are abrupt" not "improve flow"
   - Consider interdependencies: changes for one trait shouldn't harm others

4. **Make targeted edits.** Apply changes to the content:
   - Address diagnosed weaknesses with specific, actionable edits
   - Preserve what already scores well — don't rewrite strong passages
   - Multi-trait: consider all target traits simultaneously
   - Incremental: small, focused changes are better than wholesale rewrites
   - Edit the actual file if working with a file, or present the improved text

5. **Re-evaluate.** Call `score` with the improved content and `compare_to` set to the original content. This returns both scores and the delta between them.

6. **Report results.** Show before/after comparison using the delta from the response:
   - Per-trait score changes with deltas
   - Composite before and after
   - Whether any trait's zone improved (e.g. Developing → Solid)
   - Summary of what changed and why

7. **Iterate if requested.** If the user wants further improvement, repeat from step 3. Each iteration should target the trait with the most headroom.

## Methodology

### Analysis
- Look for **concrete patterns** that correlate with low scores
- Reference the trait's positive/negative labels to understand what "good" vs "bad" looks like
- Be evidence-based: point to specific sentences, paragraphs, or structural elements
- Use **headroom** to prioritize: the trait with the most headroom has the most room for improvement

### Editing
- **Specific and actionable**: "add a transitional phrase connecting these two paragraphs" not "improve transitions"
- **Multi-trait awareness**: don't sacrifice one trait's score to improve another
- **Incremental**: build on what works, don't start from scratch
- **Preserve voice**: improve quality without changing the author's style or intent

### Comparison
- Use `score` with `compare_to` to get a direct comparison with deltas
- The response includes `delta.scores` (per-trait) and `delta.composite` — use these directly

## Important Rules

- **Always re-evaluate.** Never assume edits improved scores — measure it.
- **Explain your reasoning.** Tell the user what you diagnosed and why you made specific changes.
- **Respect the user's content.** Don't change meaning, style, or voice beyond what's needed for trait improvement.
- **Handle regression.** If scores drop on re-evaluation, acknowledge it, revert the change, and try a different approach.
- **Use the API's interpretation.** Use zones, breaks, confidence, and headroom from the `detail` field — don't invent your own score interpretation.

## Example Interaction

User: "Improve my blog post for flow and storytelling"

1. No model specified and content is a blog post — call `list_profiles`, pick the most fitting model or ask the user
2. Baseline: Flow=45 (Developing, headroom 12), Storytelling=62 (Solid), Composite=53
3. Analyze: "Flow has the most headroom. The third paragraph jumps abruptly from personal anecdote to technical explanation without transition."
4. Edit: Add transitional sentences, restructure the opening to establish the narrative thread
5. Re-evaluate with `score(content=improved_text, compare_to=original_text)`:
   ```
   Flow: 71 (+26) — now Solid
   Storytelling: 68 (+6) — still Solid, closer to Strong

   Composite: 69 (+16)
   ```
6. Report: "Flow improved from 45 to 71 — now in the Solid zone. Storytelling improved from 62 to 68. Composite: 53 → 69."
