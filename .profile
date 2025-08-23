# PATH
# this file is like... 10ms º-º
# export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.surrealdb:$PATH"
export PATH="$PATH:$HOME/perl5/bin"


# ADDITIONAL ENV
export BROWSER="firefox";
export WINEDEBUG="fixme-all";

export BUN_INSTALL="$HOME/.bun"
export PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}";
export PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}";
export PERL_MB_OPT="--install_base \"$HOME/perl5\"";
export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5";

# ffs, java & android (for tauri at least for now)
export JAVA_HOME="/opt/android-studio/jbr"
export ANDROID_HOME="$HOME/Android/Sdk"

if [[ -d "$ANDROID_HOME/ndk" ]]; then
    NDK_HOME="$ANDROID_HOME/ndk/$(command ls -1 "$ANDROID_HOME/ndk" | head -1)"
    export NDK_HOME
fi

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

if [[ -z "$TERMUX_VERSION" ]]; then
    if command -v wl-copy &> /dev/null; then
        export CLIP_COPY="wl-copy"
    else
        export CLIP_COPY="xclip -sel clip"
    fi
    export SSH_ASKPASS='/usr/bin/ksshaskpass'
    export SSH_ASKPASS_REQUIRE=prefer
else
    source "$PREFIX/libexec/source-ssh-agent.sh"

    source "$PREFIX/etc/profile.d/rust-nightly.sh"
    export RUST_SRC_PATH="$PREFIX/opt/rust-nightly/lib/rustlib/rustc-src/rust/library"
    # git cloned src there as `_` and symlinked `library` there
    #
    # also checked out the commit of nightly's `rustc -vV` commit hash
    #
    # if that whole opt dir was only there for the other pkgs i shouls move
    # that out to avoid apt tracking conflicts


    export CLIP_COPY=termux-clipboard-set
    export STORAGE=/storage/emulated/0
    export NVM_DIR=/data/data/com.termux/files/home/.nvm # idek if i still have nvm
    export RSYNC_RSH=ssha
    export GIT_SSH_COMMAND=ssha
    export SSH_ASKPASS='termux-ssh-askpass'
    export SSH_ASKPASS_REQUIRE=prefer
fi

export EDITOR=${EDITOR:-nvim}

# mfw tput takes 60ms ._. (its basic ansi conventions anyways)
# (still like 5ms tho... but meh)
# Support colors in less
TPUT_SGR0=$(tput sgr0)
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
# export LESS_TERMCAP_mb LESS_TERMCAP_md LESS_TERMCAP_me LESS_TERMCAP_se \
#     LESS_TERMCAP_so LESS_TERMCAP_ue LESS_TERMCAP_us LESS_TERMCAP_mr \
#     LESS_TERMCAP_mh LESS_TERMCAP_ZN LESS_TERMCAP_ZV LESS_TERMCAP_ZO \
#     LESS_TERMCAP_ZW
export GROFF_NO_SGR=1

# SOURCES
#source "/usr/share/nvm/init-nvm.sh";
[ -s "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env";
