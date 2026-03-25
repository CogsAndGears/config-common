# Prevent the computer from going to sleep if there is an active Claude session running

LOCK_DIR="/tmp/claude_inhibit_sessions"
mkdir -p "$LOCK_DIR"

# Clean up stale sessions
for f in "$LOCK_DIR"/*; do
  pid=$(basename "$f")
  kill -0 "$pid" 2>/dev/null || rm -f "$f"
done

# Each session gets a unique file based on its parent's PID
SESSION_FILE="$LOCK_DIR/$PPID"
touch "$SESSION_FILE"

# Only start the inhibitor if this is the first session
if [ "$(ls "$LOCK_DIR" | wc -l)" -eq 1 ]; then
  systemd-inhibit --what=idle:sleep --who="Claude Code" --why="Task in progress" sleep infinity &
  echo $! > /tmp/claude_inhibit.pid
fi
