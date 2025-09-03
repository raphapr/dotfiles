local M = {}

function M.setup()
  -- Reserve a space in the gutter
  -- This will avoid an annoying layout shift in the screen
  vim.opt.signcolumn = "yes"

  local lsp_defaults = require("lspconfig").util.default_config

  -- Add cmp_nvim_lsp capabilities settings to lspconfig
  -- This should be executed before you configure any language server
  lsp_defaults.capabilities = vim.tbl_deep_extend(
    "force", 
    lsp_defaults.capabilities, 
    require("cmp_nvim_lsp").default_capabilities()
  )

  -- LspAttach is where you enable features that only work
  -- if there is a language server active in the file
  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
      require("raphapr.keymaps.lsp").setup_keymaps(event)
    end,
  })

  vim.lsp.set_log_level("off")

  -- Setup diagnostics
  require("raphapr.lsp.diagnostics").setup()

  -- Setup Mason and LSP servers
  require("raphapr.lsp.servers").setup()
end

return M