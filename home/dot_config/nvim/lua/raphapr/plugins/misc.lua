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
  -------------------------------------- copilot.lua ------------------------------------
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<C-l>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = true,
          markdown = true,
        },
      })
    end,
  },
}
