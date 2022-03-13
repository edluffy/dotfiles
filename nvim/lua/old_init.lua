local plugins = {
    {'wbthomason/packer.nvim', opt = true},

    {'folke/zen-mode.nvim', cmd = 'ZenMode'},
    {
        'ms-jpq/coq_nvim',
        config = function()
            vim.g.coq_settings = {
                auto_start = 'shut-up',
                ['display.preview.border'] = 'solid',
                ['display.pum.fast_close'] = false,
                ['display.ghost_text.enabled'] = false,
                ['clients.buffers.enabled'] = false,
                ['clients.snippets.enabled'] = false,
                ['keymap.pre_select'] = true,
            }
        end
    },

    {'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline', 'hrsh7th/nvim-cmp'},


    {'dstein64/vim-startuptime'},
    

    -- nvim-web-devicons
    -- nvim-cmp
    -- nvim-dap
    -- nvim-treesitter
    -- nvim-lspconfig
    -- telescope.nvim
    -- null-ls.nvim
    -- material.nvim
    -- coq_nvim
    -- 
    -- cmp, dap, treesitter, telescope, zen-mode, 
    -- TODO:
    -- targets.lua (splitjoin)
    -- splash.lua
    -- init.lua
    -- navbar.lua
    -- autopair
    -- gitlens
    -- use omni func but say when there is completion

    {
        'marko-cerovac/material.nvim',
        enabled = false,
            config = function()
                vim.cmd('set background=dark')
                vim.g.material_style = 'palenight'
                require('material').setup({
                    italics = {comments = true, keywords = true, functions = true},
                    disable = {eob_lines = true},
                    custom_highlights = {active = '#343b51', accent = '#A6ACCD'},
                    contrast_windows = {"netrw", "packer"},
                })
                vim.cmd('colorscheme material')
            end
    },

    --{
    --    'hrsh7th/nvim-compe',
    --    config = function()
    --        vim.o.completeopt = 'menuone,noselect'
    --        require('compe').setup{
    --            source = {
    --                path = true,
    --                buffer = true,
    --                calc = true,
    --                nvim_lsp = true,
    --                nvim_lua = true,
    --            }
    --        }
    --    end
    --},

    {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate c cpp lua python latex bash vim',
        requires = 'nvim-treesitter/nvim-treesitter-textobjects',
        config = function()
            require('nvim-treesitter.configs').setup{
                ensure_installed = 'c cpp lua python latex bash vim',
                highlight = {enable = true},
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["al"] = "@loop.outer",
                            ["il"] = "@loop.inner",
                        },
                    },
                },
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
            vim.g.bufferline.icon_custom_colors = false

        end,
    },

    --{
    --    'lewis6991/gitsigns.nvim',
    --    requires = 'nvim-lua/plenary.nvim',
    --    config = function() require('gitsigns').setup{} end,
    --},

    -- Local plugins
    --{
    --    '~/Dropbox/Projects/specs.nvim',
    --    config = function() require('specs').setup{} end,
    --},
    --
    --{
    --    '~/Dropbox/Projects/hologram',
    --    config = function() require().setup{} end,
    --},

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

            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
              local hl = "DiagnosticSign" .. type
              vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            vim.o.updatetime = 250
            vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]
        end,
    },

    {
        'williamboman/nvim-lsp-installer',
        config = require("nvim-lsp-installer").on_server_ready(function(server)
            local opts = {}

            if server.name == 'sumneko_lua' then
                opts = require('lua-dev').setup{}
            end

            if server.name == 'texlab' then
                opts = { texlab = { build = {
                    args = { "%f" },
                    executable = "tectonic",
                    onSave = true,
                }}}
            end

            server:setup(opts)
        end),
        requires = {'folke/lua-dev.nvim'}
    },

}

--[[ OPTIONS ]]--
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

vim.cmd('set formatoptions-=cro')

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 15


-- Mappings
vim.g.mapleader = " "
local function map(input, output)
    vim.api.nvim_set_keymap('n', input, output, { noremap = true, silent = true })
end

map('sl', ":TSTextobjectSwapNext @parameter.inner<cr>")
map('sh', ":TSTextobjectSwapPrevious @parameter.inner<cr>")

map('<leader>l', ":luafile %<cr>")

map('<leader><leader>',  ":Telescope<cr>")
map('<leader>f',  ":Telescope help_tags theme=get_dropdown<cr>")
map('<leader>R',  ":luafile ~/.config/nvim/lua/init.lua<cr>")
map('<leader>h',  ":Telescope help_tags theme=get_dropdown<cr>")
map('<leader>f',  ":lua require('telescope.builtin').find_files({previewer=false, theme=get_dropdown})<cr>")
map('<leader>g',  ":Telescope current_buffer_fuzzy_find<cr>")
map('<leader>G',  ":Telescope live_grep<cr>")
map('<leader>ls', ":Telescope lsp_document_symbols<cr>")
map('<leader>la', ":Telescope lsp_code_actions<cr>")
map('<leader>ld', ":Telescope lsp_document_diagnostics<cr>")
map('<leader>z',  ":ZenMode<cr>")

map('<leader>v',  ":vi ~/.config/nvim/lua/init.lua<cr>")
map('<leader>p',  ":PackerSync<cr>")

map('gd',        ":lua vim.lsp.buf.definition()<cr>")
map('K',         ":lua vim.lsp.buf.hover()<cr>")
--map('<C-k>',     ":lua vim.lsp.buf.signature_help()<cr>")
map('<space>rn', ":lua vim.lsp.buf.rename()<cr>")
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
	--use {'wbthomason/packer.nvim', opt = true}
    for _, plugin in ipairs(plugins) do
        use(plugin)
    end
end, })
