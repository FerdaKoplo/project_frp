#!/bin/sh
# Append a timestamped entry to CHANGELOG.md.
# Usage: log.sh "did something"
set -e
cd "$(git rev-parse --show-toplevel)"

ts=$(date '+%Y-%m-%d %H:%M')
entry="$ts - $*"

if [ -f CHANGELOG.md ]; then
  printf '%s\n%s\n' "$entry" "$(cat CHANGELOG.md)" >CHANGELOG.md.tmp
  mv CHANGELOG.md.tmp CHANGELOG.md
else
  printf '# Changelog\n\n%s\n' "$entry" >CHANGELOG.md
fi
