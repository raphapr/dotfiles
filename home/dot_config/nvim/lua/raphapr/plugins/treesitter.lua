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
    "help",
    "html",
    "http",
    "json",
    "yaml",
    "regex",
    "hcl",
    "vim",
    "terraform",
  },
  highlight = {
    enable = true,
    disable = { "vim" },
    additional_vim_regex_highlighting = { "markdown" },
  },
})