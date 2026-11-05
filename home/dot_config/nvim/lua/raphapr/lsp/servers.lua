local M = {}

-- Mason package names; nvim-lspconfig provides cmd, filetypes and root markers.
local mason_packages = {
  "bash-language-server",
  "dockerfile-language-server",
  "eslint-lsp",
  "fish-lsp",
  "gopls",
  "json-lsp",
  "lua-language-server",
  "pyright",
  "ruff",
  "terraform-ls",
  "typescript-language-server",
  "yaml-language-server",
}

local function ensure_installed()
  local registry = require("mason-registry")
  registry.refresh(vim.schedule_wrap(function()
    for _, name in ipairs(mason_packages) do
      local ok, package = pcall(registry.get_package, name)
      if ok and not package:is_installed() and not package:is_installing() then
        package:install()
      end
    end
  end))
end

function M.setup()
  require("mason").setup()
  ensure_installed()

  vim.lsp.config("lua_ls", {
    -- runtime/library come from lua/raphapr/.luarc.json
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  })

  vim.lsp.config("pyright", {
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

  -- tflint is intentionally NOT enabled: it ran a second langserver per buffer
  -- with --call-module-type=all, adding load without fixing the freeze. Run
  -- tflint from the CLI when needed. The freeze is terraform-ls loading ~580MB
  -- of aws/kubernetes/helm provider schemas on a low-RAM machine; scoping the
  -- root did not help, so nvim-lspconfig's default markers stay.

  local runtime_dir = vim.env.XDG_RUNTIME_DIR or ("/run/user/" .. vim.uv.os_get_passwd().uid)
  vim.lsp.config("gopls", {
    cmd = { "gopls", "-remote", "unix;" .. runtime_dir .. "/gopls-daemon-socket" },
    settings = {
      gopls = {
        buildFlags = { "-tags=integration" },
      },
    },
  })

  vim.lsp.enable({
    "bashls",
    "dockerls",
    "eslint",
    "fish_lsp",
    "gopls",
    "jsonls",
    "lua_ls",
    "pyright",
    "ruff",
    "terraformls",
    "ts_ls",
    "yamlls",
  })

  vim.api.nvim_create_user_command("GoModTidy", function()
    vim.cmd.write()
    vim.cmd("!go mod tidy -v")
    vim.cmd.LspRestart()
    vim.notify("go mod tidy finished")
  end, { desc = "Go: Run go mod tidy and restart lsp" })
  vim.keymap.set("n", "gom", "<cmd>GoModTidy<CR>", { desc = "Go: Run go mod tidy and restart lsp" })
end

return M
