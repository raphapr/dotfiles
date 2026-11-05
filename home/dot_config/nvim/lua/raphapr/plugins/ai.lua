-- Start Copilot on first insert, not at startup.
vim.api.nvim_create_autocmd("InsertEnter", {
  group = vim.api.nvim_create_augroup("CopilotSetup", { clear = true }),
  once = true,
  callback = function()
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
})
