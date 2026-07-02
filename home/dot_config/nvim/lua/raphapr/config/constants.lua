local M = {}

-- File paths
M.paths = {
  nvim_config = "~/.config/nvim/lua/raphapr/init.lua",
  fish_config = "~/.config/fish/config.fish",
  i3_config = "~/.i3/config",
  backlog = "~/Cloud/Sync/notebook/backlog.md",
  luasnip = "~/.config/nvim/lua/raphapr/luasnip/",
  undodir = vim.fn.stdpath("state") .. "/undo",
  backupdir = vim.fn.stdpath("state") .. "/backup",
}

-- Leaders
M.leaders = {
  leader = ",",
  localleader = ";",
}

return M