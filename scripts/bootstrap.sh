#!/bin/bash

set -e

echo "Setting up chezmoi ..."

brew bundle --file=- <<EOF
    brew 'chezmoi'
EOF

if [ ! -f "$HOME/.config/chezmoi/chezmoi.toml" ]; then
  echo "Applying dotfiles with chezmoi ..."
  chezmoi init --apply --verbose https://github.com/khanh-codes/dotfiles.git
  chmod 0600 "$HOME/.config/chezmoi/chezmoi.toml"
fi

if [ -f "$HOME/.Brewfile" ]; then
  echo "Installing tools and apps from Brewfile ..."
  if brew bundle --file="$HOME/.Brewfile"; then
    echo "All items in Brewfile were installed successfully."
  else
    echo "Some items in Brewfile were not installed successfully."
  fi
fi
