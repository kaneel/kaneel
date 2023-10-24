#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ ! -z $1 ] && [ -d $1 ];
then 
  /bin/echo $1
  INSTALL_DIR=$1
else 
  INSTALL_DIR=~
fi

case "$(uname -sr)" in
   Darwin*)
     Platform="mac"
     ;;
   Linux*)
     Platform="linux"
     ;;
   CYGWIN*|MINGW*|MINGW32*|MSYS*)
     /bin/echo "NO WINDOWS"
     exit
     ;;
   *)
     /bin/echo "ARE U FROM THE FUTURE?"
     exit
     ;;
esac

function makeDir {
  if [ -d $1 ]; 
  then 
    read -p "[$1] already exists; Do you want to delete? yN " delYN
    case $delYN in 
      [yY]) 
        echo "yolo!"
        rm -rf $2
        break;;
    esac
  else 
    mkdir $1
    msg="[$1] created"
  fi
  /bin/echo -e "$msg"
}

function linkFile {
  if [ -L $2 ]; 
  then 
    read -p "[$2] already exists; Do you want to delete? yN " delYN
    case $delYN in 
      [yY]) 
        rm $2
        linkFile $1 $2
        ;;
    esac
  else
    msg="[$2] linked to $1"

    command="ln -s"

    if [ -d $SCRIPT_DIR/$1 ];
    then 
      /bin/echo -e "target [$1] is a directory!"
      command="$command -n"
    fi

    $command $SCRIPT_DIR/$1 $2
  fi

  /bin/echo -e "$msg"
}
#
# create symlinks
linkFile tmux.conf        $INSTALL_DIR/.tmux.conf
linkFile zshrc            $INSTALL_DIR/.zshrc
linkFile myzsh            $INSTALL_DIR/myzsh
linkFile gitignore        $INSTALL_DIR/.gitignore
linkFile starship.toml    $INSTALL_DIR/.config/starship.toml

# creates .config
makeDir $INSTALL_DIR/.config
makeDir $INSTALL_DIR/.config/nvim

linkFile init.lua   $INSTALL_DIR/.config/nvim/init.lua
linkFile lua        $INSTALL_DIR/.config/nvim/lua

if [ $Platform = "linux" ]; then 
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  curl -sS https://starship.rs/install.sh | sh
elif [ $Platform = "mac" ]; then 
  brew install rustup
  curl -sS https://starship.rs/install.sh | sh
fi

# the right vim
git config --global core.editor $(which nvim)
