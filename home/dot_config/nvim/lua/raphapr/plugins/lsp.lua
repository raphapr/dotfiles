return {
  ------------------------------------------------------
  -- lsp-signature
  ------------------------------------------------------
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    config = function()
      require("lsp_signature").setup({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
          border = "rounded",
        },
        hint_prefix = "󰏚  ",
      })
    end,
  },
  ------------------------------------------------------
  -- lazydev
  ------------------------------------------------------
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  ------------------------------------------------------
  -- Autocompletion
  ------------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-cmdline" },
      { "mtoohey31/cmp-fish" },
      { "petertriho/cmp-git" },
      { "onsails/lspkind-nvim" },
      { "saadparwaiz1/cmp_luasnip" },
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        preselect = "item",
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        window = {
          documentation = cmp.config.window.bordered(),
        },
        sources = {
          { name = "path" },
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "fish" },
          { name = "git" },
          { name = "render-markdown" },
          { name = "buffer", keyword_length = 3 },
          { name = "luasnip", keyword_length = 2 },
          { name = "cmp_yanky" },
          { name = "lazydev", group_index = 0 },
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
          ["<C-f>"] = cmp.mapping.scroll_docs(5),
          ["<C-u>"] = cmp.mapping.scroll_docs(-5),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
          -- Simple tab complete
          ["<Tab>"] = cmp.mapping(function(fallback)
            local col = vim.fn.col(".") - 1
            if cmp.visible() then
              cmp.select_next_item({ behavior = "select" })
            elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
              fallback()
            else
              cmp.complete()
            end
          end, { "i", "s" }),
        }),
        formatting = {
          expandable_indicator = true,
          fields = { "abbr", "kind", "menu" },
          format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            menu = {
              nvim_lsp = "[lsp]",
              nvim_lua = "[lua-api]",
              path = "[path]",
              luasnip = "[snip]",
              buffer = "[buf]",
              gh_issues = "[issue]",
              cmp_yanky = "[yanky]",
              render_markdown = "[markdown]",
              fish = "[fish]",
            },
          }),
        },
      })
      require("cmp_git").setup({})

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "buffer" },
        }),
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline", keyword_length = 3 },
        }),
      })
    end,
  },
  ------------------------------------------------------
  -- LSP
  ------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    cmd = "LspInfo",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      { "rafamadriz/friendly-snippets" },
    },
    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = "yes"
    end,
    config = function()
      local lsp_defaults = require("lspconfig").util.default_config

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      lsp_defaults.capabilities = vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local U = require("raphapr.utils")
          local function opts(desc)
            return { desc = "LSP: " .. desc, buffer = event.buf, remap = false, silent = true }
          end
          vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, buffer = event.buf })
          vim.keymap.set("n", "<leader>li", vim.cmd.LspInfo, opts("Info"))
          vim.keymap.set("n", "<leader>ls", ":LspStop<CR>:lua vim.notify('lsp stopped')<CR>", opts("Stop"))
          vim.keymap.set("n", "<leader>lt", ":LspStart<CR>:lua vim.notify('lsp started')<CR>", opts("Start"))
          vim.keymap.set("n", "<leader>le", ":LspRestart<CR>:lua vim.notify('lsp restart')<CR>", opts("Restart"))
          vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover() <cr>", opts("Hover function"))
          vim.keymap.set("n", "[[", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts("Go to previous issue"))
          vim.keymap.set("n", "]]", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts("Go to next issue"))
          vim.keymap.set("n", "grd", "<cmd>lua vim.lsp.buf.definition() <cr>", opts("Go to definition"))
          vim.keymap.set("n", "grs", U.go_to_definition_split, opts("Go to definition (split)"))
          vim.keymap.set("n", "grr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts("References"))
          vim.keymap.set("n", "grn", "<cmd>lua vim.lsp.buf.rename() <cr>", opts("Rename"))
          vim.keymap.set("n", "gri", "<cmd>lua vim.lsp.buf.implementation() <cr>", opts("Implementation"))
          vim.keymap.set("n", "gra", "<cmd>lua vim.lsp.buf.code_action() <cr>", opts("Code action"))
          vim.keymap.set("n", "grc", "<ccd>lua vim.diagnostic.reset() <cr>", opts("Clear diagnotics"))
        end,
      })

      vim.lsp.set_log_level("off")

      ------------------------------------------------------
      -- diagnostics
      ------------------------------------------------------

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

      ------------------------------------------------------
      -- mason
      ------------------------------------------------------

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
          "harper_ls",
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

          ["harper_ls"] = function()
            require("lspconfig").harper_ls.setup({
              filetypes = { "markdown" },
              settings = {
                ["harper-ls"] = {
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
          end,

          ["yamlls"] = function()
            require("lspconfig").yamlls.setup({
              settings = {
                yaml = {
                  keyOrdering = false,
                },
              },
            })
          end,

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
    end,
  },
}
