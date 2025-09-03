-- File and buffer management keymaps

local constants = require("raphapr.config.constants")

-- buffers navigation
vim.keymap.set("n", "<Tab>", ":BufferNext<CR>", { silent = true, desc = "switch to next buffer" })
vim.keymap.set("n", "<S-Tab>", ":BufferPrevious<CR>", { silent = true, desc = "switch to previous buffer" })

-- open common configuration files
vim.keymap.set("n", "<leader>en", ":vsplit " .. constants.paths.nvim_config .. "<cr>", { desc = "Edit: neovim config file" })
vim.keymap.set("n", "<leader>ef", ":vsplit " .. constants.paths.fish_config .. "<cr>", { desc = "Edit: fish config file" })
vim.keymap.set("n", "<leader>ei", ":vsplit " .. constants.paths.i3_config .. "<cr>", { desc = "Edit: i3wm config file" })
vim.keymap.set("n", "<leader>eb", ":e " .. constants.paths.backlog .. "<cr>", { desc = "Edit: backlog file" })

-- toggle relative number
vim.keymap.set("n", "<leader>mn", ":set relativenumber!<CR>", { noremap = true, desc = "Misc: Toggle relative line numbers" })

-- load current lua file
vim.keymap.set("n", "<leader>mr", ":luafile %<CR>:lua vim.notify('lua file loaded')<CR>", { silent = true, desc = "Misc: Load current lua file" })

-- CircleCI integration
vim.keymap.set("n", "<leader>mi", ":!circleci open<CR><CR>", { silent = true, noremap = true, desc = "Misc: Open the CircleCI project in the browser" })