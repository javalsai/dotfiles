# for when I wanna force env instead of re-login, though exports shouldn't
# force normally though
FORCE_SOURCE=0
if [ "$FORCE_SOURCE" -eq 1 ]
    then __export_ifn() { eval 'export "'"$1"'"="'"$2"'"'; }
    else __export_ifn() { eval '[ -z "$'"$1"'" ] && export "'"$1"'"="'"$2"'"'; }
fi
unset FORCE_SOURCE

### Higene (custom homes ALWAYS first, trust me, EVEN before $BROWSER) ###

__export_ifn ANDROID_HOME "$HOME/.local/share/Android/Sdk"
__export_ifn BUN_INSTALL "$HOME/.local/share/bun" # TODO
__export_ifn CARGO_HOME "$HOME/.local/share/cargo"
__export_ifn GOPATH "$HOME/.local/share/go"
__export_ifn NODE_REPL_HISTORY "$HOME/.local/state/node_history"
__export_ifn RUSTUP_HOME "$HOME/.local/share/rustup"
__export_ifn R_HISTFILE "$HOME/.local/state/Rhistory"
__export_ifn R_LIBS_USER "$HOME/.local/share/R/%p-library/%v"
__export_ifn R_PROFILE_USER "$HOME/.config/R/Rprofile"
source "$HOME/.config/profile/perl.sh"

if [[ -d "$ANDROID_HOME/ndk" ]]; then
    __export_ifn NDK_HOME "$ANDROID_HOME/ndk/$(command ls -1 "$ANDROID_HOME/ndk" | head -1)"
fi

### Important Globals ###

__export_ifn HOSTNAME "$(hostname)"

if [[ "$HOSTNAME" != "laptop" ]]
    then __export_ifn BROWSER "firefox"
    else __export_ifn BROWSER "librewolf"
fi

export EDITOR=${EDITOR:-nvim}

if [ -z "$LS_COLORS" ]; then
    eval "$(dircolors -b)"
    # match nvim's catppuccin theme, use a dircolors db file if this gets more convoluted
    export LS_COLORS="ma=3;4;30;46:${LS_COLORS//34/"38;2;236;134;150"}"
    export CLICOLOR=${CLICOLOR:-1}
fi

unset -f __export_ifn

### PATH ###

__path_if() { [ -d "$1" ] && [ "$1" != "/bin" ] && PATH="$1:$PATH"; }
__pathafter_if() { [ -d "$1" ] && [ "$1" != "/bin" ] && PATH="$PATH:$1"; }

__path_if "$HOME/.local/bin"
__path_if "$CARGO_HOME/bin"
__path_if "$HOME/.surrealdb" #*unhigenic
__path_if "$GOPATH/bin"
__path_if "$BUN_INSTALL/bin"
__pathafter_if "$PERL5_HOME/bin"

unset -f __path_if __pathafter_if

# ADDITIONAL ENV

export WINEDEBUG=${WINEDEBUG:-"fixme-all"}

[ -n "$TERMUX_VERSION" ] &&
    source "$HOME/.config/profile/termux.sh"

if [ -z "$CLIP_COPY" ] && command -v wl-copy &> /dev/null
    then export CLIP_COPY=${CLIP_COPY:-"wl-copy"}
    else export CLIP_COPY=${CLIP_COPY:-"xclip -sel clip"}
fi
export SSH_ASKPASS=${SSH_ASKPASS:-"/usr/bin/ksshaskpass"}
export SSH_ASKPASS_REQUIRE=prefer

source "$HOME/.config/profile/less.sh"

### Shell Functions ###
source "$HOME/.config/profile/shell-functions"
