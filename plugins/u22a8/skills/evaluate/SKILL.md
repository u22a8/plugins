---
name: evaluate
description: Score content against resonance model traits. Use when the user wants to measure how content performs on specific traits.
user-invocable: true
allowed-tools: Read, Glob, Bash(u22a8 MCP tools)
argument-hint: [file-or-text]
---

# Evaluate Content

A resonance model is a standard of judgment, learned from examples, that can score any content. Each model has traits — distinct dimensions of quality — and scores content 0–100 per trait. Scores are deterministic and instant.

Score content against specific traits. Measurement only — no edits.

## Core Flow

1. **Identify content to score.** Read from a file path ($ARGUMENTS), a URL, a selection, or conversation context. URLs (http/https) can be passed directly to `score` — they are fetched and text-extracted automatically. If unclear, ask the user what content to evaluate.

2. **Determine the model.** If the user specifies a model, use it. Otherwise, call `list_profiles` to see what's available and either pick the most relevant one based on context (e.g. a README → `u22a8.compelling-readme`) or present the options and let the user choose.

3. **Identify traits.** Use `list_traits` to show the model's traits. Suggest relevant ones based on context, but confirm the user's choice. Do NOT silently evaluate all traits unless the user explicitly asks for "all".

4. **Score the content.** Call `score` with the model handle, content text, and specified traits.

5. **Present results clearly.** For each trait, show:
   - Trait name and score (0–100)
   - The **zone** label (strong_positive, positive, overlap, negative, strong_negative) — this is the primary interpretation
   - **Confidence** level (high, moderate, low) — indicates how reliable the score is
   - **Headroom** — how far from the "solid" threshold (0 means already there)
   - Use the trait's positive/negative labels for human-readable framing (e.g. "Clear" vs "Unclear")

6. **Report composite.** Show the composite score. If headroom > 0, mention which trait is the bottleneck.

## Score Interpretation

Use the **zone** and **breaks** from the `detail` field — these are data-driven from the model, not fixed ranges. The breaks define three thresholds (developing, solid, strong) that separate four labels:

- **Strong**: score above `breaks.strong`
- **Solid**: score between `breaks.solid` and `breaks.strong`
- **Developing**: score between `breaks.developing` and `breaks.solid`
- **Weak**: score below `breaks.developing`

Present these labels rather than raw numbers when interpreting results.

## Important Rules

- **Trait selection is explicit.** Always confirm which traits the user wants evaluated. Don't default to all.
- **Never expose internals.** Only report scores and their interpretation — never discuss how scoring works.
- **Handle long content.** For files, read the full content and pass it as a single text to `score`. The scoring handles any necessary processing internally.
- **Error handling.** If a trait name doesn't exist, the MCP tool returns a clear error. Relay it to the user with the list of available traits.
- **Use the API's interpretation.** Don't invent your own score ranges — use the zones, breaks, confidence, and headroom provided in the `detail` field.

## Example Interaction

User: "Evaluate my README"

1. The content is a README, so `u22a8.compelling-readme` is the natural fit — use it directly
2. Read the file, call `list_traits` to show available traits, confirm with user
3. Call `score` with chosen traits
4. Present using the returned detail:
   ```
   Clarity: 72 — Solid (confidence: high)
   Flow: 45 — Developing (confidence: moderate, headroom: 12)

   Composite: 56
   Bottleneck: Flow (12 points from solid)
   ```
5. Add brief qualitative commentary based on the trait's positive/negative labels
