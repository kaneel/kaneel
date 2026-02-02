alias ..='cd ..'

#RELOAD
alias zshr='source ~/.zshrc'
alias weather='curl wttr.in/london'
alias gsync='gclient sync'
alias gsclean='gclient sync -D -j16'
alias gnargs='python3 tools/mb/mb.py gen -c ray_mac_release out/Default'
alias compilecommand='tools/clang/scripts/generate_compdb.py -p out/Default > compile_commands.json'
alias generateflags='vpython3 tools/metrics/histograms/generate_flag_enums.py --feature $1'
