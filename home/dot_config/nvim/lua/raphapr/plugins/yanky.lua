return {
  {
    "gbprod/yanky.nvim",
    dependencies = { "kkharji/sqlite.lua" },
    lazy = true,
    cmd = "Telescope yank_history",
    keys = {
      { ";;", ":Telescope yank_history<CR>", noremap = true, silent = true },
    },
    config = function()
      local utils = require("yanky.utils")
      local mapping = require("yanky.telescope.mapping")
      local actions = require("telescope.actions")
      require("yanky").setup({
        ring = {
          history_length = 100,
          storage = "sqlite",
          storage_path = os.getenv("HOME") .. "/Cloud/Sync/yanky.db",
        },
        system_clipboard = {
          sync_with_ring = false,
        },
        highlight = {
          timer = 300,
        },
        textobj = {
          enabled = false,
        },
        picker = {
          telescope = {
            mappings = {
              default = mapping.put("p"),
              i = {
                ["<c-j>"] = actions.move_selection_next,
                ["<c-k>"] = actions.move_selection_previous,
                ["<c-p>"] = mapping.put("p"),
                ["<c-g>"] = mapping.put("P"),
                ["<c-x>"] = mapping.delete(),
                ["<c-r>"] = mapping.set_register(utils.get_default_register()),
              },
              n = {
                p = mapping.put("p"),
                P = mapping.put("P"),
                d = mapping.delete(),
                r = mapping.set_register(utils.get_default_register()),
              },
            },
          },
        },
      })
    end,
  },
}
