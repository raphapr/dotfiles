local M = {}

-- File paths
M.paths = {
  nvim_config = "~/.config/nvim/lua/raphapr/init.lua",
  fish_config = "~/.config/fish/config.fish",
  i3_config = "~/.i3/config",
  backlog = "~/Cloud/Sync/notebook/backlog.md",
  undodir = vim.fn.stdpath("state") .. "/undo",
}

-- Leaders
M.leaders = {
  leader = ",",
  localleader = ";",
}

return M