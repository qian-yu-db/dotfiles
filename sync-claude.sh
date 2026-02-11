#!/usr/bin/env bash
# Sync live ~/.claude config into dotfiles repo.
# Direction: ~/.claude (source of truth) -> dotfiles/claude (repo)
#
# Usage: ./sync-claude.sh [--dry-run]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DEST="$SCRIPT_DIR/claude"
SRC="$HOME/.claude"

RSYNC_OPTS=(-av --delete --exclude='__pycache__')

if [[ "${1:-}" == "--dry-run" ]]; then
    RSYNC_OPTS+=(-n)
    echo "=== DRY RUN ==="
fi

echo "Syncing ~/.claude -> dotfiles/claude"
echo "Direction: live (source) -> repo (destination)"
echo

# Individual files
for f in CLAUDE.md settings.json; do
    echo "--- $f ---"
    rsync "${RSYNC_OPTS[@]}" "$SRC/$f" "$DEST/$f"
done

# Directories
for d in skills agents commands hooks; do
    if [[ -d "$SRC/$d" ]]; then
        echo "--- $d/ ---"
        rsync "${RSYNC_OPTS[@]}" "$SRC/$d/" "$DEST/$d/"
    fi
done

echo
echo "Done. Review changes with: git diff"
