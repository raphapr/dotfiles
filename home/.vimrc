" .vimrc
" Author: Raphael P. Ribeiro
"

" Preambulo ---------------------------------------------------------------- {{{

" <Leader> por default é \
let mapleader=","
let maplocalleader = ","
set nocompatible
filetype off
filetype plugin on
filetype plugin indent on

" Sem setar o bash como shell padrão, o syntastic demora no tmux
set shell=/bin/bash

" }}}
" Plugins   ---------------------------------------------------------------- {{{

"call plug#begin('~/.vim/plugged')

"" ===== Esquema de cores        {{{

"Plug 'tomasr/molokai'

"" }}}
"" ===== Snipmate                {{{

"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'tomtom/tlib_vim'
"Plug 'garbas/vim-snipmate'
"Plug 'honza/vim-snippets'

"" }}}
"" ===== vim-autoclose           {{{

"" Fecha automaticamente aspas, chaves, parênteses...
"Plug 'Townk/vim-autoclose'

"" }}}
"" ===== NERDTree                {{{

"" Navegador de arquivos e diretórios
"Plug 'scrooloose/nerdtree'
"nnoremap <F10> :NERDTreeToggle<CR>

"let NERDTreeShowBookmarks=1

"" }}}
"" ===== vim-tagbar              {{{

"" Navega entre as tags do código fonte, precisa do ctags instalado para gerar as tags
"" Lembrar que <ctrl> ww troca de janela
"Plug 'majutsushi/tagbar'
"nnoremap <F9> :TagbarToggle<CR>

"" }}}
"" ===== Gundo                   {{{

"" Ver undo tree em estilo
"Plug 'sjl/gundo.vim'
"nnoremap <Leader>gu :GundoToggle<CR>

"" }}}
"" ===== vim-numbertoggle        {{{

"" Números das linhas relativo no modo normal e absoluto no modo insert
"Plug 'jeffkreeftmeijer/vim-numbertoggle'
"let g:NumberToggleTrigger="<Leader>n"

"" }}}
"" ===== Nerd Commenter          {{{

"" <leader>cc para comentar e <leader>cu para descomentar
"Plug 'scrooloose/nerdcommenter'

"" }}}
"" ===== latex-box               {{{

"Plug 'LaTeX-Box-Team/LaTeX-Box'

"let g:LatexBox_quickfix = 4


"" }}}
"" ===== matchit.vim             {{{

"" Estende o uso do %
"Plug 'matchit.zip'

"" }}}
"" ===== vim-airline             {{{

"" Se os glifos ficarem estranhos:
"" fontforge -script ~/.vim/bundle/vim-powerline/fontpatcher/fontpatcher ~/Downloads/Menlo+Regular+for+Powerline.ttf

"Plug 'bling/vim-airline'

"let g:airline_theme = 'bubblegum'
"let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1

"" Retirando o trailing check
""let g:airline#extensions#whitespace#checks = ['indent']

"" }}}
"" ===== Syntastic               {{{

"" Checa erro de sintaxe
"Plug 'scrooloose/syntastic'

"" começa em passive mode
"let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'],'passive_filetypes': [] }
"nnoremap <leader>sk :SyntasticCheck<CR> :SyntasticToggleMode<CR> }

"let g:syntastic_always_populate_loc_list=1
"let g:syntastic_error_symbol='✗'
"let g:syntastic_warning_symbol='⚠'
"let g:syntastic_style_error_symbol = '✗'
"let g:syntastic_style_warning_symbol = '⚠'
"let g:syntastic_auto_loc_list=1
"let g:syntastic_aggregate_errors = 1

"" }}}
"" ===== CtrlP                   {{{

"Plug 'kien/ctrlp.vim'

"let g:ctrlp_max_files=0
"let g:ctrlp_max_depth=40
"let g:ctrlp_working_path_mode='ra'
"let g:ctrlp_switch_buffer='Et'
"let g:ctrlp_follow_symlinks=1

"" F5 - Refresh

"" Abre no home
"noremap <C-P> :CtrlP<CR>
"" Abre no diretório atual do arquivo
"noremap <F8> :CtrlPBuffer<CR>
"noremap <F11> :CtrlPBufTag<CR>
"noremap <leader>mru :CtrlPMRU<CR>

"set wildmode=list:longest,list:full
"set wildignore+=*.o,*.obj,.git,*.rbc,.pyc,__pycache__
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|tox)$'
"let g:ctrlp_user_command = "find %s -type f | grep -Ev '"+ g:ctrlp_custom_ignore +"'"

"" }}}
"" ===== markdown.vim            {{{

"Plug 'godlygeek/tabular'
"Plug 'plasticboy/vim-markdown'

"let g:vim_markdown_folding_disabled=1

"" }}}
"" ===== vim-fugitive (git)      {{{

"Plug 'tpope/vim-fugitive'

"" }}}
"" ===== EasyMotion              {{{

"" Navegação de texto igual vimperator
"Plug 'Lokaltog/vim-easymotion'

"let g:EasyMotion_do_mapping = 0 " Disable default mappings
"let g:EasyMotion_smartcase = 1 " Turn on case sensitive feature

"" Bi-directional find motion
"" Jump to anywhere you want with minimal keystrokes, with just one key binding.

"nmap f <Plug>(easymotion-s)

"" JK motions: Line motions
"map <Leader>j <Plug>(easymotion-j)
"map <Leader>k <Plug>(easymotion-k)

"" }}}
"" ===== supertab                {{{

"" Tab para auto completar

"Plug 'ervandew/supertab'

"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"setlocal omnifunc=LatexBox_Complete

"" }}}
"" ===== vim-fish                {{{

"Plug 'dag/vim-fish'

"" }}}
"" ===== julia-vim               {{{

"Plug 'JuliaLang/julia-vim'

"" }}}
""

