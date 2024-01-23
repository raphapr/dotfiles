return {
  {
    "folke/which-key.nvim",
    config = function()
      local wk = require("which-key")
      wk.register({
        ["<leader>"] = {
          g = {
            name = "+get telescope",
          },
          t = {
            name = "+git",
          },
          x = {
            name = "+trouble",
          },
          o = {
            name = "+obsidian",
          },
        },
      })
    end,
  },
}
