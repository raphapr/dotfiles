return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = { "CodeCompanionChat", "CodeCompanion", "CodeCompanionActions" },
  lazy = true,
  opts = {
    strategies = {
      chat = {
        adapter = "copilot",
      },
      inline = {
        adapter = "copilot",
      },
    },
    opts = {
      log_level = "DEBUG",
    },
  },
  keys = {
    { "<leader>cc", ":CodeCompanionChat<cr>", desc = "CodeCompanion: Toggle Chat" },
    { "<leader>ca", ":CodeCompanionActions<cr>", desc = "CodeCompanion: Actions" },
    { "<leader>ci", ":CodeCompanion ", desc = "CodeCompanion: Inline Assistant" },
    { "<leader>cc", mode = { "v" }, ":'<,'>CodeCompanionChat<cr>", desc = "CodeCompanion: Toggle Chat for selected code" },
    { "<leader>cf", mode = { "v" }, ":'<,'>CodeCompanion /fix<cr>", desc = "CodeCompanion: Fix selected code" },
  },
}
