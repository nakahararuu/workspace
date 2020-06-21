#/bin/bash -eu
set -o pipefail

# modify dotfiles
if [ -e /custom_chezmoi.toml ]; then
  cp /custom_chezmoi.toml ~/.config/chezmoi/chezmoi.toml
  sudo chown -R docker-user:docker-user ~/.config/chezmoi
  chezmoi apply
fi

# start shell
tmux

exit 0
