-- FZF
vim.api.nvim_set_keymap("n","<C-f>",":Files<CR>",{ noremap = true})
vim.api.nvim_set_keymap("n","<C-b>",":Buffers<CR>",{ noremap = true})
vim.g.fzf_action = {
	["ctrl-t"]="tab split",
	["ctrl-x"]="split",
	["ctrl-v"]="vsplit"
}
