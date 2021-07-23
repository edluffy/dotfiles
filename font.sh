if [[ "$OSTYPE" == "darwin"* ]]; then
	cd ~/Library/Fonts
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	cd ~/.local/share/fonts
else
	exit 1
fi

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"

echo -e "$(tput bold)$(tput setaf 5)  Dotfiles: $(tput setaf 2)font.sh installed fonts\n"

