require("gitlinker").setup({
  opts = {
    mappings = nil,
  },
})

local function opts(desc)
  return { desc = "git: " .. desc, silent = true }
end

vim.api.nvim_set_keymap(
  "n",
  "<leader>tb",
  '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  opts("open repo url")
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>ty",
  '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  opts("open permalink in browser")
)

vim.api.nvim_set_keymap(
  "v",
  "<leader>ty",
  '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  opts("open permalink in browser")
)
