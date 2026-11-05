-- File explorer sidebar. Also opens for directories (`nvim .`, `:e dir`).
local api = require("nvim-tree.api")

local function open_tab_silent(node)
  api.node.open.tab(node)
  vim.cmd.tabprev()
end

local function on_attach(bufnr)
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set("n", "Z", api.node.run.system, opts("Run System"))
  vim.keymap.set("n", "s", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "i", api.node.open.horizontal, opts("Open: Horizontal Split"))
  vim.keymap.set("n", "T", open_tab_silent, opts("Open Tab Silent"))
  -- Same split keys as the pickers: <C-s> horizontal, <C-v> vertical, <C-t> tab.
  vim.keymap.set("n", "<C-s>", api.node.open.horizontal, opts("Open: Horizontal Split"))
end

require("nvim-tree").setup({
  on_attach = on_attach,
  -- netrw is already disabled in options.lua, so skip hijacking its (missing)
  -- FileExplorer autocmds. disable_netrw keeps hijack_directories working, so
  -- `nvim .` and `:e dir` open the tree.
  hijack_netrw = false,
  disable_netrw = true,
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    show_on_open_dirs = true,
  },
  actions = {
    change_dir = {
      enable = true,
      global = true,
    },
  },
  view = {
    adaptive_size = true,
  },
})

vim.keymap.set("n", "<F10>", api.tree.toggle, { desc = "Tree: Toggle sidebar" })
