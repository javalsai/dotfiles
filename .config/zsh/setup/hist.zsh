HISTFILE="$HOME/.local/state/.zsh_history"
HISTSIZE=999999999
SAVEHIST=999999999

setopt share_history
setopt hist_ignore_space
setopt hist_ignore_dups       # dont insert contiguous dups
unsetopt hist_ignore_all_dups # dont touch older hist even if matches
setopt hist_find_no_dups      # do not show already showed entries when finding
setopt inc_append_history     # immediate append
setopt hist_reduce_blanks
