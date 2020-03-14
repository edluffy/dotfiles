source ~/dotfiles/antigen.zsh

antigen theme denysdovhan/spaceship-prompt
antigen bundle colored-man-pages
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply
antigen cleanup

alias ls='ls -a -G'
alias h='cd ~/'

export TERM=xterm-256color
