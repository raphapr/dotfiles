return {
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
          yaml = true,
          markdown = true,
        },
      })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    event = { "InsertEnter", "LspAttach", "VeryLazy" },
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = false,
    },
    keys = {
      { "<leader>cce", ":CopilotChatExplain<cr>",       mode = { "n", "x" },                                      desc = "CopilotChat: Explain selected code", },
      { "<leader>cct", ":CopilotChatTests<cr>",         mode = { "n", "x" },                                      desc = "CopilotChat: Generate tests", },
      { "<leader>cci", ":CopilotChatFix<cr>",           mode = { "n", "x" },                                      desc = "CopilotChat: Fix the selected code", },
      { "<leader>ccf", ":CopilotChatFixDiagnostic<cr>", mode = { "n", "x" },                                      desc = "CopilotChat: Fix Diagnostics", },
      { "<leader>ccr", ":CopilotChatReview<cr>",        mode = { "n", "x" },                                      desc = "CopilotChat: Review the selected code", },
      { "<leader>cco", ":CopilotChatOptimize<cr>",      mode = { "n", "x" },                                      desc = "CopilotChat: Optimize the selected code", },
      { "<leader>cca", ":CopilotChat<cr>",              mode = { "n", "x" },                                      desc = "CopilotChat: Open Chat" },
      { "<leader>ccc", ":CopilotChatToggle<cr>",        desc = "CopilotChat: Toggle Chat" },
      { "<leader>ccs", ":CopilotChatReset<cr>",         desc = "CopilotChat: Reset chat history and clear buffer" },
    },
  },
}
