return {
  -------------------------------------- misc -------------------------------------------
  "editorconfig/editorconfig-vim",
  "tridactyl/vim-tridactyl",
  "andymass/vim-matchup",
  "sitiom/nvim-numbertoggle",
  { "towolf/vim-helm",          ft = { "helm" } },
  { "folke/neodev.nvim",        opts = {} },
  { "ray-x/guihua.lua",         build = "cd lua/fzy && make" },
  { "hashivim/vim-terraform",   ft = { "terraform" } },
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
  -------------------------------------- eyeliner ---------------------------------------
  {
    "jinh0/eyeliner.nvim",
    opts = { highlight_on_key = true, dim = true },
  },
  -------------------------------------- scope.nvim -------------------------------------
  {
    "tiagovla/scope.nvim",
    config = function()
      require("scope").setup({})
      require("telescope").load_extension("scope")
    end,
  },
}
