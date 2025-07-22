return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Extensions
      "ravitemer/mcphub.nvim",
      "ravitemer/codecompanion-history.nvim",
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
      extensions = {
        history = {
          enabled = true,
          opts = {
            keymap = "gh",
            auto_generate_title = true,
            continue_last_chat = false,
          },
        },
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
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
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "MCPHub",
    build = "npm install -g mcp-hub@latest",
    config = function()
      require("mcphub").setup({
        auto_approve = false,
        auto_toggle_mcp_servers = true,
        -- Extensions configuration
        extensions = {
          codecompanion = {
            show_result_in_chat = true, -- Show the mcp tool result in the chat buffer
            make_vars = true, -- make chat #variables from MCP server resources
            make_slash_commands = true, -- make /slash commands from MCP server prompts
          },
        },
      })
    end,
  },
}
