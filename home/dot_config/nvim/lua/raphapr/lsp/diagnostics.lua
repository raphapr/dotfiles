local M = {}

function M.setup()
  vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
      style = "minimal",
      border = "rounded",
      source = false,
      header = "",
      prefix = "",
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "✘",
        [vim.diagnostic.severity.WARN] = "▲",
        [vim.diagnostic.severity.HINT] = "⚑",
        [vim.diagnostic.severity.INFO] = "»",
      },
    },
  })
end

return M