" .vimrc
" Author: @raphapr
"

" Preambule   -------------------------------------------------------------- {{{

set splitbelow
set splitright

let mapleader=","
let maplocalleader = ","
filetype off
filetype plugin on
filetype plugin indent on

" unified clipboard
set clipboard+=unnamedplus

" default shell
set shell=/bin/bash

" }}}
" Plugins     -------------------------------------------------------------- {{{

call plug#begin('~/.nvim/plugged')

" ===== Color Scheme            {{{

Plug 'morhetz/gruvbox'

" }}}
" ===== vim-airline             {{{

" install powerline-fonts
" git clone https://github.com/powerline/fonts.git /tmp/fonts
" sh /tmp/fonts/install.sh
" ln -s ~/.local/share/fonts ~/.fonts

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" }}}
" ===== auto-pairs              {{{

" It automatically closes quotes, keys, parentesis...
Plug 'jiangmiao/auto-pairs'

" }}}
" ===== NERDTree                {{{

" File browser
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
nmap <F10> :NERDTreeToggle<CR>

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" }}}
" ===== vim-tagbar              {{{

" Tags browser (It needs ctags package)
Plug 'majutsushi/tagbar'
nmap <F9> :TagbarToggle<CR>

let g:tagbar_type_julia = {
    \ 'ctagstype' : 'julia',
    \ 'kinds'     : [
        \ 'f:functions',
        \ 'm:macro',
        \ 'c:constant',
        \ 't:type'
    \ ]
    \ }

let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds'     : [
        \ 'h:Heaging_L1',
        \ 'i:Heaging_L2',
        \ 'k:Heaging_L3',
        \ 'k:Heaging_L4',
        \ 'k:Heaging_L5',
        \ 'k:Heaging_L6'
    \ ]
    \ }

" }}}
" ===== vim-numbertoggle        {{{

" It quickly toggles between relative and absolute line numbers
Plug 'jeffkreeftmeijer/vim-numbertoggle'
let g:NumberToggleTrigger="<Leader>n"

" }}}
" ===== Nerd Commenter          {{{

" <leader>cc comment
" <leader>cu uncomment
Plug 'scrooloose/nerdcommenter'

" }}}
" ===== matchit.vim             {{{

" It extends % usage
Plug 'tmhedberg/matchit'

" }}}
" ===== hop.nvim                {{{

Plug 'phaazon/hop.nvim'

nnoremap <silent> ff :HopWord<CR>
nnoremap <silent> fs :HopWordCurrentLine<CR>
nnoremap <silent> fl :HopLine<CR>

" }}}
" ===== vim-peekaboo            {{{

" extends Ctrl + R
Plug 'junegunn/vim-peekaboo'

" Default peekaboo window
let g:peekaboo_window = 'vertical botright 30new'

" }}}
" ===== vim-notes               {{{

Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'

autocmd BufNewFile,BufRead todo.txt,notes.txt setlocal filetype=notes

" }}}
" ===== fzf                     {{{

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__

nnoremap <silent> <C-m> :Buffers<CR>
nnoremap <silent> <C-p> :FZF -m<CR>

"" C-k C-j mapping up-down
autocmd FileType fzf tnoremap <buffer> <C-k> <Up>
autocmd FileType fzf tnoremap <buffer> <C-j> <Down>

let g:fzf_action = {
      \ 'ctrl-i': 'split',
      \ 'ctrl-s': 'vsplit'
      \ }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }
