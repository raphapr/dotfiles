vim.loader.enable()

local constants = require("raphapr.config.constants")
vim.g.mapleader = constants.leaders.leader
vim.g.maplocalleader = constants.leaders.localleader

require("raphapr.config.options")
require("raphapr.config.autocmds")
require("raphapr.plugins")
require("raphapr.ui")
require("raphapr.lsp").setup()
require("raphapr.keymaps")
