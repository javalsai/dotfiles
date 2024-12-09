### Profiling ###
#zmodload zsh/zprof

### Basic env ###
setopt extended_glob

[ -f "$HOME/.profile" ] && . "$HOME/.profile"
[ -f "$HOME/.sh-utls" ] && . "$HOME/.sh-utls"

export ZSH="$HOME/.oh-my-zsh"
[[ "$(hostname)" == "server5" ]] && export ZSH="/usr/share/oh-my-zsh/"
# i made doas preserve home, so when i `doas -s` i get root owned dumps, added $USER
# i dont think this works on server5 now tho... as its on /usr...
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST-$USER

### ZSH / OMZ / PL9K headers ###
ZSH_THEME="powerlevel9k/powerlevel9k"
[[ "$(hostname)" == "server5" ]] && ZSH_THEME="robbyrussell-custom"
POWERLEVEL9K_MODE="nerdfont-complete"

### ZSH / OMZ / PL9K ricing ###
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%(?:%B%F{green}:%B%F{red})  ➜ %{$reset_color%}"

if [[ -z "$TERMUX_VERSION" ]]; then
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon status context dir vcs)
else
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_android_icon status context dir vcs)
fi
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

POWERLEVEL9K_STATUS_OK=false
POWERLEVEL9K_STATUS_HIDE_SIGNAME=false
## Contect Segment ##
  POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND=61
  POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND=61
  POWERLEVEL9K_CONTEXT_SUDO_BACKGROUND=61
  POWERLEVEL9K_CONTEXT_REMOTE_BACKGROUND=61
  POWERLEVEL9K_CONTEXT_REMOTE_SUDO_BACKGROUND=61

  POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND=15
  POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=15
  POWERLEVEL9K_CONTEXT_SUDO_FOREGROUND=15
  POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND=15
  POWERLEVEL9K_CONTEXT_REMOTE_SUDO_FOREGROUND=15

## Segment Path
  POWERLEVEL9K_DIR_HOME_BACKGROUND=1
  POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND=1
  POWERLEVEL9K_DIR_ETC_BACKGROUND=1
  POWERLEVEL9K_DIR_DEFAULT_BACKGROUND=1

  POWERLEVEL9K_DIR_HOME_FOREGROUND=0
  POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND=0
  POWERLEVEL9K_DIR_ETC_FOREGROUND=0
  POWERLEVEL9K_DIR_DEFAULT_FOREGROUND=0

  POWERLEVEL9K_SHORTEN_DIR_LENGTH=4
  POWERLEVEL9K_SHORTEN_DELIMITER=".."
  POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"

  ## OS icon ##
  POWERLEVEL9K_LINUX_ICON=$'\uF31F'
  POWERLEVEL9K_OS_ICON_FOREGROUND=81
  POWERLEVEL9K_OS_ICON_BACKGROUND=235
  ## Android OS icon ##
  POWERLEVEL9K_CUSTOM_ANDROID_ICON="echo ﲎ"
  POWERLEVEL9K_CUSTOM_ANDROID_ICON_FOREGROUND=64
  POWERLEVEL9K_CUSTOM_ANDROID_ICON_BACKGROUND=15

# Update behaviour
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:update' frequency 1


### PLUGINS ##
plugins=(
  git
  rust
  extract
)
if [[ "$(hostname)" == "server5" ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
else
  plugins+=(
    zsh-syntax-highlighting
    zsh-autosuggestions
  )
fi
[[ -z "$TERMUX_VERSION" ]] && plugins+=( archlinux )

. $ZSH/oh-my-zsh.sh

# automatically start ssh-agent
if [ -z "$SSH_AUTH_SOCK" ] && [[ -z "$TERMUX_VERSION" ]] ; then
  export SSH_AUTH_SOCK=~/.ssh/ssh-agent.sock
  ssh-add -l &> /dev/null
  [ $? -ge 2 ] && ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null
fi


## Example aliases
alias zshconfig="$EDITOR ~/.zshrc"

# Necesary namings
alias kys="exit"
alias please="doas"
alias fucking="doas"

# Misc Utils
alias fuckyou="%&|"
alias weather="curl -s https://wttr.in/Granada --output - | head -n 7 | tail -n 6 && echo"

# Shorthands
alias -- '+x'="chmod +x"
alias b64=base64
alias edit="$EDITOR" # I just nvim tho
alias mommy="cargo mommy" # no commentary
alias ado="doas " # alises with doas
alias xo=xdg-open

# Overrides
alias cat="bat -pp"
alias ls="eza --icons -g --smart-group -b --git --git-repos -M"
# same-command overrides tho
alias ip="ip -c"
alias ffmpeg='ffmpeg -hide_banner'
alias wget="wget --hsts-file ~/.local/share/wget/hsts"
alias nv=nvim
alias h="GIT_DIR=.dotfiles.git " # can put dotfiles in home with .git as .dotfiles.git
                                 # and manage with h alias

if [[ -z "$TERMUX_VERSION" ]]; then
  mkdir -p -m 700 "$HOME/.local/state/paru/.gnupg/"
  alias paru="GNUPGHOME=$HOME/.local/state/paru/.gnupg/ paru" # like leave my gpg keyring alone ffs
  alias pgpg="GNUPGHOME=$HOME/.local/state/paru/.gnupg/ gpg"

  mkdir -p "$HOME/.local/state/"
  export _Z_DATA="$HOME/.local/state/.z"
  [[ -r "/usr/share/z/z.sh" ]] && . /usr/share/z/z.sh
else
  alias ssh='ssha'
  alias scp='scpa'
  alias copy='termux-clipboard-set'
  alias paste='termux-clipboard-get'
  alias doas=sudo
  eval "$(zoxide init zsh)"

  vidshr() {
    TMPF=$(mktemp --suffix=.mp4 -u)
    termux-storage-get "$TMPF"
    TMPFO=$(mktemp --suffix=.mp4 -u)
    echo "$TMPF:$TMPFO"
    while [[ ! -e "$TMPF" ]]; do sleep .4; done
    ffmpeg -i "$TMPF" -vcodec libx264 -crf 20 "$TMPFO"
    rm "$TMPF"
    xdg-open --send "$TMPFO"
  }

  export NODE_PATH='/data/data/com.termux/files/usr/lib/node_modules'
fi

if command -v thefuck &> /dev/null; then
  eval $(thefuck --alias FUCK)
  eval $(thefuck --alias)
fi

### Welcome Screen ###
if command -v fastfetch &> /dev/null && [ -z "$SHELL_SESSION_LOADED" ]; then
  printf "\33[2K\r"; fastfetch -c examples/7.jsonc
  export SHELL_SESSION_LOADED=1
fi

### Bindings ###
bindkey '^H' backward-kill-word
bindkey '^[[127;5u' backward-kill-word

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "/home/javalsai/.bun/_bun" || :

### Profiling ###
#zprof
