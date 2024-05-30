return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Trouble: Diagnostics",
    },
    {
      "<leader>xb",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Trouble: Buffer Diagnostics",
    },
    {
      "<leader>xs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Trouble: Symbols",
    },
    {
      "<leader>xl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "Trouble: LSP Definitions / References",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Trouble: Location List",
    },
    {
      "<leader>xq",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Trouble: Quickfix List",
    },
  },
  opts = {},
}
