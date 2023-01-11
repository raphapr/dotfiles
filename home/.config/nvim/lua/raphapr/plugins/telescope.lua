local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')
require("telescope").load_extension("git_worktree")
require('telescope').load_extension('media_files')
require('telescope').setup {
  defaults = {
    mappings = {
      n = {
        ['<C-h>'] = action_layout.toggle_preview,
        ['<C-q>'] = actions.close,
      },
      i = {
        ['<Up>']   = actions.cycle_history_prev,
        ['<Down>'] = actions.cycle_history_next,
        ['<C-j>']  = actions.move_selection_next,
        ['<C-k>']  = actions.move_selection_previous,
        ['<C-h>']  = action_layout.toggle_preview,
        ['<C-p>']  = actions.cycle_history_prev,
        ['<C-q>']  = actions.close,
        ['<C-i>']  = actions.file_split,
        ['<C-s>']  = actions.file_vsplit,
      }
    }
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case" -- or "ignore_case" or "respect_case"
    },
    media_files = {
      -- filetypes whitelist
      filetypes = { "png", "webp", "jpg", "jpeg" },
      find_cmd = "rg" -- find command (defaults to `fd`)
    }
  }
}
local telescope_builtin = require('telescope.builtin')
local telescope_worktree = require('telescope').extensions.git_worktree
vim.keymap.set('n', '<C-p>', telescope_builtin.find_files, {})
vim.keymap.set('n', '<C-y>', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>gg', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>gs', telescope_builtin.grep_string, {})
vim.keymap.set('n', '<leader>t', telescope_builtin.help_tags, {})
vim.keymap.set('n', '<leader>wt', telescope_worktree.git_worktrees, {})
vim.keymap.set('n', '<leader>wc', telescope_worktree.create_git_worktree, {})
