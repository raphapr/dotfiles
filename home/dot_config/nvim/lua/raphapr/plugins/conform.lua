return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    require("conform").setup({
      lsp_fallback = true,
      formatters_by_ft = {
        terraform = { "terraform_fmt" },
        sh = { "shfmt" },
        go = { "goimports", "gofmt" },
        python = { "ruff_format" },
        lua = { "stylua" },
        javascript = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
      },
      formatters = {
        stylua = {
          prepend_args = { "--column-width", "150" },
        },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })
  end,
}
