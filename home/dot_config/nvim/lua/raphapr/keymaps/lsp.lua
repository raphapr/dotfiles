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

  -- LSP functionality
  vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover() <cr>", opts("Hover function"))
  vim.keymap.set("n", "[[", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts("Go to previous issue"))
  vim.keymap.set("n", "]]", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts("Go to next issue"))
  vim.keymap.set("n", "grd", "<cmd>lua vim.lsp.buf.definition() <cr>", opts("Go to definition"))
  vim.keymap.set("n", "grs", U.go_to_definition_split, opts("Go to definition (split)"))
  vim.keymap.set("n", "grr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts("References"))
  vim.keymap.set("n", "grn", "<cmd>lua vim.lsp.buf.rename() <cr>", opts("Rename"))
  vim.keymap.set("n", "gri", "<cmd>lua vim.lsp.buf.implementation() <cr>", opts("Implementation"))
  vim.keymap.set("n", "gra", "<cmd>lua vim.lsp.buf.code_action() <cr>", opts("Code action"))
  vim.keymap.set("n", "grc", "<cmd>lua vim.diagnostic.reset() <cr>", opts("Clear diagnostics"))

  -- Override conflicting keymap
  vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, buffer = event.buf })
end

return M

