local Plug = vim.fn['plug#']
vim.call('plug#begin','~/.local/share/nvim')
--  Plug('chriskempson/base16-vim')
--  Plug('neoclide/coc.nvim' , {branch = 'release'})
--  Plug('nvim-lua/completion-nvim')
--  -- Plug('goldfeld/vim-seek')
--  -- Plug('dense-analysis/ale')
--  Plug('neovim/nvim-lspconfig')
--  Plug('preservim/nerdtree')
--  Plug('elkowar/yuck.vim')
--  -- Plug('jreybert/vimagit')
--  -- Plug('nvim-lua/completion-nvim')
--  Plug('Fymyte/rasi.vim')

Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.x' })
--  Git
Plug('tpope/vim-fugitive')
-- Nerdtree alt
Plug('nvim-tree/nvim-tree.lua')

-- FZF
Plug('junegunn/fzf', {['do'] = vim.fn['fzf#install()']})
Plug('junegunn/fzf.vim')

-- Snippets
Plug("L3MON4D3/LuaSnip",{['tag'] = 'v<CurrentMajor>.*'})
Plug("rafamadriz/friendly-snippets") -- a bunch of snippets to use

-- Tree-sitter syntax
Plug('nvim-treesitter/nvim-treesitter',{['do'] = function() return vim.cmd(':TSUpdate') end})

-- Comment
Plug('tpope/vim-commentary')

-- Completions
Plug("hrsh7th/nvim-cmp") -- The completion plugin
Plug("hrsh7th/cmp-buffer") -- buffer completions
Plug("hrsh7th/cmp-path") -- path completions
Plug("saadparwaiz1/cmp_luasnip") -- snippet completions
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-nvim-lua")
-- Formatting
Plug("jose-elias-alvarez/null-ls.nvim")

vim.call('plug#end')
