return {

  -------------------------------------- misc --------------------------------------------
  "editorconfig/editorconfig-vim",
  "ray-x/guihua.lua",
  "hashivim/vim-terraform",
  "tridactyl/vim-tridactyl",
  { "folke/neodev.nvim", opts = {} },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}, -- this is equalent to setup({}) function
  },

  {
    "andymass/vim-matchup",
    event = { "CursorHold", "CursorHoldI", "VeryLazy" },
    keys = { "%", "[" },
    cmd = { "MatchupWhereAmI" },
  },

  -------------------------------------- colorscheme -------------------------------------
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
  -------------------------------------- bufdelete.nvim ----------------------------------
  {
    "famiu/bufdelete.nvim",
    config = function()
      vim.keymap.set(
        "n",
        "<C-E>",
        ":Bdelete!<CR>",
        { noremap = true, silent = true, desc = "forcibly delete current buffer" }
      )
    end,
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
  {
    "dhruvasagar/vim-zoom",
    config = function()
      vim.keymap.set(
        "n",
        "=",
        ":call zoom#toggle()<CR>",
        { noremap = true, silent = true, desc = "toggle zoom of the current window." }
      )
    end,
  },
  -------------------------------------- vim-tagbar --------------------------------------
  {
    "preservim/tagbar",
    config = function()
      vim.keymap.set("n", "<F9>", ":TagbarToggle<CR>", { noremap = true, desc = "toggle Tagbar" })
    end,
  },
  -------------------------------------- vim-numbertoggle --------------------------------
  {
    "jeffkreeftmeijer/vim-numbertoggle",
    config = function()
      vim.keymap.set(
        "n",
        "<C-n>",
        ":set relativenumber!<CR>",
        { noremap = true, desc = "toggle relative line numbers" }
      )
    end,
  },
  -------------------------------------- eyeliner ----------------------------------------
  {
    "jinh0/eyeliner.nvim",
    opts = {
      highlight_on_key = true,
      dim = true,
    },
  },
}
