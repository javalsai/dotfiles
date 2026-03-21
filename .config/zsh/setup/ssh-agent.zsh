# automatically start ssh-agent
if [ -z "$SSH_AUTH_SOCK" ] && [[ -z "$TERMUX_VERSION" ]] ; then
  export SSH_AUTH_SOCK=~/.ssh/ssh-agent.sock
  ssh-add -l &> /dev/null
  [ $? -ge 2 ] && ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null
fi
