return {
  -------------------------------------- misc -------------------------------------------
  "editorconfig/editorconfig-vim",
  "tridactyl/vim-tridactyl",
  "norcalli/nvim-colorizer.lua",
  { "mg979/vim-visual-multi", event = "BufRead" },
  { "towolf/vim-helm", ft = { "helm" } },
  { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
  { "hashivim/vim-terraform", ft = { "terraform" } },
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
  { "andymass/vim-matchup", event = "BufReadPost" },
  { "mcauley-penney/visual-whitespace.nvim", config = true, keys = { "v", "V", "<C-v>" } },
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
  -------------------------------------- strudel.nvim ----------------------------------
  {
    "gruvw/strudel.nvim",
    build = "npm ci",
    config = function()
      require("strudel").setup()
      local strudel = require("strudel")
      vim.keymap.set("n", "<leader>sl", strudel.launch, { desc = "Launch Strudel" })
      vim.keymap.set("n", "<leader>sq", strudel.quit, { desc = "Quit Strudel" })
      vim.keymap.set("n", "<leader>st", strudel.toggle, { desc = "Strudel Toggle Play/Stop" })
      vim.keymap.set("n", "<leader>su", strudel.update, { desc = "Strudel Update" })
      vim.keymap.set("n", "<leader>ss", strudel.stop, { desc = "Strudel Stop Playback" })
      vim.keymap.set("n", "<leader>sb", strudel.set_buffer, { desc = "Strudel set current buffer" })
      vim.keymap.set("n", "<leader>sx", strudel.execute, { desc = "Strudel set current buffer and update" })
    end,
  },
}
