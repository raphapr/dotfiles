return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim",
  },
  cmd = { "CodeCompanionChat", "CodeCompanion", "CodeCompanionActions" },
  lazy = true,
  opts = {
    strategies = {
      chat = {
        adapter = "copilot",
        tools = {
          ["mcp"] = {
            callback = function()
              return require("mcphub.extensions.codecompanion")
            end,
            description = "Call tools and resources from the MCP Servers",
          },
        },
      },
      inline = {
        adapter = "copilot",
      },
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
