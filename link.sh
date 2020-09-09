sudo -v 

# Delete old dotfiles
sudo rm -rf ~/.config/alacritty > /dev/null 2>&1
sudo rm -rf ~/.config/nvim > /dev/null 2>&1
sudo rm -rf ~/.zshrc > /dev/null 2>&1
sudo rm -rf ~/.vim > /dev/null 2>&1
sudo rm -rf ~/.tmux.conf > /dev/null 2>&1

SYMLINKS=()

mkdir -p ~/.config
mkdir -p ~/.config/nvim

# 'config' folder symlinks
sudo ln -sf ~/dotfiles/alacritty ~/.config/alacritty
SYMLINKS+=('.config/alacritty')
sudo ln -sf ~/dotfiles/vim/init.vim ~/.config/nvim/init.vim
SYMLINKS+=('.config/nvim/init.vim')

# 'home' folder symlinks
sudo ln -sf ~/dotfiles/zsh/zshrc ~/.zshrc
SYMLINKS+=('.zshrc')
sudo ln -sf ~/dotfiles/vim ~/.vim
SYMLINKS+=('.vim')
sudo ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
SYMLINKS+=('.tmux.conf')

echo -e "$(tput bold)$(tput setaf 5)  Dotfiles: $(tput setaf 2)link.sh created ${#SYMLINKS[@]} symlinks"
tput sgr0; printf '%s\n' "${SYMLINKS[@]}"
