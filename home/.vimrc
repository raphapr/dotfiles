" <Leader> por default é \
let mapleader=","
let maplocalleader = ","
set nocompatible
filetype off
filetype plugin on
filetype plugin indent on

" Caso eu esteja afim de usar o powerline (:
let powerline = $POWERLINE

" Estou usando o Vundle para gerenciar os bundles
"====================== Vundle ===============================

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" ===== Vundle
" P/ gerenciar os bundles
Bundle 'gmarik/vundle'

" Melhora os temas para terminais
Bundle 'godlygeek/csapprox'

" Esquemas de cores
Bundle 'altercation/vim-colors-solarized'
Bundle 'spf13/vim-colors'

" ===== SuperTab
" Usa a tecla tab para auto-completar
Bundle 'ervandew/supertab'

" ===== BASH IDE
Bundle 'vim-scripts/bash-support.vim'

" ===== Snipmate
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"

" ===== vim-autoclose
" Fecha automaticamente aspas, chaves, parênteses...
Bundle 'Townk/vim-autoclose'

"
"" Abaixo estão os Bundles que precisam de algumas opções/personalizações
"

" ===== vim-powerline
" Linha de status bem completa
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

" ===== NERDTree
" Navegador de arquivos e diretórios
Bundle 'scrooloose/nerdtree'
map <F10> :NERDTreeToggle<CR>

" ===== vim-tagbar
" Navega entre as tags do código fonte
" Precisa pacote ctags instalado para gerar as tags
Bundle 'majutsushi/tagbar'
nnoremap <F9> :TagbarToggle<CR>

" ################ Lembrar que <ctrl> ww troca de janela

" ===== numbers.vim
" Números das linhas relativo no modo normal e absoluto no modo insert
Bundle 'myusuf3/numbers.vim'
nnoremap <Leader>n :NumbersToggle<CR>

"==================== Minhas opções ===========================
"
"" Daqui para baixo são as minhas opções

syntax enable               " Habilita a marcação de sintaxe
set encoding=utf-8
set showmode                " Exibe o modo atual
set wildmenu                " Menu com as opções do vim usando tab
set background=dark         " Define o fundo preto (É melhor usar isso com a sintaxe)
set nu                      " Mostra o número de linhas
set ai                      " Faz o auto tab/auto indent
set ts=4                    " tab vale 4 espaços
set sw=4                    " tab com 4 espaços
set softtabstop=4           " Operações como o backspace também com 4 espaços
set et                      " Troca tabs por espaços
set ruler                   " Mostra a posição do cursor
set cursorline              " Destaca a linha atual
set laststatus=2            " Sempre exibe a barra de status
set autoread                " Recarrega arquivos alterados em disco automaticamente
"set tw=80                  " Define a largura do texto como 80 caracteres
set incsearch               " Pesquisa incremental
set hlsearch                " Highlight search :)
set ignorecase              " Pesquisa ignora caixa alta e baixa
set smartcase               " Pesquisa considera caixa alta apenas se ouver uma ou mais maiúsculas na pesquisa
set pastetoggle=<F2>        " ativa/desativa o auto ident para copiar/colar
set splitbelow              " Nova janela aparece abaixo da atual
set splitright              " Nova janela aparece a direita da atual
colorscheme molokai

" Meus aliases

" Cancela o highlight da busca atual
nnoremap <silent> <F3> :noh<CR>

"" Opções para que blocos selecionados sejam reselecionados após identações.
" Ajuda muito na hora de identar grandes e confusos blocos =)
vnoremap < <gv
vnoremap > >gv

" salva rapido
nnoremap <leader>s :w!<CR>

" quit all
nnoremap <leader>qt :quitall<CR>

" compilar com openGL (CG)
nnoremap <Leader>o :!g++ % -o a.out -lGLU -lGL -lglut && ./a.out<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""
" Navegação entre abas Tabs       "
"""""""""""""""""""""""""""""""""""

"navegação de abas fácil, semelhante a navegadores
nnoremap <Leader><Leader>       :tabnext<CR>
nnoremap <Leader>t              :tabnew<CR>
nnoremap <Leader>w              :tabclose<CR>
nnoremap <Leader>r              :tabrewind<CR>


""""""""""""""
" Vim Splits "
""""""""""""""

"Navegação entre janelas,
"<ctrl><j> em vez de <ctrl><w><j>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"open splits
nnoremap <Leader>v :vsplit<cr>
nnoremap <Leader>h :split<cr>

"Resize vsplit
nmap <Leader>c :vertical resize +5<cr>
nmap <Leader>x :vertical resize -5<cr>
nmap 25 :vertical resize 40<cr>
nmap 50 <c-w>=
nmap 75 :vertical resize 120<cr>



""""""""""""""
" Lembrete   "
""""""""""""""

"vertical split
":vsplit
":vsp

"horizontal split
":sp 
":split

"Resize horizontal split
":res +5
":res -5

"Resize vertical split
":vertical resize +5
":vertical resize -5


"Aumenta/diminui altura o split atual
"<ctrl>w +
"<ctrl>w -

"Aumenta/diminui largura  do split atual
"<ctrl>w >
"<ctrl>w <

"Maximiza a largura do split atual
"ctrl + w _

"Maximiza a altura do split atual
"ctrl + w |

"Normaliza o tamanho de todos os splits
"ctrl + w =

"Troca os splits topo/baixo ou esquerda/direita
"ctrl+w r

"Fecha todas as janelas da aba atual menos a janela atual.
"ctrl+w o
