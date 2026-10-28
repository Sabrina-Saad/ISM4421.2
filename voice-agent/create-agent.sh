#!/usr/bin/env bash
# Creates the Bloom & Co. receptionist on Vapi and gives it a free phone number.
# Usage: VAPI_API_KEY=your-private-key ./create-agent.sh [area-code]
set -euo pipefail

: "${VAPI_API_KEY:?Set VAPI_API_KEY to your Vapi private API key (Dashboard > API Keys)}"
AREA_CODE="${1:-407}"
DIR="$(cd "$(dirname "$0")" && pwd)"
command -v jq >/dev/null || { echo "This script needs jq (https://jqlang.org/download/)"; exit 1; }

# Put the system prompt into the assistant config.
body=$(jq --rawfile prompt "$DIR/system-prompt.md" \
  '.model.messages[0].content = $prompt' "$DIR/assistant.json")

echo "Creating assistant..."
assistant=$(curl -sS -X POST https://api.vapi.ai/assistant \
  -H "Authorization: Bearer $VAPI_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$body")
assistant_id=$(echo "$assistant" | jq -r '.id // empty')
[ -n "$assistant_id" ] || { echo "Failed to create assistant:"; echo "$assistant"; exit 1; }
echo "Assistant ID: $assistant_id"

echo "Requesting a free Vapi phone number (area code $AREA_CODE)..."
number=$(curl -sS -X POST https://api.vapi.ai/phone-number \
  -H "Authorization: Bearer $VAPI_API_KEY" \
  -H "Content-Type: application/json" \
  -d "$(jq -n --arg a "$assistant_id" --arg c "$AREA_CODE" \
        '{provider: "vapi", assistantId: $a, numberDesiredAreaCode: $c, name: "Bloom & Co. line"}')")
phone=$(echo "$number" | jq -r '.number // empty')
if [ -z "$phone" ]; then
  echo "The assistant was created, but no number was assigned:"
  echo "$number"
  echo "Try another area code (for example ./create-agent.sh 415) or buy one in the dashboard under Phone Numbers."
  exit 1
fi

echo
echo "Done! Call $phone to talk to Maya."
echo "New numbers can take a few minutes to start working."
