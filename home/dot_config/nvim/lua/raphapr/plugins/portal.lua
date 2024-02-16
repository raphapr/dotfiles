return {
  {
    "cbochs/portal.nvim",
    event = "VeryLazy",
    keys = {
      {
        ";;",
        "<cmd>Portal jumplist backward<cr>",
        desc = "portal: jump backward",
      },
      {
        "<leader>.",
        "<cmd>Portal jumplist forward<cr>",
        desc = "portal: jump forward",
      },
    },
  },
}
