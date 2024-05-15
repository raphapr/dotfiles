return {
  {
    "echasnovski/mini.nvim",
    version = false,
    event = { "User LazyUIEnter", "LspAttach" },
    keys = {
      { "<C-e>", ":lua require('mini.bufremove').delete()<CR>",          silent = true },
      { "<Esc>", "<ESC>:noh<CR>:lua require('mini.notify').clear()<CR>", silent = true },
    },
    config = function()
      require("mini.indentscope").setup()
      require("mini.bufremove").setup()
      require("mini.pairs").setup()
      require("mini.surround").setup()
      require("mini.comment").setup()
      require("mini.notify").setup({ lsp_progress = { enable = false } })
      vim.notify = require("mini.notify").make_notify()

      local miniclue = require("mini.clue")
      miniclue.setup({
        window = {
          delay = 500,
        },
        triggers = {
          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

          -- get telescope
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },

          -- git
          { mode = "n", keys = "t" },
          { mode = "x", keys = "t" },

          -- trouble
          { mode = "n", keys = "x" },
          { mode = "x", keys = "x" },

          -- obsidian
          { mode = "n", keys = "o" },
          { mode = "x", keys = "o" },

          -- overseer
          { mode = "n", keys = "v" },
          { mode = "x", keys = "v" },

          -- lsp
          { mode = "n", keys = "l" },
          { mode = "x", keys = "l" },
          { mode = "n", keys = "r" },
          { mode = "x", keys = "r" },

          -- Marks
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },

          -- Registers
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },
        },
        clues = {
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
        },
      })
    end,
  },
}
