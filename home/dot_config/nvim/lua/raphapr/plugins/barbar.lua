return {

  {
    "romgrk/barbar.nvim",
    priority = 100,
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
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
    keys = {
      { "<A-Right>", "<cmd>BufferMoveNext<CR>" },
      { "<A-Left>",  "<Cmd>BufferMovePrevious<CR>" },
      { "<A-p>",     "<Cmd>BufferPin<CR>" },
      { "<A-i>",     "<Cmd>BufferPick<CR>" },
    },
  },
}
