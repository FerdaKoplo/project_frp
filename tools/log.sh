#!/bin/sh
set -e
cd "$(git rev-parse --show-toplevel)"
mkdir -p logs

ts=$(date '+%Y-%m-%d %H:%M')
entry="$ts - $*"

if [ -f logs/CHANGELOG.md ]; then
  printf '%s\n%s\n' "$entry" "$(cat logs/CHANGELOG.md)" >logs/CHANGELOG.md.tmp
  mv logs/CHANGELOG.md.tmp logs/CHANGELOG.md
else
  printf '# Changelog\n\n%s\n' "$entry" >logs/CHANGELOG.md
fi
