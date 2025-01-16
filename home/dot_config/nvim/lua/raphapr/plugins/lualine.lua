local function get_venv()
  local venv = vim.env.VIRTUAL_ENV
  if venv then
    return "venv:" .. venv:match(".*/(.*)$") .. ""
  else
    return ""
  end
end

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
    opts = {
      options = { theme = "catppuccin" },
      extensions = { "nvim-tree", "fzf", "trouble", "lazy" },
      path = 2,
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { { get_venv }, "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = {
          "location",
          {
            function()
              local schema = require("yaml-companion").get_buf_schema(0)
              if schema.result[1].name == "none" then
                return ""
              end
              return schema.result[1].name
            end,
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    },
  },
}
