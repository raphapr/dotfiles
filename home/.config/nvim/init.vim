" .nvimrc
" Author: Raphael P. Ribeiro
"

" Preambule ---------------------------------------------------------------- {{{

set splitbelow                          " Nova janela aparece abaixo da atual
set splitright                          " Nova janela aparece a direita da atual

let mapleader=","
let maplocalleader = ","
filetype off
filetype plugin on
filetype plugin indent on

" unified clipboard
set clipboard+=unnamedplus

" fix Syntastic + tmux bug
set shell=/bin/bash

" }}}
" Plugins   ---------------------------------------------------------------- {{{

call plug#begin('~/.nvim/plugged')

" ===== Molokai Color Scheme    {{{

Plug 'tomasr/molokai'

" }}}
" ===== deoplete                {{{

" Dependency: sudo pip install neovim jedi
"(https://github.com/neovim/neovim/issues/2906)

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'

let g:python3_host_prog = '/usr/bin/python3.6'
let g:deoplete#enable_at_startup = 0
let g:deoplete#enable_smart_case = 1
nmap <Leader>d :call deoplete#toggle()<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" }}}
" ===== Syntax highlighting     {{{

Plug 'dag/vim-fish'
Plug 'JuliaLang/julia-vim'
Plug 'rdolgushin/groovy.vim'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled=1

" }}}
" ===== vim-airline             {{{

" install powerline-fonts
" git clone https://github.com/powerline/fonts.git /tmp/fonts
" sh /tmp/fonts/install.sh
" ln -s ~/.local/share/fonts ~/.fonts 

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


let g:airline_theme = 'bubblegum'
"let g:airline_theme = 'jellybeans'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" }}}
" ===== vim-autoclose           {{{

" It automatically closes quotes, keys, parentesis...
Plug 'Townk/vim-autoclose'

" }}}
" ===== NERDTree                {{{

" File browser
Plug 'scrooloose/nerdtree'
nmap <F10> :NERDTreeToggle<CR>

let NERDTreeShowBookmarks=1

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
" ===== latex-box               {{{

Plug 'LaTeX-Box-Team/LaTeX-Box'

let g:tex_flavor='latex'
let g:LatexBox_quickfix         = 4
let g:LatexBox_Folding          = 1
let g:LatexBox_latexmk_async    = 1
let g:LatexBox_fold_automatic   = 0

" }}}
" ===== matchit.vim             {{{

" It extends % usage
Plug 'tmhedberg/matchit'

" }}}
" ===== EasyMotion              {{{

" Text navigation like vimperator
Plug 'Lokaltog/vim-easymotion'

let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1 " Turn on case sensitive feature

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
nmap f <Plug>(easymotion-overwin-f)

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" n-character search motion
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

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

autocmd BufNewFile,BufRead notes.txt setlocal filetype=notes

" }}}
" ===== ack                     {{{

" Dependencies: sudo pacman -S the_silver_searcher
Plug 'mileszs/ack.vim'
let g:ackprg = 'ag --vimgrep --smart-case'

" }}}
" ===== fzf                     {{{

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" C-k C-j mapping up-down
autocmd FileType fzf tnoremap <buffer> <C-k> <Up>
autocmd FileType fzf tnoremap <buffer> <C-j> <Down>

nnoremap <c-p> :FZF<cr>
nnoremap <c-m> :FZF ~<cr>

function! s:all_files()
  return extend(
  \ filter(copy(v:oldfiles),
  \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
  \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
endfunction

let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

" Default fzf layout
" - down / up / left / right
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

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" MRU
command! FZFMru call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '40%'})

" }}}
" ===== vim-fugitive            {{{

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" }}}
" ===== async lint engine       {{{

Plug 'w0rp/ale'

" }}}
" ===== vim-gitgutter           {{{

Plug 'airblade/vim-gitgutter'

" }}}
" ===== tabular                 {{{

Plug 'godlygeek/tabular'

" }}}
" ===== vim-obsession           {{{

Plug 'tpope/vim-obsession'

" }}}
" ===== identLine               {{{

Plug 'Yggdroot/indentLine'
let g:indentLine_enabled = 0
nmap <leader>i :IndentLinesToggle<cr>

" }}}
" ===== vim-markdown-composer   {{{
" dependencies: rustup

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

let g:markdown_composer_open_browser = 0

" }}}
" ===== surround                {{{

Plug 'tpope/vim-surround'

" }}}

call plug#end()

" }}}
" Settings  ---------------------------------------------------------------- {{{

syntax enable
colorscheme molokai
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

" }}}
" Folding   ---------------------------------------------------------------- {{{

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
" Maps    -----------------------------------------------------------------  {{{

" buffers           {{{

" buffers navigation
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>

" closes buffer
nmap <C-E> :bp<cr>:bd #<cr>

"}}}
" fast edition      {{{

nmap <leader>vi :vsplit ~/.config/nvim/init.vim<cr>
nmap <leader>ef :vsplit ~/.config/fish/config.fish<cr>
nmap <leader>i3 :vsplit ~/.i3/config<cr>

" }}}
" compiling         {{{

" OpenGL
nmap <Leader>op :!g++ % -o a.out -lGLU -lGL -lglut && ./a.out<CR>
" Ruby
nmap <Leader>ru :split<CR>:term ruby %<CR>
" Julia
nmap <Leader>ju :split<CR>:term julia %<CR>
" Bash
nmap <Leader>ba :split<CR>:term . %<CR>

" }}}
" arrow keys        {{{

nmap <up> <nop>
nmap <down> <nop>
nmap <left> <nop>
nmap <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
nmap j gj
nmap k gk

" arrow keys for something more useful
"
"
nmap <UP> <C-A>
nmap <DOWN> <C-X>
nmap <LEFT> <<
nmap <RIGHT> >>
vmap <LEFT> <gv
vmap <RIGHT> >gv

" }}}
" etc               {{{
map <leader>w :%s/\s\+$//e<CR>

" Set working directory to the current file just for current window
map <leader>cd :lcd %:h<CR>

" Open files located in the same dir in with the current file is edited
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>

" Save files without sudo
cmap w!! %!sudo tee > /dev/null %

" Reload init.vim
map <Leader>re :so ~/.config/nvim/init.vim<CR>

" Cancel current highlight search
nmap <silent> <F3> :noh<cr>:call clearmatches()<cr>

" Selected blocks are selected again before identations
vmap < <gv
vmap > >gv

" Search for visually selected text
vnoremap // y/<C-R>"<CR>

" regex
" These mappings save you some keystrokes and put you where you start typing your search pattern. After typing it you move to the replacement part , type it and hit return. The second version adds confirmation flag.
noremap ;; :%s:::g<Left><Left><Left>
noremap ;' :%s:::cg<Left><Left><Left><Left>

" }}}

" }}}
" Backups ------------------------------------------------------------------ {{{

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
nmap = :vertical resize +5<cr>
nmap - :vertical resize -5<cr>
"nmap = <c-w>=

"Alt + Arrow is for minimizing/maximizing splits
nmap <M-Up>      <C-W>_
nmap <M-Down>    <C-W>=
nmap <M-Left>    <C-W>=
nmap <M-Right>   <C-W><Bar>

" }}}
" Adjusts  ----------------------------------------------------------------- {{{

" Hack to get C-h working in neovim
if has('nvim')
    nmap <BS> <C-W>h
endif

" Returns to the same line when opened again
if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
          \| exe "normal! g'\"" | endif
endif

" }}}
