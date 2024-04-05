return {
  {
    "msvechla/yaml-companion.nvim",
    branch = "kubernetes_crd_detection",
    ft = { "yaml" },
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      require("telescope").load_extension("yaml_schema")
      local cfg = require("yaml-companion").setup({
        builtin_matchers = { kubernetes = { enabled = true } },
      })
      require("lsp-zero").extend_lspconfig()
      require("lspconfig")["yamlls"].setup(cfg)
    end,
  },
}
