lspconfig = require 'lspconfig'
-- completion_callback = require'completion'.on_attach

-- Setup capabilities for cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.pyright.setup{
  capabilities = capabilities
}
lspconfig.tsserver.setup{
  capabilities = capabilities
}
lspconfig.bashls.setup{
  capabilities = capabilities
}
lspconfig.rust_analyzer.setup{
  capabilities = capabilities
}
lspconfig.gopls.setup{
  cmd = {'gopls'},
  -- on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
  init_options = {
    usePlaceholders = true,
  }
}
-- nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
-- nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
-- nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
-- nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
-- nnoremap <silent> ge    <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
-- nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
-- nnoremap <silent> <leader>f    <cmd>lua vim.lsp.buf.formatting()<CR>
-- nnoremap <silent> <leader>rn    <cmd>lua vim.lsp.buf.rename()<CR>

-- nnoremap <silent> <leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
-- xmap <silent> <leader>a <cmd>lua vim.lsp.buf.range_code_action()<CR>
vim.keymap.set("n","gD",function() return vim.lsp.buf.declaration() end,{ noremap = true, silent=true})
vim.keymap.set("n","gd",function() return vim.lsp.buf.definition() end,{ noremap = true, silent=true})
vim.keymap.set("n","K",function() return vim.lsp.buf.hover() end,{ noremap = true, silent=true})
vim.keymap.set("n","gI",function() return vim.lsp.buf.implementation() end,{ noremap = true, silent=true})
vim.keymap.set("n","gr",function() return vim.lsp.buf.references() end,{ noremap = true, silent=true})

vim.keymap.set("n","<leader>f",function() return vim.lsp.buf.format() end,{ noremap = true, silent=true})


vim.keymap.set("n","<leader>a",function() return vim.lsp.buf.code_action() end,{ noremap = true, silent=true})


vim.keymap.set("n","<leader>rn",function() return vim.lsp.buf.rename() end,{ noremap = true, silent=true})

vim.keymap.set("n","ge",function() return vim.lsp.diagnostic.set_loclist() end,{ noremap = true, silent=true})
