local M = {}

function M.setup()
  require("mason").setup()
  require("mason-lspconfig").setup({
    automatic_installation = false,
    ensure_installed = {
      "lua_ls",
      "ts_ls",
      "eslint",
      "jsonls",
      "tflint",
      "pyright",
      "bashls",
      "terraformls",
      "ruff",
      "yamlls",
      "dockerls",
    },
  })

  -- Configure LSP servers

  -- Lua
  vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = { globals = { "vim" } },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  })

  -- TypeScript
  vim.lsp.config("ts_ls", {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_markers = { "package.json", "tsconfig.json", ".git" },
  })

  -- ESLint
  vim.lsp.config("eslint", {
    cmd = { "vscode-eslint-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
    root_markers = { ".eslintrc.js", ".eslintrc.json", ".eslintrc.yaml", ".eslintrc.yml", "package.json", ".git" },
  })

  -- JSON
  vim.lsp.config("jsonls", {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    root_markers = { ".git" },
  })

  -- Python
  vim.lsp.config("pyright", {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
    settings = {
      pyright = {
        analysis = {
          disableOrganizeImports = true, -- using Ruff
        },
      },
      python = {
        analysis = {
          ignore = { "*" }, -- using Ruff
        },
      },
    },
  })

  -- Ruff
  vim.lsp.config("ruff", {})

  -- Bash
  vim.lsp.config("bashls", {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash" },
    root_markers = { ".git" },
  })

  -- Terraform
  vim.lsp.config("terraformls", {
    cmd = { "terraform-ls", "serve" },
    filetypes = { "terraform", "terraform-vars" },
    root_markers = { ".terraform", ".git" },
  })

  -- TFLint
  vim.lsp.config("tflint", {
    cmd = {
      "tflint",
      "--disable-rule=terraform_required_providers",
      "--disable-rule=terraform_module_pinned_source",
      "--call-module-type=all",
      "--langserver",
    },
    filetypes = { "terraform" },
    root_markers = { ".terraform", ".git", ".tflint.hcl" },
  })

  -- YAML
  vim.lsp.config("yamlls", {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yaml.docker-compose" },
    root_markers = { ".git" },
  })

  -- Docker
  vim.lsp.config("dockerls", {
    cmd = { "docker-langserver", "--stdio" },
    filetypes = { "dockerfile" },
    root_markers = { "Dockerfile", ".git" },
  })

  -- Go
  vim.lsp.config("gopls", {
    cmd = { "gopls", "-remote", "unix;/tmp/gopls-daemon-socket" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.work", "go.mod", ".git" },
  })

  -- Enable all configured language servers
  local servers = {
    "lua_ls",
    "ts_ls",
    "eslint",
    "jsonls",
    "pyright",
    "bashls",
    "terraformls",
    "tflint",
    "yamlls",
    "dockerls",
    "gopls",
  }

  for _, server in ipairs(servers) do
    vim.lsp.enable(server)
  end
end

return M
