-- Only required if you have packer configured as `opt`
vim.cmd.packadd("packer.nvim")

return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")
  use("preservim/tagbar")
  use("jeffkreeftmeijer/vim-numbertoggle")
  use("numToStr/Comment.nvim")
  use("andymass/vim-matchup")
  use("famiu/bufdelete.nvim")
  use("christianrondeau/vim-base64")
  use("editorconfig/editorconfig-vim")
  use("dhruvasagar/vim-zoom")
  use("ray-x/guihua.lua")
  use("ray-x/lsp_signature.nvim")
  use("nvimtools/none-ls.nvim")
  use("tpope/vim-fugitive")
  use("chentoast/marks.nvim")
  use("hashivim/vim-terraform")
  use("folke/which-key.nvim")
  use("rcarriga/nvim-notify")
  use("tridactyl/vim-tridactyl")
  use("jinh0/eyeliner.nvim")

  use({ "catppuccin/nvim", as = "catppuccin" })
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use({ "nvim-tree/nvim-tree.lua", requires = { "nvim-tree/nvim-web-devicons" } })
  use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
  use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })
  use({ "epwalsh/obsidian.nvim", requires = { "nvim-lua/plenary.nvim" } })

  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  })

  use({
    "tiagovla/scope.nvim",
    config = function()
      require("scope").setup()
    end,
  })

  use({
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  })

  use({
    "ray-x/go.nvim",
    requires = {
      { "mfussenegger/nvim-dap" },
      { "rcarriga/nvim-dap-ui" },
      { "theHamsta/nvim-dap-virtual-text" },
    },
  })

  use({
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup({})
    end,
  })

  -- use({
  --   "tris203/hawtkeys.nvim",
  --   config = true,
  -- })

  use({
    "romgrk/barbar.nvim",
    requires = {
      { "nvim-tree/nvim-web-devicons" },
      { "lewis6991/gitsigns.nvim" },
    },
  })

  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-media-files.nvim" },
      { "jvgrootveld/telescope-zoxide" },
      { "nvim-lua/popup.nvim" },
      { "kyazdani42/nvim-web-devicons" },
    },
  })

  use({
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    requires = {
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
  })
end)
