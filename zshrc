#[ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


alias pi='tmux select-pane -P "bg=#15161F" && ssh pi@10.14.187.104 && tmux select-pane -P "bg=black"'
alias ls='ls -a -G'
alias h='cd ~/'

autoload -Uz compinit
compinit

# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

export TERM=xterm-256color
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
