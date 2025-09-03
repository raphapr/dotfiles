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
      require("raphapr.lsp.completion").setup()
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
    config = function()
      require("raphapr.lsp").setup()
    end,
  },
}
