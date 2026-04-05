local M = {}

function M.setup()
  vim.opt.signcolumn = "yes"

  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  vim.lsp.config("*", {
    capabilities = capabilities,
  })

  -- LspAttach is where you enable features that only work
  -- if there is a lsp active in the file
  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
      require("raphapr.keymaps.lsp").setup_keymaps(event)
    end,
  })

  vim.lsp.log.set_level("off")

  -- Compat commands removed in 0.12 (replaced by :lsp and :checkhealth vim.lsp)
  vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", { desc = "Show LSP Info" })
  vim.api.nvim_create_user_command("LspRestart", "lsp restart", { desc = "Restart LSP" })
  vim.api.nvim_create_user_command("LspStop", "lsp stop", { desc = "Stop LSP" })
  vim.api.nvim_create_user_command("LspStart", "lsp start", { desc = "Start LSP" })

  -- Setup diagnostics
  require("raphapr.lsp.diagnostics").setup()

  -- Setup completion
  require("raphapr.lsp.completion").setup()

  -- Setup LSP servers using native vim.lsp
  require("raphapr.lsp.servers").setup()
end

return M
