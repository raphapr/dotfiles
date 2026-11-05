require("render-markdown").setup({
  file_types = { "markdown", "gitcommit" },
  html = { enabled = false },
  latex = { enabled = false },
  -- In-process LSP, so blink.cmp gets callout and checkbox completions.
  completions = { lsp = { enabled = true } },
})
vim.keymap.set("n", "<leader>mt", function()
  require("render-markdown").toggle()
end, { desc = "Misc: Toggle render-markdown" })
