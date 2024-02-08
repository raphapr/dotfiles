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
          v = {
            name = "+overseer",
          },
          c = {
            name = "+(comment/telescope/ci/lsp)",
          },
          l = {
            name = "+lsp (start/stop)",
          },
          r = {
            name = "+lsp (rename)",
          },
          e = {
            name = "+edit",
          },
        },
      })
    end,
  },
}
