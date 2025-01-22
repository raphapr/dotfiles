return {
  "folke/zen-mode.nvim",
  lazy = true,
  cmd = "ZenMode",
  opts = {
    plugins = {
      tmux = { enabled = true },
    },
    window = {
      width = 180,
    },
  },
  keys = {
    {
      "<leader>mz",
      ":Zen<cr>",
      mode = { "n", "x" },
      desc = "Misc: Toggle Zen Mode",
      silent = true,
    },
  },
}
