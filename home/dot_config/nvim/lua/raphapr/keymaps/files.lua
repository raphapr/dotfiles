-- File and buffer management keymaps

local constants = require("raphapr.config.constants")
local U = require("raphapr.config.utils")

-- buffers navigation
vim.keymap.set("n", "<Tab>", ":BufferNext<CR>", { silent = true, desc = "switch to next buffer" })
vim.keymap.set("n", "<S-Tab>", ":BufferPrevious<CR>", { silent = true, desc = "switch to previous buffer" })
vim.keymap.set("n", "<leader>bn", ":BufferNext<CR>", { silent = true, desc = "Buffer: Next" })
vim.keymap.set("n", "<leader>bp", ":BufferPrevious<CR>", { silent = true, desc = "Buffer: Previous" })
vim.keymap.set("n", "<leader>by", function()
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    vim.notify("Buffer has no file path", vim.log.levels.WARN)
    return
  end
  local location = string.format("%s:L%d:C%d", path, vim.fn.line("."), vim.fn.col("."))
  vim.fn.setreg("+", location, "v")
  vim.notify("Copied: " .. location, vim.log.levels.INFO)
end, { desc = "Buffer: Copy path, line and column" })

-- open common configuration files
vim.keymap.set(
  "n",
  "<leader>en",
  ":vsplit " .. constants.paths.nvim_config .. "<cr>",
  { desc = "Edit: neovim config file" }
)
vim.keymap.set(
  "n",
  "<leader>ef",
  ":vsplit " .. constants.paths.fish_config .. "<cr>",
  { desc = "Edit: fish config file" }
)
vim.keymap.set(
  "n",
  "<leader>ei",
  ":vsplit " .. constants.paths.i3_config .. "<cr>",
  { desc = "Edit: i3wm config file" }
)
vim.keymap.set("n", "<leader>eb", ":e " .. constants.paths.backlog .. "<cr>", { desc = "Edit: backlog file" })

-- toggle relative number
vim.keymap.set(
  "n",
  "<leader>mn",
  ":set relativenumber!<CR>",
  { noremap = true, desc = "Misc: Toggle relative line numbers" }
)

-- load current lua file
vim.keymap.set(
  "n",
  "<leader>mr",
  ":luafile %<CR>:lua vim.notify('lua file loaded')<CR>",
  { silent = true, desc = "Misc: Load current lua file" }
)

-- CircleCI integration
vim.keymap.set("n", "<leader>mi", function()
  U.run_async({ "circleci", "project", "open" }, "CircleCI")
end, { silent = true, desc = "Misc: Open CircleCI project in browser" })
