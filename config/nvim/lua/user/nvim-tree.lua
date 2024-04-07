local nvim_tree = require("nvim-tree")
local api = require("nvim-tree.api")

local function edit_or_open()
  api.node.open.edit()
end

local function my_on_attach(bufnr)
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    -- default mappings
    api.config.mappings.default_on_attach(bufnr)
    -- custom mappings
    vim.keymap.set("n", "l", edit_or_open, opts("Edit or Open"))
end

nvim_tree.setup{
  update_focused_file = { enable = true }, -- update file on BufEnter
  sync_root_with_cwd = true, -- sync root with cwd, refresh tree
  renderer = {
    root_folder_label = ":t",
    icons = {
      -- web_devicons "nvim-tree/nvim-web-devicons"
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  view = {
    width = 30,
    side = "left",
  },
  on_attach = my_on_attach
}

-- Toggle with Alt-1
local nvimTreeFocusOrToggle = function ()
	local currentBuf = vim.api.nvim_get_current_buf()
	local currentBufFt = vim.api.nvim_get_option_value("filetype", { buf = currentBuf })
	if currentBufFt == "NvimTree" then
		api.tree.toggle()
	else
		api.tree.focus()
	end
end
vim.keymap.set("n", "<A-1>", nvimTreeFocusOrToggle)

-- Auto close when last window
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
      vim.cmd "quit"
    end
  end
})

