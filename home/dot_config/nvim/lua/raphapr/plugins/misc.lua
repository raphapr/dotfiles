return {
  -------------------------------------- misc -------------------------------------------
  "editorconfig/editorconfig-vim",
  "tridactyl/vim-tridactyl",
  "andymass/vim-matchup",
  "sitiom/nvim-numbertoggle",
  { "mg979/vim-visual-multi", event = "BufRead" },
  { "towolf/vim-helm", ft = { "helm" } },
  { "folke/neodev.nvim", opts = {} },
  { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
  { "hashivim/vim-terraform", ft = { "terraform" } },
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
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
  -------------------------------------- yankbank-nvim ---------------------------------
  {
    "ptdewey/yankbank-nvim",
    dependencies = "kkharji/sqlite.lua",
    config = function()
      require("yankbank").setup({
        persist_type = "sqlite",
        vim.keymap.set("n", "<leader>y", "<cmd>YankBank<cr>", { noremap = true, desc = "Open YankBank" }),
      })
    end,
  },
}
