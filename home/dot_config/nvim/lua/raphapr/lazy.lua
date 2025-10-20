local constants = require("raphapr.config.constants")
vim.g.mapleader = constants.leaders.leader
vim.g.maplocalleader = constants.leaders.localleader

require("lazy").setup("raphapr.plugins")
