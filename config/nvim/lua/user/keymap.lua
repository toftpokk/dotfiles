vim.g.mapleader = ' '
vim.api.nvim_set_keymap("n","<C-h>","<C-W>h",{ noremap = true})
vim.api.nvim_set_keymap("n","<C-j>","<C-W>j",{ noremap = true})
vim.api.nvim_set_keymap("n","<C-k>","<C-W>k",{ noremap = true})
vim.api.nvim_set_keymap("n","<C-l>","<C-W>l",{ noremap = true})

vim.api.nvim_set_keymap("n","S",":vsplit<CR>",{ noremap = true})
vim.api.nvim_set_keymap("n","<C-x>",":q<CR>",{ noremap = true})
vim.api.nvim_set_keymap("n","<leader>h",":G<CR><C-w>H<C-w>30<<C-l>",{ noremap = true})
vim.api.nvim_set_keymap("n","<leader>d",":Gdiffsplit<CR>",{ noremap = true})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
