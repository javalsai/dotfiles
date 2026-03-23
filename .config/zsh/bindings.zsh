bindkey '^H' backward-kill-word
bindkey '^_' backward-kill-word # For TTY
bindkey '^[[127;5u' backward-kill-word

bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[Z' reverse-menu-complete

__nvim() { nv }
__ls_l() { l; zle reset-prompt }
__xdg_open_cwd() { xdg-open . }
__ctrl_shift_l() { printf '\e[H\e[3J'; zle reset-prompt }
__yazi_cwd() { yazi . }
zle -N __nvim
zle -N __ls_l
zle -N __xdg_open_cwd
zle -N __ctrl_shift_l
zle -N __yazi_cwd
bindkey "^N" __nvim
bindkey "^[^L" __ls_l # alt
bindkey "^[^E" __xdg_open_cwd # alt
bindkey "^[^Y" __yazi_cwd # alt
bindkey "^[[108;6u" __ctrl_shift_l

### OMZ
autoload -z edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
