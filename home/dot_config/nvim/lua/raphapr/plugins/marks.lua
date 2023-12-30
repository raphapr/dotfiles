return {
  {
    "chentoast/marks.nvim",
    opts = {
      -- whether to map keybinds or not. default true
      default_mappings = false,
      -- which builtin marks to show. default {}
      builtin_marks = { ".", "<", ">", "^" },
      force_write_shada = true,
      mappings = {
        set = "m",                -- set mark
        set_next = "m,",          -- set the next available alphabetical (lowercase) mark
        delete = "dm",            -- delete mark
        delete_buf = "dm<space>", -- delete all marks in the current buffer
        delete_line = "dm-",      -- delete all marks on the current line
        next = "<leader>ss",      -- goes to the next mark in buffer
        preview = "m<leader>",    -- preview maek
      },
    },
  },
}
