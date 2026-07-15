local M = {}

function M.setup()
  local runtime_dir = vim.env.XDG_RUNTIME_DIR or ("/run/user/" .. vim.uv.os_get_passwd().uid)
  local gopls_socket = "unix;" .. runtime_dir .. "/gopls-daemon-socket"

  local servers = {
    "lua_ls",
    "ts_ls",
    "eslint",
    "jsonls",
    "pyright",
    "bashls",
    "terraformls",
    "yamlls",
    "dockerls",
    "gopls",
    "harper_ls",
    "ruff",
  }

  require("mason").setup()
  require("mason-lspconfig").setup({
    automatic_installation = false,
    ensure_installed = servers,
  })

  -- Configure LSP servers

  -- Lua
  vim.lsp.config("lua_ls", {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
    -- runtime/workspace/globals are handled by lazydev.nvim
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
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

  -- Terraform. tflint is intentionally NOT enabled here: it ran a second
  -- langserver per buffer with --call-module-type=all, adding load without
  -- fixing the freeze. Run tflint from the CLI when needed. The freeze is
  -- terraform-ls loading ~580MB of aws/kubernetes/helm provider schemas on a
  -- low-RAM machine; scoping the root did not help, so default markers stay.
  vim.lsp.config("terraformls", {
    cmd = { "terraform-ls", "serve" },
    filetypes = { "terraform", "terraform-vars" },
    root_markers = { ".terraform", ".git" },
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
    cmd = { "gopls", "-remote", gopls_socket },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.work", "go.mod", ".git" },
    settings = {
      gopls = {
        buildFlags = { "-tags=integration" },
      },
    },
  })

  -- Harper
  vim.lsp.config("harper_ls", {
    filetypes = { "markdown" },
    settings = {
      ["harper-ls"] = {
        userDictPath = "~/Cloud/Sync/harper_dictionary",
        isolateEnglish = true,
        linters = {
          SentenceCapitalization = false,
        },
        codeActions = {
          forceStable = true,
        },
        markdown = {
          IgnoreLinkTitle = true,
        },
      },
    },
  })

  -- Enable all configured language servers
  for _, server in ipairs(servers) do
    vim.lsp.enable(server)
  end
end

return M
