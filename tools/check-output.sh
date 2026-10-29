#!/usr/bin/env bash
# check-output.sh — scan a file for things that should not have survived sanitization.
#
# Usage:  tools/check-output.sh work/summary.md
#
# This is a net, not a guarantee. It catches the common, obvious cases. It does not know
# your organization's identifier formats, and it cannot tell whether a name is a real
# person. The gate in the four checks in AGENTS.md section 5 is what decides; this stops the clumsy
# misses from getting that far.
#
# Exit 0 = nothing found. Exit 1 = findings. Exit 2 = bad usage.

set -uo pipefail

FILE="${1:-}"
if [ -z "$FILE" ] || [ ! -f "$FILE" ]; then
  echo "usage: $0 <file>" >&2
  exit 2
fi

TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT

scan() {  # scan <label> <extended-regex> [grep-flags]
  local label="$1" re="$2"; shift 2
  grep -nE "$@" -- "$re" "$FILE" 2>/dev/null | while IFS= read -r line; do
    printf '  %-22s %s\n' "$label" "$line"
  done >> "$TMP"
}

echo "Scanning $FILE"
echo

# Credentials and keys. Never acceptable in an output.
scan "possible credential" '(api[_-]?key|secret|passwd|password|token)[[:space:]]*[:=]' -i
scan "key-shaped string"   '(AKIA|ghp_|sk-)[A-Za-z0-9]{8,}'

# Contact details, which usually mean a real person survived.
scan "email address"       '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}'
scan "phone-shaped number" '\b(\+?1[-. ])?\(?[0-9]{3}\)?[-. ][0-9]{3}[-. ][0-9]{4}\b'
scan "SSN-shaped number"   '\b[0-9]{3}-[0-9]{2}-[0-9]{4}\b'

# The opposite failure: placeholders that were never filled in.
scan "unfilled placeholder" '\[(NAME|ID|ORG|DATE|REDACTED)\]|TODO|FIXME|XXX'

if [ -s "$TMP" ]; then
  cat "$TMP"
  echo
  echo "Findings above. Resolve them, then run the four checks in AGENTS.md section 5."
  exit 1
fi

echo "No obvious findings."
echo "This does NOT clear the file. Run the four checks in AGENTS.md section 5 before it moves to output/."
exit 0
