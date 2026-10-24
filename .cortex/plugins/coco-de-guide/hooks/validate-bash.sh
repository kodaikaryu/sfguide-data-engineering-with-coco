#!/bin/bash
# validate-bash.sh — PreToolUse hook for the bash tool.
# Blocks dbt commands that target the prod environment.
INPUT=$(cat)

# Extract tool_input.command; fall back to raw input if jq is unavailable.
if command -v jq >/dev/null 2>&1; then
  CMD=$(echo "$INPUT" | jq -r '.tool_input.command // empty')
else
  CMD="$INPUT"
fi

if echo "$CMD" | grep -Eq '(^|[^[:alnum:]_])dbt([[:space:]]|$)' &&
   echo "$CMD" | grep -Eq '(--target|-t)([[:space:]]+|=)["'\'']?prod(["'\''[:space:]]|$)'; then
  MSG="Blocked: direct production dbt runs (--target prod) are not allowed. Use the CI/CD pipeline to deploy to production."
  # Exit 0 with structured JSON so the decision (and systemMessage) is surfaced.
  printf '{"decision":"block","reason":"%s","systemMessage":"%s","hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"%s"}}\n' "$MSG" "$MSG" "$MSG"
  exit 0
fi

exit 0