let g:fzf_layout = { 'down': '~40%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"" Enable per-command history.
"" CTRL-N and CTRL-P will be automatically bound to next-history and
"" previous-history instead of down and up. If you don't like the change,
"" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" }}}
" ===== vim-fugitive            {{{

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" }}}
" ===== gitsigns.nvim           {{{

Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'

nmap <Leader>d :Gitsigns toggle_word_diff<CR>
nmap <Leader>b :Gitsigns toggle_current_line_blame<CR>

" }}}
" ===== async lint engine       {{{

Plug 'w0rp/ale'

let b:ale_linters = ['flake8', 'pylint', 'vint', 'jsonlint', 'tflint']
let g:ale_completion_enabled = 1

" }}}
" ===== vim-go                  {{{

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" gd     -  GoDef
" ctrl-t -  GoDefPop
" [[. ]] - Jump Functions

" <leader>d for split, gd for normal navigation, ctrl+t to pop
au FileType go nmap <Leader>s  <Plug>(go-def-split)
au FileType go nmap <Leader>u  <Plug>(go-run)
au FileType go nmap <Leader>b  <Plug>(go-build)
au FileType go nmap <Leader>e  <Plug>(go-rename)
au FileType go nmap <Leader>kk <Plug>(go-doc)
au FileType go nmap <Leader>kb <Plug>(go-doc-browser)
au FileType go nmap <Leader>im <Plug>(go-implements)
au FileType go nmap <Leader>in <Plug>(go-info)

" }}}
" ===== vim-buffkill            {{{

Plug 'qpkorr/vim-bufkill'

" closes buffer
nmap <C-E> :BD<cr>

" }}}
" ===== vim-terraform           {{{

Plug 'hashivim/vim-terraform'

" }}}
" ===== vim-base64              {{{

Plug 'christianrondeau/vim-base64'

" Visual Mode mappings
vnoremap <silent> <leader>de :<c-u>call base64#v_atob()<cr>
vnoremap <silent> <leader>en :<c-u>call base64#v_btoa()<cr>

" }}}
" ===== vim-telescope           {{{

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>g <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>t <cmd>lua require('telescope.builtin').help_tags()<cr>

" }}}
" ===== vim-fish                {{{

Plug 'dag/vim-fish'

" }}}
" ===== glow.nvim               {{{

Plug 'npxbr/glow.nvim'

" }}}
" ===== editorconfig-vim        {{{

Plug 'editorconfig/editorconfig-vim'

" }}}
" ===== nvim-treesitter         {{{

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" }}}

call plug#end()

" }}}
" Settings    -------------------------------------------------------------- {{{

colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'

syntax enable
set background=dark
set nu

" turn on syntax for config files
autocmd BufRead,BufNewFile config setf dosini

" settings for split windows
set splitbelow
set splitright

" Settings indentation style default
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set expandtab
set autoindent
set copyindent
set smartindent
set preserveindent

" Undo settings files
set undofile
set undolevels=1000
set undoreload=10000
set backupskip=/tmp/*,/private/tmp/*"   " No backup file is created for these

set cursorcolumn
set mmp=5000

" improve perfomance
set lazyredraw
set ttyfast

" }}}
" Folding     -------------------------------------------------------------- {{{

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

" }}}
" Maps        -------------------------------------------------------------- {{{

" buffers           {{{

" buffers navigation
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>

"}}}
" fast edition      {{{

nmap <leader>vi :vsplit ~/.config/nvim/init.vim<cr>
nmap <leader>ef :vsplit ~/.config/fish/config.fish<cr>
nmap <leader>i3 :vsplit ~/.i3/config<cr>

" }}}
" arrow keys        {{{

nmap j gj
nmap k gk

" }}}
" etc               {{{
"
" set paste/nopaste
set pastetoggle=<F2>

map <F4> :cd %:p:h<CR>

" remove all trailing space
map <leader>w :%s/\s\+$//e<CR>

" Set working directory to the current file just for current window
map <leader>cd :lcd %:h<CR>

" Open files located in the same dir in with the current file is edited
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>

" Reload init.vim
map <Leader>re :so ~/.config/nvim/init.vim<CR>

" Cancel current highlight search
nmap <silent> <F3> :noh<cr>:call clearmatches()<CR>

" Selected blocks are selected again before identations
vmap < <gv
vmap > >gv

" Search for visually selected text
vnoremap // y/<C-R>"<CR>

" Copy entire line without the newline at the end
nmap Y y$

" regex
" These mappings save you some keystrokes and put you where you start typing your search pattern. After typing it you move to the replacement part , type it and hit return. The second version adds confirmation flag.
noremap ;; :%s:::g<Left><Left><Left>
noremap ;' :%s:::cg<Left><Left><Left><Left>

"Get the 2-space YAML as the default when hit carriage return after the colon
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab

" Highlight tabs as errors.
" https://vi.stackexchange.com/a/9353/3168
autocmd FileType yaml,yml match Error /\t/

" }}}

" }}}
" Backups     -------------------------------------------------------------- {{{

set backup                                " enable backup
set noswapfile                            " don't create swap files

set undodir=~/.config/nvim/undodir        " undo list
set backupdir=~/.config/nvim/tmp/backup/  " backups
set directory=~/.config/nvim/tmp/swap/    " swap files

" folders creation
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" }}}
" Vim Splits  -------------------------------------------------------------- {{{

" move from the neovim terminal window to somewhere else
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

"Resize vsplit
nmap <Up> :resize +5<cr>
nmap <Down> :resize -5<cr>
"Resize split
nmap <Right> :vertical resize +5<cr>
nmap <Left> :vertical resize -5<cr>
nmap = <c-w>=

" Minimizing/maximizing splits
nmap <M-Up>      <C-W>_
nmap <M-Down>    <C-W>=
nmap <M-Left>    <C-W>=
nmap <M-Right>   <C-W><Bar>

" }}}
" Functions   -------------------------------------------------------------- {{{

" Zoom / Restore window.
function! s:ZoomToggle() abort
  if exists('t:zoomed') && t:zoomed
    execute t:zoom_winrestcmd
    let t:zoomed = 0
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
    let t:zoomed = 1
  endif
endfunction
command! ZoomToggle call s:ZoomToggle()

nnoremap <silent> - :ZoomToggle<CR>

" }}}
" Tweaks      -------------------------------------------------------------- {{{

" Hack to get C-h working in neovim
if has('nvim')
    nmap <BS> <C-W>h
endif

" Returns to the same line when opened again
if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
          \| exe "normal! g'\"" | endif
endif

" highlight yank region
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END

" }}}
" Lua         -------------------------------------------------------------- {{{

lua <<EOF
-- ===== telescope         {{{

local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')

require('telescope').load_extension('fzf')

require('telescope').setup {
    defaults = {
        mappings = {
            n = {
                ['<C-h>'] = action_layout.toggle_preview
            },
            i = {
                ['<Up>'] = actions.cycle_history_prev,
                ['<Down>'] = actions.cycle_history_next,
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
                ['<C-h>'] = action_layout.toggle_preview
            }
        }
    },
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case"         -- or "ignore_case" or "respect_case"
      }
    }
}


-- }}}
-- ===== gitsigns          {{{

require('gitsigns').setup {
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
}

-- }}}
-- ===== nvim-treesitter   {{{

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true
  },
}

-- }}}
-- ===== hop.nvim          {{{

require('hop').setup()

-- }}}
EOF

" }}}
