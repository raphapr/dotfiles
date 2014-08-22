" .vimrc
" Author: Raphael P. Ribeiro

" Preambulo ---------------------------------------------------------------- {{{

" <Leader> por default é \
let mapleader=","
let maplocalleader = ","
set nocompatible
filetype off
filetype plugin on
filetype plugin indent on

" }}}
" Plugins   ---------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')

" ===== Esquema de cores        {{{

Plug 'altercation/vim-colors-solarized'
Plug 'spf13/vim-colors'
Plug 'godlygeek/csapprox'

" }}}
" ===== Snipmate                {{{

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

" }}}
" ===== vim-autoclose           {{{

" Fecha automaticamente aspas, chaves, parênteses...
Plug 'Townk/vim-autoclose'

" }}}
" ===== NERDTree                {{{

" Navegador de arquivos e diretórios
Plug 'scrooloose/nerdtree'
map <F10> :NERDTreeToggle<CR>

let NERDTreeShowBookmarks=1

" }}}
" ===== vim-tagbar              {{{

" Navega entre as tags do código fonte, precisa do ctags instalado para gerar as tags
" Lembrar que <ctrl> ww troca de janela
Plug 'majutsushi/tagbar'
nnoremap <F9> :TagbarToggle<CR>

" }}}
" ===== Gundo                   {{{

" Ver undo tree em estilo
Plug 'sjl/gundo.vim'
nnoremap <Leader>g :GundoToggle<CR>

" }}}
" ===== vim-numbertoggle        {{{

" Números das linhas relativo no modo normal e absoluto no modo insert
Plug 'jeffkreeftmeijer/vim-numbertoggle'
let g:NumberToggleTrigger="<Leader>n"

" }}}
" ===== Nerd Commenter          {{{

" <leader>cc para comentar e <leader>cu para descomentar
Plug 'scrooloose/nerdcommenter'

" }}}
" ===== vim-latex               {{{

Plug 'jcf/vim-latex'

let g:tex_flavor='latex'
set grepprg=grep\ -nH\ $*
" View PDF macro; '%:r' is current file's root (base) name.
" nnoremap <leader><leader> :!okular %:r.pdf &<CR><CR>

" }}}
" ===== matchit.vim             {{{

" Estende o uso do %
Plug 'matchit.zip'

" }}}
" ===== vim-ruby-refactoring    {{{

Plug 'ecomba/vim-ruby-refactoring'

" }}}
" ===== vim-airline             {{{

" Se os glifos ficarem estranhos:
" fontforge -script ~/.vim/bundle/vim-powerline/fontpatcher/fontpatcher ~/Downloads/Menlo+Regular+for+Powerline.ttf

Plug 'bling/vim-airline'

let g:airline_theme = 'bubblegum'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Retirando o trailing check
"let g:airline#extensions#whitespace#checks = ['indent']

" }}}
" ===== minibufexpl             {{{

"Janela que lista os buffers
Plug 'fholgado/minibufexpl.vim'
map <F8> :MBEToggle<CR>

let g:miniBufExplorerAutoStart = 0

" }}}
" ===== Syntastic               {{{

" Checa erro de sintaxe
Plug 'scrooloose/syntastic'

let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1

" }}}
" ===== Surround                {{{

" Fornece mapeamento para modificação de tags, aspas, parenteses etc
Plug 'tpope/vim-surround'

" }}}
" ===== fugitive                {{{

" Git
Plug 'tpope/vim-fugitive'

" }}}
" ===== CtrlP                   {{{

Plug 'kien/ctrlp.vim'

" F5 - Refresh

" Abre no home
noremap <C-P> :CtrlPRoot<CR>
" Abre no diretório atual do arquivo
noremap <Leader>p :CtrlP<CR>
noremap <leader>b :CtrlPBuffer<CR>
noremap <leader>bt :CtrlPBufTag<CR>
noremap <leader>mru :CtrlPMRU<CR>

