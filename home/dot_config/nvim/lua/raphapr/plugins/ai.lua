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
          [""] = false, -- fix keymaps conflict with telescope
          yaml = true,
          markdown = true,
        },
      })
    end,
  },
}
