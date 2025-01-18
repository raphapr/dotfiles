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
          ["external.templates"] = {
            config = {
              keywords = { -- Add your own keywords.
                TODAY_CUSTOM = function()
                  local ls = require("luasnip")
                  local s = require("neorg.modules.external.templates.default_snippets")
                  os.setlocale("en_US.UTF-8", "time")
                  return ls.text_node(s.parse_date(0, s.file_name_date(), [[%Y-%m-%d %A]])) -- 2025-01-18 Friday
                end,
                NOW_IN_DATETIME = function() -- print current date+time of invoke
                  local ls = require("luasnip")
                  local s = require("neorg.modules.external.templates.default_snippets")
                  os.setlocale("en_US.UTF-8", "time")
                  return ls.text_node(s.parse_date(0, os.time(), [[%Y-%m-%d %A %X]])) -- 2025-01-18 Friday 23:48:10
                end,
              },
            },
          },
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
      vim.keymap.set("n", "<leader>nu", ":Neorg journal toc update<CR>", { desc = "Neorg: Update journal TOC" })
      vim.keymap.set("n", "<leader>nt", ":Neorg templates load journal<CR>", { desc = "Neorg: Load journal template" })
      vim.keymap.set("n", "<leader>no", ":Neorg templates load note<CR>", { desc = "Neorg: Load note template" })
      vim.keymap.set("n", "<leader>ns", ":Neorg generate-workspace-summary<CR>", { desc = "Neorg: Generate workspace summary" })
      vim.api.nvim_create_autocmd("Filetype", {
        pattern = "norg",
        callback = function()
          vim.wo.conceallevel = 2
          vim.keymap.set("n", "<CR>", "<Plug>(neorg.esupports.hop.hop-link)", { buffer = true })
        end,
      })
    end,
  },
}
