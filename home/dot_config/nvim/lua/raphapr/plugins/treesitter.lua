return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    config = function()
      require("nvim-treesitter.configs").setup({
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        modules = {},
        ensure_installed = {
          "c",
          "lua",
          "luadoc",
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
          "tmux",
          "gitcommit",
          "helm",
          "csv",
          "clojure",
          "css",
          "gitignore",
          "ruby",
          "gosum",
          "gotmpl",
        },
        highlight = {
          enable = true,
          disable = { "vim" },
          additional_vim_regex_highlighting = { "markdown" },
        },
        incremental_selection = {
          enable = true,

          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "<TAB>",
            node_decremental = "<S-TAB>",
          }
        }
      })
    end,
  },
}
