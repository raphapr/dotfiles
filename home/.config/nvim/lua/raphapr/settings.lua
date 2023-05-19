local opt = vim.opt
local g = vim.g

-------------------------------------- globals -----------------------------------------

g.mapleader = ","

-- disable netrw in favor of nvim-tree
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-------------------------------------- options -----------------------------------------

opt.background = "dark"

-- Reserve space for diagnostic icons
vim.opt.signcolumn = "yes"

-- true colors
opt.termguicolors = true

opt.splitbelow = true
opt.splitright = true

-- unified clipboard
opt.clipboard = { "unnamed", "unnamedplus" }

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

-- set paste/nopaste
opt.pastetoggle = "<F2>"

-- undo / backup
opt.backup = true
opt.swapfile = false
opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
opt.backupdir = os.getenv("HOME") .. "/.config/nvim//tmo/backup"

-------------------------------------- autocmds ----------------------------------------

-- YAML
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "yaml", "yml" },
  callback = function()
    vim.api.nvim_command("setlocal ts=2 sts=2 sw=2 expandtab") -- get the 2-space YAML as the default when hit carriage return after the colon
    vim.api.nvim_command("match Error /\\t/") -- Highlight tabs as errors: https://vi.stackexchange.com/a/9353/3168
  end,
})

-- jump to the last place you’ve visited in a file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- highlight yank region
local autocmd = vim.api.nvim_create_autocmd
autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 200,
    })
  end,
})

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
