
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'
    use 'nvim-lua/plenary.nvim'

    use 'kyazdani42/nvim-web-devicons'
    use 'sindrets/material.nvim'

    use 'nvim-telescope/telescope.nvim'
    use 'jose-elias-alvarez/buftabline.nvim'
    use 'sindrets/diffview.nvim'

    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'nvim-treesitter/nvim-treesitter'

    use 'rcarriga/nvim-notify'

    use 'edluffy/hologram.nvim'

    --use '~/Dropbox/Projects/hologram'
    --use 'Shatur/neovim-ayu'

    if packer_bootstrap then
        require('packer').sync()
    end
end)--, config = {compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua'})

require('impatient')

vim.opt.number = true
vim.opt.colorcolumn = {80}
vim.opt.signcolumn = 'yes'
vim.opt.formatoptions:remove({'c', 'r', 'o'})
vim.opt.undofile = true
vim.opt.splitright = true
vim.opt.showmode = false
vim.cmd[[au TextYankPost * silent! lua vim.highlight.on_yank()]]

vim.opt.clipboard = 'unnamedplus'

vim.opt.list = true
vim.opt.listchars = {tab = '⎸ ', trail = '•'}
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.cmd[[au FileType c,cpp,arduino,make set noexpandtab]]

-- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 15

-- Line wrapping
vim.opt.showbreak = '↳ '
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'",
    {noremap=true, expr = true, silent = true})
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'",
    {noremap= true, expr = true, silent = true})

require('material').setup{
    italics = {comments = true, functions = true},
    disable = {eob_lines = true},
    contrast_windows = {'netrw', 'packer'},
}
require('nvim-treesitter.configs').setup{
    ensure_installed = {'c', 'cpp', 'lua', 'python', 'latex', 'bash', 'vim'},
    sync_install = true,
    highlight = {enable = true}
}

require('buftabline').setup{
    tab_format = " #{n}: #{b}#{f} #{i} ",
    hlgroups = { current = 'StatusLine', normal = 'TabLine' }
}

vim.opt.termguicolors = true
vim.g.material_style = 'palenight'

vim.opt.background = 'dark'
vim.cmd('colorscheme material')

require('hologram').setup{}

-- LSP

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        underline = false,
        update_in_insert = false
    }
)

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]


require("nvim-lsp-installer").on_server_ready(function(server)
    local opts = {}
    if server.name == 'texlab' then
        opts = { texlab = { build = {
            args = { "%f", "--synctex", "--keep-logs", "--keep-intermediates" },
            executable = "tectonic",
            onSave = true,
        }}}
    end
    server:setup(opts)
end)

-- Mappings
vim.g.mapleader = " "
local function nmap(input, output)
    vim.api.nvim_set_keymap('n', input, output, { noremap = true, silent = true })
end

nmap('<leader>l', ":luafile %<cr>")
nmap('<leader>v',  ":vi ~/.config/nvim/lua/init.lua<cr>")
nmap('<C-H>', '<C-W><C-H>')
nmap('<C-J>', '<C-W><C-J>')
nmap('<C-K>', '<C-W><C-K>')
nmap('<C-L>', '<C-W><C-L>')

nmap('<C-N>', ':BufNext<cr>')
nmap('<C-P>', ':BufPrev<cr>')
