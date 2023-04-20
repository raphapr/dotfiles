vim.opt.background = "dark"

-- disable netrw in favor of nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- true colors
vim.opt.termguicolors = true

vim.opt.splitbelow = true
vim.opt.splitright = true

-- unified clipboard
vim.opt.clipboard = { "unnamed", "unnamedplus" }

-- enable syntax highlighting
vim.opt.background = "dark"
vim.opt.nu = true

-- settings for split windows
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Settings indentation style default
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.copyindent = true
vim.opt.preserveindent = true

-- Undo settings files
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
vim.opt.backupskip = "/tmp/*,/private/tmp/*"

-- show cursor column
vim.opt.cursorcolumn = true

-- improve perfomance
vim.opt.lazyredraw = true
vim.opt.ttyfast = true

-- set paste/nopaste
vim.opt.pastetoggle = "<F2>"

-- undo / backup
vim.opt.backup = true
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.backupdir = os.getenv("HOME") .. "/.config/nvim//tmo/backup"

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

-- folding
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
