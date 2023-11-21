local Plug = vim.fn['plug#']
vim.call('plug#begin','~/.local/share/nvim')

-- Git
--  -- Plug('jreybert/vimagit')

-- LSP
Plug('neovim/nvim-lspconfig')

-- Highlights
Plug('Fymyte/rasi.vim') -- Rofi
Plug('elkowar/yuck.vim') -- Yuck

--  Git
Plug('tpope/vim-fugitive')

-- Nerdtree alt
Plug('nvim-tree/nvim-tree.lua')

-- FZF
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.x' }) -- FZF Replacement
Plug('nvim-lua/plenary.nvim') -- telescope dependency

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
Plug("hrsh7th/cmp-nvim-lsp") -- nvim language servers
Plug("hrsh7th/cmp-nvim-lua") -- lua api
Plug("hrsh7th/cmp-cmdline") -- vim commandline

-- Formatting
Plug("jose-elias-alvarez/null-ls.nvim")

-- Wiki
Plug("vimwiki/vimwiki")

-- Indent Lines
Plug("lukas-reineke/indent-blankline.nvim")
Plug("lewis6991/gitsigns.nvim")

-- Quick Fix/Location List 
Plug('ten3roberts/qf.nvim')

-- Terminal
Plug('akinsho/toggleterm.nvim', {['tag'] = '*'})

vim.call('plug#end')
