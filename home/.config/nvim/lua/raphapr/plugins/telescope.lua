local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

local moveUp = actions.move_selection_previous
  + actions.move_selection_previous
  + actions.move_selection_previous
  + actions.move_selection_previous
  + actions.move_selection_previous
local moveDown = actions.move_selection_next
  + actions.move_selection_next
  + actions.move_selection_next
  + actions.move_selection_next
  + actions.move_selection_next

require("telescope").load_extension("media_files")
require("telescope").load_extension("zoxide")
require("telescope").setup({
  defaults = {
    mappings = {
      n = {
        ["<C-h>"] = action_layout.toggle_preview,
        ["<C-q>"] = actions.close,
        ["<C-u>"] = moveUp,
        ["<C-d>"] = moveDown,
      },
      i = {
        ["<Up>"] = actions.cycle_history_prev,
        ["<Down>"] = actions.cycle_history_next,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-h>"] = action_layout.toggle_preview,
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-q>"] = actions.close,
        ["<C-i>"] = actions.file_split,
        ["<C-s>"] = actions.file_vsplit,
        ["<C-u>"] = moveUp,
        ["<C-d>"] = moveDown,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
    media_files = {
      -- filetypes whitelist
      filetypes = { "png", "webp", "jpg", "jpeg" },
      find_cmd = "rg", -- find command (defaults to `fd`)
    },
  },
})

local telescope_builtin = require("telescope.builtin")
local telescope_extensions = require("telescope").extensions
local find_files_cwd_file = function()
  telescope_builtin.find_files({ cwd = vim.fn.expand("%:p:h") })
end

vim.keymap.set("n", "<C-p>", telescope_builtin.find_files, { desc = "telescope: find files" })
vim.keymap.set("n", "<C-m>", find_files_cwd_file, { desc = "telescope: find files from current file's directory" })
vim.keymap.set("n", "<C-y>", telescope_builtin.buffers, { desc = "telescope: buffers" })
vim.keymap.set("n", "<leader>cd", telescope_extensions.zoxide.list, { desc = "telescope: cd directory" })
vim.keymap.set("n", "<leader>gg", telescope_builtin.live_grep, { desc = "telescope: live grep" })
vim.keymap.set("n", "<leader>gs", telescope_builtin.grep_string, { desc = "telescope: grep string" })
vim.keymap.set("n", "<leader>gt", telescope_builtin.help_tags, { desc = "telescope: help tags" })
vim.keymap.set("n", "<leader>gk", telescope_builtin.keymaps, { desc = "telescope: keymaps" })
vim.keymap.set("n", "<leader>gd", telescope_builtin.diagnostics, { desc = "telescope: diagnostics" })
vim.keymap.set("n", "<leader>gc", telescope_builtin.command_history, { desc = "telescope: command history" })
vim.keymap.set("n", "<leader>ge", telescope_builtin.search_history, { desc = "telescope: search history" })
vim.keymap.set("n", "<leader>go", telescope_builtin.oldfiles, { desc = "telescope: old files" })
vim.keymap.set("n", "<leader>gl", telescope_builtin.lsp_document_symbols, { desc = "telescope: lsp document symbols" })
