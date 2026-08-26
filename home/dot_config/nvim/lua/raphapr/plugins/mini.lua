return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    event = { "User LazyUIEnter", "LspAttach" },
    keys = {
      { "<C-e>", ":lua require('mini.bufremove').delete()<CR>", silent = true },
      { "<leader>bd", ":lua require('mini.bufremove').delete()<CR>", silent = true, desc = "Buffer: Delete" },
      { "<Esc>", "<ESC>:noh<CR>:lua require('mini.notify').clear()<CR>", silent = true },
    },
    config = function()
      require("mini.indentscope").setup()
      require("mini.bufremove").setup()
      require("mini.surround").setup()
      require("mini.notify").setup({ lsp_progress = { enable = false } })
      require("mini.pairs").setup({ mappings = { ["`"] = false } })
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
          { mode = { "n", "x" }, keys = "<Leader>" },

          -- Navigation families
          { mode = "n", keys = "[" },
          { mode = "n", keys = "]" },
          { mode = { "n", "x" }, keys = "g" },
          { mode = "n", keys = "<C-w>" },
          { mode = { "n", "x" }, keys = "z" },

          -- Built-in completion
          { mode = "i", keys = "<C-x>" },

          -- Marks
          { mode = { "n", "x" }, keys = "'" },
          { mode = { "n", "x" }, keys = "`" },

          -- Registers
          { mode = { "n", "x" }, keys = '"' },
          { mode = { "i", "c" }, keys = "<C-r>" },
        },
        clues = {
          miniclue.gen_clues.square_brackets(),
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),

          -- Normal mode
          { mode = "n", keys = "<leader>v", desc = "venv-selector" },
          { mode = "n", keys = "<leader>f", desc = "Find" },
          { mode = "n", keys = "<leader>b", desc = "Buffers" },
          { mode = "n", keys = "<leader>g", desc = "Git" },
          { mode = "n", keys = "<leader>x", desc = "Diagnostics" },
          { mode = "n", keys = "<leader>e", desc = "Edit" },
          { mode = "n", keys = "<leader>m", desc = "Miscellaneous" },
          { mode = "n", keys = "<leader>z", desc = "zk" },
          { mode = "n", keys = "<leader>l", desc = "LSP" },
          { mode = "n", keys = "go", desc = "Go" },
          { mode = "n", keys = "gr", desc = "LSP" },
          { mode = "n", keys = "gh", desc = "Yank History" },

          -- Visual mode
          { mode = "x", keys = "<leader>f", desc = "Find" },
          { mode = "x", keys = "<leader>g", desc = "Git" },
          { mode = "x", keys = "<leader>b", desc = "Base64" },
          { mode = "x", keys = "<leader>z", desc = "zk" },
        },
      })
    end,
  },
}
