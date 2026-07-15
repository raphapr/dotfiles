return {
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>gn", "<cmd>Neogit<CR>", desc = "Git: Neogit" },
    },
    opts = {
      integrations = {
        diffview = true,
        telescope = true,
      },
    },
  },
}
