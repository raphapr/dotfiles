return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    ft = { "http" },
    cmd = { "Neorg" },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/Cloud/Sync/notes",
              },
              default_workspace = "notes",
            },
          },
        },
      })
      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
      vim.keymap.set("n", "<leader>n", ":Neorg workspace notes<CR>", { desc = "Neorg: Open workspace notes" })
      vim.api.nvim_create_autocmd("Filetype", {
        pattern = "norg",
        callback = function()
          vim.keymap.set("n", "<CR>", "<Plug>(neorg.esupports.hop.hop-link)", { buffer = true })
        end,
      })
    end,
  },
}
