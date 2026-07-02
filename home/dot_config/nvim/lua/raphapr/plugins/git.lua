return {
  -------------------------------------- fugitive ---------------------------------------
  {
    "tpope/vim-fugitive",
    event = { "VeryLazy" },
    cmd = { "G", "Git", "Gclog", "Gvdiffsplit" },
    keys = {
      { "<leader>tb", ":Git blame<CR>", silent = true, desc = "Git: Blame" },
    },
  },
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
      vim.keymap.set(
        "n",
        "<leader>to",
        ":!gh browse<CR><CR>",
        { silent = true, noremap = true, desc = "Git: Open the github project in the browser" }
      )
      vim.keymap.set("n", "<leader>tl", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Git: Toggle current line blame" })
    end,
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
      vim.keymap.set("n", "<leader>ty", function()
        require("gitlinker").get_buf_range_url("n", { action_callback = require("gitlinker.actions").open_in_browser })
      end, { silent = true, desc = "Git: Open permalink in browser" })

      vim.keymap.set("v", "<leader>ty", function()
        require("gitlinker").get_buf_range_url("v", { action_callback = require("gitlinker.actions").open_in_browser })
      end, { silent = true, desc = "Git: Open permalink in browser" })
    end,
  },
}
