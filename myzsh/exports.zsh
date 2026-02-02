export LC_ALL="en_US.UTF-8"

export EDITOR="nvim"
export VISUAL="nvim"

export TERM=screen-256color

BASE16_SHELL_PATH="$HOME/.config/base16-shell"

[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL_PATH/profile_helper.sh" ] && \
    source "$BASE16_SHELL_PATH/profile_helper.sh"

# Ruby install needed exports
# export optflags="-Wno-error=implicit-function-declaration"
# export LDFLAGS="-L/opt/homebrew/opt/libffi/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/libffi/include"
# export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"
#

source $HOME/.heim/heim/env

export PYENV_ROOT="$HOME/.pyenv"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# export HEIM_HOME="$HOME/rayspace/heim"
export BUN_INSTALL="$HOME/.bun"

# reclient stuff for ray
export NINJA_STATUS='[%r processes, %f/%t @ %c/s (%o): %es] '
export GO_PATH="$HOME/code"
export GOROOT=""
export O_PATH=$PATH:/Library/PostgreSQL/16/bin:$BUN_INSTALL/bin:$GO_PATH/bin:/Users/kaneel/.lmstudio/bin:i
export PATH=$O_PATH
