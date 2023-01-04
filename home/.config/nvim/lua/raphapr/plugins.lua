-- lualine
require('lualine').setup {
  options = { theme  = 'gruvbox-material' },
  extensions = {'nerdtree','fzf','fugitive'},
  tabline = {
    lualine_a = {'buffers'},
  }
}

-- zoom-toggle
vim.keymap.set("n", "-", ":call zoom#toggle()<CR>", {silent = true, noremap = true})

-- nerdtree
vim.g.NERDTreeMinimalUI = true
vim.g.NERDTreeDirArrows = true
vim.keymap.set("n", "<F10>", ":NERDTreeToggle<CR>")

-- vim-tagbar
vim.keymap.set("n", "<F9>", ":TagbarToggle<CR>")

-- vim-numbertoggle
vim.keymap.set("n", "<C-n>", ":set relativenumber!<CR>", {noremap = true})

-- telescope
local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')
require("telescope").load_extension("git_worktree")
require('telescope').load_extension('media_files')
require('telescope').setup {
    defaults = {
        mappings = {
            n = {
                ['<C-h>'] = action_layout.toggle_preview,
            },
            i = {
                ['<Up>'] = actions.cycle_history_prev,
                ['<Down>'] = actions.cycle_history_next,
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,
                ['<C-h>'] = action_layout.toggle_preview,
                ["<C-p>"] = actions.cycle_history_prev
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
local telescope_builtin = require('telescope.builtin')
local telescope_worktree = require('telescope').extensions.git_worktree
vim.keymap.set('n', '<C-p>', telescope_builtin.find_files, {})
vim.keymap.set('n', '<C-y>', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>g', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>t', telescope_builtin.help_tags, {})
vim.keymap.set('n', '<leader>wt', telescope_worktree.git_worktrees, {})
vim.keymap.set('n', '<leader>wc', telescope_worktree.create_git_worktree, {})

-- gitsigns
require('gitsigns').setup {
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
}

-- nvim-treesitter
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
  "vim",
  "terraform"
  },
  highlight = {
    enable = true,
    disable = {"vim"},
    additional_vim_regex_highlighting = { "markdown" }
  },
}

--  filetype.nvim
vim.g.did_load_filetypes = 1
require("filetype").setup {
    overrides = {
        extensions = {
            tf = "terraform",
            tfvars = "terraform",
            tfstate = "json",
            fish = "fish",
        },
    },
}

--  remember.nvim
require("remember").setup { open_folds = true }

-- vim-go

-- use coc.nvim go-to-definition
vim.g.go_def_mapping_enabled = 0

-- disable all linters as that is taken care of by coc.nvim
vim.g.go_diagnostics_enabled = 0
vim.g.go_metalinter_enabled = {}

-- don't jump to errors after metalinter is invoked
vim.g.go_jump_to_error = 0

-- run go imports on file save
vim.g.go_fmt_command = "goimports"

-- automatically highlight variable your cursor is on
vim.g.go_auto_sameids = 0

-- disable vim-go fmt autosave
vim.g.go_fmt_autosave = 0

-- unmap K key for doc lookup
vim.g.go_doc_keywordprg_enabled = 0

-- highlights
vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_operators = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_build_constraints = 1
vim.g.go_highlight_generate_tags = 1

-- share gopls instance with coc.nvim
vim.g.go_gopls_options = {'-remote=unix;/tmp/gopls-daemon-socket'}

-- coc.nvim

vim.cmd([[

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

]])
