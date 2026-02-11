#!/bin/bash
# Tmux-aware notification hook for Claude Code
# Sends macOS notifications with tmux session/window context

INPUT=$(cat)

# Notification type passed as $1 from settings.json command
NOTIF_TYPE="${1:-unknown}"

# Build tmux context if inside tmux
TMUX_CONTEXT=""
if [ -n "$TMUX" ]; then
    SESSION=$(tmux display-message -p '#S' 2>/dev/null)
    WINDOW_INDEX=$(tmux display-message -p '#I' 2>/dev/null)
    WINDOW_NAME=$(tmux display-message -p '#W' 2>/dev/null)
    PANE_INDEX=$(tmux display-message -p '#P' 2>/dev/null)
    TMUX_CONTEXT="${SESSION}:${WINDOW_INDEX} (${WINDOW_NAME})"
fi

# Set notification title and message based on type
case "$NOTIF_TYPE" in
    idle_prompt)
        TITLE="Claude Code — Ready for input"
        MESSAGE="Waiting for your input"
        SOUND="/Users/q.yu/.claude/sounds/claude_code_input.aiff"
        ;;
    permission_prompt)
        TITLE="Claude Code — Permission needed"
        MESSAGE="Approval required to continue"
        SOUND="/Users/q.yu/.claude/sounds/claude_code_permission.aiff"
        ;;
    *)
        TITLE="Claude Code"
        MESSAGE="Notification"
        SOUND=""
        ;;
esac

# Append tmux context to title
if [ -n "$TMUX_CONTEXT" ]; then
    TITLE="${TITLE} [${TMUX_CONTEXT}]"
fi

# Send macOS notification
osascript -e "display notification \"$MESSAGE\" with title \"$TITLE\"" 2>/dev/null &

# Play sound if configured
if [ -n "$SOUND" ] && [ -f "$SOUND" ]; then
    afplay "$SOUND" &
fi

exit 0
