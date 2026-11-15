#!/bin/bash
# Holds a logind sleep/idle inhibitor while any SSH connection is established.
#
# To use, link and enable the `services/ssh-inhibit.service` service. This will keep
# the ssh host computer awake so long as there are any active connections.
PORT=22
has_ssh() { ss -Htn state established "( sport = :$PORT )" | grep -q .; }

while true; do
  if has_ssh; then
    systemd-inhibit --what=sleep:idle --mode=block \
      --who="ssh-inhibit" --why="Active SSH connection" \
      bash -c "$(declare -f has_ssh); PORT=$PORT; while has_ssh; do sleep 30; done"
  fi
  sleep 30
done

