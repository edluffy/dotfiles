# dotfiles
🍙 My dev environment + custom setup scripts for macOS - nvim, zsh, tmux, alacritty, homebrew.

<p float="left">
  <img src="/screenshots/s1.png?raw=True" width="60%" />
  <img src="/screenshots/s2.png?raw=True" width="39%" /> 
</p>

## Neovim
Switched to full lua Neovim 0.5 only config, vi is aliased to nvim.
Using [packer.nvim](https://github.com/wbthomason/packer.nvim) as plugin manager.

### [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
Awesome fuzzy finder with live preview. Has builtin support for Files, Git, LSP and Treesitter sources.
### [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
Switched away from coc.nvim to Neovim's lightweight built-in language server client. Plugin provides common LSP configurations.
- Using [nvim-compe](https://github.com/hrsh7th/nvim-compe) for autocomplete popups

## Zsh
Using [antigen](https://github.com/zsh-users/antigen) as plugin manager.

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-colored-man-pages](https://github.com/ael-code/zsh-colored-man-pages)
- [spaceship-prompt](https://github.com/denysdovhan/spaceship-prompt)

## Tmux
- [tmux-cpu](https://github.com/tmux-plugins/tmux-cpu)
- [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect)


## Emacs
