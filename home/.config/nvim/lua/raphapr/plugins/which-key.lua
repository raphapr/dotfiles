local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    g = {
      name = "+get telescope",
    },
    t = {
      name = "+git/tab",
    },
    b = {
      name = "+harpoon",
    },
  },
})
