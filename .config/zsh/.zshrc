# should be fine if nothing asks for any input and requires stdin display
stty -echo

[[ -n "$NO_ZSHRC" ]] && return || :

### Profiling ###
[[ -n "$ZSH_PROF" ]] && zmodload zsh/zprof || :

### Basic env ###
[ -f "$HOME/.profile" ] && . "$HOME/.profile" || :
[ -f "$HOME/.sh-utls" ] && . "$HOME/.sh-utls" || :

ZCFG="$HOME/.config/zsh"
export HOSTNAME=$(hostname)

source "$ZCFG/setup/compinit.zsh"
source "$ZCFG/setup/hist.zsh"
source "$ZCFG/setup/ssh-agent.zsh"

### Base ZSH ###
ZSH_THEME="powerlevel10k/powerlevel10k"
[[ "$HOSTNAME" == "server5" ]] || [[ "$HOSTNAME" == "artway" ]] \
  && ZSH_THEME="robbyrussell-custom"

source "$ZCFG/style.zsh"

### Plugins ###
source "$ZCFG/antidote.zsh"
source "$ZCFG/pl10k.zsh"
source "$ZCFG/aliases.zsh"
source "$ZCFG/bindings.zsh"

antidote load

### Welcome Screen ###
if [ -z "$SHELL_SESSION_LOADED" ] && [ -z "$FAST_SHELL" ]; then
  if command -v fastfetch &> /dev/null; then
    printf "\033[2K\r"; fastfetch
    export SHELL_SESSION_LOADED=1
  fi
fi

### Profiling ###
[[ -n "$ZSH_PROF" ]] && zprof || :
