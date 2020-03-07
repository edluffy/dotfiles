# Ask for administrator passowrd
sudo -v 

mactools=(
	# shell tools
	zsh
	tmux
	git
	wget
	python

	zsh-autosuggestions
	zsh-syntax-highlighting
	fzf
	tree

	# embedded / C tools
	gcc
	avr-gcc
	avrdude
	macvim
	platformio

	# fun!
	sl
)

macapps=(
	# misc apps
	kitty
	google-chrome
	spotify
	transmission
	visual-studio-code
	balenaetcher
	ltspice
	mactex
)

linuxtools=(
	# shell tools
	zsh
	tmux
	git
	wget
	python

	zsh-autosuggestions
	zsh-syntax-highlighting
	fzf
	tree

	# embedded / C tools
	gcc
	vim-gui-common

	# fun!
	sl
)

linuxapps=(
	# nothing yet
)

################### MAC SETUP ####################
if [ "$(uname)" == "Darwin" ]; then

	# Install homebrew if not already
	if test ! $(which brew); then
	  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	#brew remove --force $(brew list) # optional purge
	brew doctor
	brew update

	# taps
	brew tap "homebrew/bundle"
	brew tap "homebrew/cask"
	brew tap "osx-cross/avr"

	cd ~

	echo -e "\n====== Searching for uninstalled Mac tools... ======\n"
	brew list "${mactools[@]}" &>/dev/null || brew install "${mactools[@]}"

	echo -e "\n====== Searching for uninstalled Mac apps... ======"
	brew cask list "${macapps[@]}" &>/dev/null || brew cask install "${macapps[@]}"
fi

################### LINUX SETUP ####################

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then

	sudo apt-get update
	sudo apt-get upgrade

	echo -e "\n====== Searching for uninstalled Linux tools... ======\n"
	sudo apt-get ${linuxtools[@]}
fi

echo -e "\n====== Symlink Setup Finished! ======\n"
echo
echo "Enjoy - edluffy"
