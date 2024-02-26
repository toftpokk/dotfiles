-- Transparency
vim.g.neovide_transparency = 0.8

-- Hyprland Maximization issue
vim.g.neovide_remember_window_size = false
-- delete this file too: .local/share/neovide/neovide-settings.json
-- as per: https://github.com/neovide/neovide/issues/2248

-- Paste
if vim.g.neovide then
  vim.keymap.set('n', '<CS-v>', '"+p') --ripgrep Paste normal mode
  vim.keymap.set('v', '<CS-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<CS-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<CS-v>', '<ESC>"+pa') -- Paste insert mode
end
