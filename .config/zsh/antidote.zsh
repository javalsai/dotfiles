if [ -f '/usr/share/zsh-antidote/antidote.zsh' ]; then
    source '/usr/share/zsh-antidote/antidote.zsh'
elif [ -f "${ZDOTDIR:-$HOME}/.antidote" ]; then
    source "${ZDOTDIR:-$HOME}/.antidote"
else
    printf "\033[31m%s\033[0m\n" "Antidote not found"
fi
