----------------
-- colorscheme
----------------
require("gruvbox").setup({
  contrast = "hard",
})
vim.cmd("colorscheme gruvbox")

----------------
-- vim-bufkill
----------------
vim.cmd("nmap <C-E> :BD!<cr>")

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
-- vim-fugitive
--------------------------
vim.keymap.set("n", "<C-b>", ":GBrowse<CR>", { noremap = true, desc = "open fugitive's git object browser" })

--------------------------
-- which-key
--------------------------
local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    g = {
      name = "+get telescope",
    },
  },
})
