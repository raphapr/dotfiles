return {
  -------------------------------------- misc -------------------------------------------
  "editorconfig/editorconfig-vim",
  "tridactyl/vim-tridactyl",
  "andymass/vim-matchup",
  { "sitiom/nvim-numbertoggle" },
  { "folke/neodev.nvim", opts = {} },
  { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
  { "hashivim/vim-terraform", ft = { "terraform" } },
  -------------------------------------- nvim-autopairs----------------------------------
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    opts = {}, -- this is equalent to setup({}) function
  },
  -------------------------------------- eyeliner ---------------------------------------
  {
    "jinh0/eyeliner.nvim",
    opts = { highlight_on_key = true, dim = true },
  },
  -------------------------------------- bufdelete.nvim ---------------------------------
  {
    "famiu/bufdelete.nvim",
    keys = {
      { "<C-E>", ":Bdelete!<CR>", silent = true, noremap = true, desc = "forcibly delete current buffer" },
    },
  },
}
