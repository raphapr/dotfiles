return {
  -------------------------------------- misc -------------------------------------------
  "editorconfig/editorconfig-vim",
  "tridactyl/vim-tridactyl",
  { "folke/neodev.nvim", opts = {} },
  { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
  -------------------------------------- nvim-autopairs----------------------------------
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    opts = {}, -- this is equalent to setup({}) function
  },
  -------------------------------------- vim-matchup-------------------------------------
  {
    "andymass/vim-matchup",
  },

  -------------------------------------- vim-terraform-----------------------------------
  {
    "hashivim/vim-terraform",
    ft = { "terraform" },
  },

  -------------------------------------- colorscheme ------------------------------------
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
    },
    config = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  -------------------------------------- bufdelete.nvim ---------------------------------
  {
    "famiu/bufdelete.nvim",
    keys = {
      { "<C-E>", ":Bdelete!<CR>", silent = true, noremap = true, desc = "forcibly delete current buffer" },
    },
  },
  -------------------------------------- vim-base64 -------------------------------------
  {
    "christianrondeau/vim-base64",
    config = function()
      vim.keymap.set(
        "v",
        "<leader>de",
        ":<c-u>call base64#v_atob()<cr>",
        { noremap = true, silent = true, desc = "decode selected base64-encoded text." }
      )
      vim.keymap.set(
        "v",
        "<leader>en",
        ":<c-u>call base64#v_btoa()<cr>",
        { noremap = true, silent = true, desc = "encode selected text as base64." }
      )
    end,
  },
  -------------------------------------- vim-zoom ---------------------------------------
  {
    "dhruvasagar/vim-zoom",
    keys = {
      {
        "=",
        ":call zoom#toggle()<CR>",
        silent = true,
        { noremap = true, desc = "toggle zoom of the current window." },
      },
    },
  },
  -------------------------------------- vim-tagbar -------------------------------------
  {
    "preservim/tagbar",
    cmd = "TagBarToggle",
    keys = {
      { "<F9>", ":TagbarToggle<CR>", noremap = true, desc = "toggle Tagbar" },
    },
  },
  -------------------------------------- vim-numbertoggle -------------------------------
  { "sitiom/nvim-numbertoggle" },
  -------------------------------------- eyeliner ---------------------------------------
  {
    "jinh0/eyeliner.nvim",
    opts = {
      highlight_on_key = true,
      dim = true,
    },
  },
}
