# Ask for administrator passowrd
sudo -v 

# Install homebrew if not already
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew doctor
brew update


cd ~
#brew remove --force $(brew list) # optional purge

tools=(
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

# Install all tools
echo -e "\n====== Searching for uninstalled cross-platform tools... ======\n"
brew list "${tools[@]}" &>/dev/null || brew install "${tools[@]}"

# Install correct apps
if [ "$(uname)" == "Darwin" ]; then
	echo -e "\n====== Searching for uninstalled Mac apps... ======"
	brew cask list "${macapps[@]}" &>/dev/null || brew cask install "${macapps[@]}"
fi

# taps
brew tap "homebrew/bundle"
brew tap "homebrew/cask"
brew tap "osx-cross/avr"

echo -e "\n====== Symlink Setup Finished! ======\n"
echo
echo "Enjoy - edluffy"
