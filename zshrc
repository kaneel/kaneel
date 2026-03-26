test -e $HOME/myzsh/plug.zsh && source $HOME/myzsh/plug.zsh
test -e $HOME/myzsh/aliases.zsh && source $HOME/myzsh/aliases.zsh
test -e $HOME/myzsh/exports.zsh && source $HOME/myzsh/exports.zsh
test -e $HOME/myzsh/functions.zsh && source $HOME/myzsh/functions.zsh
test -e $HOME/myzsh/init.zsh && source $HOME/myzsh/init.zsh
test -e $HOME/myzsh/theme.zsh && source $HOME/myzsh/theme.zsh
test -e $HOME/myzsh/autosrc.zsh && source $HOME/myzsh/autosrc.zsh

# bun completions
[ -s "/Users/kaneel/.bun/_bun" ] && source "/Users/kaneel/.bun/_bun"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
