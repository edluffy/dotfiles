[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fpath=( "$HOME/.zsh" $fpath )

alias pi='tmux select-pane -P "bg=#15161F" && ssh pi@10.14.185.236 && tmux select-pane -P "bg=black"'
alias greytmx='tmux select-pane -P "bg=#15161F"'
alias blacktmx='tmux select-pane -P "bg=black"'
alias ls='ls -a -G'
alias h='cd ~/'

autoload -U promptinit; promptinit
autoload -Uz compinit; compinit
prompt lambda-pure

export TERM=xterm-256color
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
