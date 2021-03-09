#!/bin/bash

echo "Setting up a new mac book"

DOTFILES_DIR=$HOME/.dotfiles
WORK_CODE_DIR=$HOME/Work/Code
CODE_DIR=$HOME/Code
NVM_DIR=$HOME/.nvm

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
  nvm
  python
  python3
  tree
  vim
  wget
  yarn
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

mkdir -p $WORK_CODE_DIR # Work Code
mkdir -p $CODE_DIR # Personal Code
mkdir NVM_DIR #nvm dir


echo "Setting up dotfiles"

if [ -d "$DOTFILES_DIR" ]
then
  echo "Dot files already exists, pulling in latest changes"
  cd $DOTFILES_DIR
  git pull origin master
  cd $HOME
else
  echo "Dotfiles does not exists, installing"
  git clone https://github.com/ygnr/dotfiles.git $DOTFILES_DIR
fi

cd $DOTFILES_DIR
sudo /bin/bash script/bootstrap
sudo /bin/bash script/install

if [ -d "$CODE_DIR/mac-setup" ]
then
  echo "Clone this repository into $CODE_DIR"
  cd $CODE_DIR/mac-setup
  git pull origin master
  cd $HOME
else
  echo "Mac setup does not exists, installing"
  cd $CODE_DIR
  git clone https://github.com/ygnr/mac-setup.git
  cd $HOME
fi

echo "Installing node"
nvm install node