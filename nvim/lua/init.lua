local plugins = {
    {'wbthomason/packer.nvim', opt = true},
    {'folke/zen-mode.nvim'},

    {
        'marko-cerovac/material.nvim',
            config = function()
                vim.g.material_style = 'palenight'
                vim.g.material_italic_comments = true
                vim.g.material_italic_keywords = true
                vim.g.material_italic_functions = true
                vim.g.material_hide_eob = true
                vim.g.material_custom_colors = {active = '#343b51', accent = '#A6ACCD'}
                require('material').set()
            end
    },

    {
        'hrsh7th/nvim-compe',
        config = function()
            vim.o.completeopt = 'menuone,noselect'
            require('compe').setup{
                source = {
                    path = true,
                    buffer = true, 
                    calc = true,
                    nvim_lsp = true, 
                    nvim_lua = true
                }
            }
        end
    },

    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = 'nvim-treesitter/nvim-treesitter-textobjects',
        config = function()
            require('nvim-treesitter.configs').setup{
                ensure_installed = 'maintained',
                highlight = {enable = true},
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "v",
                        node_incremental = "v",
                        scope_incremental = "grc",
                        node_decremental = "V",
                    },
                },
                --textobjects = {
                --    select = {
                --        enable = true,
                --        lookahead = true,
                --        keymaps = {
                --            ["af"] = "@function.outer",
                --            ["if"] = "@function.inner",
                --            ["ac"] = "@class.outer",
                --            ["ic"] = "@class.inner",
                --            ["aa"] = "@parameter.outer",
                --            ["ia"] = "@parameter.inner",
                --            ["al"] = "@loop.outer",
                --            ["il"] = "@loop.inner",
                --        },
                --    },
                --},
            }
        end,
    },

    -- Navigation
    {
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
    },

    {
        'romgrk/barbar.nvim',
        requires = {'kyazdani42/nvim-web-devicons'},
        config = function()
            vim.g.bufferline = { animation = false, closable = false }
        end,
    },

    {
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function() require('gitsigns').setup{} end,
    },

    -- Local plugins
    --{
    --    '~/Dropbox/Projects/specs.nvim',
    --    config = function() require('specs').setup{} end,
    --},
    --
    {
        'edluffy/hologram.nvim',
        config = function() require('hologram').setup{} end,
    },

    {
        'neovim/nvim-lspconfig',
        config = function()
            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
              vim.lsp.diagnostic.on_publish_diagnostics, {
                  virtual_text = false,
                  underline = false,
                  update_in_insert = false
              }
            )

            local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
            for type, icon in pairs(signs) do
              local hl = "LspDiagnosticsSign" .. type
              vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            vim.o.updatetime = 250
            vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]

            require'lspconfig'.pyright.setup{}

            require'lspconfig'.clangd.setup{
                cmd = { "/usr/local/Cellar/llvm/11.1.0/bin/clangd", "--background-index" }
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
        end,
    },
}


--[[ OPTIONS ]]--
vim.cmd('set background=dark')
vim.o.termguicolors = true
vim.cmd[[ au TextYankPost * silent! lua vim.highlight.on_yank()]]

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
vim.g.markdown_fenced_languages = {'python', 'c', 'cpp', 'lua'}
-- set inccommand=split


-- Mappings
vim.g.mapleader = " "

local function map(input, output)
    vim.api.nvim_set_keymap('n', input, output, { noremap = true, silent = true })
end

map('sl', ":TSTextobjectSwapNext @parameter.inner<cr>")
map('sh', ":TSTextobjectSwapPrevious @parameter.inner<cr>")

map('<leader>R', ":luafile ~/.config/nvim/lua/init.lua<cr>")
map('<leader>h', ":Telescope help_tags theme=get_dropdown<cr>")
map('<leader>f', ":lua require('telescope.builtin').find_files({previewer=false, theme=get_dropdown})<cr>")
map('<leader>g', ":Telescope current_buffer_fuzzy_find<cr>")
map('<leader>G', ":Telescope live_grep<cr>")
map('<leader>ls', ":Telescope lsp_document_symbols<cr>")
map('<leader>la', ":Telescope lsp_code_actions<cr>")
map('<leader>ld', ":Telescope lsp_document_diagnostics<cr>")

--map('gD',        ":lua vim.lsp.buf.declaration()<cr>")
map('gd',        ":lua vim.lsp.buf.definition()<cr>")
map('K',         ":lua vim.lsp.buf.hover()<cr>")
--map('gi',        ":lua vim.lsp.buf.implementation()<cr>")
map('<C-k>',     ":lua vim.lsp.buf.signature_help()<cr>")
--map('<space>D',  ":lua vim.lsp.buf.type_definition()<cr>")
map('<space>rn', ":lua vim.lsp.buf.rename()<cr>")
--map('gr',        ":lua vim.lsp.buf.references()<cr>")
map('<space>e',  ":lua vim.lsp.diagnostic.show_line_diagnostics()<cr>")

map('<C-H>', '<C-W><C-H>')
map('<C-J>', '<C-W><C-J>')
map('<C-K>', '<C-W><C-K>')
map('<C-L>', '<C-W><C-L>')

map('<C-P>', ":BufferPrevious<cr>")
map('<C-N>', ":BufferNext<cr>")

map('<space>w',  ":lua hologram_test()<cr>")
map('<space>q',  ":lua require('hologram').gen_images()<cr>")

-- Auto install packer.nvim if not installed
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.api.nvim_command('packadd packer.nvim')
end

require('packer').startup({function()
    for _, plugin in ipairs(plugins) do
	    use(plugin)
    end
end, config = { display = {open_fn = require('packer.util').float}, }})
