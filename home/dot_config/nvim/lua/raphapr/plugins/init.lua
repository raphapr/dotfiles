-- Hooks must exist before vim.pack.add() so they also run on first install.
vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("PackHooks", { clear = true }),
  callback = function(event)
    local data = event.data
    if data.spec.name == "nvim-treesitter" and data.kind == "update" then
      if not data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

local function gh(repo)
  return "https://github.com/" .. repo
end

vim.pack.add({
  { src = gh("catppuccin/nvim"), name = "catppuccin" },
  gh("nvim-mini/mini.nvim"),
  gh("nvim-lualine/lualine.nvim"),
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
  gh("neovim/nvim-lspconfig"),
  gh("mason-org/mason.nvim"),
  -- Release tags ship a prebuilt fuzzy matcher, so no cargo build is needed.
  { src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") },
  gh("Kaiser-Yang/blink-cmp-git"),
  gh("stevearc/conform.nvim"),
  gh("lewis6991/gitsigns.nvim"),
  gh("esmuellert/codediff.nvim"), -- diff view used by review.nvim
  gh("MunifTanjim/nui.nvim"),
  { src = gh("georgeguimaraes/review.nvim"), version = vim.version.range("1.*") },
  gh("nvim-tree/nvim-tree.lua"),
  gh("folke/flash.nvim"),
  gh("zk-org/zk-nvim"),
  gh("MeanderingProgrammer/render-markdown.nvim"),
  gh("folke/zen-mode.nvim"),
  gh("christianrondeau/vim-base64"),
  gh("andymass/vim-matchup"),
  gh("tridactyl/vim-tridactyl"),
  gh("zbirenbaum/copilot.lua"),
  gh("kkharji/sqlite.lua"),
  gh("gbprod/yanky.nvim"),
})

for _, module in ipairs({
  "colorscheme",
  "lualine",
  "mini",
  "treesitter",
  "git",
  "conform",
  "flash",
  "nvim-tree",
  "render-markdown",
  "zen-mode",
  "zk",
  "yanky",
  "ai",
  "vim-base64",
}) do
  require("raphapr.plugins." .. module)
end
