sudo -v 

# Delete old dotfiles
sudo rm -rf ~/.config/kitty > /dev/null 2>&1
sudo rm -rf ~/.config/nvim > /dev/null 2>&1
sudo rm -rf ~/.zshrc > /dev/null 2>&1
sudo rm -rf ~/.bashrc > /dev/null 2>&1
sudo rm -rf ~/.tmux.conf > /dev/null 2>&1

SYMLINKS=()

mkdir -p ~/.config

# 'config' folder symlinks
sudo ln -sf ~/dotfiles/kitty ~/.config/kitty
SYMLINKS+=('.config/kitty')
sudo ln -sf ~/dotfiles/nvim ~/.config/nvim
SYMLINKS+=('.config/nvim')

# 'home' folder symlinks
sudo ln -sf ~/dotfiles/shell/zshrc ~/.zshrc
SYMLINKS+=('.zshrc')
sudo ln -sf ~/dotfiles/shell/bashrc ~/.bashrc
SYMLINKS+=('.bashrc')
sudo ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
SYMLINKS+=('.tmux.conf')

echo -e "$(tput bold)$(tput setaf 5)  Dotfiles: $(tput setaf 2)link.sh created ${#SYMLINKS[@]} symlinks"
tput sgr0; printf '%s\n' "${SYMLINKS[@]}"
