sudo -v 

# Delete old dotfiles
sudo rm -rf ~/.config > /dev/null 2>&1
sudo rm -rf ~/.zshrc > /dev/null 2>&1
sudo rm -rf ~/.vim > /dev/null 2>&1

SYMLINKS=()
# 'config' folder symlinks
mkdir -p ~/.config

sudo ln -sf ~/dotfiles/kitty ~/.config/kitty
SYMLINKS+=('.config/kitty')
sudo ln -sf ~/dotfiles/git ~/.config/git
SYMLINKS+=('.config/git')

# 'home' folder symlinks
sudo ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
SYMLINKS+=('.zshrc')
sudo ln -sf ~/dotfiles/vim ~/.vim
SYMLINKS+=('.vim')

echo ${SYMLINKS[@]}
echo -e "\n====== Symlink Setup Finished! ======"
echo "Enjoy - edluffy"
