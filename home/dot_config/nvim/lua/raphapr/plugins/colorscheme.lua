return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      integrations = {
        overseer = true,
        codecompanion = true,
        flash = true,
        fzf = true,
        gitsigns = true,
        markdown = true,
        cmp = true,
        lsp_trouble = true,
        telescope = { enabled = true },
        mini = {
          enabled = true,
          indentscope_color = "", -- catppuccin color (eg. `lavender`) Default: text
        },
      },
    },
    config = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
