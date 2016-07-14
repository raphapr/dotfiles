" .nvimrc
" Author: Raphael P. Ribeiro
"

" Preambulo ---------------------------------------------------------------- {{{
"

" <Leader> por default é \
let mapleader=","
let maplocalleader = ","
filetype off
filetype plugin on
filetype plugin indent on

" clipboard unificado
set clipboard+=unnamedplus

" Sem setar o bash como shell padrão, o syntastic demora no tmux
set shell=/bin/bash

" }}}
" Plugins   ---------------------------------------------------------------- {{{

call plug#begin('~/.nvim/plugged')

" ===== Molokai Color Scheme    {{{

Plug 'tomasr/molokai'

" }}}
" ===== Snipmate                {{{

" Dependency: sudo pip install neovim
"(https://github.com/neovim/neovim/issues/2906)

" Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" }}}
" ===== Languages support       {{{

Plug 'dag/vim-fish'
Plug 'JuliaLang/julia-vim'
Plug 'zorab47/vim-gams'

au BufEnter *.gms set ft=gams 

" }}}
" ===== vim-airline             {{{

" Se os glifos ficarem estranhos:
" fontforge -script ~/.vim/bundle/vim-powerline/fontpatcher/fontpatcher ~/Downloads/Menlo+Regular+for+Powerline.ttf

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

let g:airline_theme = 'bubblegum'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Retirando o trailing check
"let g:airline#extensions#whitespace#checks = ['indent']

" }}}
" ===== vim-autoclose           {{{

" Fecha automaticamente aspas, chaves, parênteses...
Plug 'Townk/vim-autoclose'

" }}}
" ===== NERDTree                {{{

" Navegador de arquivos e diretórios
Plug 'scrooloose/nerdtree'
nmap <F10> :NERDTreeToggle<CR>

let NERDTreeShowBookmarks=1

" }}}
" ===== vim-tagbar              {{{

" Navega entre as tags do código fonte, precisa do ctags instalado para gerar as tags
" Lembrar que <ctrl> ww troca de janela
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

" Números das linhas relativo no modo normal e absoluto no modo insert
Plug 'jeffkreeftmeijer/vim-numbertoggle'
let g:NumberToggleTrigger="<Leader>n"

" }}}
" ===== Nerd Commenter          {{{

" <leader>cc para comentar e <leader>cu para descomentar
Plug 'scrooloose/nerdcommenter'

" }}}
" ===== latex-box               {{{

Plug 'LaTeX-Box-Team/LaTeX-Box'

let g:LatexBox_quickfix         = 4
let g:LatexBox_Folding          = 1
let g:LatexBox_latexmk_async    = 1


" }}}
" ===== matchit.vim             {{{

" Estende o uso do %
Plug 'matchit.zip'

" }}}
" ===== Syntastic               {{{

" Checa erro de sintaxe
Plug 'scrooloose/syntastic'

" começa em passive mode
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'],'passive_filetypes': [] }
nmap <leader>ss :SyntasticToggleMode<CR>

let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1

" }}}
" ===== markdown.vim            {{{

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

let g:vim_markdown_folding_disabled=1

" }}}
" ===== vim-fugitive (git)      {{{

Plug 'tpope/vim-fugitive'

" }}}
" ===== EasyMotion              {{{

" Navegação de texto igual vimperator
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

" extende Ctrl + R
Plug 'junegunn/vim-peekaboo'

" Default peekaboo window
let g:peekaboo_window = 'vertical botright 30new'

" }}}
" ===== vim-quickrun            {{{

Plug 'thinca/vim-quickrun'

nmap <F11> :QuickRun<CR>

" }}}
" ===== gist-vim                {{{

Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'

let g:gist_clip_command = 'xclip -sel clip'

" }}}
" ===== vim-notes               {{{

Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'

autocmd BufNewFile,BufRead *.notes setlocal filetype=notes

" }}}
" ===== vim-obsession           {{{

Plug 'tpope/vim-obsession'

" }}}

call plug#end()

" }}}
" Opções Básicas  ---------------------------------------------------------- {{{

