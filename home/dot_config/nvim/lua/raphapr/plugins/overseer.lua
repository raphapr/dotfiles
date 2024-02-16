return {
  "stevearc/overseer.nvim",
  enabled = true,
  keys = {
    { "<leader>vr", "<cmd>OverseerRun<cr>",    desc = "Overseer Run" },
    { "<leader>vv", "<cmd>OverseerToggle<cr>", desc = "Overseer" },
  },
  config = function()
    require("overseer").setup({ templates = { "builtin", "user" } })
  end,
}
