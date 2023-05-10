#!/bin/bash

SCRIPTDIR=~/kaneel

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

function program_is_installed {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  type $1 >/dev/null 2>&1 || { local return_=0; }
  # return value
  echo "$return_"
}

linkFile vimrc     ~/.vimrc
linkFile vimrc     ~/.nvimrc
linkFile vim       ~/.vim
linkFile tmux.conf ~/.tmux.conf
linkFile zshrc     ~/.zshrc
linkFile myzsh     ~/myzsh
linkFile gitignore ~/.gitignore
linkFile gitconfig ~/.gitconfig

# the right vim
git config --global core.editor $(which nvim)

