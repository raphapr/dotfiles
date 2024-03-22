return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "lua",
          "rust",
          "dockerfile",
          "python",
          "bash",
          "json",
          "markdown",
          "cmake",
          "fish",
          "comment",
          "go",
          "gomod",
          "gowork",
          "html",
          "regex",
          "hcl",
          "vim",
          "terraform",
          "http",
          "xml",
          "json",
          "yaml",
          "graphql",
        },
        highlight = {
          enable = true,
          disable = { "vim" },
          additional_vim_regex_highlighting = { "markdown" },
        },
      })
    end,
  },
}
