#!/usr/bin/env bash

echo "Setting up a new mac book"

DOTFILES_DIR=$HOME/.dotfiles

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
if [[ $SHELL != "/bin/zsh" ]]
then
  echo "Changing default shell to zsh"
  chsh -s /bin/zsh
fi

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
  jq
  kubectl
  kubectx
  python
  python3
  tree
  vim
  wget
  zsh
  zsh-completions
  zsh-syntax-highlighting
  zsh-autosuggestions
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
  dotnet-sdk
  drawio
  github
  google-chrome
  iterm2
  kdiff3
  lastpass
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
  vlc
  zoom
)

for application in "${APPLICATIONS[@]}"
do
  echo "Installing application $application"
  brewCaskInstall $application
done

brew cleanup

echo "Hombrew installation complete"

mkdir -p ~/Work/Code # Work Code
mkdir -p ~/Code # Personal Code


echo "Setting up dotfiles"

if [ -d "$DOTFILES_DIR" ]
then
  echo "Dot files already exists, pulling in latest changes"
  cd $DOTFILES_DIR
  git pull origin master
  cd $HOME
else
  echo "Dotfiles does not exists, installing"
  git clone https://github.com/ygnr/dotfiles.git ~/.dotfiles
fi

cd $DOTFILES_DIR
/bin/bash script/bootstrap
/bin/bash script/install
