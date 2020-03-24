sudo -v 

# Delete old dotfiles
sudo rm -rf ~/.zshrc > /dev/null 2>&1
sudo rm -rf ~/.tmux.conf > /dev/null 2>&1
sudo rm -rf ~/.config > /dev/null 2>&1
sudo rm -rf ~/.gitconfig > /dev/null 2>&1


sudo rm -rf ~/Brewfile > /dev/null 2>&1
sudo rm -rf ~/.vim > /dev/null 2>&1
sudo rm -rf ~/.vimrc > /dev/null 2>&1

SYMLINKS=()
mkdir -p ~/.config

# 'config' folder symlinks
sudo ln -sf ~/dotfiles/nvim ~/.config/nvim
SYMLINKS+=('.config/nvim')

sudo ln -sf ~/dotfiles/kitty ~/.config/kitty
SYMLINKS+=('.config/kitty')

sudo ln -sf ~/dotfiles/git ~/.config/git
SYMLINKS+=('.config/git')

# 'home' folder symlinks
sudo ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
SYMLINKS+=('.tmux.conf')

sudo ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
SYMLINKS+=('.zshrc')

echo ${SYMLINKS[@]}
echo -e "\n====== Symlink Setup Finished! ======"
echo "Enjoy - edluffy"
