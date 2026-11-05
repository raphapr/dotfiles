-- File and buffer management keymaps

local constants = require("raphapr.config.constants")
local U = require("raphapr.config.utils")

-- buffers navigation
vim.keymap.set("n", "<Tab>", "<cmd>bnext<CR>", { silent = true, desc = "switch to next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { silent = true, desc = "switch to previous buffer" })
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { silent = true, desc = "Buffer: Next" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", { silent = true, desc = "Buffer: Previous" })
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
vim.keymap.set({ "n", "x" }, "<leader>yf", function()
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    vim.notify("Buffer has no file path", vim.log.levels.WARN)
    return
  end
  local root = vim.fs.root(0, ".git") or vim.fn.getcwd()
  local relative = vim.fs.relpath(root, path) or path
  local first, last = vim.fn.line("v"), vim.fn.line(".")
  if first > last then
    first, last = last, first
  end
  local location = relative .. ":" .. (first == last and first or (first .. "-" .. last))
  vim.fn.setreg("+", location)
  vim.notify("Copied: " .. location, vim.log.levels.INFO)
  if vim.fn.mode() ~= "n" then
    vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "n", false)
  end
end, { desc = "Yank: Repo-relative path:line" })

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

-- GitHub integration
vim.keymap.set("n", "<leader>go", function()
  U.run_async({ "gh", "browse" }, "GitHub")
end, { silent = true, desc = "Git: Open project in browser" })

vim.keymap.set({ "n", "x" }, "<leader>gy", function()
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    vim.notify("Buffer has no file path", vim.log.levels.WARN)
    return
  end
  local first, last = vim.fn.line("v"), vim.fn.line(".")
  if first > last then
    first, last = last, first
  end
  local range = first == last and tostring(first) or (first .. "-" .. last)
  -- gh resolves the path relative to cwd, so run it from the file's directory.
  U.run_async({ "gh", "browse", "--commit", vim.fs.basename(path) .. ":" .. range }, "GitHub", { cwd = vim.fs.dirname(path) })
  if vim.fn.mode() ~= "n" then
    vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "n", false)
  end
end, { silent = true, desc = "Git: Open permalink in browser" })

-- CircleCI integration
vim.keymap.set("n", "<leader>mi", function()
  U.run_async({ "circleci", "project", "open" }, "CircleCI")
end, { silent = true, desc = "Misc: Open CircleCI project in browser" })
