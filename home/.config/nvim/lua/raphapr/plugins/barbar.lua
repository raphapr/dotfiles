vim.g.barbar_auto_setup = true

require("barbar").setup({
  tabpages = true,
  clickable = false,
  icons = {
    button = false,
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true, icon = "ﬀ" },
    },
    gitsigns = {
      added = { enabled = true, icon = "+" },
      changed = { enabled = true, icon = "~" },
      deleted = { enabled = true, icon = "-" },
    },
  },
})

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Re-order to previous/next
map("n", "<A-Right>", "<Cmd>BufferMoveNext<CR>", opts)
map("n", "<A-Left>", "<Cmd>BufferMovePrevious<CR>", opts)
-- Pin/unpin buffer
map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
map("n", "<A-i>", "<Cmd>BufferPick<CR>", opts)
