return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-media-files.nvim" },
      { "jvgrootveld/telescope-zoxide" },
      { "nvim-lua/popup.nvim" },
      { "nvim-tree/nvim-web-devicons" },
    },
    lazy = true,
    cmd = "Telescope",
    config = function()
      local telescope = require("telescope")
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

      telescope.load_extension("media_files")
      telescope.load_extension("zoxide")
      telescope.load_extension("yank_history")
      telescope.setup({
        defaults = {
          file_ignore_patterns = { ".git/", "node_modules", ".gem/" },
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
      local telescope_extensions = telescope.extensions

      vim.keymap.set("n", "<C-p>", ":Telescope find_files hidden=true<CR>", { noremap = true, silent = true, desc = "Telescope: Find files" })
      vim.keymap.set("n", "<C-y>", telescope_builtin.buffers, { desc = "Telescope: Buffers" })
      vim.keymap.set("n", "<leader>gz", telescope_extensions.zoxide.list, { desc = "Telescope: (zoxide) cd directory" }) -- ctrl+f for builtin.find_files
      vim.keymap.set("n", "<leader>gg", telescope_builtin.live_grep, { desc = "Telescope: Live grep" })
      vim.keymap.set({ "n", "v" }, "<leader>gs", telescope_builtin.grep_string, { desc = "Telescope: grep string" })
      vim.keymap.set("n", "<leader>gh", telescope_builtin.help_tags, { desc = "Telescope: Help tags" })
      vim.keymap.set("n", "<leader>gk", telescope_builtin.keymaps, { desc = "Telescope: Keymaps" })
      vim.keymap.set("n", "<leader>gc", telescope_builtin.command_history, { desc = "Telescope: Command history" })
      vim.keymap.set("n", "<leader>ge", telescope_builtin.search_history, { desc = "Telescope: Search history" })
      vim.keymap.set("n", "<leader>go", telescope_builtin.oldfiles, { desc = "Telescope: Old files" })
      vim.keymap.set("n", "<leader>gy", ":Telescope yaml_schema<CR>", { desc = "Telescope: List YAML schemas" })
      vim.keymap.set("n", "<leader>gp", ":Telescope scope buffers<CR>", { desc = "Telescope: List YAML schemas" })
      vim.keymap.set("n", "<leader>gt", ":TodoTelescope<CR>", { desc = "Telescope: Search through all project todos" })
      vim.keymap.set("n", "<leader>gl", telescope_builtin.lsp_document_symbols, { desc = "Telescope: LSP document symbols" })
    end,
  },
}
