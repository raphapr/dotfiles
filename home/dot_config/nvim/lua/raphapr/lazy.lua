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

local constants = require("raphapr.config.constants")
vim.g.mapleader = constants.leaders.leader
vim.g.maplocalleader = constants.leaders.localleader

require("lazy").setup("raphapr.plugins")
