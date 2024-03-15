return {
  {
    "someone-stole-my-name/yaml-companion.nvim",
    ft = { "yaml" },
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      require("telescope").load_extension("yaml_schema")
      local cfg = require("yaml-companion").setup({
        builtin_matchers = {
          kubernetes = { enabled = true },
        },
        schemas = {
          {
            name = "KEDA ScaledObject",
            uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/keda.sh/scaledobject_v1alpha1.json",
          },
          {
            name = "KEDA ScaledJob",
            uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/keda.sh/scaledjob_v1alpha1.json",
          },
          {
            name = "KEDA ClusterTriggerAuthentication",
            uri =
            "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/keda.sh/clustertriggerauthentication_v1alpha1.json",
          },
          {
            name = "KEDA TriggerAuthentication",
            uri =
            "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/keda.sh/triggerauthentication_v1alpha1.json",
          },
        },
      })
      require("lspconfig")["yamlls"].setup(cfg)
    end,
  },
}
