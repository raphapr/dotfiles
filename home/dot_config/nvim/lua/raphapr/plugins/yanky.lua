return {
  {
    "gbprod/yanky.nvim",
    dependencies = { "kkharji/sqlite.lua" },
    event = "VeryLazy",
    keys = {
      { "gh", ":Telescope yank_history<CR>", noremap = true, silent = true, desc = "Yanky History" },
    },
    config = function()
      local utils = require("yanky.utils")
      -- Resolve telescope modules on first use; requiring them here would load
      -- telescope (and its extensions) at VeryLazy on every startup.
      local function mapping(name, ...)
        local args = { ... }
        return function(prompt_bufnr)
          return require("yanky.telescope.mapping")[name](unpack(args))(prompt_bufnr)
        end
      end
      local function action(name)
        return function(prompt_bufnr)
          return require("telescope.actions")[name](prompt_bufnr)
        end
      end
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
          on_yank = false, -- TextYankPost in autocmds.lua already highlights yanks
          timer = 300,
        },
        textobj = {
          enabled = false,
        },
        picker = {
          telescope = {
            mappings = {
              default = mapping("put", "p"),
              i = {
                ["<c-j>"] = action("move_selection_next"),
                ["<c-k>"] = action("move_selection_previous"),
                ["<c-p>"] = mapping("put", "p"),
                ["<c-g>"] = mapping("put", "P"),
                ["<c-x>"] = mapping("delete"),
                ["<c-r>"] = mapping("set_register", utils.get_default_register()),
              },
              n = {
                p = mapping("put", "p"),
                P = mapping("put", "P"),
                d = mapping("delete"),
                r = mapping("set_register", utils.get_default_register()),
              },
            },
          },
        },
      })
    end,
  },
}
