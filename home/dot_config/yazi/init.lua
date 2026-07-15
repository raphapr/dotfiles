-- ~/.config/yazi/init.lua
require("bookmarks"):setup({
  last_directory = {
    enable = true,
    persist = true,
    mode = "dir",
  },
  notify = {
    enable = true,
    timeout = 1,
    message = {
      new = "New bookmark '<key>' -> '<folder>'",
      delete = "Deleted bookmark in '<key>'",
      delete_all = "Deleted all bookmarks",
    },
  },
})
