-------------------------------------- quick-scope -------------------------------------

vim.g["qs_highlight_on_keys"] = { "f", "F", "t", "T" }

-- custom colors
vim.cmd([[
  augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#ff007c' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#00dfff' gui=underline ctermfg=81 cterm=underline
  augroup END
]])

-------------------------------------- colorscheme -------------------------------------

require("gruvbox").setup({
  contrast = "hard",
})

vim.cmd("colorscheme gruvbox")

-------------------------------------- bufdelete.nvim ----------------------------------

vim.keymap.set(
  "n",
  "<C-E>",
  ":Bdelete!<CR>",
  { noremap = true, silent = true, desc = "forcibly delete current buffer" }
)

-------------------------------------- vim-base64 -------------------------------------

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

-------------------------------------- zoom-toggle -------------------------------------

vim.keymap.set(
  "n",
  "=",
  ":call zoom#toggle()<CR>",
  { noremap = true, silent = true, desc = "toggle zoom of the current window." }
)

-------------------------------------- vim-tagbar --------------------------------------

vim.keymap.set("n", "<F9>", ":TagbarToggle<CR>", { noremap = true, desc = "toggle Tagbar" })

-------------------------------------- vim-numbertoggle --------------------------------

vim.keymap.set("n", "<C-n>", ":set relativenumber!<CR>", { noremap = true, desc = "toggle relative line numbers" })
