### Stop Keyborad Text ###
stty_state=$(stty -g)
stty -echo

### Basic declarations ###
bold=$(tput bold)
normal=$(tput sgr0)

### Basic env ###
. "$HOME/.profile"
export ZSH="/home/javalsai/.oh-my-zsh"
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

### Bindings ###
bindkey '^H' backward-kill-word

### ZSH / OMZ / PL9K headers ###
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE="nerdfont-complete"

### ZSH / OMZ / PL9K ricing ###
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%B%F{green}  ➜ "

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

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

## OS icon ##
 POWERLEVEL9K_OS_ICON_FOREGROUND=81
 POWERLEVEL9K_OS_ICON_BACKGROUND=235

# Update behaviour
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:update' frequency 1


### PLUGINS ##
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh

# automatically start ssh-agent
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s` > /dev/null
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='nvim'
fi

# Example aliases
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias edit="$EDITOR $1"
alias cat="bat -pp";
alias wget="wget --hsts-file ~/dotfiles/config/wget/wget-hsts"
alias hang="tput civis; read -s; tput cnorm"
appreciate() { clear; $1; hang; }
alias weather="curl -s https://wttr.in/Granada --output - | head -n 7 | tail -n 6 && echo"
alias macchina="macchina -o Host -o Kernel -o Distribution -o Packages -o Terminal -o Shell -o Uptime -o Resolution -o ProcessorLoad -o Memory"
eval $(thefuck --alias FUCK)
eval $(thefuck --alias)

macchina

# Re-enable Keyboard Text
stty "$stty_state"
