# set vim mode
bindkey -v

# think in vim mode, allows to delete past the current insertion text (previous
# buffer text) after going from normal/insert mode
bindkey -M viins '^?' backward-delete-char
# you'd be surprised by how much multiline behavior this fixes, also btw, if
# you wanna insert a line, `ctrl + v , ctrl + j`.

bindkey '^H' backward-kill-word          # ctrl + backspace
bindkey '^_' backward-kill-word          # ctrl + backspace (TTY)
# bindkey '^[[127;5u' backward-kill-word # I think this was alacritty?

bindkey '^[[1;5D' backward-word      # ctrl + ←
bindkey '^[[1;5C' forward-word       # ctrl + →
bindkey '^[[Z' reverse-menu-complete # shift + tab

bindkey '^[[H' beginning-of-line # home
bindkey '^[[F' end-of-line       # end
bindkey '^[[3~' delete-char      # del
bindkey '^[[3;5~' kill-word      # ctrl + del

bindkey '^[.' insert-last-word # alt + .

bindkey '^R' history-incremental-search-backward # ctrl + r
bindkey '^S' history-incremental-search-forward  # ctrl + s

__zle_bind__() { zle -N "$2"; bindkey "$1" "$2" }

__nvim() { nv }
__ls_l() { echo; l .; zle reset-prompt }
__xdg_open_cwd() { xdg-open . }
__ctrl_shift_l() { printf '\e[H\e[3J'; zle reset-prompt }
__yazi_cwd() { yazi . }

__zle_bind__ "^N" __nvim           # ctrl + N
__zle_bind__ "^[^L" __ls_l         # ctrl + alt + l
__zle_bind__ "^[^E" __xdg_open_cwd # ctrl + alt + e
__zle_bind__ "^[^Y" __yazi_cwd     # ctrl + alt + y
__zle_bind__ "^[[108;6u" __ctrl_shift_l

### OMZ-like
autoload -z edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
