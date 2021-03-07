#!/bin/zsh

echo "Setting up a new mac book"

# Check if xcode-select —-install is installed

# Supporting Functions
brewPackageInstall() {
  if brew ls --versions "$1";
  then HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade "$1";
  else HOMEBREW_NO_AUTO_UPDATE=1 brew install "$1";
  fi
}

brewCaskInstall() {
  brew install --cask $1
}

# Setup zsh as default shell
chsh -s /bin/zsh

# Installing Homebrew

# Check for Homebrew and install
if test ! $(which brew);
then
  echo "  Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update brew
brew update

# Install required softwares

PACKAGES=(
  azure-cli
  coreutils
  gnupg
  grep
  git
  kubectl
  kubectx
  tree
  vim
  wget
)

for package in "${PACKAGES[@]}"
do
  echo "Installing package $package"
  brewPackageInstall $package
done


# Install MacOs Applications
APPLICATIONS=(
  adobe-acrobat-reader
  alfred
  brave-browser
  dbeaver-community
  docker
  github
  google-chrome
  iterm2
  kdiff3
  lens
  microsoft-azure-storage-explorer
  pgadmin4
  postman
  robo-3t
  slack
  sourcetree
  spotify
  sublime-text
  visual-studio-code
  telegram
  whatsapp
  zoom
)

for application in "${APPLICATIONS[@]}"
do
  echo "Installing application $application"
  brewCaskInstall $application
done

brew cleanup
