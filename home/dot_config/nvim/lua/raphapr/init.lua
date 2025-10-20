local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("raphapr.config.options")
require("raphapr.config.autocmds")
require("raphapr.config.utils")
require("raphapr.lazy")
require("raphapr.keymaps")

local constants = require("raphapr.config.constants")
require("luasnip.loaders.from_lua").load({ paths = { constants.paths.luasnip } })
