require("lualine").setup({
  options = { theme = "gruvbox-material" },
  extensions = { "nvim-tree", "fzf", "fugitive" },
  path = 2,
  tabline = {
    lualine_a = { "buffers" },
    lualine_z = { "tabs" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
})
