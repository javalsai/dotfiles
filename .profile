# PATH
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/home/javalsai/.surrealdb:$PATH"
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

NDK_HOME="$ANDROID_HOME/ndk/$(command ls -1 "$ANDROID_HOME/ndk" | head -n1)"
export NDK_HOME

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export SSH_ASKPASS='/usr/bin/ksshaskpass'
export SSH_ASKPASS_REQUIRE=prefer

export EDITOR=${EDITOR:-nvim}
#if [[ -z $EDITOR ]]; then
#  if [[ -n $SSH_CONNECTION ]]; then
#    export EDITOR='nano'
#  else
#    export EDITOR='nvim'
#  fi
#fi

# Support colors in less
LESS_TERMCAP_mb=$(tput bold; tput setaf 1)
LESS_TERMCAP_md=$(tput bold; tput setaf 1)
LESS_TERMCAP_me=$(tput sgr0)
LESS_TERMCAP_se=$(tput sgr0)
LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
LESS_TERMCAP_ue=$(tput sgr0)
LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 2)
LESS_TERMCAP_mr=$(tput rev)
LESS_TERMCAP_mh=$(tput dim)
LESS_TERMCAP_ZN=$(tput ssubm)
LESS_TERMCAP_ZV=$(tput rsubm)
LESS_TERMCAP_ZO=$(tput ssupm)
LESS_TERMCAP_ZW=$(tput rsupm)
export LESS_TERMCAP_mb LESS_TERMCAP_md LESS_TERMCAP_me LESS_TERMCAP_se \
    LESS_TERMCAP_so LESS_TERMCAP_ue LESS_TERMCAP_us LESS_TERMCAP_mr \
    LESS_TERMCAP_mh LESS_TERMCAP_ZN LESS_TERMCAP_ZV LESS_TERMCAP_ZO \
    LESS_TERMCAP_ZW
export GROFF_NO_SGR=1

# SOURCES
#source "/usr/share/nvm/init-nvm.sh";
source "/home/javalsai/.ghcup/env";
