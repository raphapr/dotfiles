local opt = vim.opt
local g = vim.g

-------------------------------------- globals -----------------------------------------

-- disable netrw in favor of nvim-tree
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-------------------------------------- options -----------------------------------------

-- true colors
opt.termguicolors = true

opt.splitbelow = true
opt.splitright = true

-- enable syntax highlighting
opt.background = "dark"
opt.nu = true

-- settings for split windows
opt.splitbelow = true
opt.splitright = true

-- Settings indentation style default
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.smarttab = true
opt.expandtab = true
opt.autoindent = true
opt.copyindent = true
opt.preserveindent = true

-- Undo settings files
opt.undofile = true
opt.undolevels = 1000
opt.undoreload = 10000
opt.backupskip = "/tmp/*,/private/tmp/*"

-- show cursor column
opt.cursorcolumn = true

-- improve perfomance
opt.lazyredraw = true
opt.ttyfast = true

-- undo / backup
opt.backup = true
opt.swapfile = false
opt.undodir = vim.env.HOME .. "/.config/nvim/undodir"
opt.backupdir = vim.env.HOME .. "/.config/nvim/tmo/backup"

-- prepend mise shims to PATH
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH

vim.g.python3_host_prog = vim.env.HOME .. "/.virtualenvs/neovim/bin/python"

-------------------------------------- folding -----------------------------------------

vim.cmd([[
set foldmethod=marker
set foldmarker={{{,}}}
set foldlevelstart=0   " It begins with marks closed

" Space to toggle folds.
nmap <Space> za
vmap <Space> za

function! MyFoldText() "
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction "
set foldtext=MyFoldText()
]])

-- Toggle all folds
vim.keymap.set("n", "zt", function()
  local get_opt = vim.api.nvim_win_get_option
  local set_opt = vim.api.nvim_win_set_option

  if get_opt(0, "foldlevel") >= 20 then
    set_opt(0, "foldlevel", 0)
  else
    set_opt(0, "foldlevel", 20)
  end
end, { noremap = true, silent = true, desc = "Fold: Toggle all folds" })
