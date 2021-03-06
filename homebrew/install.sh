#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check for Homebrew
if test $(which brew)
then
  brew update
  brew bundle --global
  brew cask cleanup
else
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install homebrew packages
brew install ack autojump caskroom/cask/brew-cask coreutils findutils git openssl xctool zsh cowsay

# Make sure we have chrome
brew cask install google-chrome sublime-text3

exit 0
