local function telescope_builtin(name, options)
  return function()
    require("telescope.builtin")[name](options or {})
  end
end

return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-media-files.nvim" },
      { "jvgrootveld/telescope-zoxide" },
      { "nvim-lua/popup.nvim" },
      { "nvim-tree/nvim-web-devicons" },
      { "debugloop/telescope-undo.nvim" },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
    lazy = true,
    cmd = "Telescope",
    keys = {
      { "<C-p>", telescope_builtin("find_files", { hidden = true }), desc = "Find: Files" },
      { "<C-y>", telescope_builtin("buffers"), desc = "Buffer: List" },
      { "<leader>ff", telescope_builtin("find_files", { hidden = true }), desc = "Find: Files" },
      {
        "<leader>fz",
        function()
          require("telescope").extensions.zoxide.list()
        end,
        desc = "Find: Directory with zoxide",
      },
      { "<leader>fg", telescope_builtin("live_grep"), desc = "Find: Live grep" },
      { "<leader>fs", telescope_builtin("grep_string"), mode = { "n", "v" }, desc = "Find: Current string" },
      { "<leader>fh", telescope_builtin("help_tags"), desc = "Find: Help tags" },
      { "<leader>fk", telescope_builtin("keymaps"), desc = "Find: Keymaps" },
      { "<leader>fc", telescope_builtin("command_history"), desc = "Find: Command history" },
      { "<leader>fe", telescope_builtin("search_history"), desc = "Find: Search history" },
      { "<leader>fo", telescope_builtin("oldfiles"), desc = "Find: Old files" },
      { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "Find: Project TODOs" },
      { "<leader>fy", telescope_builtin("lsp_document_symbols"), desc = "Find: Document symbols" },
      { "<leader>fu", "<cmd>Telescope undo<CR>", desc = "Find: Undo tree" },
      { "<leader>bb", telescope_builtin("buffers"), desc = "Buffer: List" },
      { "<leader>bs", "<cmd>Telescope scope buffers<CR>", desc = "Buffer: List scope" },
    },
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
      telescope.load_extension("undo")
      telescope.load_extension("ui-select")
      telescope.setup({
        defaults = {
          file_ignore_patterns = { ".git/", "node_modules", ".gem/" },
          preview = {
            treesitter = { enable = false },
          },
          history = {
            path = vim.fn.stdpath("data") .. "/telescope_history",
            limit = 1000,
          },
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
          media_files = {
            -- filetypes whitelist
            filetypes = { "png", "webp", "jpg", "jpeg" },
            find_cmd = "rg", -- find command (defaults to `fd`)
          },
        },
      })
    end,
  },
}
