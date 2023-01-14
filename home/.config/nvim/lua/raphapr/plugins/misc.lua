----------------
-- colorscheme
----------------
require('gruvbox').setup({
  contrast = 'hard',
})
vim.cmd('colorscheme gruvbox')

----------------
-- vim-bufkill
----------------
vim.cmd('nmap <C-E> :BD!<cr>')

--------------------------
-- lualine
--------------------------
require('lualine').setup {
  options = { theme = 'gruvbox-material' },
  extensions = { 'nerdtree', 'fzf', 'fugitive' },
  tabline = {
    lualine_a = { 'buffers' },
  }
}

----------------
-- vim-base64
----------------
vim.keymap.set('v', '<leader>de', ':<c-u>call base64#v_atob()<cr>', { silent = true, noremap = true })
vim.keymap.set('v', '<leader>en', ':<c-u>call base64#v_btoa()<cr>', { silent = true, noremap = true })

--------------------------
-- zoom-toggle
--------------------------
vim.keymap.set('n', '-', ':call zoom#toggle()<CR>', { silent = true, noremap = true })

----------------
-- nerdtree
----------------
vim.g.NERDTreeMinimalUI = true
vim.g.NERDTreeDirArrows = true
vim.keymap.set('n', '<F10>', ':NERDTreeToggle<CR>')

--------------------------
-- vim-tagbar
--------------------------
vim.keymap.set('n', '<F9>', ':TagbarToggle<CR>')

--------------------------
-- vim-numbertoggle
--------------------------
vim.keymap.set('n', '<C-n>', ':set relativenumber!<CR>', { noremap = true })

--------------------------
-- gitsigns
--------------------------
require('gitsigns').setup {
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
}
--------------------------
--  filetype.nvim
--------------------------
vim.g.did_load_filetypes = 1
require("filetype").setup {
  overrides = {
    extensions = {
      tf = "terraform",
      tfvars = "terraform",
      tfstate = "json",
      fish = "fish",
    },
  },
}


--------------------------
-- mbbill/undotree
--------------------------
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

--------------------------
-- nvim-treesitter
--------------------------
require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "c",
    "lua",
    "rust",
    "dockerfile",
    "python",
    "bash",
    "json",
    "markdown",
    "cmake",
    "fish",
    "comment",
    "go",
    "gomod",
    "gowork",
    "help",
    "html",
    "http",
    "json",
    "yaml",
    "regex",
    "hcl",
    "vim",
    "terraform"
  },
  highlight = {
    enable = true,
    disable = { "vim" },
    additional_vim_regex_highlighting = { "markdown" }
  },
}

--------------------------
-- comment.nvim
--------------------------
require('Comment').setup {
  ---Add a space b/w comment and the line
  padding = true,
  ---Whether the cursor should stay at its position
  sticky = true,
  ---Lines to be ignored while (un)comment
  ignore = nil,
  ---LHS of toggle mappings in NORMAL mode
  toggler = {
    ---Line-comment toggle keymap
    line = '<leader>cc',
    ---Block-comment toggle keymap
    block = '<leader>cb',
  },
  ---LHS of operator-pending mappings in NORMAL and VISUAL mode
  opleader = {
    ---Line-comment keymap
    line = '<leader>cc',
    ---Block-comment keymap
    block = '<leader>cb',
  },
  mappings = {
    ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
    basic = true,
  }
}
