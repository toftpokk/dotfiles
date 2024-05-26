local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Packer itself
  use 'wbthomason/packer.nvim'

  -- Git
  use 'tpope/vim-fugitive'
  use 'sindrets/diffview.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'

  -- Highlights
  use 'Fymyte/rasi.vim'  -- Rofi
  use 'elkowar/yuck.vim'  -- Yuck

  -- Nerdtree alt
  use 'nvim-tree/nvim-tree.lua'

  -- FZF
  use 'junegunn/fzf.vim'
  use {'nvim-telescope/telescope.nvim', tag = '0.1.x'} -- FZF Replacement
  use 'nvim-lua/plenary.nvim' -- telescope dependency

  -- Snippets
  use {'L3MON4D3/LuaSnip', tag = 'v<CurrentMajor>.*'}
  use 'rafamadriz/friendly-snippets' -- a bunch of snippets to use

  -- Tree-sitter syntax
  use {'nvim-treesitter/nvim-treesitter'}

  -- Comment
  use 'tpope/vim-commentary'

  -- Completions
  use 'hrsh7th/nvim-cmp' -- The completion plugin
  use 'hrsh7th/cmp-buffer' -- buffer completions
  use 'hrsh7th/cmp-path' -- path completions
  use 'saadparwaiz1/cmp_luasnip' -- snippet completions
  use 'hrsh7th/cmp-nvim-lsp' -- nvim language servers
  use 'hrsh7th/cmp-nvim-lua' -- lua api
  use 'hrsh7th/cmp-cmdline' -- vim commandline

  -- Formatting
  use 'jose-elias-alvarez/null-ls.nvim'

  -- Wiki
  use 'vimwiki/vimwiki'

  -- Indent Lines
  use "lukas-reineke/indent-blankline.nvim"
  use 'lewis6991/gitsigns.nvim'

  -- Quick Fix/Location List 
  use 'ten3roberts/qf.nvim'

  -- Terminal
  use {'akinsho/toggleterm.nvim', tag = '*'}

  if packer_bootstrap then
    require('packer').sync()
  end
end)
