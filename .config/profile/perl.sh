# TODO: idk where I had perl, but I gotta search for its custom home env path,
# $HOME/perl5 is shii

if [ -d "$HOME/perl5" ]; then
    __export_ifn PERL5_HOME "$HOME/perl5" # made up for reusability, idk if actually exists

    __export_ifn PERL5LIB "$PERL5_HOME/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
    __export_ifn PERL_LOCAL_LIB_ROOT "$PERL5_HOME${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
    __export_ifn PERL_MB_OPT "--install_base \"$PERL5_HOME\""
    __export_ifn PERL_MM_OPT "INSTALL_BASE=$PERL5_HOME"
fi
