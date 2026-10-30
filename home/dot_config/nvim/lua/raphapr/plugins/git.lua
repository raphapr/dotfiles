return {
  -------------------------------------- gitsigns ---------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Git: Toggle current line blame" },
      { "<leader>gd", "<cmd>Gitsigns preview_hunk_inline<CR>", desc = "Git: Preview hunk inline" },
      { "<leader>ga", "<cmd>Gitsigns stage_hunk<CR>", desc = "Git: Stage hunk" },
      { "<leader>ga", ":Gitsigns stage_hunk<CR>", mode = "x", silent = true, desc = "Git: Stage selected lines" },
    },
    opts = {
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    },
  },
  -------------------------------------- gitlinker --------------------------------------
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = "VeryLazy",
    config = function()
      -- mappings = nil: keymaps are defined manually below with open_in_browser
      -- instead of the default copy-to-clipboard action
      require("gitlinker").setup({ mappings = nil })
      vim.keymap.set("n", "<leader>gy", function()
        require("gitlinker").get_buf_range_url("n", { action_callback = require("gitlinker.actions").open_in_browser })
      end, { silent = true, desc = "Git: Open permalink in browser" })

      vim.keymap.set("v", "<leader>gy", function()
        require("gitlinker").get_buf_range_url("v", { action_callback = require("gitlinker.actions").open_in_browser })
      end, { silent = true, desc = "Git: Open permalink in browser" })
    end,
  },
}
