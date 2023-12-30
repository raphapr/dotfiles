return {

  {
    "romgrk/barbar.nvim",
    priority = 100,
    event = "VeryLazy",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "lewis6991/gitsigns.nvim" },
    },
    init = function()
      vim.g.barbar_auto_setup = true
    end,
    opts = {
      tabpages = true,
      clickable = false,
      icons = {
        button = false,
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true, icon = "ﬀ" },
        },
      },
    },
    config = function()
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      map("n", "<A-Right>", "<Cmd>BufferMoveNext<CR>", opts)
      map("n", "<A-Left>", "<Cmd>BufferMovePrevious<CR>", opts)
      map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
      map("n", "<A-i>", "<Cmd>BufferPick<CR>", opts)
    end,
  },
}
