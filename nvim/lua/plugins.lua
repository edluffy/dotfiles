vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
    vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup { function(use)
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'kyazdani42/nvim-web-devicons'

    -- Core
    use 'neovim/nvim-lspconfig'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-telescope/telescope.nvim'
    use 'williamboman/mason.nvim'
    --use 'jose-elias-alvarez/null-ls.nvim'

    -- Navigation
    --use { 'akinsho/bufferline.nvim', tag = "v2.*"}
    --use 'kyazdani42/nvim-tree.lua'

    -- UI
    --use '~/Dropbox/Projects/specs.nvim'
    --use '~/Dropbox/Projects/hologram'

    use 'folke/tokyonight.nvim'
    use 'lewis6991/satellite.nvim'

    if packer_bootstrap then
        require('packer').sync()
    end
end
}
