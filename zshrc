source ~/dotfiles/antigen.zsh

antigen theme denysdovhan/spaceship-prompt
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply
antigen cleanup

color-ssh() {
	trap "tmux select-pane -P 'bg=black'" INT EXIT
        tmux select-pane -P "bg=#15161F"
    	ssh $*
}

compdef _ssh color-ssh=ssh
alias ssh=color-ssh

alias ls='ls -a -G'
alias h='cd ~/'

export TERM=xterm-256color
