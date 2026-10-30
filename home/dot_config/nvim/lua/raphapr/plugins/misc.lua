return {
  -------------------------------------- misc -------------------------------------------
  -- editorconfig support is built into Neovim >= 0.9
  { "tridactyl/vim-tridactyl", ft = "tridactyl" },
  { "mg979/vim-visual-multi", event = "BufRead" },
  { "towolf/vim-helm", ft = { "helm" } },
  { "hashivim/vim-terraform", ft = { "terraform" } },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TodoTelescope", "TodoTrouble", "TodoQuickFix", "TodoLocList" },
    opts = {},
  },
  { "andymass/vim-matchup", event = "BufReadPost" },
  { "mcauley-penney/visual-whitespace.nvim", config = true, keys = { "v", "V", "<C-v>" } },
  -------------------------------------- scope.nvim -------------------------------------
  {
    "tiagovla/scope.nvim",
    event = "VeryLazy",
    config = function()
      require("scope").setup({})
    end,
  },
  -------------------------------------- tiny-inline-diagnostic.nvim --------------------
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
      require("tiny-inline-diagnostic").setup({
        options = { show_all_diags_on_cursorline = true },
      })
    end,
  },
}
