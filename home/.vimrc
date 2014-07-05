" vimrc
" Raphael P. Ribeiro

" Preambulo ---------------------------------------------------------------- {{{

" <Leader> por default é \
let mapleader=","
let maplocalleader = ","
set nocompatible
filetype off
filetype plugin on
filetype plugin indent on
let powerline = $POWERLINE " Caso eu esteja afim de usar o powerline (:

" }}}
" Bundles   ---------------------------------------------------------------- {{{

" ===== Vundle           {{{

" P/ gerenciar os bundles
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" }}}
" ===== Esquema de cores {{{

Bundle 'altercation/vim-colors-solarized'
Bundle 'spf13/vim-colors'
Bundle 'godlygeek/csapprox'

" }}}
" ===== Bash IDE         {{{

Bundle 'vim-scripts/bash-support.vim'

" }}}
" ===== Snipmate         {{{

Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"

" }}}
" ===== vim-autoclose    {{{

" Fecha automaticamente aspas, chaves, parênteses...
Bundle 'Townk/vim-autoclose'

" }}}
" ===== vim-powerline    {{{

" Se os glifos ficarem estranhos:
" fontforge -script ~/.vim/bundle/vim-powerline/fontpatcher/fontpatcher ~/Downloads/Menlo+Regular+for+Powerline.ttf
if powerline
    Bundle 'Lokaltog/vim-powerline'
    let g:Powerline_symbols = 'fancy'
    " Acaba com o delay do esc (no .tmux.conf: set -sg escape-time 0)
    if ! has('gui_running')
        set ttimeoutlen=10
        augroup FastEscape
            autocmd!
            au InsertEnter * set timeoutlen=0
            au InsertLeave * set timeoutlen=1000
        augroup END
    endif
endif

" }}}
" ===== NERDTree         {{{

" Navegador de arquivos e diretórios
Bundle 'scrooloose/nerdtree'
map <F10> :NERDTreeToggle<CR>

" }}}
" ===== vim-tagbar       {{{

" Navega entre as tags do código fonte, precisa do ctags instalado para gerar as tags
" Lembrar que <ctrl> ww troca de janela
Bundle 'majutsushi/tagbar'
nnoremap <F9> :TagbarToggle<CR>

" }}}
" ===== Gundo            {{{

" Ver undo tree em estilo
Bundle 'sjl/gundo.vim'
nnoremap <Leader>g :GundoToggle<CR>

" }}}
" ===== vim-numbertoggle {{{

" Números das linhas relativo no modo normal e absoluto no modo insert
Bundle 'jeffkreeftmeijer/vim-numbertoggle'
let g:NumberToggleTrigger="<Leader>n"

" }}}
" ===== Nerd Commenter   {{{

Bundle 'scrooloose/nerdcommenter'

" }}}
" ===== Command-T        {{{

" FIX: could not load the C extension
" cd ~/.vim/ruby/command-t
" ruby extconf.rb
" make

Bundle 'wincent/Command-T'

" }}}

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
au VimResized * :wincmd =               " Ajusta os splits quando a janela é redimensionada
colorscheme molokai

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

" Atalhos rápidos   {{{

" Mata a janela
nnoremap K :q<cr>
" Salva e sai da janela
nnoremap X :x<cr>
" Salva arquivo
nnoremap W :w<cr>
" quit all
nnoremap <leader>qt :quitall<CR>

" }}}
" Copy/Paste        {{{

" ,c para copiar pra área de transferência
map <Leader>y "+y<CR>
map <Leader>p "+p<CR>

"Copia conteúdo selecionado para o arquivo .vimbuffer. Bom para copiar de uma aba tmux para outra.
vmap <Leader>c :w! ~/.vimbuffer<CR>
nmap <Leader>c :.w! ~/.vimbuffer<CR>
" cut to ~/.vimbuffer
vmap <Leader>x :w! ~/.vimbuffer<CR>gvx
" paste from ~/.vimbuffer
map <Leader>v :r ~/.vimbuffer<CR>

" }}}
" txt2tags          {{{

map 2h :w<CR>:!txt2tags -t html % ; $BROWSER %<.html<CR>
map 2l :w<CR>:!txt2tags -t tex % ; xelatex %<.tex ; okular %<.pdf<CR>
map 2t :w<CR>:!txt2tags -t txt % <CR>

" }}}
" etc               {{{

" Dois <Enter> para quebrar linha sem entrar no insert mode
nmap <CR><CR> o<ESC>

" compilar com openGL (CG)
nnoremap <Leader>o :!g++ % -o a.out -lGLU -lGL -lglut && ./a.out<CR>

" Recarrega vimrc
map <Leader>re :so %<CR>
" Cancela o highlight da busca atual noremap <silent> <F3> :noh<cr>:call clearmatches()<cr>
"" Opções para que blocos selecionados sejam reselecionados após identações.
vnoremap < <gv
vnoremap > >gv

"inoremap jj <ESC>

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
nnoremap <leader>zs :vsplit ~/.zshrc<cr>
nnoremap <leader>tm :vsplit ~/.tmux/tmux.conf<cr>

" }}}
" Navegação entre abas  ---------------------------------------------------- {{{

"navegação de abas fácil, semelhante a navegadores
nnoremap <tab>  :tabnext<CR>
nnoremap <C-t>  :tabnew<CR>

" }}}
" Vim Splits  -------------------------------------------------------------- {{{

"Navegação entre janelas,
"<ctrl><j> em vez de <ctrl><w><j>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

map <silent> <Leader>1 :tabn 1<cr>
map <silent> <Leader>2 :tabn 2<cr>
map <silent> <Leader>3 :tabn 3<cr>
map <silent> <Leader>4 :tabn 4<cr>
map <silent> <Leader>5 :tabn 5<cr>
map <silent> <Leader>6 :tabn 6<cr>
map <silent> <Leader>7 :tabn 7<cr>

"open splits
nnoremap <Leader>\| :vsplit<cr>
nnoremap <Leader>_ :split<cr>

"Resize vsplit
nmap <Leader>= :vertical resize +5<cr>
nmap <Leader>- :vertical resize -5<cr>
nmap 25 :vertical resize 40<cr>
nmap 50 <c-w>=
nmap 75 :vertical resize 120<cr>

" }}}
" Highlight Word  ---------------------------------------------------------- {{{

" " This mini-plugin provides a few mappings for highlighting words
" temporarily.
" "
" " Sometimes you're looking at a hairy piece of code and would like a certain
" " word or two to stand out temporarily.  You can search for it, but that
" only
" " gives you one color of highlighting.  Now you can use <leader>N where N is
" " a number from 1-6 to highlight the current word in a specific color.

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

nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195


" }}}
" Ajustes  ----------------------------------------------------------------- {{{

" Certifica-se que o Vim retorna para a mesma linha quando abre o arquivo
if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
          \| exe "normal! g'\"" | endif
endif


let @z = "{{{"
let @x = "}}}"
map <Leader><Leader> "zp<CR>
map <Leader>. "xp<CR>


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
else
    " Console Vim
    " For me, this means iTerm2, possibly through tmux

    " Mouse support
    set mouse=a
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

