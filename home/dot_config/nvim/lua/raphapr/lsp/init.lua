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

  vim.lsp.set_log_level("off")

  -- Setup diagnostics
  require("raphapr.lsp.diagnostics").setup()

  -- Setup completion
  require("raphapr.lsp.completion").setup()

  -- Setup LSP servers using native vim.lsp
  require("raphapr.lsp.servers").setup()
end

return M
