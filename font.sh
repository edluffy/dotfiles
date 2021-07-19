if [[ "$OSTYPE" == "darwin"* ]]; then
	cd ~/Library/Fonts
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	cd ~/.local/share/fonts
else
	exit 1
fi

curl -fLo "JetBrains Mono Regular Nerd Font Complete Mono.ttf"  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete%20Mono.ttf

echo -e "$(tput bold)$(tput setaf 5)  Dotfiles: $(tput setaf 2)font.sh installed fonts\n"

