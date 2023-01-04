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

" Reminder:
" Install powerline-fonts
" git clone https://github.com/powerline/fonts.git /tmp/fonts
" sh /tmp/fonts/install.sh
" ln -s ~/.local/share/fonts ~/.fonts

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1

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
Plug 'preservim/tagbar'
nmap <F9> :TagbarToggle<CR>

" }}}
" ===== vim-numbertoggle        {{{

" It quickly toggles between relative and absolute line numbers
Plug 'jeffkreeftmeijer/vim-numbertoggle'
nnoremap <silent> <C-n> :set relativenumber!<cr>

" }}}
" ===== Nerd Commenter          {{{

" <leader>cc comment
" <leader>cu uncomment
Plug 'scrooloose/nerdcommenter'

" }}}
" ===== vim-matchup             {{{

" It extends % usage
Plug 'andymass/vim-matchup'

" }}}
" ===== vim-peekaboo            {{{

" extends Ctrl + R
Plug 'junegunn/vim-peekaboo'

" Default peekaboo window
let g:peekaboo_window = 'vertical botright 30new'

" }}}
" ===== fzf                     {{{

" Reminder: for syntax-highlighted preview, install bat

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'


set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__

nnoremap <silent> <C-y> :Buffers<CR>
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
" ===== vim-go                  {{{

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" [[. ]] - Jump Functions

" use coc.nvim go-to-definition
let g:go_def_mapping_enabled = 0
" disable all linters as that is taken care of by coc.nvim
let g:go_diagnostics_enabled = 0
let g:go_metalinter_enabled = []
" don't jump to errors after metalinter is invoked
let g:go_jump_to_error = 0
" run go imports on file save
let g:go_fmt_command = "goimports"
" automatically highlight variable your cursor is on
let g:go_auto_sameids = 0
" disable vim-go fmt autosave
let g:go_fmt_autosave = 0
" unmap K key for doc lookup
let g:go_doc_keywordprg_enabled = 0

" highlights
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

" share gopls instance with coc.nvim
let g:go_gopls_options = ['-remote=unix;/tmp/gopls-daemon-socket']

" }}}
" ===== vim-buffkill            {{{

Plug 'qpkorr/vim-bufkill'

" closes buffer
nmap <C-E> :BD<cr>

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
Plug 'nvim-telescope/telescope-media-files.nvim'

nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>g <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>t <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>wt <cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>
nnoremap <leader>wc <cmd>:lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>

" }}}
" ===== editorconfig-vim        {{{

Plug 'editorconfig/editorconfig-vim'

" }}}
" ===== nvim-treesitter         {{{

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" }}}
" ===== coc.nvim                {{{

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Reminder:
" :CocInstall coc-pyright coc-json coc-html coc-css coc-toml coc-tabnine
" coc-tsserver
" ctrl+f ctrl+b to scroll the hover pop-up menu

" TextEdit might fail if hidden is not set.
set hidden
" Give more space for displaying messages.
set cmdheight=1
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" remap for complete to use tab and <cr>
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x> coc#pum#visible() ? coc#pum#stop() : "\<C-x>"
" remap for complete to use tab and <cr>
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gs :call CocAction('jumpDefinition', 'split')<CR>

" Show all diagnostics.
nnoremap <silent><nowait> <leader>d  :<C-u>CocList diagnostics<cr>

" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <leader>j <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>k <Plug>(coc-diagnostic-next)

" }}}
" ===== vimwiki                 {{{

Plug 'vimwiki/vimwiki'

let g:vimwiki_global_ext = 0
let g:vimwiki_folding='syntax:quick'
let g:vimwiki_list = [{'path': '~/Cloud/sync/wiki', 'auto_diary_index': 1}]

nnoremap <leader>ws :VimwikiSplitLink<cr>
nnoremap <leader>wv :VimwikiVSplitLink<cr>
nnoremap <leader>wi :call VimwikiDiaryIndex()<cr>

function! VimwikiDiaryIndex()
  set foldlevelstart=99
  :VimwikiDiaryIndex
  set foldlevelstart=0
endfunction

" }}}
" ===== filetype.nvim           {{{

Plug 'nathom/filetype.nvim'

" }}}
" ===== vim-python-pep8-indent  {{{

Plug 'Vimjas/vim-python-pep8-indent'

" }}}
" ===== git-worktree.nvim       {{{

Plug 'ThePrimeagen/git-worktree.nvim'

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

" wiki
autocmd BufNewFile,BufRead *.wiki set tw=100

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

" set paste/nopaste
set pastetoggle=<F2>

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
" Remaps      -------------------------------------------------------------- {{{

" buffers navigation
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>

" fast edition
nmap <leader>vi :vsplit ~/.config/nvim/init.vim<cr>
nmap <leader>ef :vsplit ~/.config/fish/config.fish<cr>
nmap <leader>i3 :vsplit ~/.i3/config<cr>

" arrow keys
nmap j gj
nmap k gk

" move selected area up or down
vnoremap K :<C-u>silent! '<,'>move-2<CR>gv=gv
vnoremap J :<C-u>silent! '<,'>move'>+<CR>gv=gv

" remove all trailing space
map <leader>w :%s/\s\+$//e<CR>

" Set working directory to the current file just for current window
map <leader>cd :lcd %:h<CR>

" Reload init.vim
map <leader>re :so ~/.config/nvim/init.vim<CR>

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
" These mappings save you some keystrokes and put you where you start typing your search pattern.
" After typing it you move to the replacement part , type it and hit return. The second version adds confirmation flag.
noremap ;; :%s:::g<Left><Left><Left>
noremap ;' :%s:::cg<Left><Left><Left><Left>

"Get the 2-space YAML as the default when hit carriage return after the colon
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab

" Highlight tabs as errors.
" https://vi.stackexchange.com/a/9353/3168
autocmd FileType yaml,yml match Error /\t/

" page up/down half a page
nmap <C-d> <C-d>zz
nmap <C-u> <C-u>zz

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

require("telescope").load_extension("git_worktree")
require('telescope').load_extension('media_files')
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
      },
       media_files = {
         -- filetypes whitelist
         filetypes = {"png", "webp", "jpg", "jpeg"},
         find_cmd = "rg" -- find command (defaults to `fd`)
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
  ensure_installed = {
  "c",
  "lua",
  "rust",
  "dockerfile",
  "python",
  "bash",
  "json",
  "markdown",
  "cmake",
  "fish",
  "comment",
  "go",
  "gomod",
  "gowork",
  "help",
  "html",
  "http",
  "json",
  "yaml",
  "regex",
  "hcl",
  "vim"
  },
  highlight = {
    enable = true,
    disable = {"vim"},
    additional_vim_regex_highlighting = { "markdown" }
  },
}

-- }}}
-- ===== filetype.nvim     {{{

vim.g.did_load_filetypes = 1

require("filetype").setup {
    overrides = {
        extensions = {
            tf = "terraform",
            tfvars = "terraform",
            tfstate = "json",
        },
    },
}

-- }}}
EOF

" }}}
" True Color  -------------------------------------------------------------- {{{

"Use 24-bit (true-color) mode in Vim/Neovim
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

" }}}
