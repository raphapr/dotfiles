require("yanky").setup({
  ring = {
    history_length = 100,
    storage = "sqlite",
    storage_path = os.getenv("HOME") .. "/Cloud/Sync/yanky.db",
  },
  system_clipboard = {
    sync_with_ring = false,
  },
  highlight = {
    on_yank = false, -- TextYankPost in autocmds.lua already highlights yanks
    timer = 300,
  },
  textobj = {
    enabled = false,
  },
})

-- Uses vim.ui.select, which mini.pick provides.
vim.keymap.set("n", "gh", "<cmd>YankyRingHistory<CR>", { silent = true, desc = "Yanky History" })
