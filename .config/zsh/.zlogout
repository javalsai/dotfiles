if [ -n "$SSH_AGENT_PID" ] ; then
  eval `/usr/bin/ssh-agent -k`
fi
