local M = {}

-- File paths
M.paths = {
  nvim_config = "~/.config/nvim/lua/raphapr/init.lua",
  fish_config = "~/.config/fish/config.fish",
  i3_config = "~/.i3/config",
  backlog = "~/Cloud/Sync/notebook/backlog.md",
  luasnip = "~/.config/nvim/lua/raphapr/luasnip/",
  undodir = vim.env.HOME .. "/.config/nvim/undodir",
  backupdir = vim.env.HOME .. "/.config/nvim/tmp/backup",
}

-- Leaders
M.leaders = {
  leader = ",",
  localleader = ";",
}

return M