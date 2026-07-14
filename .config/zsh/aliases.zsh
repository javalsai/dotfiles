alias kys="exit"
alias please="doas "
alias fucking="doas "

# Misc Utils
alias hl='rg --passthru'
alias fuckyou="%&|"
alias weather="curl -s https://wttr.in/Granada --output - | head -n 7 | tail -n 6 && echo"

# Shorthands
for a in {,u,g,o,a}{+,-}{r,w,x}; do alias -- "$a=chmod $a"; done
alias b64=base64
alias edit="$EDITOR" # I just nvim tho
alias mommy="cargo mommy" # no commentary
alias ado="doas " # aliases with doas
alias xa="xargs " # aliases with xargs
alias each="each " # aliases with each
alias xo=xdg-open
alias nv=nvim
alias nvR="nvim -R"
alias gz=gzip
alias rp=realpath
alias dn=dirname
alias dps="docker ps --format 'table {{.ID }} \\t {{ .Names }} \\t {{ .Image }}'"
alias ndk="PATH=\"\$NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/:\$PATH\" "
alias tmp="cd \${TMPDIR:-/tmp}"
alias ns='nix-shell --command "export SHELL=\"$SHELL\"; exec \"\$SHELL\""'
alias nd='nix develop --command bash -c "export SHELL=\"$SHELL\"; exec \"\$SHELL\""'
alias m='man1 ' # manual but alias expanded and shorter, making the savage 'm g' possible
alias pm=pacman
alias rs=rsync
alias cgo=cargo
alias ka=killall
alias hyc=hyprctl
alias tg=timg

# Overrides
alias dig=dog
alias cat="bat -pp"
eza() { timeout 0.5s eza "$@" || command eza --no-git "$@" }
alias ls="eza --icons -g --smart-group -b --hyperlink --git --git-repos -M"
# same-command overrides tho
alias ip="ip -c=auto -iec"
alias ffmpeg='ffmpeg -hide_banner'
alias ffprobe='ffprobe -hide_banner'
alias wget="wget --hsts-file ~/.local/share/wget/hsts"
alias R="R --silent --no-restore-data --no-save"
# programs i sometime typo'd and cant ctrlc/ctrld out or are annoying asf
alias gs='printf "\x1b[1;31m%s\x1b[0m\n" "OMFG WE BOTH KNOW YOU DIDN'\''T MEAN TO USE GHOSTSCRIPT" #'
alias mf='printf "\x1b[1;31m%s\x1b[0m\n" "OMFG WE BOTH KNOW YOU DIDN'\''T MEAN TO USE METAFONT, WHATEVER TS IS" #'

alias h="GIT_DIR=.dotfiles.git " # can put dotfiles in home with .git as .dotfiles.git
                                 # and manage with h alias

# Non-Override Whoopsies
alias :qa=exit
alias :q=exit
alias ':q!'=exit

if [[ -z "$TERMUX_VERSION" ]]; then
  mkdir -p -m 700 "$HOME/.local/state/paru/.gnupg/"
  alias paru="GNUPGHOME=$HOME/.local/state/paru/.gnupg/ paru" # like leave my gpg keyring alone ffs
  alias pgpg="GNUPGHOME=$HOME/.local/state/paru/.gnupg/ gpg"

  mkdir -p "$HOME/.local/state/"
  if [[ "$HOST" == "artway" ]]; then
    eval "$(zoxide init zsh)"
  else
    export _Z_DATA="$HOME/.local/state/.z"
    [[ -r "/usr/share/z/z.sh" ]] && . /usr/share/z/z.sh
  fi
else
  alias ssh='ssha'
  alias scp='scpa'
  alias copy='termux-clipboard-set'
  alias paste='termux-clipboard-get'
  alias doas=sudo
  eval "$(zoxide init zsh)"

  vidshr() {
    TMPF=$(mktemp --suffix=.mp4 -u)
    termux-storage-get "$TMPF"
    TMPFO=$(mktemp --suffix=.mp4 -u)
    echo "$TMPF:$TMPFO"
    while [[ ! -e "$TMPF" ]]; do sleep .4; done
    ffmpeg -i "$TMPF" -vcodec libx264 -crf 20 "$TMPFO"
    rm "$TMPF"
    xdg-open --send "$TMPFO"
  }

  export NODE_PATH="$PREFIX/lib/node_modules"
fi
