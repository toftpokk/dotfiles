-- Toftpokk's Vim Config

-- Lazy.nvim needs leader first
vim.g.mapleader = ' '

---- Plugins
require('user.bootstrap')
require('user.plugins')
require('user.cmp')
require('user.keymap')
require('user.lsp')
require('user.nvim-tree')
require('user.theme')
require('user.treesitter')
require('user.null-ls')
require('user.vimwiki')
require('user.indent-blankline')
require('user.gitsigns')
require('user.telescope')
require('user.qf')
require('user.toggleterm')

-- :set vim.opt.option_name
local options = {
  -- Tabs
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
  wrap=false,			-- No wrap text
  number=true,			-- Show number
  showcmd=true,			-- Current command
  termguicolors=true,	-- set gui color
  clipboard="unnamedplus", -- Aways copy to clipboard
  scrolloff=5, -- top/bottom spacing when scrolling

  delcombine=true,
  -- colorcolumn="80", -- put a color column at col=80
}
vim.syntax=true

-- Fold makes nvim *slow*
-- vim.opt.foldmethod="indent"
-- vim.opt.foldlevel = 99
-- vim.g.vimwiki_folding = 'list'
-- vim.g.markdown_folding = 1

for k, v in pairs(options) do
  vim.opt[k] = v
end
--  ---- Commands
--  vim.api.nvim_create_user_command("Make", "write | make! <args? | cwindow",{ nargs="*"})
--  vim.api.nvim_create_user_command("Run", "!%:p",{})
--  vim.api.nvim_create_user_command("Py", "!python %",{})
--  vim.api.nvim_create_user_command("M", ":w | make",{})

vim.api.nvim_create_user_command("Format", function()
  if vim.bo.filetype == "html" then
    vim.cmd("%!xmllint -html %")
  elseif vim.bo.filetype == "xml" then
    vim.cmd("%!xmllint %")
  elseif vim.bo.filetype == "json" then
    vim.cmd("%!python -m json.tool %")
  end
 end,{})

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

-- Auto format
vim.api.nvim_create_autocmd({"BufWritePost"}, {
	pattern="*.tex",
	callback = function()
    vim.api.nvim_exec("exec '!latexmk -pdf %'",true) -- works normally
    -- vim.api.nvim_exec("exec '!latexmk -xelatex %'",true) -- works with thai text
	end
})

-- Filetypes
vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
	pattern="nginx.conf",
	callback = function()
		vim.opt.ft = "nginx"
	end
})
vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
	pattern="sxhkdrc,*.sxhkdrc",
	callback = function()
		vim.opt.ft = "sxhkdrc"
	end
})
vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
	pattern=".gitignore",
	callback = function()
		vim.opt.ft = "gitignore"
	end
})


-- Open Tree at startup
local function open_nvim_tree(data)
  -- buffer is a real file on the disk
  local real_file = vim.fn.filereadable(data.file) == 1
  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
  if not real_file and not no_name then
    return
  end
  -- open the tree, find the file but don't focus it
  require("nvim-tree.api").tree.toggle({ focus = false, find_file = true, })
end

-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- Return to last pos, See: https://www.reddit.com/r/neovim/comments/uri33x/autocommand_to_go_to_last_position_in_the_document/
vim.api.nvim_create_autocmd({'BufReadPost'},{
  pattern='*',
  callback = function()
    local test_pos = vim.api.nvim_buf_get_mark(0,'\"')
    local last_line = vim.api.nvim_buf_line_count(0)
    if test_pos[1] > 0 and test_pos[1] <= last_line then
      vim.api.nvim_win_set_cursor(0,test_pos)
    end
  end
})

