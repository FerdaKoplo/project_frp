#!/bin/sh
# One-time setup per clone: enable tracked git hooks + changelog logging.
set -e
cd "$(git rev-parse --show-toplevel)"
git config core.hooksPath .githooks
chmod +x .githooks/* tools/log.sh 2>/dev/null
echo "hooks enabled -> .githooks"
