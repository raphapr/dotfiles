return {
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local nls = require("null-ls")
      local U = require("raphapr.utils")

      local fmt = nls.builtins.formatting
      local diag = nls.builtins.diagnostics

      nls.setup({
        sources = {
          fmt.black.with({ extra_args = { "--fast" } }),
          fmt.shfmt,
          fmt.gofumpt,
          fmt.terraform_fmt,
          fmt.stylua.with({ extra_args = { "--column_width 150" } }),
          fmt.prettier.with({
            filetypes = { "html", "css", "yaml", "markdown", "json" },
          }),
          diag.hadolint,
        },
        on_attach = function(client, bufnr)
          U.fmt_on_save(client, bufnr)
        end,
      })
    end,
  },
}
