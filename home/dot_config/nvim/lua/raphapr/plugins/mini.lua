return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile", "LspAttach" },
    keys = {
      { "<C-e>", ":lua require('mini.bufremove').delete()<CR>", silent = true },
      { "<leader>bd", ":lua require('mini.bufremove').delete()<CR>", silent = true, desc = "Buffer: Delete" },
      -- Must stay a <Cmd> string: :nohlsearch has no effect when run inside a function.
      {
        "<Esc>",
        "<Cmd>nohlsearch<Bar>lua require('mini.notify').clear()<CR>",
        desc = "Clear search highlight and notifications",
      },
    },
    config = function()
      -- Hex color highlighting, skipped in markdown and yaml.
      local hipatterns = require("mini.hipatterns")
      local hex_color = hipatterns.gen_highlighter.hex_color()
      local hex_pattern = hex_color.pattern
      hex_color.pattern = function(buf_id)
        local filetype = vim.bo[buf_id].filetype
        if filetype == "markdown" or filetype == "yaml" then
          return nil
        end
        return hex_pattern(buf_id)
      end
      hipatterns.setup({ highlighters = { hex_color = hex_color } })

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
