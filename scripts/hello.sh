#!/usr/bin/env bash
# The line above (the "shebang") says: run this file with bash.
set -euo pipefail
# -e: stop at the first failing command
# -u: treat unset variables as errors
# -o pipefail: a pipe fails if any command in it fails

NAME="${1:-world}"   # first argument, or "world" if none was given
echo "Hello, ${NAME}!"

for tool in git node docker java; do
  if command -v "$tool" > /dev/null; then
    echo "OK      $tool is installed"
  else
    echo "MISSING $tool"
  fi
done