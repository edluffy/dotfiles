vim.cmd('packadd packer.nvim')

return require('packer').startup(function(use)
    use {'wbthomason/packer.nvim'}
    use {'nvim-lua/plenary.nvim'}

    use {'ms-jpq/coq_nvim'}
    use {'neovim/nvim-lspconfig'}
    use {'williamboman/nvim-lsp-installer'}
    use {'nvim-treesitter/nvim-treesitter'}
    use {'nvim-telescope/telescope.nvim'}
    use {'kyazdani42/nvim-web-devicons'}
    use {'marko-cerovac/material.nvim'}

    --use {'folke/zen-mode.nvim', cmd = 'ZenMode'}
    --use {'edluffy/hologram.nvim', cmd = '...'}
    use {'folke/lua-dev.nvim'}
end)
