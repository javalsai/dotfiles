export LESS=${LESS:-"-R --mouse"}

# Support man colors in less

[ -z "$TPUT_SGR0" ] && TPUT_SGR0=$(tput sgr0)
export TPUT_SGR0

export LESS_TERMCAP_mb=$'\x1b''[1;31m' # $(tput bold; tput setaf 1)
export LESS_TERMCAP_md=$'\x1b''[1;31m' # $(tput bold; tput setaf 1)
export LESS_TERMCAP_me=$TPUT_SGR0 # $(tput sgr0)
export LESS_TERMCAP_se=$TPUT_SGR0 # $(tput sgr0)
export LESS_TERMCAP_so=$'\x1b''[1;33;44m' # $(tput bold; tput setaf 3; tput setab 4)
export LESS_TERMCAP_ue=$TPUT_SGR0 # $(tput sgr0)
export LESS_TERMCAP_us=$'\x1b''[1;4;32m' # $(tput smul; tput bold; tput setaf 2)
export LESS_TERMCAP_mr=$'\x1b''[7m' # $(tput rev)
export LESS_TERMCAP_mh=$'\x1b''[2m' # $(tput dim)
# apparently not even supported in any of my terms
export LESS_TERMCAP_ZN= # $(tput ssubm)
export LESS_TERMCAP_ZV= # $(tput rsubm)
export LESS_TERMCAP_ZO= # $(tput ssupm)
export LESS_TERMCAP_ZW= # $(tput rsupm)

export GROFF_NO_SGR=1
