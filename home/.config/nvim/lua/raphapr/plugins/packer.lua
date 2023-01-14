-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use('ellisonleao/gruvbox.nvim')
  use('jiangmiao/auto-pairs')
  use('preservim/tagbar')
  use('jeffkreeftmeijer/vim-numbertoggle')
  use('numToStr/Comment.nvim')
  use('andymass/vim-matchup')
  use('junegunn/vim-peekaboo')
  use('nathom/filetype.nvim')
  use('ThePrimeagen/git-worktree.nvim')
  use('qpkorr/vim-bufkill')
  use('christianrondeau/vim-base64')
  use('editorconfig/editorconfig-vim')
  use('dhruvasagar/vim-zoom')
  use('mbbill/undotree')
  use('ray-x/go.nvim')
  use('ray-x/guihua.lua')

  use('jose-elias-alvarez/null-ls.nvim')

  use {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup {}
    end
  }

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'scrooloose/nerdtree', requires = { 'Xuyuanp/nerdtree-git-plugin' } }
  use { 'tpope/vim-fugitive', requires = { 'tpope/vim-rhubarb' } }
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true} }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-media-files.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'kyazdani42/nvim-web-devicons' }
    }
  }

  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      -- Snippet Collection (Optional)
      { 'rafamadriz/friendly-snippets' },
    }
  }

end)