syntax enable                           " Habilita a marcação de sintaxe
"set encoding=utf-8                     "
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
au InsertLeave * set nopaste            " Desativa paste mode ao sair do insert mode
set splitbelow                          " Nova janela aparece abaixo da atual
set splitright                          " Nova janela aparece a direita da atual
set backupskip=/tmp/*,/private/tmp/*"   " Faz o Vim editar arquivos crontab
set undofile                            " Estabelece o uso de um arquivo persistente para undo list
set undolevels=1000                     " Máximo numero de mudanças que podem ser desfeitas
set undoreload=10000                    " Máximo número de linhas a serem salvar pra buffer reload
set re=1                                " Corrige os arquivos ruby que estavam lentos por causa da nova regex engine do vim
au VimResized * :wincmd =               " Ajusta os splits quando a janela é redimensionada
set keywordprg=trans\ -b\ :pt           " Traduz para o inglês ao pressionar Shift+K quando o texto estiver selecionado pelo vim. NEED: translate-shell-git (AUR)
let g:tex_flavor='latex'
colorscheme molokai

" }}}
" Omni completion ---------------------------------------------------------- {{{

" <C-x><C-o> auto completar sintaxe
" <C-n> auto completar geral

" h cancela sem completar
" l completa
imap <expr> h ((pumvisible())?("\<C-e>"):("h"))
imap <expr> l ((pumvisible())?("\<C-y>"):("l"))

" usa jk para mover a janela do popup omnicomplete
imap <expr> j ((pumvisible())?("\<C-n>"):("j"))
imap <expr> k ((pumvisible())?("\<C-p>"):("k"))


" }}}
" Folding   ---------------------------------------------------------------- {{{

set foldmethod=marker
set foldmarker={{{,}}} " marker para abrir folder e fechar folder
set foldlevelstart=0   " Começa com todas os folders fechados

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

" navegação entre buffers
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>

" fecha buffer (sem quebrar a janela do NERDTree)
nmap <C-E> :bp<cr>:bd #<cr>

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
" edição rápida     {{{

nmap <leader>vi :vsplit ~/.config/nvim/init.vim<cr>
nmap <leader>ef :vsplit ~/.config/fish/config.fish<cr>
nmap <leader>i3 :vsplit ~/.i3/config<cr>

" }}}
" programação       {{{

" compilar com openGL (CG)
nmap <Leader>op :!g++ % -o a.out -lGLU -lGL -lglut && ./a.out<CR>

" ruby
nmap <Leader>ru :split<CR>:term ruby %<CR>

" julia
nmap <Leader>ju :split<CR>:term julia %<CR>

" bash
nmap <Leader>ba :split<CR>:term . %<CR>

" }}}
" setas             {{{

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

" Usar setas p/ algo mais útil

nmap <UP> ddkP
nmap <DOWN> ddp
nmap <LEFT> <<
nmap <RIGHT> >>
vmap <LEFT> <gv
vmap <RIGHT> >gv

" }}}
" sessions          {{{
let session_dir="~/.config/nvim/sessions"

if !isdirectory(expand(session_dir))
    call mkdir(expand(session_dir), "p")
endif

nnoremap <leader>ss :mks! ~/.config/nvim/sessions/default<CR>
nnoremap <leader>sa :mks! ~/.config/nvim/sessions/session_a<CR>
nnoremap <leader>sb :mks! ~/.config/nvim/sessions/session_b<CR>

" }}}
" etc               {{{

" quick save
nmap S :w<CR>

" Mata a janela
"nmap K :q<cr>
"

"Salva arquivos que requerem permissão root
cmap w!! %!sudo tee > /dev/null %

" Dois <Enter> para quebrar linha sem entrar no insert mode
nmap <CR><CR> o<ESC>

" Recarrega vimrc
map <Leader>re :so ~/.config/nvim/init.vim<CR>

" Cancela o highlight da busca atual
nmap <silent> <F3> :noh<cr>:call clearmatches()<cr>

" Opções para que blocos selecionados sejam reselecionados após identações.
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

set backup                                " habilita backups
set noswapfile                            " não cria mais os malditos .swp

set undodir=~/.config/nvim/undodir        " undo list
set backupdir=~/.config/nvim/tmp/backup/  " backups
set directory=~/.config/nvim/tmp/swap/    " swap files

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

"""" Faz com que o esquema de cores funcione perfeitamente dentro do tmux e urxvt
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
" Ajustes  ----------------------------------------------------------------- {{{

" Hack to get C-h working in neovim
if has('nvim')
    nmap <BS> <C-W>h
endif

" Certifica-se que o Vim retorna para a mesma linha quando abre o arquivo
if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
          \| exe "normal! g'\"" | endif
endif

" }}}
