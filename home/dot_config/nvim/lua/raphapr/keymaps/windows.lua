-- Window and split management keymaps

-- Windows navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "move to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "move to window above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "move to right window" })

-- Resize current split
vim.keymap.set("n", "<Up>", ":resize +5<cr>", { desc = "resize split upwards by 5 lines" })
vim.keymap.set("n", "<Down>", ":resize -5<cr>", { desc = "resize split downwards by 5 lines" })

-- Resize current vertical split
vim.keymap.set("n", "<Right>", ":vertical resize +5<cr>", { desc = "resize vsplit to the right by 5 columns" })
vim.keymap.set("n", "<Left>", ":vertical resize -5<cr>", { desc = "resize vsplit to the left by 5 columns" })

-- Close window
vim.keymap.set("n", "zz", ":q<CR>", { noremap = true, desc = "close the current window" })

-- Tmux integration
local function open_tmux_pane()
  local current_dir = vim.fn.getcwd()
  local tmux_cmd = string.format("tmux split-window -h -c %q", current_dir)
  vim.fn.system(tmux_cmd)
end

vim.keymap.set("n", '<leader>"', open_tmux_pane, { silent = true, noremap = true, desc = "open tmux pane in current directory" })

