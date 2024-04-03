return {
  -------------------------------------- misc -------------------------------------------
  "editorconfig/editorconfig-vim",
  "tridactyl/vim-tridactyl",
  "andymass/vim-matchup",
  "sitiom/nvim-numbertoggle",
  { "folke/neodev.nvim",      opts = {} },
  { "ray-x/guihua.lua",       build = "cd lua/fzy && make" },
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
  -------------------------------------- vim-helm ---------------------------------------
  {
    "towolf/vim-helm",
    ft = { "helm" },
  },
  -------------------------------------- scope.nvim -------------------------------------
  {
    "tiagovla/scope.nvim",
    config = function()
      require("scope").setup({})
      require("telescope").load_extension("scope")
    end,
  },
  -------------------------------------- copilot.vim ------------------------------------
  {
    "github/copilot.vim",
    config = function()
      vim.keymap.set("i", "<C-l>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
      vim.g.copilot_no_tab_map = true
    end,
  },
}
