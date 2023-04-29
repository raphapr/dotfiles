local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    g = {
      name = "+get telescope",
    },
    t = {
      name = "+git",
    },
    b = {
      name = "+harpoon",
    },
  },
})
