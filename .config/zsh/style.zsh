zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

# allows scrolling in less
autoload -Uz bracketed-paste-magic
zle_bracketed_paste_magic() { zle bracketed-paste; }
zle -N bracketed-paste-magic

WORDCHARS=${WORDCHARS//\//}
WORDCHARS=${WORDCHARS//[_-]/}
WORDCHARS=${WORDCHARS//./}
