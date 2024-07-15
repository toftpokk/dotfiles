return {
  -- Git
  'tpope/vim-fugitive',
  'sindrets/diffview.nvim',

  -- LSP
  'neovim/nvim-lspconfig',
  
  -- Highlights
  'Fymyte/rasi.vim',  -- Rofi
  'elkowar/yuck.vim',  -- Yuck

  -- Tree
  'nvim-tree/nvim-tree.lua',

  -- FZF
  {'nvim-telescope/telescope.nvim', tag = '0.1.8'}, -- FZF Replacement
  'nvim-lua/plenary.nvim',

  -- Snippets
  {'L3MON4D3/LuaSnip', version = 'v2.*'},
  'rafamadriz/friendly-snippets', -- a bunch of snippets to use

  -- Tree-sitter syntax
  'nvim-treesitter/nvim-treesitter',

  -- Comment
  'tpope/vim-commentary',

  -- Completions
  'hrsh7th/nvim-cmp', -- The completion plugin
  'hrsh7th/cmp-buffer', -- buffer completions
  'hrsh7th/cmp-path', -- path completions
  'saadparwaiz1/cmp_luasnip', -- snippet completions
  'hrsh7th/cmp-nvim-lsp', -- nvim language servers
  'hrsh7th/cmp-nvim-lua', -- lua api
  'hrsh7th/cmp-cmdline', -- vim commandline

  -- Formatting
  'jose-elias-alvarez/null-ls.nvim',

  -- Wiki
  'vimwiki/vimwiki',

  -- Indent Lines
  'lukas-reineke/indent-blankline.nvim',
  'lewis6991/gitsigns.nvim',

  -- Quick Fix/Location List 
  'ten3roberts/qf.nvim',

  -- Terminal
  {'akinsho/toggleterm.nvim', version = '*'},
}
