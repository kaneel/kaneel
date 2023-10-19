export ZPLUG_HOME=~/.zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
zplug "iam4x/zsh-iterm-touchbar"
zplug "mafredri/zsh-async", from:github
zplug "bobsoppe/zsh-ssh-agent", use:ssh-agent.zsh, from:github
zplug "chriskempson/base16-shell", use:"scripts/base16-ashes.sh", defer:0
zplug "lukechilds/zsh-better-npm-completion", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:2 # Should be loaded 2nd last.
zplug "zsh-users/zsh-history-substring-search", defer:3 # Should be loaded last.

if ! zplug check; then
    zplug install
fi

zplug load
