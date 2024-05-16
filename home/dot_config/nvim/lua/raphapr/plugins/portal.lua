return {
  {
    "cbochs/portal.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader><leader>", "<cmd>Portal jumplist backward<cr>", desc = "Portal: jump backward", },
      { "<leader>.",        "<cmd>Portal jumplist forward<cr>",  desc = "Portal: jump forward", },
    },
  },
}
