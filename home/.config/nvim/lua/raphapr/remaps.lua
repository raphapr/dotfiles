-- Windows
vim.cmd("nmap <C-h> <C-w>h")
vim.cmd("nmap <C-j> <C-w>j")
vim.cmd("nmap <C-k> <C-w>k")
vim.cmd("nmap <C-l> <C-w>l")

-- Resize current split
vim.keymap.set("n", "<Up>", ":resize +5<cr>", { desc = "resize split upwards by 5 lines" })
vim.keymap.set("n", "<Down>", ":resize -5<cr>", { desc = "resize split downwards by 5 lines" })

-- Resize current vertical split
vim.keymap.set("n", "<Right>", ":vertical resize +5<cr>", { desc = "resize vsplit to the right by 5 columns" })
vim.keymap.set("n", "<Left>", ":vertical resize -5<cr>", { desc = "resize vsplit to the left by 5 columns" })

-- Cancel current highlight search and clear matches
vim.keymap.set(
  "n",
  "<F3>",
  ":noh<cr>:call clearmatches()<cr>",
  { silent = true, desc = "cancel current search highlight" }
)

-- buffers navigation
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true, desc = "switch to next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { silent = true, desc = "switch to previous buffer" })

-- open common configuration files
vim.keymap.set(
  "n",
  "<leader>vi",
  ":vsplit ~/.config/nvim/lua/raphapr/init.lua<cr>",
  { desc = "open neovim configuration file" }
)
vim.keymap.set("n", "<leader>ef", ":vsplit ~/.config/fish/config.fish<cr>", { desc = "open fish configuration file" })
vim.keymap.set("n", "<leader>i3", ":vsplit ~/.i3/config<cr>", { desc = "open i3wm configuration file" })

-- arrow keys
vim.keymap.set("n", "j", "gj", { noremap = true, desc = "move cursor down" })
vim.keymap.set("n", "k", "gk", { noremap = true, desc = "move cursor up" })

-- move selected area up or down
vim.keymap.set("v", "K", [[:'<,'>move-2<cr>gv=gv]], { noremap = true, desc = "move selected area up" })
vim.keymap.set("v", "J", [[:'<,'>move'>+<cr>gv=gv]], { noremap = true, desc = "move selected area down" })

-- cancel current highlight search
vim.keymap.set(
  "n",
  "<silent> <F3>",
  ":noh<cr>:call clearmatches()<CR>",
  { noremap = true, desc = "cancel current highlight search" }
)

-- selected blocks are selected again before identations
vim.keymap.set("v", "<", "<gv", { noremap = true, desc = "select block and indent left" })
vim.keymap.set("v", ">", ">gv", { noremap = true, desc = "select block and indent right" })

-- copy entire line without the newline at the end
vim.keymap.set("n", "Y", "y$", { noremap = true, desc = "copy entire line without the newline at the end" })

-- search and replace
vim.keymap.set("n", ";;", ":%s:::g<Left><Left><Left>", { noremap = true, desc = "search and replace" })

-- page up/down half a page
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, desc = "scroll down half a page" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, desc = "scroll up half a page" })

-- Windows
vim.keymap.set("n", "zz", ":q<CR>", { noremap = true, desc = "save file and close the current window" })

-- Quickfix navigation
vim.keymap.set("n", "[q", ":cprev<CR>", { silent = true, desc = "jump to previous quickfix item" })
vim.keymap.set("n", "]q", ":cnext<CR>", { silent = true, desc = "jump to next quickfix item" })
vim.keymap.set("n", "[Q", ":cfirst<CR>", { silent = true, desc = "jump to first quickfix item" })
vim.keymap.set("n", "]Q", ":clast<CR>", { silent = true, desc = "jump to last quickfix item" })
