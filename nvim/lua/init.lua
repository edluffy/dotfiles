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


vim.o.laststatus = 0
--vim.o.cmdheight = 0
vim.o.termguicolors = true
vim.g.material_style = 'palenight'
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
nmap('<leader>v', ":vi ~/.config/nvim/init.lua<cr>")
nmap('<leader>l', ":LspZeroFormat<cr>")
nmap('<C-H>', '<C-W><C-H>')
nmap('<C-J>', '<C-W><C-J>')
nmap('<C-K>', '<C-W><C-K>')
nmap('<C-L>', '<C-W><C-L>')

nmap('<C-N>', ':BufferLineCycleNext<cr>')
nmap('<C-P>', ':BufferLineCyclePrev<cr>')

vim.cmd [[nmap n nzz]]
vim.cmd [[nmap N Nzz]]

local plugins = require('plugins')

require('mason').setup {}
require('scrollbar').setup {}
require('neoscroll').setup {}
require('hologram').setup { auto_display = false }
vim.g.coq_settings = { auto_start = 'shut-up' }


require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'cpp', 'lua', 'python', 'latex', 'bash', 'vim' },
    sync_install = true,
    highlight = { enable = true },
    indent = { enable = true },
}

require('bufferline').setup {
    options = {
        separator_style = 'thin',
        color_icons = true,
        offsets = {
            {
                filetype = "NvimTree",
                text = "",
                highlight = "NvimTreeNormal",
            },
        },
    }
}

require('specs').setup {
    popup = {
        width = 10,
        winhl = 'Cursor',
        fader = require('specs').exp_fader,
        resizer = require('specs').shrink_resizer,
    }
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

require('nvim-tree').setup {
    open_on_setup = true,
    open_on_setup_file = true,
    sync_root_with_cwd = true,
    view = {
        adaptive_size = true,
        side = "left",
        width = 25,
        hide_root_folder = true,
    },
    git = {
        enable = false,
        ignore = true,
    },
}
-- Auto open nvim-tree
vim.api.nvim_create_autocmd('BufEnter', {
    command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
    nested = true,
})

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

local colors = require('material.colors')
require('material').setup {
    lualine_style = 'stealth',
    disable = {
        eob_lines = true,
        colored_cursor = false,
    },
    italics = {
        comments = true,
        keywords = true,
    },
    contrast = {
        sidebars = true,
        floating_windows = true,
    }, contrast_filetypes = {
        'packer', 'help'
    },
    custom_highlights = {
        TSAnnotation                = { fg = colors.red },
        TSConstructor               = { fg = colors.purple },
        TSConstBuiltin              = { fg = colors.red },
        TSConstMacro                = { fg = colors.red },
        TSFloat                     = { fg = colors.red },
        TSStringEscape              = { fg = colors.disabled },
        TSKeywordFunction           = { fg = colors.purple },
        TSFuncBuiltin               = { fg = colors.cyan },
        TSVariable                  = { fg = '#717CB4' },
        TSVariableBuiltin           = { fg = '#717CB4' },
        TSField                     = { fg = '#717CB4' },
        TSText                      = { fg = '#717CB4' },
        TelescopeBorder             = { fg = colors.contrast, bg = colors.contrast },
        TelescopePromptBorder       = { fg = colors.active, bg = colors.active },
        TelescopePromptNormal       = { fg = colors.fg, bg = colors.active },
        TelescopePromptPrefix       = { fg = colors.purple, bg = colors.active },
        TelescopeNormal             = { fg = colors.fg, bg = colors.contrast },
        TelescopePreviewTitle       = { fg = colors.black, bg = colors.green },
        TelescopePreviewBorder      = { fg = colors.contrast, bg = colors.contrast },
        TelescopePromptTitle        = { fg = colors.black, bg = colors.orange },
        TelescopeResultTitle        = { fg = colors.accent, bg = colors.active },
        TelescopeSelection          = { bg = colors.active },
        TelescopeSelectionCaret     = { fg = colors.purple },
        TelescopeResultsBorder      = { fg = colors.contrast, bg = colors.contrast },
        TelescopeMatching           = { fg = colors.cyan },
        NvimTreeWinSeparator        = { fg = colors.bg },
        NvimTreeEndOfBuffer         = { fg = colors.bg_alt },
        BufferLineFill              = { bg = colors.contrast },
        BufferLineIndicatorSelected = { fg = colors.disabled },
        Cursor                      = { bg = '#8FEE96' },
    }
}
vim.cmd('colorscheme material')
