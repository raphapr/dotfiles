-- LSP-specific keymaps (set up in autocmd)

local M = {}

function M.setup_keymaps(event)
  local U = require("raphapr.config.utils")
  local function opts(desc)
    return { desc = "LSP: " .. desc, buffer = event.buf, remap = false, silent = true }
  end

  -- LSP management
  vim.keymap.set("n", "<leader>li", vim.cmd.LspInfo, opts("Info"))
  vim.keymap.set("n", "<leader>ls", ":LspStop<CR>:lua vim.notify('lsp stopped')<CR>", opts("Stop"))
  vim.keymap.set("n", "<leader>lt", ":LspStart<CR>:lua vim.notify('lsp started')<CR>", opts("Start"))
  vim.keymap.set("n", "<leader>le", ":LspRestart<CR>:lua vim.notify('lsp restart')<CR>", opts("Restart"))

  -- LSP functionality. K, grn, gri, gra, [d and ]d are Neovim defaults.
  vim.keymap.set("n", "[[", function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, opts("Go to previous issue"))
  vim.keymap.set("n", "]]", function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, opts("Go to next issue"))
  vim.keymap.set("n", "grd", "<cmd>lua vim.lsp.buf.definition() <cr>", opts("Go to definition"))
  vim.keymap.set("n", "grs", U.go_to_definition_split, opts("Go to definition (split)"))
  vim.keymap.set("n", "grr", function()
    MiniExtra.pickers.lsp({ scope = "references" })
  end, opts("References"))
  vim.keymap.set("n", "grc", "<cmd>lua vim.diagnostic.reset() <cr>", opts("Clear diagnostics"))
end

return M
