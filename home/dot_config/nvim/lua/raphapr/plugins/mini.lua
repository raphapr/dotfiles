return {
  {
    "echasnovski/mini.nvim",
    version = false,
    event = { "User LazyUIEnter", "LspAttach" },
    keys = {
      { "<C-e>", ":lua require('mini.bufremove').delete()<CR>", silent = true },
      { "<Esc>", "<ESC>:noh<CR>:lua require('mini.notify').clear()<CR>", silent = true },
    },
    config = function()
      require("mini.indentscope").setup()
      require("mini.bufremove").setup()
      require("mini.pairs").setup()
      require("mini.surround").setup()
      require("mini.notify").setup({ lsp_progress = { enable = false } })
      vim.notify = require("mini.notify").make_notify()

      local miniclue = require("mini.clue")
      miniclue.setup({
        window = {
          delay = 500,
          config = {
            width = "60",
          },
        },
        triggers = {
          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

          -- Marks
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },
        },
        clues = {
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          -- Normal mode
          { mode = "n", keys = "<leader>v", desc = "Overseer / venv-selector" },
          { mode = "n", keys = "<leader>vv", desc = "Overseer" },
          { mode = "n", keys = "<leader>c", desc = "CoPilot / CI" },
          { mode = "n", keys = "<leader>cc", desc = "CoPilot" },
          { mode = "n", keys = "<leader>ci", desc = "CI" },
          { mode = "n", keys = "<leader>g", desc = "Telescope" },
          { mode = "n", keys = "<leader>t", desc = "Git" },
          { mode = "n", keys = "<leader>x", desc = "Trouble" },
          { mode = "n", keys = "<leader>l", desc = "LSP" },
          { mode = "n", keys = "<leader>e", desc = "Edit" },
          { mode = "n", keys = "<leader>m", desc = "Miscellaneous" },
          { mode = "n", keys = "<leader>r", desc = "Rest" },
          { mode = "n", keys = "<leader>z", desc = "zk" },
          { mode = "n", keys = "go", desc = "Go" },

          -- Visual mode
          { mode = "x", keys = "<leader>cc", desc = "CoPilot" },
          { mode = "x", keys = "<leader>g", desc = "Telescope" },
          { mode = "x", keys = "<leader>t", desc = "Git" },
          { mode = "x", keys = "<leader>c", desc = "CoPilot / CI" },
          { mode = "x", keys = "<leader>b", desc = "Base64" },
          { mode = "x", keys = "<leader>z", desc = "zk" },
        },
      })
    end,
  },
}
