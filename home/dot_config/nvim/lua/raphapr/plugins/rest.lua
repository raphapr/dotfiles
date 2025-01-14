return {
  {
    "rest-nvim/rest.nvim",
    lazy = true,
    ft = { "http" },
    config = function()
      vim.keymap.set("n", "<leader>rr", "<cmd>Rest run<cr>", { desc = "Rest: Run request under the cursor" })
      vim.keymap.set("n", "<leader>rl", "<cmd>Rest last<cr>", { desc = "Rest: Run last executed request" })
      vim.keymap.set("n", "<leader>re", "<cmd>Rest env show<cr>", { desc = "Rest: Show Env" })
      vim.keymap.set("n", "<leader>rc", "<cmd>Rest curl yank<cr>", { desc = "Rest: Copy curl command equivalent to the request" })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "http")
      end,
    },
  },
}
