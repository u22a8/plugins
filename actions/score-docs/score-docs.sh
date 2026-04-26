#!/usr/bin/env bash
set -euo pipefail

# U+22A8 Score Docs — GitHub Action
# Scores markdown files changed in a PR against a U+22A8 scoring model.
# Posts (or updates) a PR comment with per-trait scores.

MARKER="<!-- u22a8-score -->"
API="${U22A8_API:-https://u22a8.ai}"
MODEL="${U22A8_MODEL:-u22a8.compelling-readme}"
THRESHOLD="${U22A8_THRESHOLD:-}"
REPO="${GITHUB_REPOSITORY:-}"

# Resolve PR number from event payload
PR_NUMBER=""
if [[ -f "${GITHUB_EVENT_PATH:-}" ]]; then
    PR_NUMBER=$(jq -r '.pull_request.number // empty' "$GITHUB_EVENT_PATH" 2>/dev/null || true)
fi

if [[ -z "${PR_NUMBER:-}" ]]; then
    echo "::warning::Not a pull request event — skipping U+22A8 scoring."
    exit 0
fi

# Get changed files matching the glob pattern
echo "Fetching changed files for PR #${PR_NUMBER}..."
CHANGED_FILES=$(gh pr diff "$PR_NUMBER" --name-only 2>/dev/null || true)

if [[ -z "$CHANGED_FILES" ]]; then
    echo "No changed files found."
    exit 0
fi

# Filter to matching files
MD_FILES=()
while IFS= read -r file; do
    # Check if file matches glob and exists
    case "$file" in
        *.md|*.MD|*.markdown)
            if [[ -f "$file" ]]; then
                MD_FILES+=("$file")
            fi
            ;;
    esac
done <<< "$CHANGED_FILES"

if [[ ${#MD_FILES[@]} -eq 0 ]]; then
    echo "No markdown files changed in this PR."
    exit 0
fi

echo "Found ${#MD_FILES[@]} markdown file(s) to score against ${MODEL}."

# Score each file and build comment body
COMMENT_BODY="${MARKER}"$'\n'
COMMENT_BODY+="**U+22A8 Quality Score** · [u22a8.ai](https://u22a8.ai)"$'\n\n'

SCORES_JSON="{}"
BELOW_THRESHOLD="false"

for file in "${MD_FILES[@]}"; do
    echo "Scoring: ${file}"

    CONTENT=$(cat "$file")

    # Call U+22A8 API with tracking headers
    RESPONSE=$(curl -sf "${API}/m/${MODEL}" \
        -H "Content-Type: application/json" \
        -H "Accept: application/json" \
        -H "User-Agent: u22a8-score-docs/1.0 (GitHub Action)" \
        -H "X-U22A8-Source: github-action" \
        -H "X-U22A8-Repo: ${REPO}" \
        -d "$(jq -n --arg content "$CONTENT" '{"content": $content}')" \
        2>/dev/null) || {
        echo "::warning::Failed to score ${file} — API returned an error."
        continue
    }

    # Extract composite score
    COMPOSITE=$(echo "$RESPONSE" | jq -r '.composite // empty')
    if [[ -z "$COMPOSITE" ]]; then
        echo "::warning::No composite score for ${file}."
        continue
    fi

    # Get plain-text formatted output for the comment
    PLAIN_RESPONSE=$(curl -sf "${API}/m/${MODEL}" \
        -H "Content-Type: application/json" \
        -H "Accept: text/plain" \
        -H "User-Agent: u22a8-score-docs/1.0 (GitHub Action)" \
        -H "X-U22A8-Source: github-action" \
        -H "X-U22A8-Repo: ${REPO}" \
        -d "$(jq -n --arg content "$CONTENT" '{"content": $content}')" \
        2>/dev/null) || PLAIN_RESPONSE=""

    # Build file section
    COMMENT_BODY+="\`${file}\` scored against \`${MODEL}\` — **${COMPOSITE}/100**"$'\n\n'

    if [[ -n "$PLAIN_RESPONSE" ]]; then
        COMMENT_BODY+='```'$'\n'
        COMMENT_BODY+="${PLAIN_RESPONSE}"$'\n'
        COMMENT_BODY+='```'$'\n\n'
    fi

    # Check threshold
    if [[ -n "$THRESHOLD" ]] && [[ "$COMPOSITE" -lt "$THRESHOLD" ]]; then
        COMMENT_BODY+="> ⚠️ Below threshold (${THRESHOLD})"$'\n\n'
        BELOW_THRESHOLD="true"
    fi

    # Accumulate scores JSON
    SCORES_JSON=$(echo "$SCORES_JSON" | jq --arg file "$file" --argjson score "$COMPOSITE" --argjson detail "$RESPONSE" \
        '. + {($file): {"composite": $score, "detail": $detail}}')

    echo "  ${file}: ${COMPOSITE}/100"
done

# Set outputs
echo "scores=$(echo "$SCORES_JSON" | jq -c '.')" >> "$GITHUB_OUTPUT"
echo "below_threshold=${BELOW_THRESHOLD}" >> "$GITHUB_OUTPUT"

# Find existing comment to update
EXISTING_COMMENT_ID=$(gh api "repos/${REPO}/issues/${PR_NUMBER}/comments" \
    --jq ".[] | select(.body | startswith(\"${MARKER}\")) | .id" \
    2>/dev/null | head -1 || true)

if [[ -n "$EXISTING_COMMENT_ID" ]]; then
    echo "Updating existing comment #${EXISTING_COMMENT_ID}..."
    gh api "repos/${REPO}/issues/comments/${EXISTING_COMMENT_ID}" \
        -X PATCH \
        -f body="$COMMENT_BODY" \
        --silent 2>/dev/null || echo "::warning::Failed to update comment."
else
    echo "Posting new comment..."
    gh api "repos/${REPO}/issues/${PR_NUMBER}/comments" \
        -f body="$COMMENT_BODY" \
        --silent 2>/dev/null || echo "::warning::Failed to post comment."
fi

echo "Done."