"call plug#end()

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
set pastetoggle=<F2>                    " ativa/desativa o paste mode para copiar/colar
au InsertLeave * set nopaste            " Desativa paste mode ao sair do insert mode
set splitbelow                          " Nova janela aparece abaixo da atual
set splitright                          " Nova janela aparece a direita da atual
set backupskip=/tmp/*,/private/tmp/*"   " Faz o Vim editar arquivos crontab
set number                              " Enumera as linhas
set undofile                            " Estabelece o uso de um arquivo persistente para undo list
set undolevels=1000                     " Máximo numero de mudanças que podem ser desfeitas
set undoreload=10000                    " Máximo número de linhas a serem salvar pra buffer reload
set re=1                                " Corrige os arquivos ruby que estavam lentos por causa da nova regex engine do vim
au VimResized * :wincmd =               " Ajusta os splits quando a janela é redimensionada
set keywordprg=trans\ -b\ :pt           " Traduz para o inglês ao pressionar Shift+K quando o texto estiver selecionado pelo vim. NEED: translate-shell-git (AUR)
let g:tex_flavor='latex'
"colorscheme molokai

" }}}
" Omni completion ---------------------------------------------------------- {{{

" <C-x><C-o> auto completar sintaxe
" <C-n> auto completar geral

" h cancela sem completar
" l completa
inoremap <expr> h ((pumvisible())?("\<C-e>"):("h"))
inoremap <expr> l ((pumvisible())?("\<C-y>"):("l"))

" usa jk para mover a janela do popup omnicomplete
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))


" }}}
" Highlight words ---------------------------------------------------------- {{{

" ===== Function                {{{

function! HiInterestingWord(n)
    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)

    " Move back to our original location.
    normal! `z
endfunction 

" }}}
" ===== Mappings                {{{

nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

" }}}
" ===== Default Highlights      {{{

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

" }}}

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
map 2v :w<CR>:!pandoc % -o %<.pdf ; zathura %<.pdf<CR>

" }}}
" buffers           {{{

" navegação entre buffers
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>

" fecha buffer (sem quebrar a janela do NERDTree)
nnoremap <C-E> :bp<cr>:bd #<cr>

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
" sessions          {{{

if !isdirectory("/home/raphael/.vim/sessions")
    call mkdir("/home/raphael/.vim/sessions", "p")
endif

nnoremap <leader>ss :mksession! ~/.vim/sessions/default<CR>
nnoremap <leader>sa :mksession! ~/.vim/sessions/session_a<CR>
nnoremap <leader>sb :mksession! ~/.vim/sessions/session_b<CR>

""}}}
" edição rápida     {{{

nnoremap <leader>vi :vsplit ~/.vimrc<cr>
nnoremap <leader>eb :vsplit ~/.bashrc<cr>
nnoremap <leader>i3 :vsplit ~/.i3/config<cr>

" }}}
" etc               {{{

" quick save
nmap S :w<CR>

" Mata a janela
nnoremap K :q<cr>

"Salva arquivos que requerem permissão root
cmap w!! %!sudo tee > /dev/null %

" Dois <Enter> para quebrar linha sem entrar no insert mode
nmap <CR><CR> o<ESC>

" compilar com openGL (CG)
nnoremap <Leader>op :!g++ % -o a.out -lGLU -lGL -lglut && ./a.out<CR>

" ruby
nnoremap <Leader>ru :!clear && ruby %<CR>

" julia
nnoremap <Leader>ju :!clear && julia %<CR>

" bash
nnoremap <Leader>ba :!clear && . %<CR>

" Recarrega vimrc
map <Leader>re :so %<CR>

" Cancela o highlight da busca atual
noremap <silent> <F3> :noh<cr>:call clearmatches()<cr>

" Opções para que blocos selecionados sejam reselecionados após identações.
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
" Navegação entre abas  ---------------------------------------------------- {{{

"navegação de abas fácil, semelhante a navegadores
nnoremap <C-t> :tabnew<CR>
nnoremap <C-b> :tabprevious<CR>
nnoremap <C-n> :tabnext<CR>
inoremap <C-t> <Esc>:tabnew<CR>
inoremap <C-b> <Esc>:tabprevious<CR>i
inoremap <C-n> <Esc>:tabnext<CR>i

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
" Trailing whitespace  ----------------------------------------------------- {{{

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
