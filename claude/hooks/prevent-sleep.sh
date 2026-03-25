# ~/.claude/hooks/prevent-sleep.sh
systemd-inhibit --what=idle:sleep --who="Claude Code" --why="Task in progress" sleep infinity &
echo $! > /tmp/claude_inhibit.pid

