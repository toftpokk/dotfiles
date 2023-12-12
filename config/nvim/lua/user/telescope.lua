local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}

-- Built-in actions
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local function run_selection(prompt_bufnr, map)
  actions.select_default:replace(function()
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    if not selection then -- selection is nil
      return
    end

    local row, col = unpack(vim.api.nvim_win_get_cursor(0))

    -- Get only filename
    local target_str = selection[1]
    local ext_loc = string.find(target_str,"%.")
    local filename
    if ext_loc then
      filename = string.sub(target_str,0,ext_loc-1)
    else
      filename = target_str
    end
    vim.api.nvim_buf_set_text(0,row-1,col,row-1,col,{"[["..filename.."]]"})
  end)
  return true
end

local wiki_link = function()
  -- example for running a command on a file
  local opts = {
    attach_mappings = run_selection
  }
  require('telescope.builtin').find_files(opts)
end

vim.keymap.set('n', '<C-f>', builtin.find_files, {})
vim.keymap.set('n', '<C-g>', builtin.live_grep, {})
-- Note live grep -> quick fix uses <C-q>
vim.keymap.set('n', '<leader>wl', wiki_link, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
