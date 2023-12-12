vim.g.mapleader = ' '
vim.api.nvim_set_keymap("n","<C-h>","<C-W>h",{ noremap = true})
vim.api.nvim_set_keymap("n","<C-j>","<C-W>j",{ noremap = true})
vim.api.nvim_set_keymap("n","<C-k>","<C-W>k",{ noremap = true})
vim.api.nvim_set_keymap("n","<C-l>","<C-W>l",{ noremap = true})

vim.api.nvim_set_keymap("n","S",":vsplit<CR>",{ noremap = true})
vim.api.nvim_set_keymap("n","<C-x>",":q<CR>",{ noremap = true})
vim.api.nvim_set_keymap("n","<leader>h",":G<CR><C-w>H<C-w>30<<C-l>",{ noremap = true})
vim.api.nvim_set_keymap("n","<leader>d",":VimwikiMakeDiaryNote<CR>",{ noremap = true})
-- vim.api.nvim_set_keymap("n","<A-5>",":Gdiffsplit<CR>",{ noremap = true})

-- Open Tree with Alt-1

-- Open Terminal with Alt-2
-- > See toggleterm.lua

-- Open Location List with Alt-3
vim.keymap.set("n","<A-3>",function() require("qf").toggle('l') end,{ noremap = true, silent=true})
vim.keymap.set("n","<A-4>",function() require("qf").toggle('c') end,{ noremap = true, silent=true})
