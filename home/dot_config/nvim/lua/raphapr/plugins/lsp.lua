return {
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
      -- Reserve space for diagnostic icons
      vim.opt.signcolumn = "yes"
    end,
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    },
    config = function()
      ------------------------------------------------------
      -- lsp-zero
      ------------------------------------------------------
      local lsp = require("lsp-zero")

      lsp.on_attach(function(_, bufnr)
        local function opts(desc) return { desc = "LSP: " .. desc, buffer = bufnr, remap = false, silent = true } end
        local U = require("raphapr.utils")

        vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })

        vim.keymap.set("n", "<leader>li", vim.cmd.LspInfo, opts("Info"))

        vim.keymap.set("n", "<leader>ls", ":LspStop<CR>:lua vim.notify('lsp stopped')<CR>",
          { silent = true, desc = "LSP: Stop" })

        vim.keymap.set("n", "<leader>lt", ":LspStart<CR>:lua vim.notify('lsp started')<CR>",
          { silent = true, desc = "LSP: Start" })

        vim.keymap.set("n", "<leader>le", ":LspRestart<CR>:lua vim.notify('lsp restart')<CR>",
          { silent = true, desc = "LSP: Restart" })

        vim.keymap.set("n", "<leader>lf", function() vim.diagnostic.open_float() end, opts("Open float window"))
        vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts("Code action"))
        vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, opts("Rename"))
        vim.keymap.set("n", "<leader>lc", function() vim.diagnostic.reset() end, opts("Clear diagnotics"))

        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts("Hover function"))
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts("go to definition"))
        vim.keymap.set("n", "gs", U.go_to_definition_split, opts("Go to definition (split)"))
        vim.keymap.set("n", "gr", function() require("telescope.builtin").lsp_references() end, opts("references"))
        vim.keymap.set("n", "[[", function() vim.diagnostic.goto_prev() end, opts("Go to previous issue"))
        vim.keymap.set("n", "]]", function() vim.diagnostic.goto_next() end, opts("Go to next issue"))
      end)

      lsp.set_sign_icons({
        error = "✘",
        warn = "▲",
        hint = "⚑",
        info = "",
      })

      vim.lsp.set_log_level("off")

      ------------------------------------------------------
      -- diagnotics
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
      })

      vim.diagnostic.config({
        virtual_text = false,
      })

      ------------------------------------------------------
      -- mason
      ------------------------------------------------------

      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = {
          "tsserver",
          "eslint",
          "gopls",
          "jsonls",
          "tflint",
          "pyright",
          "bashls",
          "terraformls",
          "yamlls",
          "helm_ls",
        },
        handlers = {
          lsp.default_setup,

          ------------------------
          -- lsp servers settings
          ------------------------

          function()
            local lua_opts = lsp.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
          end,

          function()
            require("lspconfig").yamlls.setup({
              settings = {
                yaml = {
                  keyOrdering = false,
                },
              },
            })
          end,

          function()
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

      ------------------------------------------------------
      -- cmp
      ------------------------------------------------------

      local cmp = require("cmp")
      local cmp_action = lsp.cmp_action()

      -- load friendly-snippets
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
          { name = "buffer",  keyword_length = 3 },
          { name = "luasnip", keyword_length = 2 },
        },
        mapping = cmp.mapping.preset.insert({
          -- toggle completion menu
          ["<C-e>"] = cmp_action.toggle_completion({}),

          -- tab complete
          ["<Tab>"] = cmp_action.tab_complete(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),

          -- navigate between snippet placeholder
          ["<C-d>"] = cmp_action.luasnip_jump_forward(),
          ["<C-b>"] = cmp_action.luasnip_jump_backward(),

          -- scroll documentation window
          ["<C-f>"] = cmp.mapping.scroll_docs(5),
          ["<C-u>"] = cmp.mapping.scroll_docs(-5),

          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
      })

      lsp.setup()
    end,
  },
}
