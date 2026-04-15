source "$PREFIX/libexec/source-ssh-agent.sh"

# isnt this already /etc/profile.d anyways?
# source "$PREFIX/etc/profile.d/rust-nightly.sh"

# git cloned (rust/?)src there as `_` and symlinked `library` there
#
# also checked out the commit of nightly's `rustc -vV` commit hash
#
# if that whole opt dir was only there for the other pkgs i shouls move
# that out to avoid apt tracking conflicts
export RUST_SRC_PATH="$PREFIX/opt/rust-nightly/lib/rustlib/rustc-src/rust/library"

export CLIP_COPY=termux-clipboard-set
export STORAGE=/storage/emulated/0
export RSYNC_RSH=ssha
export GIT_SSH_COMMAND=ssha
export SSH_ASKPASS='termux-ssh-askpass'
