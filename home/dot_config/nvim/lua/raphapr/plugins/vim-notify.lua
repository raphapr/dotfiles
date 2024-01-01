return {
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      local notify = require("notify")
      vim.notify = notify
      print = function(...)
        local print_safe_args = {}
        local _ = { ... }
        for i = 1, #_ do
          table.insert(print_safe_args, tostring(_[i]))
        end
        notify(table.concat(print_safe_args, " "), "info")
      end
      notify.setup()
    end,
    keys = {
      { "<Esc>", "<ESC>:noh<CR>:lua require('notify').dismiss()<CR>", silent = true },
    },
  },
}
