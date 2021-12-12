#!/bin/bash

SCRIPTDIR=~/dotfiles

function linkFile {
  if [ -L $2 ]; then
    msg="[$1] already exists"
  else
    msg="[$1] linked to $2"
    command="ln -s"
    if [ -d $SCRIPTDIR/$1 ] ; then command="$command -n"; fi
    $command $SCRIPTDIR/$1 $2
  fi
  /bin/echo -e "$msg"
}

function doSSH {
  ssh-keygen -t rsa -b 4096 -C "$1"
  eval "$(ssh-agent -s)"
  ssh-add -K ~/.ssh/id_rsa
}

function program_is_installed {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  type $1 >/dev/null 2>&1 || { local return_=0; }
  # return value
  echo "$return_"
}

# Asking the real questions
echo "mac username plz"
read username
echo "fullname plz"
read fullname
echo "email address plz"
read emailaddr
read -n1 -p "Create SSH key? [y,n]" ssh
case "$ssh" in
  [yY] )
    doSSH "$emailaddr"
    ;;
    * )
  echo "okay…"
  ;;
esac

linkFile vimrc     ~/.vimrc
linkFile vimrc     ~/.nvimrc
linkFile vim       ~/.vim
linkFile tmux.conf ~/.tmux.conf
linkFile zshrc     ~/.zshrc
linkFile myzsh     ~/myzsh
linkFile gitignore ~/.gitignore
linkFile gitconfig ~/.gitconfig

# BREW
if [ program_is_installed == 0 ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  brew update
  brew upgrade
fi

brew cask install iTerm2 sourcetree
brew install ack zsh zsh-completions ag zplug tmux reattach-to-user-namespace wget yarn
brew install vim --with-override-system-vi --with-client-server 
brew install neovim

# lel
brew install fortune cowsay
sudo gem install lolcat

# Plug for vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# the right vim
git config --global core.editor $(which vim)
# the right git username and email addy
git config --global user.name "$fullname"
git config --global user.email "$emailaddr"

# install shell integration for iterm2
curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash
