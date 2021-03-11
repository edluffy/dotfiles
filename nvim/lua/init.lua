local M = {}

-- Auto install packer.nvim
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.cmd('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end
vim.cmd [[packadd packer.nvim]]

--------------- Plugins ---------------
require('packer').startup(function()
    use {'wbthomason/packer.nvim', opt = true}
    use {'kaicataldo/material.vim', branch = 'main'}
    use {'tjdevries/nlua.nvim'}
    use {'neovim/nvim-lspconfig'}
    use {'hrsh7th/nvim-compe'}
    use {'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
end)

--------------- Aesthetics ---------------
vim.g.material_theme_style = 'palenight'
vim.g.material_terminal_italics = true
vim.o.termguicolors = true
vim.cmd('colorscheme material')
-- vim.cmd('highlight EndOfBuffer guifg=bg')

-------------- Options ---------------
vim.bo.expandtab = true
vim.bo.tabstop = 4
vim.bo.shiftwidth = 0 -- auto indent by tabstop
vim.bo.undofile = true
vim.wo.signcolumn = "yes" -- always show signcolumn
vim.wo.number = true
vim.o.showmode = false
vim.o.clipboard = "unnamedplus"
vim.o.splitright = true
vim.g.vimsyn_embed = 'l'

--------------- LSP + Completion ---------------
require'lspconfig'.pyright.setup{}
require'lspconfig'.clangd.setup{
	cmd = { "/usr/local/Cellar/llvm/10.0.1/bin/clangd", "--background-index" }
}
require('nlua.lsp.nvim').setup(require('lspconfig'), {
    on_attach = custom_nvim_lspconfig_attach,
})

require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
        path = true;
        buffer = true;
        calc = true;
        vsnip = true;
        nvim_lsp = true;
        nvim_lua = true;
        spell = true;
        tags = true;
        snippets_nvim = true;
        treesitter = true;
    };
}

--------------- Mappings ---------------
vim.g.mapleader = " "

function M.map(input, output)
    vim.api.nvim_set_keymap('n', input, output, { noremap = true, silent = true })
end

M.map('<leader>r', ":luafile ~/.config/nvim/lua/init.lua<cr>")
M.map('<leader>f', ":Telescope find_files<cr>")
M.map('<leader>g', ":Telescope current_buffer_fuzzy_find<cr>")
M.map('<leader>G', ":Telescope live_grep<cr>")
M.map('<leader>ls', ":Telescope lsp_document_symbols<cr>")
M.map('<leader>la', ":Telescope lsp_code_actions<cr>")
M.map('<leader>ld', ":Telescope lsp_document_diagnostics<cr>")

M.map('<C-H>', '<C-W><C-H>')
M.map('<C-J>', '<C-W><C-J>')
M.map('<C-K>', '<C-W><C-K>')
M.map('<C-L>', '<C-W><C-L>')

return M
