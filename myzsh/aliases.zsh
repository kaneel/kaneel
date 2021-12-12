alias ..='cd ..'
#RELOAD
alias zshr='source ~/.zshrc'
#EDIT
alias edit="atom"
#PLEASE
alias prettyplease='sudo'
alias lsa='ls -lsa'
alias lolls='ls | lolcat'
alias lollsa='ls -lsa | lolcat'
#SPECIAL
alias showhidden='defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder'
alias hidehidden='defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder'
#SSH
alias opensshdir='open ~/.ssh'
alias copypubkey='pbcopy < ~/.ssh/id_rsa.pub'
#VPS
alias vpsconnect='ssh kaneel@vps74306.ovh.net'
alias vps='echo vps74306.ovh.net'

alias weather='curl wttr.in/london'
