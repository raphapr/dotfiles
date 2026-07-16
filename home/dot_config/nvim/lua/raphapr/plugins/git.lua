return {
  -------------------------------------- gitsigns ---------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    },
    config = function()
      require("gitsigns").setup()
      local U = require("raphapr.config.utils")
      vim.keymap.set("n", "<leader>go", function()
        U.run_async({ "gh", "browse" }, "GitHub")
      end, { silent = true, desc = "Git: Open project in browser" })
      vim.keymap.set(
        "n",
        "<leader>gb",
        ":Gitsigns toggle_current_line_blame<CR>",
        { desc = "Git: Toggle current line blame" }
      )
    end,
  },
  -------------------------------------- review.nvim ------------------------------------
  {
    "georgeguimaraes/review.nvim",
    version = "v*",
    dependencies = {
      "esmuellert/codediff.nvim",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Review",
    keys = {
      { "<leader>gr", "<cmd>Review<cr>", desc = "Git: Review changes" },
      { "<leader>gR", "<cmd>Review commits<cr>", desc = "Git: Review commits" },
    },
    opts = {},
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
