local flash = require("flash")
flash.setup()

vim.keymap.set({ "n", "x", "o" }, "s", flash.jump, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", flash.treesitter, { desc = "Flash Treesitter" })
vim.keymap.set("n", "<leader>mf", flash.toggle, { desc = "Misc: Toggle Flash Search" })
