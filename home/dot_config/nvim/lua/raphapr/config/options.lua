local opt = vim.opt
local g = vim.g

-------------------------------------- globals -----------------------------------------

-- disable netrw in favor of nvim-tree
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-------------------------------------- options -----------------------------------------

-- disable mouse
opt.mouse = ""

-- true colors
opt.termguicolors = true

-- window splitting
opt.splitbelow = true
opt.splitright = true

-- enable syntax highlighting
opt.background = "dark"
opt.number = true
opt.relativenumber = true

-- settings indentation style default
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.smarttab = true
opt.expandtab = true
opt.autoindent = true
opt.copyindent = true
opt.preserveindent = true

-- undo settings files
opt.undofile = true
opt.undolevels = 1000
opt.undoreload = 10000
opt.backupskip = "/tmp/*,/private/tmp/*"

-- cursor column and a highlighted current line number, without a cursor line
-- bar (autocmds.lua keeps both to the active window)
opt.cursorcolumn = true
opt.cursorline = true
opt.cursorlineopt = "number"

-- no `~` after the end of a buffer, blank fold filler, hatched diff filler lines,
-- and no vertical split line (dim_inactive already sets windows apart)
opt.fillchars = { eob = " ", fold = " ", diff = "╱", vert = " " }

-- Helm chart templates (replaces vim-helm's detection)
local function helm_template(path)
  if vim.fs.root(path, "Chart.yaml") then
    return "helm"
  end
end
vim.filetype.add({
  pattern = {
    [".*/templates/.*%.ya?ml"] = { helm_template, { priority = 10 } },
    [".*/templates/.*%.tpl"] = { helm_template, { priority = 10 } },
    [".*/templates/NOTES%.txt"] = { helm_template, { priority = 10 } },
  },
})

-- Auto-reload files when changed outside of Neovim
vim.o.autoread = true

-- undo / backup
local constants = require("raphapr.config.constants")
opt.backup = false
opt.swapfile = false
-- Keep persistent undo in a user-private state directory.
vim.fn.mkdir(constants.paths.undodir, "p", 448)
vim.uv.fs_chmod(constants.paths.undodir, 448)
opt.undodir = constants.paths.undodir


-- Append mise shims as a fallback for sessions started without mise activated.
-- Shims add ~80ms per spawn, so real install paths from the shell must win.
local mise_shims = vim.env.HOME .. "/.local/share/mise/shims"
if not vim.tbl_contains(vim.split(vim.env.PATH, ":", { plain = true }), mise_shims) then
  vim.env.PATH = vim.env.PATH .. ":" .. mise_shims
end

-------------------------------------- folding -----------------------------------------

vim.cmd([[
set foldmethod=marker
set foldmarker={{{,}}}
set foldlevelstart=0   " It begins with marks closed

" Space to toggle folds.
nmap <Space> za
vmap <Space> za

" Empty foldtext shows the folded line with its syntax colors.
set foldtext=
]])

-- Toggle all folds
vim.keymap.set("n", "zt", function()
  if vim.wo.foldlevel >= 20 then
    vim.wo.foldlevel = 0
  else
    vim.wo.foldlevel = 20
  end
end, { noremap = true, silent = true, desc = "Fold: Toggle all folds" })
