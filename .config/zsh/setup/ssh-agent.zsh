# automatically start ssh-agent
if [ -z "$SSH_AUTH_SOCK" ] ; then
  export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-"${TERMUX__PREFIX:-"${PREFIX}"}/var/run"}"/ssh-agent.socket
  ssh-add -l &> /dev/null
  [ $? -ge 2 ] && eval `ssh-agent -a "$SSH_AUTH_SOCK"` >/dev/null
fi
