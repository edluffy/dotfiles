if [[ "$TERM" = "screen"* ]] && [[ -n "$TMUX" ]]; then
	if [ "$1" == "pi" ]; then
		tmux select-pane -P 'bg=#331C1F'
	else
		tmux select-pane -P 'bg=#282c34'
	fi;
else
	if [ "$1" == "pi" ]; then
		printf '\033]11;#331C1F\007'
	else
		printf '\033]11;#282c34\007'
	fi
fi
