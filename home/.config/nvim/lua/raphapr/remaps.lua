-- Windows
vim.cmd("nmap <C-h> <C-w>h")
vim.cmd("nmap <C-j> <C-w>j")
vim.cmd("nmap <C-k> <C-w>k")
vim.cmd("nmap <C-l> <C-w>l")

-- Resize vsplit
vim.keymap.set('n', 'Up', ':resize +5<cr>')
vim.keymap.set('n', 'Down', ':resize -5<cr>')

-- Resize split
vim.keymap.set('n', 'Right', ':vertical resize +5<cr>')
vim.keymap.set('n', 'Left', ':vertical resize -5<cr>')

-- Minimizing/maximizing splits
vim.keymap.set('n', 'M-Up', '<C-W>_')
vim.keymap.set('n', 'M-Down', '<C-W>=')
vim.keymap.set('n', 'M-Left', '<C-W>=')
vim.keymap.set('n', 'M-Right', '<C-W><Bar>')

-- Cancel current highlight search
vim.keymap.set('n', '<F3>', ':noh<cr>:call clearmatches()<cr>', {noremap = true})

-- buffers navigation
vim.keymap.set('n', '<Tab>', ':bnext<CR>', {noremap = true})
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', {noremap = true})

-- fast edition
vim.keymap.set('n', '<leader>vi', ':vsplit ~/.config/nvim/lua/raphapr/init.lua<cr>', {noremap = true})
vim.keymap.set('n', '<leader>ef', ':vsplit ~/.config/fish/config.fish<cr>', {noremap = true})
vim.keymap.set('n', '<leader>i3', ':vsplit ~/.i3/config<cr>', {noremap = true})

-- arrow keys
vim.keymap.set('n', 'j', 'gj', {noremap = true})
vim.keymap.set('n', 'k', 'gk', {noremap = true})

-- move selected area up or down
vim.keymap.set('v', 'K', [[:'<,'>move-2<CR>gv=gv]], {noremap = true})
vim.keymap.set('v', 'J', [[:'<,'>move'>+<CR>gv=gv]], {noremap = true})

-- remove all trailing space
vim.keymap.set('n', '<leader>w', ':%s/\\s\\+$//e<CR>', {noremap = true})

-- set working directory to the current file just for current window
vim.keymap.set('n', '<leader>cd', ':lcd %:h<CR>', {noremap = true})

-- cancel current highlight search
vim.keymap.set('n', '<silent> <F3>', ':noh<cr>:call clearmatches()<CR>', {noremap = true})

-- selected blocks are selected again before identations
vim.keymap.set('v', '<', '<gv', {noremap = true})
vim.keymap.set('v', '>', '>gv', {noremap = true})

-- search for visually selected text
vim.keymap.set('v', '//', 'y/<C-R>\'<CR>', {noremap = true})

-- copy entire line without the newline at the end
vim.keymap.set('n', 'Y', 'y$', {noremap = true})

-- search and replace
vim.keymap.set("n", ";;", ":%s:::g<Left><Left><Left>", {noremap = true})
vim.keymap.set("n", ";'", ":%s:::cg<Left><Left><Left><Left>", {noremap = true})

-- page up/down half a page
vim.keymap.set('n', '<C-d>', '<C-d>zz', {noremap = true})
vim.keymap.set('n', '<C-u>', '<C-u>zz', {noremap = true})
