source ~/dotfiles/antigen.zsh

antigen theme denysdovhan/spaceship-prompt
antigen bundle colored-man-pages
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply
antigen cleanup

color-ssh(){
	trap "printf '\x1b]11;#292D3E\x1b\\'" INT EXIT
		printf '\x1b]11;#15161F\x1b\\'
	ssh $*
}

compdef _ssh color-ssh=ssh
alias ssh=color-ssh

alias ls='ls -a -G'
alias h='cd ~/'

export TERM=xterm-256color
