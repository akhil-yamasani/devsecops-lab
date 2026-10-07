#!/usr/bin/env bash
# Fails (exit 1) when findings exceed the allowed limits.
# Usage: check_threshold.sh <findings.json> [max_critical] [max_high]
set -euo pipefail

FILE="${1:?Usage: $0 <findings.json> [max_critical] [max_high]}"
MAX_CRITICAL="${2:-0}"
MAX_HIGH="${3:-5}"

if [[ ! -f "$FILE" ]]; then
  echo "ERROR: file not found: $FILE" >&2
  exit 2
fi

echo "Findings by severity:"
for sev in CRITICAL HIGH MEDIUM LOW; do
  count=$(jq --arg s "$sev" '[.findings[] | select(.severity==$s)] | length' "$FILE")
  printf '  %-9s %s\n' "$sev" "$count"
done

critical=$(jq '[.findings[] | select(.severity=="CRITICAL")] | length' "$FILE")
high=$(jq '[.findings[] | select(.severity=="HIGH")] | length' "$FILE")

if (( critical > MAX_CRITICAL || high > MAX_HIGH )); then
  echo "FAIL: $critical critical (max $MAX_CRITICAL), $high high (max $MAX_HIGH)" >&2
  exit 1
fi

echo "PASS: within limits"