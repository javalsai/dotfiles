[[ -n "$NO_ZSHRC" ]] && return || :

### Profiling ###
[[ -n "$ZSH_PROF" ]] && zmodload zsh/zprof || :

# start-up clean
FULL_GRAPHICAL_SHELl=false
if [[ -z "$SHELL_SESSION_LOADED" ]] && [[ -z "$FAST_SHELL" ]]; then
  FULL_GRAPHICAL_SHELl=true
fi

# should be fine if nothing asks for any input and requires stdin display
[[ "$FULL_GRAPHICAL_SHELl" == true ]] && stty -echo

### Basic env ###
[ -f "$HOME/.profile" ] && . "$HOME/.profile" || :

ZCFG="$HOME/.config/zsh"
export HOSTNAME=$(hostname)

source "$ZCFG/setup/compinit.zsh"
source "$ZCFG/setup/hist.zsh"
source "$ZCFG/setup/ssh-agent.zsh"

### Base ZSH ###
ZSH_THEME="powerlevel10k/powerlevel10k"
[[ "$HOSTNAME" == "server5" ]] || [[ "$HOSTNAME" == "artway" ]] \
  && ZSH_THEME="robbyrussell-custom"

### Plugins ###
source "$ZCFG/antidote.zsh"
source "$ZCFG/pl10k.zsh"

# dont wanna load allat if its nvim's `:!` for example, but still the same
# command behavior (aliases, functions, etc)
if [[ "$-" == *m* ]]; then
  antidote load
else
  antidote load "${ZDOTDIR:-$HOME}"/.zsh_plugins_noninteractive.txt
fi

### Base ZSH, After Plugins ##
# (bindings might use like... `l`, which comes from plugins) #
source "$ZCFG/style.zsh"
source "$ZCFG/aliases.zsh"
source "$ZCFG/bindings.zsh"

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

# ---

### Welcome Screen ###
if [[ "$FULL_GRAPHICAL_SHELl" == true ]]; then
  if command -v fastfetch &> /dev/null; then
    printf "\033[2K\r"; fastfetch
    export SHELL_SESSION_LOADED=1
  fi
fi

### Profiling ###
[[ -n "$ZSH_PROF" ]] && zprof || :
