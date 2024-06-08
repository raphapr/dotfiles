return {
  -------------------------------------- misc -------------------------------------------
  "editorconfig/editorconfig-vim",
  "tridactyl/vim-tridactyl",
  "andymass/vim-matchup",
  "sitiom/nvim-numbertoggle",
  { "towolf/vim-helm",        ft = { "helm" } },
  { "folke/neodev.nvim",      opts = {} },
  { "ray-x/guihua.lua",       build = "cd lua/fzy && make" },
  { "hashivim/vim-terraform", ft = { "terraform" } },
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
  -------------------------------------- grug-far --------------------------------------
  {
    'MagicDuck/grug-far.nvim',
    cmd = "GrugFar",
    config = function()
      require('grug-far').setup()
    end,
    keys = {
      { "<leader>f", "<cmd>GrugFar<CR>", desc = "Find and Replace" },
    },
  },
}
