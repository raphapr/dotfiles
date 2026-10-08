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
  -- Bare `:lsp enable` would also enable every nvim-lspconfig config for the filetype
  -- (e.g. stylua); re-enabling only the enabled ones restarts what `:lsp stop` killed.
  vim.api.nvim_create_user_command("LspStart", function()
    local configs = vim.lsp.get_configs({ enabled = true, filetype = vim.bo.filetype })
    vim.lsp.enable(vim.tbl_map(function(config)
      return config.name
    end, configs))
  end, { desc = "Start LSP" })

  -- Setup diagnostics
  require("raphapr.lsp.diagnostics").setup()

  -- Completion is set up by the nvim-cmp plugin spec (plugins/lsp.lua)

  -- Setup LSP servers using native vim.lsp
  require("raphapr.lsp.servers").setup()
end

return M
