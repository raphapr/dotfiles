local M = {}

function M.setup()
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
end

return M

