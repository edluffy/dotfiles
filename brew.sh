if [[ "$OSTYPE" == "darwin"* ]]; then
	sudo -v 

	if [[ $1 == "--purge" ]]; then
		brew remove --force $(brew list)
		brew cask remove --force $(brew cask list)
		exit 1
	fi

	if [[ $1 == "--lsdeps" ]]; then
		echo -e "$(tput bold)$(tput setaf 5)  Dotfiles: $(tput setaf 2)brew.sh listing package dependencies.\n"
		brew list -1 | while read cask; do echo -ne "\x1B[1;34m $cask \x1B[0m"; brew uses $cask --installed | awk '{printf(" %s ", $0)}'; echo ""; done
		exit 1
	fi

	echo -e "$(tput bold)$(tput setaf 5)  Dotfiles: $(tput setaf 2)brew.sh starting package install for darwin.\n"
	if test ! $(which brew); then
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	brew doctor
	brew update
	brew bundle --no-lock --file=packages/Brewfile
	brew bundle --force cleanup --file=packages/Brewfile
fi

echo -e "$(tput bold)$(tput setaf 5)  Dotfiles: $(tput setaf 2)brew.sh finished installing packages.\n"
