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
-- vim-go
--------------------------
-- use coc.nvim go-to-definition
vim.g.go_def_mapping_enabled = 0

-- disable all linters as that is taken care of by coc.nvim
vim.g.go_diagnostics_enabled = 0
vim.g.go_metalinter_enabled = {}

-- don't jump to errors after metalinter is invoked
vim.g.go_jump_to_error = 0

-- run go imports on file save
vim.g.go_fmt_command = "goimports"

-- automatically highlight variable your cursor is on
vim.g.go_auto_sameids = 0

-- disable vim-go fmt autosave
vim.g.go_fmt_autosave = 0

-- unmap K key for doc lookup
vim.g.go_doc_keywordprg_enabled = 0

-- highlights
vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_operators = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_build_constraints = 1
vim.g.go_highlight_generate_tags = 1

-- share gopls instance with coc.nvim
vim.g.go_gopls_options = { '-remote=unix;/tmp/gopls-daemon-socket' }

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
