# My Dotfiles

Git repo of my home folder, most stuff is self contained here and intertwined.

# Notice

These dotfiles are provided as-is. I make no guarantees regarding stability, correctness, or suitability for any system.

Use at your own risk.

# Use

I often make breaking changes that require manual migrations and to understand what to migrate.

# Bootstraping

To use the dotfiles you'll need to have aliases and configurations provided in the dootfiles, that's obviously problematic, so the general bootstraping is:

```sh
mkdir -p ~/.config/dotfiles
git clone --bare https://github.com/javalsai/dotfiles ~/.config/dotfiles/bare.git

alias h='GIT_DIR=~/.config/dotfiles/bare.git GIT_WORK_TREE=~ '
h git reset --hard # WILL delete whatever matches a file in the dotfiles without warning

# the following is not required but neat
h git sparse-checkout init --no-cone && \
  h git sparse-checkout set '/*' '!LICENSE' '!README.md'
```

# Licensing

Unless otherwise noted, files in this repository are licensed under WTFPL.

Some files may contain third-party code under different licenses (e.g. MIT). Those files will include their original license notices.
