vim.opt.number = true
vim.opt.signcolumn = 'yes'
vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
vim.opt.undofile = true
vim.opt.splitright = true
vim.opt.showmode = false
vim.cmd [[au TextYankPost * silent! lua vim.highlight.on_yank()]]
vim.opt.clipboard = 'unnamedplus'

vim.opt.list = true
vim.opt.listchars = { tab = '⎸ ', trail = '•' }
vim.opt.fillchars = vim.opt.fillchars + 'diff:/'
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.cmd [[au FileType c,cpp,arduino,make set noexpandtab]]


--vim.o.laststatus = 0
--vim.o.cmdheight = 0
vim.o.termguicolors = true
vim.cmd [[set mouse=nvi]]

vim.opt.showbreak = '↪ '
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'",
    { noremap = true, expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'",
    { noremap = true, expr = true, silent = true })

-- Vertical help
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'help',
    command = ":wincmd L | :vert resize 90",
})

-- Mappings
vim.g.mapleader = " "
local function nmap(input, output)
    vim.api.nvim_set_keymap('n', input, output, { noremap = true, silent = true })
end

nmap('<leader><leader>', ":Telescope<cr>")
nmap('<leader>e', ":lua vim.diagnostic.open_float()<cr>")
nmap('<leader>v', ":vi ~/.config/nvim/lua/init.lua<cr>")
nmap('<leader>l', ":LspZeroFormat<cr>")
nmap('<C-H>', '<C-W><C-H>')
nmap('<C-J>', '<C-W><C-J>')
nmap('<C-K>', '<C-W><C-K>')
nmap('<C-L>', '<C-W><C-L>')

nmap('<C-N>', ':tabn<cr>')
nmap('<C-P>', ':tabp<cr>')

local plugins = require('plugins')

require('mason').setup {}
require('hologram').setup { auto_display = true }

require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'cpp', 'lua', 'python', 'latex', 'bash', 'vim' },
    sync_install = true,
    highlight = { enable = true },
    indent = { enable = true },
}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

require'lspconfig'.clangd.setup{}

require('lspconfig').sumneko_lua.setup({
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

--vim.diagnostic.config({
--  virtual_text = false,
--})
--vim.o.updatetime = 1000
--vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

require('telescope').setup {
    defaults = {
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
    },
    pickers = {
        help_tags = {
            theme = "dropdown",
            previewer = false,
        }
    }
}

require("tokyonight").setup({
    style = "night",
    styles = {
        sidebars = "dark",
        floats = "dark",
    },
    sidebars = { "netrw", "help", "packer"},
})

vim.cmd('colorscheme tokyonight')

-- $VIMRUNTIME/autoload/netrw.vim, treedepthstring
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = -25
--vim.g.netrw_cursor = 0

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'netrw',
    command = ":noremap <buffer> <C-L> <C-W><C-L>",
})

vim.api.nvim_create_autocmd('VimEnter', {
    pattern = '*',
    callback = function(au)
        vim.cmd(":Lexplore")
        vim.cmd("wincmd w")
        if au.file == "" then
            require('splash').open()
            vim.cmd("wincmd w")
        end
    end,
})
