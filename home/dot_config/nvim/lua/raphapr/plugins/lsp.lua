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
      { "hrsh7th/cmp-nvim-lsp" },
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
      lsp.preset("recommended")

      lsp.on_attach(function(_, bufnr)
        local function opts(desc)
          return { desc = "lsp: " .. desc, buffer = bufnr, remap = false, silent = true }
        end

        local U = require("raphapr.utils")

        vim.keymap.set("n", "<leader>li", vim.cmd.LspInfo, opts("info"))

        vim.keymap.set(
          "n",
          "<leader>ls",
          ":LspStop<CR>:lua vim.notify('lsp stopped')<CR>",
          { silent = true, desc = "lsp: stop" }
        )

        vim.keymap.set(
          "n",
          "<leader>lr",
          ":LspRestart<CR>:lua vim.notify('lsp restart')<CR>",
          { silent = true, desc = "lsp: restart" }
        )

        vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })

        vim.keymap.set("n", "gd", function()
          vim.lsp.buf.definition()
        end, opts("go to definition"))
        vim.keymap.set("n", "gs", U.go_to_definition_split, opts("go to definition (split)"))
        vim.keymap.set("n", "gr", function()
          require("telescope.builtin").lsp_references()
        end, opts("references"))
        vim.keymap.set("n", "gl", function()
          vim.diagnostic.open_float()
        end, opts("open float window"))
        vim.keymap.set("n", "K", function()
          vim.lsp.buf.hover()
        end, opts("hover function"))
        vim.keymap.set("n", "<leader>ca", function()
          vim.lsp.buf.code_action()
        end, opts("code action"))
        vim.keymap.set("n", "<leader>rn", function()
          vim.lsp.buf.rename()
        end, opts("rename"))
        vim.keymap.set("n", "[[", function()
          vim.diagnostic.goto_next()
        end, opts("go to next issue"))
        vim.keymap.set("n", "]]", function()
          vim.diagnostic.goto_prev()
        end, opts("go to previous issue"))
      end)

      lsp.set_sign_icons({
        error = "✘",
        warn = "▲",
        hint = "⚑",
        info = "",
      })

      ------------------------------------------------------
      -- diagnotics
      ------------------------------------------------------

      vim.diagnostic.config({
        virtual_text = false,
        severity_sort = true,
        float = {
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      vim.diagnostic.config({
        virtual_text = true,
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
          yamlls = function()
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
      local cmp_format = lsp.cmp_format()
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        formatting = cmp_format,
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
          ["<C-e>"] = cmp_action.toggle_completion(),

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
