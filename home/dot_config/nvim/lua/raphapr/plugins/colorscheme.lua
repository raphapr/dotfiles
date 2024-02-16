return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      integrations = { overseer = true },
    },
    config = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
