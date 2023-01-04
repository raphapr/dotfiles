-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use{'ellisonleao/gruvbox.nvim'}
  use('jiangmiao/auto-pairs')
  use('preservim/tagbar')
  use('jeffkreeftmeijer/vim-numbertoggle')
  use('scrooloose/nerdcommenter')
  use('andymass/vim-matchup')
  use('junegunn/vim-peekaboo')
  use('nathom/filetype.nvim')
  use('Vimjas/vim-python-pep8-indent')
  use('ThePrimeagen/git-worktree.nvim')
  use('qpkorr/vim-bufkill')
  use('christianrondeau/vim-base64')
  use('editorconfig/editorconfig-vim')
  use('dhruvasagar/vim-zoom')

  use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})
  use{'scrooloose/nerdtree', requires = {'Xuyuanp/nerdtree-git-plugin'}}
  use{'tpope/vim-fugitive', requires = {'tpope/vim-rhubarb'}}
  use{'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}

  use{'fatih/vim-go', run = ':GoUpdateBinaries' }
  use{'neoclide/coc.nvim', branch = 'release'}

  use {
	  'nvim-telescope/telescope.nvim',
	  requires = {
		  {'nvim-lua/plenary.nvim'},
		  {'nvim-telescope/telescope-media-files.nvim'},
		  {'nvim-lua/popup.nvim'},
		  {'kyazdani42/nvim-web-devicons'}
	  }
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

end)
