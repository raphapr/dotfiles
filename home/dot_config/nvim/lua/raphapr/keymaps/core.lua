-- Basic editing and navigation keymaps

-- arrow keys for visual lines
vim.keymap.set("n", "j", "gj", { noremap = true, desc = "move cursor down" })
vim.keymap.set("n", "k", "gk", { noremap = true, desc = "move cursor up" })

-- move selected area up or down
vim.keymap.set("v", "K", [[:'<,'>move-2<cr>gv=gv]], { noremap = true, desc = "move selected area up" })
vim.keymap.set("v", "J", [[:'<,'>move'>+<cr>gv=gv]], { noremap = true, desc = "move selected area down" })

-- selected blocks are selected again before indentation
vim.keymap.set("v", "<", "<gv", { noremap = true, desc = "select block and indent left" })
vim.keymap.set("v", ">", ">gv", { noremap = true, desc = "select block and indent right" })

-- copy entire line without the newline at the end
vim.keymap.set("n", "Y", "y$", { noremap = true, desc = "copy entire line without the newline at the end" })

-- page up/down half a page and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, desc = "scroll down half a page" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, desc = "scroll up half a page" })

-- Quickfix navigation
vim.keymap.set("n", "[q", ":cprev<CR>", { silent = true, desc = "jump to previous quickfix item" })
vim.keymap.set("n", "]q", ":cnext<CR>", { silent = true, desc = "jump to next quickfix item" })
vim.keymap.set("n", "[Q", ":cfirst<CR>", { silent = true, desc = "jump to first quickfix item" })
vim.keymap.set("n", "]Q", ":clast<CR>", { silent = true, desc = "jump to last quickfix item" })

-- Copy/paste with system clipboard
vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Clipboard: Copy to system clipboard" })
vim.keymap.set({ "n", "x" }, "gY", '"+y$', { desc = "Clipboard: Copy to system clipboard without the new line at the end" })
vim.keymap.set("n", "gp", '"+p', { desc = "Clipboard: Paste from system clipboard" })
-- Paste in Visual with `P` to not copy selected text (`:h v_P`)
vim.keymap.set("x", "gp", '"+P', { desc = "Clipboard: Paste from system clipboard" })
