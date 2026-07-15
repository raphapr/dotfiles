-- Minimal, network-independent Neovim configuration for Kitty scrollback.

vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.keymap.set("n", "q", "<cmd>qa!<cr>", { silent = true })

vim.opt.scrollback = 100000
vim.opt.termguicolors = true
vim.opt.laststatus = 0
vim.opt.showmode = false
vim.opt.clipboard:append("unnamedplus")

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
    local input_line = tonumber(vim.env.INPUT_LINE_NUMBER) or 0
    local cursor_line = tonumber(vim.env.CURSOR_LINE) or 0
    local cursor_column = tonumber(vim.env.CURSOR_COLUMN) or 0

    vim.fn.cursor(math.max(1, input_line - 1 + cursor_line), math.max(1, cursor_column))
  end,
})
