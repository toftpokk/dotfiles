-- Toftpokk's Vim Config

---- Plugins
require('user.plugins')
require('user.cmp')
require('user.fzf')
require('user.keymap')
require('user.lsp')
require('user.nvim-tree')
require('user.theme')
require('user.treesitter')
require('user.null-ls')
require('user.vimwiki')

-- NERDTree
-- vim.api.nvim_set_keymap("n","<leader>n",":NERDTreeToggle<CR>",{ noremap = true})

local options = {
  -- Tabs
  -- tabstop=4,			-- one tab = 4 colums
  -- softtabstop=4,		-- All tabs equal to 4
  -- shiftwidth=4,			-- >> and << move width
  -- expandtab=false,		-- Use tabs when presses tab
  -- smarttab=true,		-- Tabs are only used for indentation

  -- ***eslint
  expandtab=true,		-- Use tabs when presses tab
  tabstop=2,			-- one tab = 4 colums
  softtabstop=2,		-- All tabs equal to 4
  shiftwidth=2,			-- >> and << move width
  smarttab=true,		-- Tabs are only used for indentation
  
  -- Indents
  autoindent=true,		-- Automatically indent next line
  smartindent=true,		-- Helps auto indent readt to syntax
  backspace="indent,eol,start",	-- Backspace over autoindent and line breaks
  -- Matching
  showmatch=true,		-- Show matching bracket
  ignorecase=true,		-- Ignore case when searching
  
  -- Decor
  wrap=true,			-- No wrap text
  number=true,			-- Show number
  showcmd=true,			-- Current command
  termguicolors=true,	-- set gui color
  clipboard="unnamedplus", -- Aways copy to clipboard
  scrolloff=5, -- top/bottom spacing when scrolling
}
vim.syntax=true

for k, v in pairs(options) do
  vim.opt[k] = v
end
--  ---- Commands
--  vim.api.nvim_create_user_command("Make", "write | make! <args? | cwindow",{ nargs="*"})
--  vim.api.nvim_create_user_command("Run", "!%:p",{})
--  vim.api.nvim_create_user_command("Py", "!python %",{})
--  vim.api.nvim_create_user_command("Json", "%!python -m json.tool",{})
--  vim.api.nvim_create_user_command("Html","!xmllint -html %",{})
--  vim.api.nvim_create_user_command("M", ":w | make",{})
--  vim.api.nvim_create_user_command("M", ":w | make",{})
--  

-- Status Line
local statusline=""
statusline=table.concat {
	"%2*",
	"%<\\ %f",	-- File Path
	"%3*",
	"%m",		-- Modified
	"%(\\ [%W%R%H]%)",	-- Preview Readonly Help
	"%=",		-- Right
	"%4*",
	"\\ (%l,%c)\\ ",	-- Line, Column
	"%5*",
	"\\ %y",	-- Filetype
	"\\ %{&fileencoding?&fileencoding:&encoding}\\ ",	-- encoding
	"%6*",
	"\\ %P\\ "	-- Percentage
}
vim.cmd("set statusline="..statusline)

-- Augroup
local filetype_tsv = vim.api.nvim_create_augroup('filetype_tsv',{clear=true})
vim.api.nvim_create_autocmd({"BufWritePost"}, {
	pattern="*.tex",
	callback = function()
    vim.api.nvim_exec("exec '!latexmk -pdf %'",true) -- works normally
    -- vim.api.nvim_exec("exec '!latexmk -xelatex %'",true) -- works with thai text
	end
})
vim.api.nvim_create_autocmd({"BufRead,BufNewFile"}, {
	pattern="nginx.conf",
	callback = function()
		vim.opt.ft = "nginx"
	end
})
vim.api.nvim_create_autocmd({"BufRead,BufNewFile"}, {
	pattern="sxhkdrc,*.sxhkdrc",
	callback = function()
		vim.opt.ft = "sxhkdrc"
	end
})
vim.api.nvim_create_autocmd({"BufRead,BufNewFile"}, {
	pattern=".gitignore",
	callback = function()
		vim.opt.ft = "gitignore"
	end
})
