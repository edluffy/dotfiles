if [[ "$OSTYPE" == "darwin"* ]]; then
	cd ~/Library/Fonts
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	cd ~/.local/share/fonts
else
	exit 1
fi

curl -fLo "Roboto Mono Light Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Light/complete/Roboto%20Mono%20Light%20Nerd%20Font%20Complete.ttf
curl -fLo "Roboto Mono Light Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Light-Italic/complete/Roboto%20Mono%20Light%20Italic%20Nerd%20Font%20Complete.ttf
curl -fLo "Roboto Mono Bold Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Bold/complete/Roboto%20Mono%20Bold%20Nerd%20Font%20Complete.ttf
curl -fLo "Roboto Mono Bold Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Bold-Italic/complete/Roboto%20Mono%20Bold%20Italic%20Nerd%20Font%20Complete.ttf

echo -e "$(tput bold)$(tput setaf 5)  Dotfiles: $(tput setaf 2)font.sh installed fonts\n"
