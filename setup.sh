# Ask for administrator passowrd
sudo -v 

# Install homebrew if not already
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew doctor
brew update

# Delete old dotfiles
sudo rm -rf ~/.zshrc > /dev/null 2>&1
sudo rm -rf ~/.tmux.conf > /dev/null 2>&1
sudo rm -rf ~/.config > /dev/null 2>&1
sudo rm -rf ~/.gitconfig > /dev/null 2>&1

sudo rm -rf ~/.vim > /dev/null 2>&1
sudo rm -rf ~/.vimrc > /dev/null 2>&1

sudo rm -rf ~/Brewfile > /dev/null 2>&1

# Create symlinks in home folder
SYMLINKS=()
ln -sf ~/dotfiles/zshrc ~/.zshrc
SYMLINKS+=('.zshrc')
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
SYMLINKS+=('.tmux.conf')
ln -sf ~/dotfiles/config ~/.config
SYMLINKS+=('.config')
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
SYMLINKS+=('.gitconfig')

ln -sf ~/dotfiles/vim ~/.vim
SYMLINKS+=('.vim')
ln -sf ~/dotfiles/vimrc ~/.vimrc
SYMLINKS+=('.vimrc')

ln -sf ~/dotfiles/homebrew/Brewfile ~/Brewfile
SYMLINKS+=('Brewfile')

echo ${SYMLINKS[@]}

cd ~
#brew remove --force $(brew list) # optional purge

# taps
brew tap "homebrew/bundle"
brew tap "homebrew/cask"
brew tap "osx-cross/avr"

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

echo -e "\n====== Install Finished! ======\n"
echo
echo "Enjoy - edluffy"