set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,.pyc,__pycache__
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|tox)$'
let g:ctrlp_user_command = "find %s -type f | grep -Ev '"+ g:ctrlp_custom_ignore +"'"
let g:ctrlp_working_path_mode='c'

" }}}

call plug#end()

" }}}
" Opções Básicas  ---------------------------------------------------------- {{{

syntax enable                           " Habilita a marcação de sintaxe
set encoding=utf-8                      "
set showmode                            " Exibe o modo atual
set wildmenu                            " Menu com as opções do vim usando tab
set background=dark                     " Define o fundo preto (É melhor usar isso com a sintaxe)
set nu                                  " Mostra o número de linhas
set ai                                  " Faz o auto tab/auto indent
set ts=4                                " tab vale 4 espaços
set sw=4                                " tab com 4 espaços
set softtabstop=4                       " Operações como o backspace também com 4 espaços
set et                                  " Troca tabs por espaços
set ruler                               " Mostra a posição do cursor
set cursorline                          " Destaca a linha atual
set laststatus=2                        " Sempre exibe a barra de status
set autoread                            " Recarrega arquivos alterados em disco automaticamente
set incsearch                           " Pesquisa incremental
set hlsearch                            " Highlight search :)
set ignorecase                          " Pesquisa ignora caixa alta e baixa
set smartcase                           " Pesquisa considera caixa alta apenas se ouver uma ou mais maiúsculas na pesquisa
set pastetoggle=<F2>                    " ativa/desativa o auto ident para copiar/colar
set splitbelow                          " Nova janela aparece abaixo da atual
set splitright                          " Nova janela aparece a direita da atual
set backupskip=/tmp/*,/private/tmp/*"   " Faz o Vim editar arquivos crontab
set number                              " Enumera as linhas
set undofile                            " Estabelece o uso de um arquivo persistente para undo list
set undolevels=1000                     " Máximo numero de mudanças que podem ser desfeitas
set undoreload=10000                    " Máximo número de linhas a serem salvar pra buffer reload
set re=1                                " Corrige os arquivos ruby que estavam lentos por causa da nova regex engine do vim
au VimResized * :wincmd =               " Ajusta os splits quando a janela é redimensionada
colorscheme molokai




" }}}
" Omni completion ---------------------------------------------------------- {{{

" ctrl+space para completar código
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
            \ "\<lt>C-n>" :
            \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
            \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
            \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

" }}}
" Folding   ---------------------------------------------------------------- {{{

set foldmethod=marker
set foldmarker={{{,}}} " marker para abrir folder e fechar folder
set foldlevelstart=0   " Começa com todas os folders fechados

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

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

" System Clipboard  {{{

" Copia para a área de transferência do X
map <leader>c !xclip -sel clip<CR>u

" }}}
" markdown          {{{

" Precisa do pacote haskell-pandoc (Adicionar o repo haskell)
map 2h :w<CR>:!pandoc % -f markdown -t html -s -o %<.html<CR>
map 2p :w<CR>:!pandoc % -o %<.pdf<CR>
map 2v :w<CR>:!pandoc % -o %<.pdf ; okular %<.pdf<CR>

" }}}
" buffers           {{{

" navegação entre buffers
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>

" fecha buffer
nmap <C-E> :bd<CR>

"}}}
" git               {{{

noremap <Leader>ga :!git add .<CR>
noremap <Leader>gc :!git commit -m '<C-R>="'"<CR>
noremap <Leader>gsh :!git push<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>'

"}}}
" etc               {{{

" Mata a janela
nnoremap K :q<cr>
" quit all
nnoremap <leader>qt :quitall<CR>

" Dois <Enter> para quebrar linha sem entrar no insert mode
nmap <CR><CR> o<ESC>

" compilar com openGL (CG)
nnoremap <Leader>o :!g++ % -o a.out -lGLU -lGL -lglut && ./a.out<CR>

" ruby
nnoremap <Leader>ru :!clear && ruby %<CR>

" Recarrega vimrc
map <Leader>re :so %<CR>

" Cancela o highlight da busca atual
noremap <silent> <F3> :noh<cr>:call clearmatches()<cr>

"" Opções para que blocos selecionados sejam reselecionados após identações.
vnoremap < <gv
vnoremap > >gv

" }}}

" }}}
" Backups ------------------------------------------------------------------ {{{

set backup                          " habilita backups
set noswapfile                      " não cria mais os malditos .swp

set undodir=~/.vim/undodir          " undo list
set backupdir=~/.vim/tmp/backup/    " backups
set directory=~/.vim/tmp/swap/      " swap files

" Certifica-se de que as pastas sejam criadas automaticamente se já não existirem.
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
" tmux    ------------------------------------------------------------------ {{{

" Para as cores funcionarem bem é preciso usar 256 cores no terminal.
" " No bashrc, zshrc ou similar, faça algo como
" " export TERM="xterm-256color"
"
" " let g:solarized_termcolors=256


"""" Faz com que o esquema de cores funcione perfeitamente dentro do tmux e konsole
if &term =~ '256color'
      " Disable Background Color Erase (BCE) so that color schemes
      "   " work properly when Vim is used inside tmux and GNU screen.
      "     " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
             set t_ut=
endif

" ~/.vimrc
" " Make Vim recognize xterm escape sequences for Page and Arrow
" " keys combined with modifiers such as Shift, Control, and Alt.
" " See http://www.reddit.com/r/vim/comments/1a29vk/_/c8tze8p
if &term =~ '^screen'
"   " Page keys http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/FAQ
    execute "set t_kP=\e[5;*~"
    execute "set t_kN=\e[6;*~"
"       " Arrow keys http://unix.stackexchange.com/a/34723
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

" }}}
" Edição Rápida  ----------------------------------------------------------- {{{

nnoremap <leader>vi :vsplit ~/.vimrc<cr>
nnoremap <leader>ez :vsplit ~/.zshrc<cr>
nnoremap <leader>tm :vsplit ~/.tmux/tmux.conf<cr>

" }}}
" Navegação entre abas  ---------------------------------------------------- {{{

"navegação de abas fácil, semelhante a navegadores
nnoremap <leader><leader>  :tabnext<CR>
nnoremap <C-t>  :tabnew<CR>

" }}}
" Vim Splits  -------------------------------------------------------------- {{{

"Navegação entre janelas,
"<ctrl><hjkl> em vez de <ctrl><w><hjkl>
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

"Resize vsplit
nnoremap = :vertical resize +5<cr>
nnoremap - :vertical resize -5<cr>
"nmap = <c-w>=

"Alt + Arrow is for minimizing/maximizing splits
nnoremap <M-Up>      <C-W>_
nnoremap <M-Down>    <C-W>=
nnoremap <M-Left>    <C-W>=
nnoremap <M-Right>   <C-W><Bar>




" }}}
" Trailing whitespace  ------------------------------------------------------ {{{

function! TrimWhiteSpace()
  let @*=line(".")
  %s/\s*$//e
  ''
endfunction

nnoremap <leader>tw :call TrimWhiteSpace()<cr>:let @/=''<CR>

" }}}
" Ajustes  ----------------------------------------------------------------- {{{

"" Acaba com o delay do esc (no .tmux.conf: set -sg escape-time 0)
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
   augroup END
endif

" Certifica-se que o Vim retorna para a mesma linha quando abre o arquivo
if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
          \| exe "normal! g'\"" | endif
endif

" Ajustes GUI
if has('gui_running')
    " GUI Vim

    set guifont=Menlo\ Regular\ for\ Powerline:h12

    " Remove all the UI cruft
    set go-=T
    set go-=l
    set go-=L
    set go-=r
    set go-=R

    highlight SpellBad term=underline gui=undercurl guisp=Orange

    " Different cursors for different modes.
    set guicursor=n-c:block-Cursor-blinkon0
    set guicursor+=v:block-vCursor-blinkon0
    set guicursor+=i-ci:ver20-iCursor
endif

" Só assim eu aprendo a usar o hjkl
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" }}}
