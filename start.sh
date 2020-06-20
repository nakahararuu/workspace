#/bin/bash -eu
set -o pipefail

# modify dotfiles
sudo chown -R docker-user:docker-user ~/.config/chezmoi
if [ -v GIT_USER ]; then
  sed -i -e "s/git-docker-user/${GIT_USER}/g" ~/.config/chezmoi/chezmoi.toml
fi
if [ -v GIT_EMAIL ]; then
  sed -i -e "s/git-docker-user@example.com/${GIT_EMAIL}/g" ~/.config/chezmoi/chezmoi.toml
fi
chezmoi apply

# start shell
fish -l

exit 0
