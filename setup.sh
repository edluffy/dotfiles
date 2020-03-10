# Ask for administrator passowrd
sudo -v 

# Delete old dotfiles
sudo rm -rf ~/.zshrc > /dev/null 2>&1
sudo rm -rf ~/.zfunctions > /dev/null 2>&1
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
ln -sf ~/dotfiles/zfunctions ~/.zfunctions
SYMLINKS+=('.zfunctions')
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

ln -s "~dotfiles/lambda-pure.zsh" /usr/local/share/zsh/site-functions/prompt_lambda-pure_setup
ln -s "~dotfiles/async.zsh" /usr/local/share/zsh/site-functions/async

vim +PlugInstall +PlugClean +qall

echo ${SYMLINKS[@]}
echo -e "\n====== Symlink Setup Finished! ======"
echo "Enjoy - edluffy"
