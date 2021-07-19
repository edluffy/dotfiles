--[[ PLUGINS ]]--
vim.cmd [[packadd packer.nvim]]

-- Auto install packer.nvim if not installed
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd('packadd packer.nvim')
end

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'
require('packer').startup(function()
    use {'wbthomason/packer.nvim', opt = true}

    -- Theming
    use {'marko-cerovac/material.nvim'}
    use {'folke/zen-mode.nvim'}

    -- LSP
    use {'neovim/nvim-lspconfig'}
    use {'hrsh7th/nvim-compe'}
    use {'ray-x/lsp_signature.nvim'}

    -- TS
    use {'nvim-treesitter/nvim-treesitter'}
    use {'nvim-treesitter/nvim-treesitter-textobjects'}

    -- Navigation
    use {'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/popup.nvim', 
                    'nvim-lua/plenary.nvim'}}

    use {'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim'}

    -- Local plugins
    --use {'~/Dropbox/Projects/specs.nvim'}
    use {'edluffy/hologram.nvim'}
    --use {'~/hologram'}
end)

vim.g.markdown_fenced_languages = {'python', 'c', 'cpp', 'lua'}

--[[ OPTIONS ]]--
vim.cmd('set background=dark')
vim.o.termguicolors = true
vim.cmd[[ au TextYankPost * silent! lua vim.highlight.on_yank()]]

vim.g.material_style = 'palenight'
vim.g.material_italic_comments = true
vim.g.material_italic_keywords = true
vim.g.material_italic_functions = true
require('material').set()

vim.cmd('highlight EndOfBuffer guifg=bg') -- hide tildes

vim.cmd('set noshowcmd')
vim.cmd('set tabstop=4')
vim.cmd('set shiftwidth=0')
vim.cmd('set expandtab')

vim.bo.expandtab = true
vim.bo.undofile = true
vim.wo.signcolumn = "yes" -- always show signcolumn
vim.wo.number = true
vim.o.showmode = false
vim.o.clipboard = "unnamedplus"
vim.o.splitright = true
vim.g.vimsyn_embed = 'l'
-- set inccommand=split


-- TS
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
}

require'nvim-treesitter.configs'.setup{
  textobjects = {
    swap = {
      enable = true,
      swap_next = {
        ["sa"] = "@parameter.inner",
      },
      swap_previous = {
        ["sA"] = "@parameter.inner",
      },
    },
  },
}


-- LSP
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      underline = false,
      update_in_insert = false
  }
)
vim.fn.sign_define("LspDiagnosticsSignError",
                   {texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError"})
vim.fn.sign_define("LspDiagnosticsSignWarning",
                   {texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation",
                   {texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint",
                   {texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint"})

require'lspconfig'.pyright.setup{
    on_attach = function(client, bufnr)
        require'lsp_signature'.on_attach({ floating_window = false, })
    end,
}

require'lspconfig'.texlab.setup{
    settings = {
        latex = {
            build = {
                args = { "%f", "--synctex", "--keep-logs", "--keep-intermediates", },
                executable = "tectonic",
                onSave = true
            },
        },
    },
}
require'lspconfig'.clangd.setup{
    cmd = { "/usr/local/Cellar/llvm/11.1.0/bin/clangd", "--background-index" }
}

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

require('gitsigns').setup{}

-- Local Plugins
require('hologram').setup{}
--require('specs').setup{}

-- Mappings
vim.g.mapleader = " "

local function map(input, output)
    vim.api.nvim_set_keymap('n', input, output, { noremap = true, silent = true })
end

map('<leader>R', ":luafile ~/.config/nvim/lua/init.lua<cr>")
map('<leader>h', ":Telescope help_tags<cr>")
map('<leader>f', ":Telescope find_files<cr>")
map('<leader>g', ":Telescope current_buffer_fuzzy_find<cr>")
map('<leader>G', ":Telescope live_grep<cr>")
map('<leader>ls', ":Telescope lsp_document_symbols<cr>")
map('<leader>la', ":Telescope lsp_code_actions<cr>")
map('<leader>ld', ":Telescope lsp_document_diagnostics<cr>")

map('gD',        ":lua vim.lsp.buf.declaration()<cr>")
map('gd',        ":lua vim.lsp.buf.definition()<cr>")
map('K',         ":lua vim.lsp.buf.hover()<cr>")
map('gi',        ":lua vim.lsp.buf.implementation()<cr>")
map('<C-k>',     ":lua vim.lsp.buf.signature_help()<cr>")
map('<space>D',  ":lua vim.lsp.buf.type_definition()<cr>")
map('<space>rn', ":lua vim.lsp.buf.rename()<cr>")
map('gr',        ":lua vim.lsp.buf.references()<cr>")
map('<space>e',  ":lua vim.lsp.diagnostic.show_line_diagnostics()<cr>")

map('<C-H>', '<C-W><C-H>')
map('<C-J>', '<C-W><C-J>')
map('<C-K>', '<C-W><C-K>')
map('<C-L>', '<C-W><C-L>')

map('<space>r',  ":lua require('keymaps').reload_lua_package()<cr>")

map('<space>w',  ":lua hologram_test()<cr>")
map('<space>q',  ":lua require('hologram').gen_images()<cr>")
