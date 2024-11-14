### Profiling ###
#zmodload zsh/zprof

### Basic declarations ###
bold=$(tput bold)
normal=$(tput sgr0)

### Basic env ###
setopt extended_glob

[ -f "$HOME/.profile" ] && . "$HOME/.profile"
[ -f "$HOME/.sh-utls" ] && . "$HOME/.sh-utls"

export ZSH="/home/javalsai/.oh-my-zsh"
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

### ZSH / OMZ / PL9K headers ###
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE="nerdfont-complete"

### ZSH / OMZ / PL9K ricing ###
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%(?:%B%F{green}:%B%F{red})  ➜ %{$reset_color%}"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon status context dir vcs)
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

# Update behaviour
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:update' frequency 1


### PLUGINS ##
plugins=(
  git
  rust
  zsh-syntax-highlighting
  zsh-autosuggestions
  extract
  archlinux
)
. $ZSH/oh-my-zsh.sh

# automatically start ssh-agent
export SSH_AUTH_SOCK=~/.ssh/ssh-agent.sock
ssh-add -l &> /dev/null
[ $? -ge 2 ] && ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null

#if [ -z "$SSH_AUTH_SOCK" ] ; then
#  eval `ssh-agent -s` > /dev/null
#fi


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

# Overrides
alias cat="bat -pp"
alias ls="eza --icons -g --smart-group -b --git --git-repos -M"
# same-command overrides tho
alias ip="ip -c"
alias ffmpeg='ffmpeg -hide_banner'
alias wget="wget --hsts-file ~/.local/share/wget/hsts"
if command -v macchina &> /dev/null; then
  alias macchina="macchina -o host -o kernel -o distribution -o packages -o terminal -o shell -o uptime -o resolution -o processor-load -o memory"
fi
mkdir -p -m 700 "$HOME/.local/state/paru/.gnupg/"
alias paru="GNUPGHOME=$HOME/.local/state/paru/.gnupg/ paru" # like leave my gpg keyring alone ffs
alias pgpg="GNUPGHOME=$HOME/.local/state/paru/.gnupg/ gpg"
alias nv=nvim
alias h="GIT_DIR=.dotfiles.git " # can put dotfiles in home with .git as .dotfiles.git
                                 # and manage with h alias

if command -v thefuck &> /dev/null; then
  eval $(thefuck --alias FUCK)
  eval $(thefuck --alias)
fi

mkdir -p "$HOME/.local/state/"
export _Z_DATA="$HOME/.local/state/.z"
[[ -r "/usr/share/z/z.sh" ]] && . /usr/share/z/z.sh


### Welcome Screen ###
if command -v fastfetch &> /dev/null && [ -z "$SHELL_SESSION_LOADED" ]; then
  printf "\33[2K\r"; fastfetch -c examples/7.jsonc
  export SHELL_SESSION_LOADED=1
fi

### Bindings ###
bindkey '^H' backward-kill-word

# bun completions
[ -s "/home/javalsai/.bun/_bun" ] && source "/home/javalsai/.bun/_bun"

### Profiling ###
#zprof
