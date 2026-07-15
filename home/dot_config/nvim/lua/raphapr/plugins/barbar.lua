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
          [vim.diagnostic.severity.ERROR] = { enabled = true, icon = "✘" },
        },
        gitsigns = {
          added = { enabled = true, icon = "+" },
          changed = { enabled = true, icon = "~" },
          deleted = { enabled = true, icon = "-" },
        },
      },
    },
    keys = {
      { "<A-Right>", "<cmd>BufferMoveNext<CR>" },
      { "<A-Left>", "<Cmd>BufferMovePrevious<CR>" },
      { "<A-p>", "<Cmd>BufferPin<CR>" },
      { "<A-i>", "<Cmd>BufferPick<CR>" },
      { "<leader>b>", "<cmd>BufferMoveNext<CR>", desc = "Buffer: Move next" },
      { "<leader>b<", "<cmd>BufferMovePrevious<CR>", desc = "Buffer: Move previous" },
      { "<leader>bP", "<cmd>BufferPin<CR>", desc = "Buffer: Toggle pin" },
      { "<leader>bi", "<cmd>BufferPick<CR>", desc = "Buffer: Pick" },
    },
  },
}
