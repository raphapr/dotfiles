require("zen-mode").setup({
  plugins = {
    tmux = { enabled = true },
  },
  window = {
    width = 180,
  },
})
vim.keymap.set({ "n", "x" }, "<leader>mz", "<cmd>ZenMode<CR>", { silent = true, desc = "Misc: Toggle Zen Mode" })
