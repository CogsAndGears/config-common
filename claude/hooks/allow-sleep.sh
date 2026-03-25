# ~/.claude/hooks/allow-sleep.sh
if [ -f /tmp/claude_inhibit.pid ]; then
  kill $(cat /tmp/claude_inhibit.pid) 2>/dev/null
  rm -f /tmp/claude_inhibit.pid
fi
