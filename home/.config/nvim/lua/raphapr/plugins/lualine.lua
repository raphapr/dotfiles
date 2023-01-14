require('lualine').setup {
  options = { theme = 'gruvbox-material' },
  extensions = { 'nerdtree', 'fzf', 'fugitive' },
  tabline = {
    lualine_a = { 'buffers' },
  }
}
