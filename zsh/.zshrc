### Stop Keyborad Text ###
stty_state=$(stty -g)
stty -echo

### Basic declarations ###
bold=$(tput bold)
normal=$(tput sgr0)

### Basic env ###
export ZSH="~/.oh-my-zsh"
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

### ZSH / OMZ / PL9K headers ###
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE="nerdfont-complete"

### ZSH / OMZ / PL9K ricing ###
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%B%F{green}  ➜ "

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs custom_command_time)

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

POWERLEVEL9K_CUSTOM_COMMAND_TIME="zsh_command_time"
POWERLEVEL9K_CUSTOM_COMMAND_TIME_BACKGROUND=234
ZSH_COMMAND_TIME_MIN_SECONDS=0

# PL9 theme for ZSH / OMZ
source $ZSH/custom/themes/powerlevel9k/powerlevel9k.zsh-theme


# Update behaviour
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:update' frequency 1


### PLUGINS ##
plugins=(
  git
  command-time
  zsh-syntax-highlighting
  zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh


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
alias wget="wget --hsts-file ~/dotfiles/config/wget/wget-hsts"
alias hang="tput civis; read -s; tput cnorm"
appreciate() { clear; $1; hang; }

# Custom time that a command took
zsh_command_time() {
    POWERLEVEL9K_CUSTOM_COMMAND_TIME_FOREGROUND=255
    if [ -n "$ZSH_COMMAND_TIME" ]; then
        sec=$ZSH_COMMAND_TIME
        if [ "$sec" -le 60 ]; then # Less than 1 min
            POWERLEVEL9K_CUSTOM_COMMAND_TIME_FOREGROUND=2 # Green
        elif [ "$sec" -le 180 ]; then # Less than 3 min
            POWERLEVEL9K_CUSTOM_COMMAND_TIME_FOREGROUND=3 # Yellow
        elif [ "$sec" -le 600 ]; then # Less than 10 min
            POWERLEVEL9K_CUSTOM_COMMAND_TIME_FOREGROUND=208 # Orange
        else # More than 10 min
            POWERLEVEL9K_CUSTOM_COMMAND_TIME_FOREGROUND=1 # Red
        fi
        #printf "$fg[white]took ${bold}$fg[$color]${sec}${normal}$fg[white]s\n"
        printf "${sec}s"
    fi
}


[ -f ~/.pathrc ] && source ~/.pathrc
colorscript -r

# Re-enable Keyboard Text
stty "$stty_state"
