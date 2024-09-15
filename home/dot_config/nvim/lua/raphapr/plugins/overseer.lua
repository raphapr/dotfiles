return {
  "stevearc/overseer.nvim",
  enabled = true,
  keys = {
    { "<leader>vvr", "<cmd>OverseerRun<cr>",    desc = "Overseer: Run" },
    { "<leader>vvv", "<cmd>OverseerToggle<cr>", desc = "Overseer: Toggle panel" },
  },
  config = function()
    require("overseer").setup({ templates = { "builtin", "user" } })
  end,
}
