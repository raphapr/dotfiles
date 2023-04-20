----------------
-- colorscheme
----------------
require("gruvbox").setup({
  contrast = "hard",
})
vim.cmd("colorscheme gruvbox")

----------------
-- bufdelete.nvim
----------------
vim.keymap.set(
  "n",
  "<C-E>",
  ":Bdelete!<CR>",
  { noremap = true, silent = true, desc = "forcibly delete current buffer" }
)

----------------
-- vim-base64
----------------
vim.keymap.set(
  "v",
  "<leader>de",
  ":<c-u>call base64#v_atob()<cr>",
  { noremap = true, silent = true, desc = "decode selected base64-encoded text." }
)
vim.keymap.set(
  "v",
  "<leader>en",
  ":<c-u>call base64#v_btoa()<cr>",
  { noremap = true, silent = true, desc = "encode selected text as base64." }
)

--------------------------
-- zoom-toggle
--------------------------
vim.keymap.set(
  "n",
  "-",
  ":call zoom#toggle()<CR>",
  { noremap = true, silent = true, desc = "toggle zoom of the current window." }
)

--------------------------
-- vim-tagbar
--------------------------
vim.keymap.set("n", "<F9>", ":TagbarToggle<CR>", { noremap = true, desc = "toggle Tagbar" })

--------------------------
-- vim-numbertoggle
--------------------------
vim.keymap.set("n", "<C-n>", ":set relativenumber!<CR>", { noremap = true, desc = "toggle relative line numbers" })

--------------------------
-- which-key
--------------------------
local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    g = {
      name = "+get telescope",
    },
    t = {
      name = "+gitlinker",
    },
    b = {
      name = "+harpoon",
    },
  },
})

--------------------------
-- gitlinker
--------------------------
require("gitlinker").setup({
  opts = {
    mappings = nil,
  },
})

vim.api.nvim_set_keymap(
  "n",
  "<leader>tb",
  '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  { silent = true, desc = "git: open repo url" }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>ty",
  '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>'
  ,
  { silent = true, desc = "git: open permalink in browser" }
)

vim.api.nvim_set_keymap(
  "v",
  "<leader>ty",
  '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>'
  ,
  { desc = "git: open permalink in browser" }
)

--------------------------
-- harpoon
--------------------------
local function h_opts(desc)
  return { desc = "harpoon: " .. desc, noremap = true, silent = true }
end

vim.keymap.set("n", "<leader>bb", ":Telescope harpoon marks<CR>", h_opts("harpoon: teleport quick menu"))
vim.keymap.set("n", "<leader>ba", ':lua require("harpoon.mark").add_file()<CR>', h_opts("harpoon: add file"))
vim.keymap.set("n", "<leader>br", ':lua require("harpoon.mark").rm_file()<CR>', h_opts("harpoon: rm file"))
vim.keymap.set("n", "<leader>bc", ':lua require("harpoon.mark").clear_all()<CR>', h_opts("harpoon: clear all"))
vim.keymap.set("n", "<leader>bn", ':lua require("harpoon.ui").nav_next()<CR>', h_opts("harpoon: go to next mark"))
vim.keymap.set("n", "<leader>bp", ':lua require("harpoon.ui").nav_prev()<CR>', h_opts("harpoon: go to prev mark"))
vim.keymap.set("n", "<leader>1", ':lua require("harpoon.ui").nav_file(1)<CR>', h_opts("harpoon: go to mark 1"))
vim.keymap.set("n", "<leader>2", ':lua require("harpoon.ui").nav_file(2)<CR>', h_opts("harpoon: go to mark 2"))
vim.keymap.set("n", "<leader>3", ':lua require("harpoon.ui").nav_file(3)<CR>', h_opts("harpoon: go to mark 3"))
vim.keymap.set("n", "<leader>4", ':lua require("harpoon.ui").nav_file(4)<CR>', h_opts("harpoon: go to mark 4"))
vim.keymap.set("n", "<leader>5", ':lua require("harpoon.ui").nav_file(5)<CR>', h_opts("harpoon: go to mark 5"))
