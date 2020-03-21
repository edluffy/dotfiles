# Ask for administrator passowrd
sudo -v 

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
sudo ln -sf ~/dotfiles/zshrc ~/.zshrc
SYMLINKS+=('.zshrc')
sudo ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
SYMLINKS+=('.tmux.conf')
sudo ln -sf ~/dotfiles/config ~/.config
SYMLINKS+=('.config')
sudo ln -sf ~/dotfiles/gitconfig ~/.gitconfig
SYMLINKS+=('.gitconfig')

sudo ln -sf ~/dotfiles/vim ~/.vim
SYMLINKS+=('.vim')
sudo ln -sf ~/dotfiles/vimrc ~/.vimrc
SYMLINKS+=('.vimrc')

sudo ln -sf ~/dotfiles/homebrew/Brewfile ~/Brewfile
SYMLINKS+=('Brewfile')

echo ${SYMLINKS[@]}
echo -e "\n====== Symlink Setup Finished! ======"
echo "Enjoy - edluffy"
