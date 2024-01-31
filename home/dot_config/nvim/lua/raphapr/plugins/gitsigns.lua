return {
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    },
    config = function()
      require("gitsigns").setup()
      vim.keymap.set("n", "<leader>tp", ":Gitsigns preview_hunk<CR>", { desc = "git: diff preview" })
      vim.keymap.set(
        "n",
        "<leader>tl",
        ":Gitsigns toggle_current_line_blame<CR>",
        { desc = "git: toggle current line blame" }
      )
    end,
  },
}
