local M = {}

function M.setup()
  require("mason").setup()
  require("mason-lspconfig").setup({
    automatic_installation = true,
    ensure_installed = {
      "lua_ls",
      "ts_ls",
      "eslint",
      "gopls",
      "jsonls",
      "tflint",
      "pyright",
      "bashls",
      "terraformls",
      "yamlls",
      "dockerls",
    },
    handlers = {
      -- default handler
      -- applies to every language server without a custom handler
      function(server_name)
        require("lspconfig")[server_name].setup({})
      end,

      ------------------------
      -- lsp servers settings
      ------------------------

      ["pyright"] = function()
        require("lspconfig").pyright.setup({
          settings = {
            pyright = {
              analysis = {
                disableOrganizeImports = true, -- using Ruff
              },
            },
            python = {
              analysis = {
                ignore = { "*" }, -- Using Ruff
              },
            },
          },
        })
      end,

      ["tflint"] = function()
        require("lspconfig").tflint.setup({
          cmd = {
            "tflint",
            "--disable-rule=terraform_required_providers",
            "--disable-rule=terraform_module_pinned_source",
            "--module",
            "--langserver",
          },
        })
      end,
    },
  })
end

return M
