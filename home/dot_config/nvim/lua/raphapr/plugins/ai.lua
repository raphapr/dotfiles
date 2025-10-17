return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
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
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = { "InsertEnter", "LspAttach", "VeryLazy" },
    config = function()
      require("copilot").setup({
        panel = {
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<C-l>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          [""] = false, -- fix keymaps conflict with telescope
          yaml = true,
          markdown = true,
        },
      })
    end,
  },
}
