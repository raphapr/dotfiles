return {
  -------------------------------------- misc -------------------------------------------
  "editorconfig/editorconfig-vim",
  "tridactyl/vim-tridactyl",
  "sitiom/nvim-numbertoggle",
  { "mg979/vim-visual-multi", event = "BufRead" },
  { "towolf/vim-helm", ft = { "helm" } },
  { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
  { "hashivim/vim-terraform", ft = { "terraform" } },
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
  { "andymass/vim-matchup", event = "CursorMoved" },
  -------------------------------------- eyeliner ---------------------------------------
  {
    "jinh0/eyeliner.nvim",
    opts = { highlight_on_key = true, dim = true },
  },
  -------------------------------------- scope.nvim -------------------------------------
  {
    "tiagovla/scope.nvim",
    event = "VeryLazy",
    config = function()
      require("scope").setup({})
      require("telescope").load_extension("scope")
      vim.api.nvim_set_hl(0, "EyelinerSecondary", { fg = "#AB47BC" })
    end,
  },
  -------------------------------------- tiny-inline-diagnostic.nvim --------------------
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
      require("tiny-inline-diagnostic").setup({
        multiple_diag_under_cursor = true,
      })
    end,
  },
  -------------------------------------- zen-mode --------------------------------------
  {
    "folke/zen-mode.nvim",
    lazy = true,
    cmd = "ZenMode",
    opts = {
      plugins = {
        tmux = { enabled = true },
      },
    },
    keys = {
      {
        "<leader>mz",
        ":Zen<cr>",
        mode = { "n", "x" },
        desc = "Misc: Toggle Zen Mode",
      },
    },
  },
}
