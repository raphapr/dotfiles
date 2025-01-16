return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    ft = { "norg" },
    cmd = "Neorg",
    build = ":Neorg sync-parsers",
    dependencies = { { "pysan3/neorg-templates", dependencies = { "L3MON4D3/LuaSnip" } } },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["external.templates"] = {},
          ["core.summary"] = { config = { strategy = "by_path" } },
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
      vim.keymap.set("n", "<leader>nn", ":Neorg workspace notes<CR>", { desc = "Neorg: Open workspace notes" })
      vim.keymap.set("n", "<leader>nj", ":Neorg journal today<CR>", { desc = "Neorg: Open journal today" })
      vim.keymap.set("n", "<leader>nt", ":Neorg templates load journal<CR>", { desc = "Neorg: Load journal template" })
      vim.api.nvim_create_autocmd("Filetype", {
        pattern = "norg",
        callback = function()
          vim.wo.foldlevel = 99
          vim.wo.conceallevel = 2
          vim.keymap.set("n", "<CR>", "<Plug>(neorg.esupports.hop.hop-link)", { buffer = true })
        end,
      })
    end,
  },
}
