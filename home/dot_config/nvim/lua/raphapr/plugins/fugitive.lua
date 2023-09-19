vim.keymap.set("n", "<leader>tt", vim.cmd.Git, { desc = "git: summary window" })
vim.keymap.set("n", "<leader>tl", ":Gclog<CR>", { silent = true, desc = "git: log" })
vim.keymap.set("n", "<leader>tp", ":Git push ", { desc = "git: push" })
vim.keymap.set("n", "<leader>td", vim.cmd.Gvdiffsplit, { desc = "git: diff split vertically " })
