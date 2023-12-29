local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ","

local plugins = {
  "wbthomason/packer.nvim",
  "preservim/tagbar",
  "jeffkreeftmeijer/vim-numbertoggle",
  "numToStr/Comment.nvim",
  "andymass/vim-matchup",
  "famiu/bufdelete.nvim",
  "christianrondeau/vim-base64",
  "editorconfig/editorconfig-vim",
  "dhruvasagar/vim-zoom",
  "ray-x/guihua.lua",
  "ray-x/lsp_signature.nvim",
  "nvimtools/none-ls.nvim",
  "tpope/vim-fugitive",
  "chentoast/marks.nvim",
  "hashivim/vim-terraform",
  "folke/which-key.nvim",
  "rcarriga/nvim-notify",
  "tridactyl/vim-tridactyl",
  "jinh0/eyeliner.nvim",

  { "catppuccin/nvim", name = "catppuccin" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "lewis6991/gitsigns.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", lazy = true } },
  { "epwalsh/obsidian.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}, -- this is equalent to setup({}) function
  },

  {
    "ray-x/go.nvim",
    dependencies = {
      { "mfussenegger/nvim-dap" },
      { "rcarriga/nvim-dap-ui" },
      { "theHamsta/nvim-dap-virtual-text" },
    },
  },

  { "folke/neodev.nvim", opts = {} },

  {
    "romgrk/barbar.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "lewis6991/gitsigns.nvim" },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-media-files.nvim" },
      { "jvgrootveld/telescope-zoxide" },
      { "nvim-lua/popup.nvim" },
      { "nvim-tree/nvim-web-devicons" },
    },
  },

  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    },
  },
}


require("lazy").setup(plugins,{})
