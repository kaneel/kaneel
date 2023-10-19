#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

case "$(uname -sr)" in
   Darwin*)
     Platform="mac"
     ;;
   Linux*)
     Platform="linux"
     ;;
   CYGWIN*|MINGW*|MINGW32*|MSYS*)
     Platform="win"
     ;;
   *)
     Platform=""
     ;;
esac

function makeDir {
  if [ -d $1 ]; 
  then 
    msg="[$1] already exists"
    read -p "Do you want to delete? yN " delYN
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
        echo "yolo!"
        rm $2
        break;;
    esac
  else
    msg="[$2] linked to $1"

    if [ $Platform = "linux" ] || [ $Platform = "mac" ];
    then command="ln -s"
    elif [ $Platform = "win" ];
    then command="mklink"
    fi

    if [ -d $SCRIPT_DIR/$1 ];
    then 
      /bin/echo -e "target [$1] is a directory!"
      if [ $Platform = "linux" ] || [ $Platform = "mac" ];
      then command="$command -n"
      elif [ $Platform = "win" ];
      then command="$command -D"
      fi
    fi

    if [ $Platform = "linux" ];
    then $command $SCRIPT_DIR/$1 $2
    elif [ $Platform = "mac" ];
    then $command $SCRIPT_DIR/$1 $2
    elif [ $Platform = "win" ];
    then $command $SCRIPT_DIR/$1 $2
    fi
  fi

  /bin/echo -e "$msg"
}
#
# creates .config
makeDir ~/.config
makeDir ~/.config/nvim

# create symlinks
linkFile init.lua   ~/.config/nvim/init.lua
linkFile lua        ~/.config/nvim/lua
linkFile tmux.conf  ~/.tmux.conf
linkFile zshrc      ~/.zshrc
linkFile myzsh      ~/myzsh
linkFile gitignore  ~/.gitignore
# windows' a bit special here
if [ $Platform = "win" ];
then
  # move init-win.lua to the AppData dir
  makeDir ~/AppData/Local/nvim
  linkFile init-win.lua   ~/AppData/Local/nvim/init.lua
fi

# the right vim
git config --global core.editor $(which nvim)

