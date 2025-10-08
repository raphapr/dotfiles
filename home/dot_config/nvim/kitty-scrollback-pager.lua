-- Basic Neovim configuration for use as a scrollback pager in Kitty terminal

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { "norcalli/nvim-colorizer.lua" },
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      opts = { flavour = "mocha" },
      config = function()
        vim.cmd.colorscheme("catppuccin")
      end,
    },
    {
      "folke/flash.nvim",
      lazy = false,
      keys = { { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash", } },
    },
  },
  checker = { enabled = true },
})

vim.keymap.set("n", "q", "<cmd>qa!<cr>", { silent = true })

-- Configure settings for pager mode
vim.opt.scrollback = 100000
vim.opt.termguicolors = true
vim.opt.laststatus = 0
vim.opt.clipboard:append("unnamedplus")

-- Set up autocommands for terminal behavior
local pager_group = vim.api.nvim_create_augroup("ScrollbackPager", { clear = true })

vim.api.nvim_create_autocmd("TermEnter", {
  group = pager_group,
  callback = function()
    vim.cmd("stopinsert")
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  group = pager_group,
  callback = function()
    -- Handle cursor positioning (you may need to adjust this based on your needs)
    local input_line = vim.env.INPUT_LINE_NUMBER or 0
    local cursor_line = vim.env.CURSOR_LINE or 0
    local cursor_column = vim.env.CURSOR_COLUMN or 0

    vim.fn.cursor(math.max(0, tonumber(input_line) - 1) + tonumber(cursor_line), tonumber(cursor_column))
  end,
})
