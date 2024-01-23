return {
  "kdheepak/lazygit.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "VeryLazy" },
  cmd = { "LazyGit" },
  keys = {
    { "<leader>tt", ":LazyGit<CR>", silent = true, { desc = "git: call lazygit" } },
  },
}
