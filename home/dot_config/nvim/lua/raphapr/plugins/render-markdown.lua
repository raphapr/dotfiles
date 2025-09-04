return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
    lazy = true,
    ft = { "markdown" },
    config = function()
      require("render-markdown").setup({
        file_types = { "markdown", "gitcommit" },
        html = { enabled = false },
        latex = { enabled = false },
      })
      vim.keymap.set("n", "<leader>mt", ":lua require('render-markdown').toggle()<CR>", { noremap = true, desc = "Misc: Toggle render-markdown" })
    end,
  },
}
