# Permit the computer to go to sleep after the last Claude session stops running

LOCK_DIR="/tmp/claude_inhibit_sessions"

# Clean up stale sessions
for f in "$LOCK_DIR"/*; do
  pid=$(basename "$f")
  kill -0 "$pid" 2>/dev/null || rm -f "$f"
done

# Remove this session's file
rm -f "$LOCK_DIR/$PPID"

# Only release the inhibitor if no sessions remain
if [ -z "$(ls "$LOCK_DIR" 2>/dev/null)" ]; then
  if [ -f /tmp/claude_inhibit.pid ]; then
    kill $(cat /tmp/claude_inhibit.pid) 2>/dev/null
    rm -f /tmp/claude_inhibit.pid
  fi
fi
