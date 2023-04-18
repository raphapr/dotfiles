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
vim.keymap.set("v", "<leader>de", ":<c-u>call base64#v_atob()<cr>", { silent = true, noremap = true })
vim.keymap.set("v", "<leader>en", ":<c-u>call base64#v_btoa()<cr>", { silent = true, noremap = true })

--------------------------
-- zoom-toggle
--------------------------
vim.keymap.set("n", "-", ":call zoom#toggle()<CR>", { silent = true, noremap = true })

--------------------------
-- vim-tagbar
--------------------------
vim.keymap.set("n", "<F9>", ":TagbarToggle<CR>")

--------------------------
-- vim-numbertoggle
--------------------------
vim.keymap.set("n", "<C-n>", ":set relativenumber!<CR>", { noremap = true })

--------------------------
-- mbbill/undotree
--------------------------
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
