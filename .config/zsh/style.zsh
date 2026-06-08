zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
# zstyle ':completion:*' auto-description 'specify: %d'
# zstyle ':completion:*' group-name ''

# should move this to 'behavior.zsh' or smth

# allows scrolling in less
autoload -Uz bracketed-paste-magic
zle_bracketed_paste_magic() { zle bracketed-paste; }
zle -N bracketed-paste-magic

# cursor beam on startup (for ssh'ing in, or nvim builtin term)
echo -ne '\e[6 q'

# custom word boundaries
WORDCHARS=${WORDCHARS//\//}
WORDCHARS=${WORDCHARS//[_-]/}
WORDCHARS=${WORDCHARS//./}

# case insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# multiline zle
bindkey '^J' self-insert
bindkey '^[^M' self-insert

# misc

### `man zshparam`
export KEYTIMEOUT=2

### `man zshoptions`
setopt extended_glob   # allows more complex regex (e.g. *.txt~file.txt, *.txt except file.txt or ^ for exception (all but))
setopt glob_star_short # `echo **.c` works
setopt glob_dots       # `*` matches dotfiles too

setopt complete_aliases

setopt correct              # > correct 'X' yo 'Y' [nyae]?
setopt interactive_comments # I can comment in my interactiev yayy
setopt no_beep              # I **think** its just no overuse of BEL
